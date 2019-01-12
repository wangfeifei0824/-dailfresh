from django.http import HttpResponse
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
        '''提交订单页面显示'''
        user = request.user
        sku_ids = request.POST.getlist('sku_ids')
        if not sku_ids:
            print(sku_ids)
            return redirect(reverse('cart:cart'))
        # 从redis购物车获取数据
        conn = get_redis_connection()
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
        # 运费
        transit_price = 10
        # 总费用
        total_pay = transit_price + total_price
        # 收获地址
        addr_list = Address.objects.filter(user=user)
        context = {
            'sku_list':sku_list,
            'total_price':total_price,
            'total_count':total_count,
            'transit_price':transit_price,
            'total_pay':total_pay,
            'addr_list':addr_list,
        }
        return render(request, 'place_order.html', context)
 
 
# /order/pay
class OrderCommitView(View):
    '''订单创建'''
    def post(self, request):
        '''订单创建'''
        user = request.user
        addr_id = request.POST.get('addr_id')
        pay_method = request.POST.get('pay_style')
        sku_id_list = request.POST.getlist('sku_ids')
        # 从redis购物车获取数据
        conn = get_redis_connection()
        cart_key = 'cart_%d' % user.id
        # 购物车商品列表
        sku_list = []
        # 总件数
        total_count = 0
        # 总金额
        total_price = 0
        for sku_id in sku_id_list:
            sku = GoodsSKU.objects.get(id=sku_id)
            sku.count = conn.hget(cart_key, sku_id)
            sku.amount = int(sku.price) * int(sku.count)
            sku_list.append(sku)
            total_count += int(sku.count)
            total_price += sku.amount
        # 运费
        transit_price = 10
        # 总费用
        total_pay = transit_price + total_price
        
        # 生成订单
        order = OrderInfo()
        order.order_id = datetime.now().strftime('%y%m%d%H%M%S') + str(user.id)
        order.user = user
        order.addr = Address.objects.filter(id=addr_id)
        order.pay_method = int(pay_method)
        order.total_count = total_count
        order.total_price = total_price
        order.transit_price = 10
        order.save()
        # 生成订单商品
        for sku_id in sku_id_list:
            try:
                sku = GoodsSKU.objects.get(id=sku_id)
            except Exception as e:
                print(e)
                return HttpResponse('所够买的商品不存在')
            count = conn.hget(cart_key, sku_id)
            # 判断库存量是否足够
            if int(count) > sku.stock:
                return HttpResponse('库存不足')
            
            ordergoods = OrderGoods()
            ordergoods.order = order
            ordergoods.sku = sku
            ordergoods.count = count
            ordergoods.price = sku.price
            ordergoods.comment = '味道很好'
            ordergoods.save()
            # 修改库存量和销量
            sku.stock -= int(count)
            sku.sales += int(count)
            sku.save()
            # 删除购物车信息
            conn.hdel(cart_key, sku_id)
            
        return redirect(reverse('order:'))