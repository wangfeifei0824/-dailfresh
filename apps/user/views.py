from django.conf import settings
from django.contrib.auth import authenticate, login
from django.core.mail import send_mail
from django.http import HttpResponse, response
from django.shortcuts import render, redirect
from django.urls import reverse
from django.views import View
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer, SignatureExpired

from .models import *
from celery_tasks.tasks import send_register_active_email


# /user/register
class RegisterView(View):
    '''注册'''
    def get(self, request):
        '''显示注册页面'''
        return render(request, 'register.html')
        
    def post(self, request):
        '''处理注册请求'''
        # 获取数据
        username = request.POST.get('user_name')
        password = request.POST.get('pwd')
        email = request.POST.get('email')
        user = User.objects.filter(username=username).all()
        # 判断用户名是否已经被注册
        if user:
            return render(request, 'register.html', {'errmsg':'用户名已经存在'})
        # 用户名不存在，进行注册
        user = User.objects.create_user(username, email, password)
        user.is_active = 0
        user.save()
        # 加密用户身份信息并发送激活邮件
        serializer = Serializer(settings.SECRET_KEY, 3600)
        info = {'confirm':user.id}
        token = serializer.dumps(info).decode()
        # 使用celery发送邮件
        send_register_active_email.delay(email, username, token)
        
        # subject = '天天生鲜注册信息'
        # message = ''
        # html_message = '<h1>%s,欢迎您注册天天生鲜会员</h1>请点击以下链接激活账户<br/><a href="http://127.0.0.1:8000/user/active/%s">http://127.0.0.1:8000/user/active/%s</a>' % (username, token, token)
        # sender = settings.EMAIL_FROM
        # receiver = [email]
        # # print(email)
        # sent_status = send_mail(subject, message, sender, receiver, html_message=html_message)
        # 可以通过打印邮件发送返回的状态值判断邮件是否发送成功
        # print(sent_status)
        
        # 注册成功，返回首页
        return redirect(reverse('goods:index'))
 
# /user/active/token
class ActiveView(View):
    '''激活账户'''
    def get(self, request, token):
        '''收到激活信息，激活用户的账户信息'''
        serializer = Serializer(settings.SECRET_KEY, 3600)
        try:
             info = serializer.loads(token)
             user_id = info['confirm']
             user = User.objects.get(id=user_id)
             user.is_active = 1
             user.save()
             return HttpResponse('激活成功')
        except SignatureExpired:
             return HttpResponse('激活链接已经失效，请重新激活')
     
     
# /user/login
class LoginView(View):
    '''登录'''
    def get(self, request):
        '''显示登录页面'''
        if 'username' in request.COOKIES:
            username = request.COOKIES.get('username')
            checked = 'checked'
        else:
            username = ''
            checked = ''
        return render(request, 'login.html', {'username':username, 'checked':checked})
    
    def post(self, request):
        '''处理登录请求'''
        username = request.POST.get('username')
        password = request.POST.get('pwd')
        # 认证用户
        user = authenticate(username=username,  password=password)
        if user:
            if user.is_active:
                # 记录用户的登录状态，将用户信息存入session
                login(request, user)
                response = redirect((reverse('goods:idnex')))
                if request.POST.get('issave') == 'on': # 判断是否需要记住用户名
                    response.set_cookie('username', username, max_age=7*24*3600)
                else:
                    response.delete_cookie('username')
                return  response
            else:
                return render(request, 'login.html', {'errmsg': '用户名未激活'})
        else:
            return render(request, 'login.html', {'errmsg':'用户名或密码错误'})
        
    
