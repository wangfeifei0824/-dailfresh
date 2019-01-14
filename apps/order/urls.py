"""dailyfresh URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from .views import *

urlpatterns = [
    url(r'^place$', OrderView.as_view(), name='place'),
    url(r'^commit', OrderCommitView.as_view(), name='commit'),
    url(r'^pay', OrderPayView.as_view(), name='pay'),
    url(r'^deliver', OrderPayView.as_view(), name='deliver'),
    url(r'^receiver', OrderPayView.as_view(), name='receiver'),
    url(r'^comment', OrderPayView.as_view(), name='comment'),
]