import re

from django.conf import settings
from django.contrib.auth import authenticate, login, logout
from django.core.mail import send_mail
from django.core.paginator import Paginator
from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.urls import reverse
from django.views import View
from django_redis import get_redis_connection
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer, SignatureExpired
from redis import StrictRedis

from apps.user.models import User, Address
from apps.goods.models import GoodsSKU
from apps.order.models import OrderInfo, OrderGoods
from celery_tasks.tasks import send_register_active_email
from utils.mixin import LoginRequiredMixin


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
            return render(request, 'register.html', {'errmsg': '用户名已经存在'})
        # 用户名不存在，进行注册
        user = User.objects.create_user(username, email, password)
        user.is_active = 0
        user.save()
        # 加密用户身份信息并发送激活邮件
        serializer = Serializer(settings.SECRET_KEY, 3600)
        info = {'confirm': user.id}
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
        return render(request, 'login.html', {'username': username, 'checked': checked})
    
    def post(self, request):
        '''处理登录请求'''
        username = request.POST.get('username')
        password = request.POST.get('pwd')
        # 认证用户
        user = authenticate(username=username, password=password)
        if user:
            if user.is_active:
                # 记录用户的登录状态，将用户信息存入session
                login(request, user)
                # 获取登录成功后要跳转的地址，默认跳转到首页
                next_url = request.GET.get('next', reverse('goods:index'))
                response = redirect(next_url)
                if request.POST.get('issave') == 'on':  # 判断是否需要记住用户名
                    response.set_cookie('username', username, max_age=7 * 24 * 3600)
                else:
                    response.delete_cookie('username')
                return response
            else:
                return render(request, 'login.html', {'errmsg': '用户名未激活'})
        else:
            return render(request, 'login.html', {'errmsg': '用户名或密码错误'})


# /user/logout/
class LogoutView(View):
    '''退出登录'''
    
    def get(self, request):
        logout(request)
        return redirect(reverse('goods:index'))


# /user
class UserInfoView(LoginRequiredMixin, View):
    '''用户中心-信息页'''
    
    def get(self, request):
        '''显示用户中心-信息页'''
        user = request.user
        address = Address.objects.get_default_address(user)
        # 从redis获取用户的浏览记录
        # sr = StrictRedis(host='127.0.0.1', port=6379, db=9)
        conn = get_redis_connection('default')
        history_key = 'history_%d' % user.id
        sku_ids = conn.lrange(history_key, 0, 4)
        goods_list = []
        for id in sku_ids:  # 按照用户的浏览顺序查询列表
            try:
                goods = GoodsSKU.objects.get(id=id.decode())
                goods_list.append(goods)
            except:
                continue
        
        params = {
            'address': address,
            'goods_list': goods_list
        }
        return render(request, 'user_center_info.html', params)


# /user/address
class AddressView(LoginRequiredMixin, View):
    '''用户中心-地址页'''
    
    def get(self, request):
        '''显示用户中心-地址页'''
        # 获取用户的默认的收获地址
        # try:
        #     address = Address.objects.get(user=request.user, is_default=True)
        # except:
        #     address = False
        address = Address.objects.get_default_address(user=request.user)
        return render(request, 'user_center_site.html', {'address': address})
    
    def post(self, request):
        '''收获地址的添加'''
        receiver = request.POST.get('receiver')
        addr = request.POST.get('addr')
        code = request.POST.get('code')
        phone = request.POST.get('phone')
        # 校验数据
        if not all([receiver, addr, phone]):
            return render(request, 'user_center_site.html', {'errmsg': '数据不完整'})
        if not re.match(r'^1[3|4|5|7|8][0-9]{9}$', phone):
            return render(request, 'user_center_site.html', {'errmsg': '手机号格式错误'})
        
        if Address.objects.get_default_address(user=request.user):
            is_default = False
        else:
            is_default = True
        address = Address.objects.create(
            user=request.user,
            receiver=receiver,
            addr=addr,
            zip_code=code,
            phone=phone,
            is_default=is_default)
        return redirect(reverse('user:address'))


# /user/order
class UserOrderView(LoginRequiredMixin, View):
    '''用户中心-订单页'''
    
    def get(self, request):
        '''显示用户中心-订单页'''
        # 获取数据
        user = request.user
        page = request.GET.get('page')

        if user.is_authenticated():
            # 获取购物车信息
            conn = get_redis_connection('default')
            cart_key = 'cart_%d' % user.id
            cart_count = conn.hlen(cart_key)
        
        # 查询数据
        orders = OrderInfo.objects.filter(user=user).order_by('-create_time')
        for order in orders:
            order.status = order.ORDER_STATUS[order.order_status]
            order_sku_list = OrderGoods.objects.filter(order_id=order.order_id)
            for order_sku in order_sku_list:
                amount = order_sku.price * order_sku.count
                order_sku.amount = amount
            order.sku_list = order_sku_list
          
        paginator = Paginator(orders, 1)
        # 数据校验
        try:
            page = int(page)
        except Exception as e:
            page = 1
        if page > paginator.num_pages:
            page = 1
        # 获取对应页码的数据
        order_page = paginator.page(page)
        # 页码列表处理
        num_pages = paginator.num_pages  # 返回页面总数
        # 分页之后宗页数不足5页
        # 当前页属于前三页，显示1-5页
        # 当前页属于后三页，显示后5页
        # 其他的情况喜爱男士当前页的前2页，当前页，当前页的后2页
        if num_pages < 5:
            pages = range(1, num_pages + 1)
        elif page <= 3:
            pages = range(1, 6)
        elif num_pages - page <= 2:
            pages = range(num_pages - 4, num_pages + 1)
        else:
            pages = range(page - 2, page + 3)
            
        context = {
            'order_page':order_page,
            'pages':pages,
            'cart_count':cart_count,
        }
        
        return render(request, 'user_center_order.html', context)

