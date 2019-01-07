from django.shortcuts import render
from django.views import View


# Create your views here.
# /
# /index
class IndexView(View):
    '''首页'''
    def get(self, request):
        '''首页展示'''
        return render(request, 'index.html')