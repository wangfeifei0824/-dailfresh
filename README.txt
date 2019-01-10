Django web后端开发电商项目--dailfresh
    --本项目仅供交流学习

1.开发环境
    python3.6.4
    django1.11.8
    django-tinymic2.6.0 (pip安装)
    itsdangerous (pip安装)
    celery(pip安装)
    eventlet(pip安装，Windows10需安装，否则报错)
    django-redis(pip安装）
    redis
    mysql(需手动创建数据库dailyfresh)
    django-haystack(pip安装)
    whoosh(pip安装)

2.启动项目
    1.启动redis数据库服务
        redis-server
    2.在项目的根目录下，依次执行
        python manage.py migrate
        python manage.py runserver
    3.在项目的根目录下，执行
        celery -A celery_tasks.tasks worker -l info
        celery -A celery_tasks.tasks worker -l info -P eventlet(win10)

    启动完成

