from django.core.exceptions import ObjectDoesNotExist
from django.db import transaction
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect
from django.urls import reverse
from django.views import View
from apps.goods.models import *
from apps.user.models import *
from django_redis import get_redis_connection
from apps.order.models import *
from datetime import datetime


# /order/palce
class OrderView(View):
    '''提交订单页面'''
    
    def post(self, request):
        '''显示提交订单页面'''
        # 数据获取
        user = request.user
        sku_ids = request.POST.getlist('sku_ids')
        # 数据验证
        if not user.is_authenticated:
            return redirect(reverse('user:login'))
        if not sku_ids:
            return redirect(reverse('cart:cart'))
        
        # 从redis购物车获取数据
        conn = get_redis_connection('default')
        cart_key = 'cart_%d' % user.id
        # 购物车商品列表
        sku_list = []
        # 总件数
        total_count = 0
        # 总金额
        total_price = 0
        for sku_id in sku_ids:
            sku = GoodsSKU.objects.get(id=sku_id)
            sku.count = conn.hget(cart_key, sku_id)
            sku.amount = int(sku.price) * int(sku.count)
            sku_list.append(sku)
            total_count += int(sku.count)
            total_price += sku.amount
        # 商品id组成的字符串
        sku_ids_str = ','.join(sku_ids)
        # 运费
        transit_price = 10
        # 总费用
        total_pay = transit_price + total_price
        # 收获地址
        addr_list = Address.objects.filter(user=user)
        
        context = {
            'sku_list': sku_list,
            'total_price': total_price,
            'total_count': total_count,
            'transit_price': transit_price,
            'total_pay': total_pay,
            'addr_list': addr_list,
            'sku_ids_str': sku_ids_str,
        }
        return render(request, 'place_order.html', context)


# /order/commit
class OrderCommitView(View):
    '''订单创建'''
    
    @transaction.atomic
    def get(self, request):
        '''订单创建'''
        # 获取数据
        user = request.user
        addr_id = request.GET.get('addr_id')
        pay_method = request.GET.get('pay_method')
        sku_ids_str = request.GET.get('sku_ids_str')
        sku_id_list = sku_ids_str.split(',')
        # 数据验证
        if not user.is_authenticated:
            return JsonResponse({'status': 0, 'msg': '用户未登录'})
        if not all([addr_id, pay_method, sku_ids_str]):
            return JsonResponse({'status': 0, 'msg': '数据不完整'})
        try:
            addr = Address.objects.get(id=addr_id)
        except ObjectDoesNotExist as e:
            return JsonResponse({'status': 0, 'msg': '地址信息错误'})
        if pay_method not in OrderInfo.PAY_METHODS.keys():
            return JsonResponse({'status': 0, 'msg': '支付方式无效'})
        
        # 生成订单
        order = OrderInfo()
        order.order_id = datetime.now().strftime('%y%m%d%H%M%S') + str(user.id)
        order.user = user
        order.addr = addr
        order.pay_method = int(pay_method)
        
        # 从redis购物车获取数据
        conn = get_redis_connection()
        cart_key = 'cart_%d' % user.id
        # 购物车商品列表
        sku_list = []
        # 总件数
        total_count = 0
        # 总金额
        total_price = 0
        # 运费
        transit_price = 10
        order.total_count = total_count
        order.total_price = total_price
        order.transit_price = transit_price
        order.save()  # 先保存主表
        
        # 生成订单里的商品列表
        for sku_id in sku_id_list:
            try:
                sku = GoodsSKU.objects.select_for_update().get(id=sku_id)
            except ObjectDoesNotExist as e:
                return JsonResponse({'status': 0, 'msg': '所购买的商品不存在'})
            sku.count = conn.hget(cart_key, sku_id)
            if sku.stock < int(sku.count.decode()):
                return JsonResponse({'status': 0, 'msg': '所购买的商品数量不足'})
            ordergoods = OrderGoods()
            ordergoods.order = order
            ordergoods.sku = sku
            ordergoods.count = sku.count
            ordergoods.price = sku.price
            ordergoods.save()
            # 修改库存量和销量
            sku.stock -= int(sku.count)
            sku.sales += int(sku.count)
            sku.save()
            # 删除购物车信息
            conn.hdel(cart_key, sku_id)
            # 计算订单总数和总价
            sku.amount = int(sku.price) * int(sku.count)
            sku_list.append(sku)
            total_count += int(sku.count)
            total_price += sku.amount
        
        # 总费用
        total_pay = transit_price + total_price
        
        order.total_count = total_count
        order.total_price = total_price
        order.save()
        
        print('ok')
        return JsonResponse({'status': 1, 'msg': '订单创建成功'})


# order/pay
class OrderPayView(View):
    '''订单支付'''
    
    def get(self, request):
        user = request.user
        if not user.is_authenticated:
            return JsonResponse({'status':'0', 'msg':'用户未登录'})
        order_id = request.GET.get('order_id')
        try:
            order = OrderInfo.objects.get(order_id=order_id)
        except ObjectDoesNotExist as e:
            return JsonResponse({'status':'0', 'msg':'订单不存在'})
        order.order_status = 2
        order.save()
        return JsonResponse({'status':'1', 'msg':'支付成功'})
        
        
# order/deliver
class OrderDeliverView(View):
    '''订单发货'''
    
    def get(self, request):
        user = request.user
        if not user.is_authenticated:
            return JsonResponse({'status':'0', 'msg':'用户未登录'})
        order_id = request.GET.get('order_id')
        try:
            order = OrderInfo.objects.get(order_id=order_id)
        except ObjectDoesNotExist as e:
            return JsonResponse({'status':'0', 'msg':'订单不存在'})
        order.order_status = 3
        order.save()
        return JsonResponse({'status':'1', 'msg':'发货成功'})
        
# order/pay
class OrderReceiverView(View):
    '''订单收货'''
    
    def get(self, request):
        user = request.user
        if not user.is_authenticated:
            return JsonResponse({'status':'0', 'msg':'用户未登录'})
        order_id = request.GET.get('order_id')
        try:
            order = OrderInfo.objects.get(order_id=order_id)
        except ObjectDoesNotExist as e:
            return JsonResponse({'status':'0', 'msg':'订单不存在'})
        order.order_status = 4
        order.save()
        return JsonResponse({'status':'1', 'msg':'收货成功'})
        
        
# order/pay
class OrderCommentView(View):
    '''订单评价'''
    
    def get(self, request):
        user = request.user
        if not user.is_authenticated:
            return JsonResponse({'status':'0', 'msg':'用户未登录'})
        order_id = request.GET.get('order_id')
        comment = request.GET.get('comment')
        try:
            order = OrderInfo.objects.get(order_id=order_id)
        except ObjectDoesNotExist as e:
            return JsonResponse({'status':'0', 'msg':'订单不存在'})
        order.order_status = 5
        order.save()
        return JsonResponse({'status':'1', 'msg':'支付成功'})
        
        