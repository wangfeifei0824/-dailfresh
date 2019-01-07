# -*-coding:utf-8 -*-
from celery import Celery
from django.conf import settings
from django.core.mail import send_mail
# django的初始化
import os
import django
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "dailyfresh.settings")
django.setup()


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
    


    