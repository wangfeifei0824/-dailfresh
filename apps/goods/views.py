from django.core.cache import cache
from django.shortcuts import render, redirect
from django.urls import reverse
from django.views import View
from django_redis import get_redis_connection

from apps.goods.models import *
from apps.order.models import OrderGoods


# Create your views here.
# /
class StaticIndexView(View):
    '''静态首页'''
    def get(self, request):
        return render(request, 'static_index.html')
    
    
# /index
class IndexView(View):
    '''首页'''
    def get(self, request):
        '''首页展示'''
        # 从缓存中获取数据
        context = cache.get('index_page_data')
        if context is None: #缓存中没有数据，从数据库查询数据
            types = GoodsType.objects.all()
            index_banner = IndexGoodsBanner.objects.all().order_by('index')
            promotion_banner = IndexPromotionBanner.objects.all().order_by('index')
            for type in types:
                title_banner = IndexTypeGoodsBanner.objects.filter(type=type, display_type=0).order_by('index')
                image_banner = IndexTypeGoodsBanner.objects.filter(type=type, display_type=1).order_by('index')
                # 动态给type对象添加两个属性高并保存
                type.title_banner = title_banner
                type.image_banner = image_banner
    
            context = {
                'types': types,
                'index_banner': index_banner,
                'promotion_banner': promotion_banner,
            }
            # 设置缓存
            cache.set('index_page_data', context, 3600)
        # 获取用户的信息
        user = request.user
        cart_count = 0
        if user.is_authenticated:
            # 用户已经登录
            conn = get_redis_connection('default')
            cart_key = 'cart_%d' % user.id
            cart_count = conn.hlen(cart_key)
            context.update(cart_count=cart_count)
        return render(request, 'index.html', context)
    

# /user/detail/goodsku.id
class DetailView(View):
    '''详情页'''
    def get(self, request, goods_id):
        try:
            sku = GoodsSKU.objects.get(id=goods_id)
        except GoodsSKU.DoesNotExist:
            # 商品不存在
            return redirect(reverse('goods:index'))
        # 获取商品类型
        types = GoodsType.objects.all()
        # 获取商品评论
        sku_orders = OrderGoods.objects.filter(sku=sku).exclude(comment='')
        # 获取新品信息
        new_skus = GoodsSKU.objects.filter(type=sku.type).order_by('create_time')
        # 获取同一个spu的其他规格的商品
        same_spu_skus = GoodsSKU.objects.filter(goods=sku.goods).exclude(id=goods_id)
        
        user = request.user
        cart_count = 0
        if user.is_authenticated():
            # 获取购物车信息
            conn = get_redis_connection('default')
            cart_key = 'cart_%d' % user.id
            cart_count = conn.hlen(cart_key)
            # 添加用户的历史记录
            history_key = 'history_%d' % user.id
            conn.lrem(history_key, 0, goods_id) # 移除
            conn.lpush(history_key, goods_id)  # 增加
            conn.ltrim(history_key, 0, 4)    # 修建，只保留5条
            
        context = {
            'sku':sku,
            'types':types,
            'cart_count':cart_count,
            'new_skus':new_skus,
            'sku_orders':sku_orders,
            'same_spu-skus':same_spu_skus,
        }
        
        return render(request, 'detail.html', context)
    
    
# /user/info