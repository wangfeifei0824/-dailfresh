# -*-coding:utf-8 -*-
from django.db import models


class BaseModel(models.Model):
    '''抽象模型类'''
    create_time = models.DateTimeField('创建时间', auto_now_add=True)
    update_time = models.DateTimeField('更新时间', auto_now_add=True)
    is_delete = models.BooleanField('删除标记', default=False)
    
    class Meta:
        # 说明这是一个抽象类
        abstract=True