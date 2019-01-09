# -*-coding:utf-8 -*-
from celery import Celery
from django.conf import settings
from django.core.mail import send_mail
from django.template import loader, RequestContext

# django的初始化
import os
import django
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "dailyfresh.settings")
django.setup()

from apps.goods.models import *


app = Celery('celery_tasks.tasks', broker='redis://127.0.0.1:6379/8')


@app.task
def send_register_active_email(to_email, username, token):
    '''发送激活邮件'''
    subject = '天天生鲜注册信息'
    message = ''
    html_message = '<h1>%s,欢迎您注册天天生鲜会员</h1>请点击以下链接激活账户<br/><a href="http://127.0.0.1:8000/user/active/%s">http://127.0.0.1:8000/user/active/%s</a>' % (
    username, token, token)
    sender = settings.EMAIL_FROM
    receiver = [to_email]
    sent_status = send_mail(subject, message, sender, receiver, html_message=html_message)


@app.task
def generate_static_html():
    '''产生首页静态页面'''
    types = GoodsType.objects.all()
    index_banner = IndexGoodsBanner.objects.all().order_by('index')
    promotion_banner = IndexPromotionBanner.objects.all().order_by('index')
    for type in types:
        title_banner = IndexTypeGoodsBanner.objects.filter(type=type, display_type=0).order_by('index')
        image_banner = IndexTypeGoodsBanner.objects.filter(type=type, display_type=1).order_by('index')
        # 动态给type对象添加两个属性高并保存
        type.title_banner = title_banner
        type.image_banner = image_banner
    
    cart_count = 0
    context = {
        'types':types,
        'index_banner':index_banner,
        'promotion':promotion_banner,
        'cart_count':cart_count,
    }
    # 加载模板
    temp = loader.get_template('index.html')
    # 模板渲染
    static_index_html = temp.render(context)
    # 生成静态文件
    save_path = os.path.join(settings.BASE_DIR, 'templates/static_index.html')
    with open(save_path, 'w', encoding='utf-8') as f:
        f.write(static_index_html)
    
if __name__ == '__main':
    generate_static_html()

    