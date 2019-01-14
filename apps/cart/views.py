from django.core.exceptions import ObjectDoesNotExist
from django.http import JsonResponse
from django.shortcuts import render
from django.views import View
from django_redis import get_redis_connection
from utils.mixin import LoginRequiredMixin
from apps.goods.models import GoodsSKU


# /add
class CartAddView(View):
    '''添加购物车'''
    
    def get(self, request):
        user = request.user
        if not user.is_authenticated:
            return JsonResponse({'status': 0, 'msg': '用户未登录'})
        sku_id = request.GET.get('sku_id')
        count = request.GET.get('count')
        # 数据校验
        if not all([sku_id, count]):
            return JsonResponse({'status': 0, 'msg': '数据不完整'})
        try:
            count = int(count)
        except Exception as e:
            return JsonResponse({'status': 0, 'msg': '数据错误'})
        try:
            sku = GoodsSKU.objects.get(id=sku_id)
        except ObjectDoesNotExist as e:
            return JsonResponse({'status': 0, 'msg': '商品不存在'})
        # 加入购物车
        conn = get_redis_connection('default')
        cart_key = 'cart_%d' % user.id
        cart_count = conn.hget(cart_key, sku_id)
        if cart_count:
            cart_count = int(cart_count) + int(count)
        else:
            cart_count = count
            # 校验商品的库存
        if cart_count > sku.stock:
            return JsonResponse({'status': 0, 'msg': '商品库存不足'})
        print(count, sku.stock)
        conn.hset(cart_key, sku_id, cart_count)
        # 获取购物车数量
        cart_count = conn.hlen(cart_key)
        # print('cart', cart_count)
        return JsonResponse({'status': 1, 'msg': '添加成功', 'cart_count': cart_count})


# /cart
class CartView(LoginRequiredMixin, View):
    '''购物车'''
    
    def get(self, request):
        '''显示购物车页'''
        user = request.user
        conn = get_redis_connection('default')
        cart_key = 'cart_%d' % user.id
        # 获取购物车信息
        cart_dict = conn.hgetall(cart_key)
        # 获取商品信息
        sku_list = []
        total_count = 0
        total_price = 0
        for sku_id, count in cart_dict.items():
            sku = GoodsSKU.objects.get(id=sku_id)
            # 计算商品小计
            sku.amount = sku.price * int(count)
            sku.count = count
            sku_list.append(sku)
            total_count += int(count)
            total_price += sku.amount
        context = {
            'total_count': total_count,
            'total_price': total_price,
            'sku_list': sku_list
        }
        return render(request, 'cart.html', context)


# /update
class CartUpdate(View):
    '''更新购物车'''
    def get(self, request):
        user = request.user
        if not user.is_authenticated:
            return JsonResponse({'status': 0, 'msg': '用户未登录'})
        sku_id = request.GET.get('sku_id')
        count = request.GET.get('count')
        # print(sku_id, count)
        # 数据校验
        if not all([sku_id, count]):
            return JsonResponse({'status': 0, 'msg': '数据不完整'})
        try:
            count = int(count)
        except Exception as e:
            return JsonResponse({'status': 0, 'msg': '数据错误'})
        try:
            sku = GoodsSKU.objects.get(id=sku_id)
        except ObjectDoesNotExist as e:
            return JsonResponse({'status': 0, 'msg': '商品不存在'})
            # 校验商品的库存
        if count > sku.stock:
            return JsonResponse({'status': 0, 'msg': '商品库存不足'})
        # print('cart', count, sku.stock)
        # 更新购物车
        conn = get_redis_connection('default')
        cart_key = 'cart_%d' % user.id
        conn.hset(cart_key, sku_id, count)
        # print('ok')
        return JsonResponse({'status': 1, 'msg': '更新成功'})


# /delete
class CartDelete(View):
    '''购物车记录删除'''
    def get(self, request):
        user = request.user
        if not user.is_authenticated:
            return JsonResponse({'status': 0, 'msg': '用户未登录'})
        sku_id = request.GET.get('sku_id')
        # 数据校验
        if not sku_id:
            return JsonResponse({'status': 0, 'msg': '数据不完整'})
        try:
            sku = GoodsSKU.objects.get(id=sku_id)
        except ObjectDoesNotExist as e:
            return JsonResponse({'status': 0, 'msg': '商品不存在'})
        # 删除购物车记录
        conn = get_redis_connection('default')
        cart_key = 'cart_%d' % user.id
        conn.hdel(cart_key, sku_id,)
        return JsonResponse({'status': 1, 'msg': '删除成功'})