$(function () {
    //更新被选中商品的数量和价格
    function update_page_info() {
        var total_count = 0;
        var total_price = 0;
        $('.cart_list_td').find(':checked').parents('ul').each(function () {
            // console.log('ok');
            var price = $(this).find('.amount').text();
            var number = $(this).find('.num_show').val();
            // console.log(price, number);

            total_count = total_count + parseInt(number);
            total_price = total_price + parseFloat(price);
        });
        total_price = total_price.toFixed(2);
        $('#total_count').text(total_count);
        $('#total_count1').text(total_count);
        $('#total_price').text(total_price);
    }

    //更新购物车
    function update_cart_info(sku_id, count) {
        var status = false;
        // var csrf = $('input[name=csrfmiddlewaretoken]').val();
        // console.log(csrf);
        data = {
            'sku_id': sku_id,
            'count': count,
            // 'csrf': csrf,
        };
        $.ajax({
            url: 'update',
            type: 'get',
            data: data,
            dataType: 'json',
            async: false,
            success:function (data) {
                console.log('ok');
                if (data.status == 1){
                    status = true;
                } else {
                    alert(data.msg);
                }
            }
        });
        return status
    }

    //点击全选和全不选
    $('#checkall').click(function () {
        var is_ckecked = $(this).prop('checked');
        $('.checked').each(function () {
            $(this).prop('checked', is_ckecked);
        });
        update_page_info();
    });

    //根据选择数量判断全选是否被选中
    $('.checked').click(function () {
        var goods_num = $('.checked').length;
        var checked_goods_num = $('.cart_list_td').find(':checked').length;
        console.log(goods_num);
        console.log(checked_goods_num);
        if (checked_goods_num == goods_num) {
            $('#checkall').prop('checked', true);
        } else {
            $('#checkall').prop('checked', false);
        }
        update_page_info();
    });

    //点击商品增加
    $('.add').click(function () {
        var sku_id = $(this).next().attr('sku_id');
        var count = $(this).next().val();
        count = parseInt(count) + 1;
        //更新购物车
        var status = update_cart_info(sku_id, count);
        //更新页面显示
        if (status) {
           $(this).next().val(count);
            // 更新小计
            var price = $(this).parents('.cart_list_td').find('.price').text();
            var amount = parseFloat(price) * count;
            $(this).parents('.cart_list_td').find('.amount').text(amount.toFixed(2));
            //更新被选中商品的数量和价格
            update_page_info();
        }
    });

    // 点击商品减少
    $('.minus').click(function () {
        var sku_id = $(this).prev().attr('sku_id');
        var count = $(this).prev().val();
        count = parseInt(count);
        if (count < 2) {
            count = 1;
        } else {
            count -= 1;
        }
        //更新购物车
        var status = update_cart_info(sku_id, count);
        // 更新页面显示
        if (status) {
            $(this).prev().val(count);
            // 更新小计
            var price = $(this).parents('.cart_list_td').find('.price').text();
            var amount = parseFloat(price) * parseInt(count);
            $(this).parents('.cart_list_td').find('.amount').text(amount.toFixed(2));
            //更新被选中商品的数量和价格
            update_page_info();
        }
    });

    //保存输入框之前的数据
    var pre_count ;

    //鼠标点击输入框时
    $('.num_show').focus(function () {
        pre_count = $(this).val();
        console.log(pre_count);
    });

    //手动输入商品数量
    $('.num_show').blur(function () {
        var count = $(this).val();
        var sku_id = $(this).attr('sku_id');
        // 数据校验
        if (isNaN(count) || count.trim().length == 0 || parseInt(count) <= 0) {
            count = pre_count;
        }
        console.log(count);
         //更新购物车
        var status = update_cart_info(sku_id, count);
        // 更新页面显示
        if (status) {
            $(this).val(count);
            // 更新小计
            var price = $(this).parents('.cart_list_td').find('.price').text();
            var amount = parseFloat(price) * parseInt(count);
            $(this).parents('.cart_list_td').find('.amount').text(amount.toFixed(2));
            //更新被选中商品的数量和价格
            update_page_info();
        } else {
            $(this).val(pre_count);
        }

    });

    //点击删除
    $('.delete').click(function () {
        var sku_id = $(this).attr('sku_id');
        var is_delet = false;
        $.ajax({
            url: 'delete',
            type: 'get',
            data: {'sku_id': sku_id},
            dataType: 'json',
            async: false,
            success: function (data) {
                console.log('ok');
                if (data.status == 1) {
                    // console.log($(this).parents('ul'));
                    // $(this).parents('ul').remove();
                    // console.log($(this).parents('ul'));
                    is_delet = true;
                    update_page_info();
                } else {
                    alert(data.msg);
                }
            }
        });
        if (is_delet) {
            console.log('ok');
            $(this).parents('ul').remove();
        }
    });


});