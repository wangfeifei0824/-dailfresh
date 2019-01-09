from django.core.cache import cache
from django.core.paginator import Paginator
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
    

# /detail/goodsku.id
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
            conn.ltrim(history_key, 0, 4)    # 修剪，只保留5条
            
        context = {
            'sku':sku,
            'types':types,
            'cart_count':cart_count,
            'new_skus':new_skus,
            'sku_orders':sku_orders,
            'same_spu-skus':same_spu_skus,
        }
        
        return render(request, 'detail.html', context)
    

# 种类id 页码 排序方式
# /list/种类id/页码/排序方式
# /list?type_id=种类id&page=页码&sort=排序方式
class ListView(View):
    '''列表页'''
    def get(self, request):
        '''显示列表页'''
        type_id = request.GET.get('type_id')
        page = request.GET.get('page')
        sort = request.GET.get('sort')
        try:
            type = GoodsType.objects.get(id=type_id)
        except GoodsType.DoesNotExist:
            return redirect(reverse('goods:index'))
        
        types = GoodsType.objects.all()
        if sort == 'price':
            skus = GoodsSKU.objects.filter(type=type).order_by('price')
        elif sort == 'hot':
            skus = GoodsSKU.objects.filter(type=type).order_by('-sales')
        else:
            skus = GoodsSKU.objects.filter(type=type).order_by('-id')
        # 对数据进行分页
        paginator = Paginator(skus, 1)
        try:
            page = int(page)
        except Exception as e:
            page = 1
        if page > paginator.num_pages:
            page = 1
        # 获取对应页码的数据
        skus_page = paginator.page(page)
        # 页码列表处理
        num_pages = paginator.num_pages # 返回页面总数
        # 分页之后宗页数不足5页
        # 当前页属于前三页，显示1-5页
        # 当前页属于后三页，显示后5页
        # 其他的情况喜爱男士当前页的前2页，当前页，当前页的后2页
        if num_pages < 5:
            pages = range(1, num_pages+1)
        elif page <= 3:
            pages = range(1, 6)
        elif num_pages - page <= 2:
            pages = range(num_pages-4, num_pages+1)
        else:
            pages = range(page-2, page+3)
            
        # 获取购物车信息
        user = request.user
        cart_count = 0
        if user.is_authenticated:
            # 用户已经登录
            conn = get_redis_connection('default')
            cart_key = 'cart_%d' % user.id
            cart_count = conn.hlen(cart_key)
        # 获取新品信息
        new_skus = GoodsSKU.objects.filter(type=type).order_by('-create_time')[:2]
        context = {
            'type':type,
            'types':types,
            'skus_page':skus_page,
            'new_skus':new_skus,
            'cart_count':cart_count,
            'sort':sort,
            'pages':pages,
        }
        
        return render(request ,'list.html', context)