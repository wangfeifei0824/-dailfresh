from django.contrib import admin
from django.core.cache import cache

from .models import *


# 定义一个基类
class BaseModelAdmin(admin.ModelAdmin):
    def save_model(self, request, obj, form, change):
        '''更新表中的数据时调用'''
        super().save_model(request, obj, form, change)
        # 发出任务，让celery worker 重新生成首页静态页面
        from celery_tasks.tasks import generate_static_html
        generate_static_html.delay()
        # 清除首页的缓存数据
        cache.delete('index_page_data')
        
    def delete_model(self, request, obj):
        '''删除表中的数据时调用'''
        super().delete_model(request, obj)
    # 发出任务，让celery worker 重新生成首页静态页面
        from celery_tasks.tasks import generate_static_html
        generate_static_html.delay()
    # 清除首页的缓存数据
    cache.delete('index_page_data')
 
 
class GoodsTypeAdmin(BaseModelAdmin):
    pass


class IndexGoodsBannerAdmin(BaseModelAdmin):
    pass


class IndexTypeGoodsBannerAdmin(BaseModelAdmin):
    pass


class IndexPromotionBannerAdmin(BaseModelAdmin):
    pass


admin.site.register(GoodsType, GoodsTypeAdmin)
admin.site.register(GoodsSKU)
admin.site.register(Goods)
admin.site.register(GoodsImage)
admin.site.register(IndexGoodsBanner, IndexGoodsBannerAdmin)
admin.site.register(IndexTypeGoodsBanner, IndexTypeGoodsBannerAdmin)
admin.site.register(IndexPromotionBanner, IndexPromotionBannerAdmin)
