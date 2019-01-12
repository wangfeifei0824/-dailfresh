$(function () {
    //动画
    function add_cart_sign(data) {
        $(".add_jump").stop().animate({
            'left': $to_y+7,
            'top': $to_x+7},
            "fast", function() {
                $(".add_jump").fadeOut('fast',function(){
                    $('#show_count').html(data.cart_count);
                });
        });
    }

    //加入购物车
    function add_cart(sku_id, count) {
        var data = {
            'sku_id':sku_id,
            'count': count,
        };
        $.ajax({
            url: 'http://localhost:8000/cart/add',
            type: 'get',
            data:data,
            dataTyep:'json',
            async:false,
            success:function (data) {
                if (data.status == 1) {
                    console.log(data.cart_count);
                    add_cart_sign(data);
                    // $('#show_count').text(data.cart_count);
                } else {
                    alert(data.msg);
                }
            }

        })
    }

    //加入购物车-列表页
    function add_cart2(sku_id, count) {
        var data = {
            'sku_id':sku_id,
            'count': count,
        };
        $.ajax({
            url: 'cart/add',
            type: 'get',
            data:data,
            dataTyep:'json',
            async:false,
            success:function (data) {
                if (data.status == 1) {
                    // console.log(data.cart_count);
                    $('#show_count').text(data.cart_count);
                    alert(data.msg);
                } else {
                    alert(data.msg);
                }
            }

        })
    }

    // 详情页-点击添加购物车
    $('#add_cart').click(function () {
        // console.log('ok');
        var sku_id = $('#sku_id').text();
        var count = $('.num_show').val();
        add_cart(sku_id, count);
    });

    // 列表页-加入购物车
    $('.list_add_cart').click(function () {
        // console.log('ok');
        var sku_id = $(this).attr('sku_id');
        var count = '1';
        add_cart2(sku_id, count);
    });

    // 用户中心页加入购物车
    $('.userinfo_add_cart').click(function () {
        // console.log('ok');
        var sku_id = $(this).attr('sku_id');
        var count = '1';
        add_cart2(sku_id, count);
    });
});