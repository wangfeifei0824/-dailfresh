from django.db import models
from db.base_model import BaseModel
from tinymce.models import HTMLField


# Create your models here.


class GoodsType(BaseModel):
    '''商品类型模型类'''
    name = models.CharField('种类名称', max_length=20)
    logo = models.CharField('标识', max_length=20)
    image = models.ImageField('商品种类图片', upload_to='goodstype')
    
    class Meta:
        db_table = 'df_goods_type'
        verbose_name = '商品种类'
        verbose_name_plural = verbose_name
    
    def __str__(self):
        return self.name


class GoodsSKU(BaseModel):
    '''商品SKU模型类'''
    status_choices = (
        (0, '下线'),
        (1, '上线'),
    )
    type = models.ForeignKey('GoodsType', verbose_name='商品种类')
    goods = models.ForeignKey('Goods', verbose_name='商品SPU')
    name = models.CharField('商品名称', max_length=20)
    desc = models.CharField('商品简介', max_length=256)
    price = models.DecimalField('商品价格', max_length=10, decimal_places=2, max_digits=10)
    unite = models.CharField('商品单位', max_length=20)
    image = models.ImageField('商品图片', upload_to='goods')
    stock = models.IntegerField('商品库存', default=1)
    sales = models.IntegerField('商品销量', default=0)
    status = models.SmallIntegerField('商品状态', default=1, choices=status_choices)
    
    class Meta:
        db_table = 'df_goods_sku'
        verbose_name = '商品'
        verbose_name_plural = verbose_name
    
    def __str__(self):
        return self.name


class Goods(BaseModel):
    '''商品SPU模型类'''
    name = models.CharField('商品SPU名称', max_length=20)
    detail = HTMLField('商品详情', blank=True)
    
    class Meta:
        db_table = 'df_goods'
        verbose_name = '商品SPU'
        verbose_name_plural = verbose_name
    
    def __str__(self):
        return self.name


class GoodsImage(BaseModel):
    '''商品图片模型类'''
    sku = models.ForeignKey('GoodsSKU', verbose_name='商品')
    image = models.ImageField('图片路径', upload_to='goods')
    
    class Meta:
        db_table = 'df_goods_image'
        verbose_name = '商品图片'
        verbose_name_plural = verbose_name
    
    def __str__(self):
        return self.sku


class IndexGoodsBanner(BaseModel):
    '''首页轮播商品展示模型类'''
    sku = models.ForeignKey('GoodsSKU', verbose_name='商品')
    image = models.ImageField('图片', upload_to='banner')
    index = models.SmallIntegerField('展示顺序', default=0)  # 0 1 2 3
    
    class Meta:
        db_table = 'df_index_banner'
        verbose_name = '首页轮播商品'
        verbose_name_plural = verbose_name


class IndexTypeGoodsBanner(BaseModel):
    '''首页分类商品展示模型类'''
    DISPLAY_TYPE_CHOICES = (
        (0, "标题"),
        (1, "图片")
    )
    
    type = models.ForeignKey('GoodsType', verbose_name='商品类型')
    sku = models.ForeignKey('GoodsSKU', verbose_name='商品SKU')
    display_type = models.SmallIntegerField(default=1, choices=DISPLAY_TYPE_CHOICES, verbose_name='展示类型')
    index = models.SmallIntegerField(default=0, verbose_name='展示顺序')
    
    class Meta:
        db_table = 'df_index_type_goods'
        verbose_name = "主页分类展示商品"
        verbose_name_plural = verbose_name


class IndexPromotionBanner(BaseModel):
    '''首页促销活动模型类'''
    name = models.CharField('活动名称', max_length=20)
    url = models.CharField('活动链接', max_length=256)
    image = models.ImageField('活动图片', upload_to='banner')
    index = models.SmallIntegerField('展示顺序', default=0)  # 0 1 2 3
    
    class Meta:
        db_table = 'df_index_promotion'
        verbose_name = '主页促销活动'
        verbose_name_plural = verbose_name
    
    def __str__(self):
        return self.name
