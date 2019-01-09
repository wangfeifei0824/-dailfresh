import pymysql
pymysql.install_as_MySQLdb()


# 启动服务时，生成首页静态页面
# from celery_tasks.tasks import generate_static_html
# generate_static_html.delay()