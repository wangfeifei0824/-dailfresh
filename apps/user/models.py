from django.db import models
from django.contrib.auth.models import AbstractUser
from db.base_model import BaseModel


# 自定义地址的管理类
class AddressMangager(models.Manager):

    def get_default_address(self, user):
        # 查询默认的地址,查询不到会报异常

        try:
            # default_address = Address.objects.get(user__exact=user, is_default=True)
            # 进行改写,self.model 获取类型替换
            default_address = self.get(user__exact=user, is_default=True)
        except self.model.DoesNotExist as e:
            # 未找到地址设置为空
            default_address = None


class User(AbstractUser, BaseModel):
    '''用户模型类'''
    class Meta:
        db_table = 'df_user'
        verbose_name = '用户'
        verbose_name_plural = verbose_name
        

class Address(BaseModel):
    '''地址模型类'''
    user = models.ForeignKey('User', verbose_name='所属账户')
    receiver = models.CharField('收件人', max_length=20)
    addr = models.CharField('收件地址', max_length=256)
    zip_code = models.CharField('邮政编码', max_length=6, null=True)
    phone = models.CharField('练习电话', max_length=11)
    is_default = models.BooleanField('是否默认', default=False)
    
#     自定义的管理器实例化
    objects = AddressMangager()
    
    class Meta:
        db_table = 'df_address'
        verbose_name = '地址'
        verbose_name_plural = verbose_name
    
    def __str__(self):
        return self.addr
    
    
        

