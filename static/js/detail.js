$(function () {
    //评论和详情的切换
    $('#comment').click(function () {
        $(this).attr('class', 'active');
        $('#introduce').attr('class','');
        $('#intblock').css('display', 'none');
        $('#comblock').css('display', 'block');
    });

    $('#introduce').click(function () {
        $(this).attr('class', 'active');
        $('#comment').attr('class','');
        $('#comblock').css('display', 'none');
        $('#intblock').css('display', 'block');
    });

// 计算商品的总价
    total_price();
    function total_price() {
        var price = $('.show_pirze').children('em').text();
        var count = $('.num_show').val();
        var total_price = parseFloat(price) * parseInt(count);
        $('.total').children('em').text(total_price.toFixed(2) + '元');
    }

  //更新购物车
    function update_cart_info(sku_id, count) {
        var status = false;
        data = {
            'sku_id': sku_id,
            'count': count,
        };
        console.log(data);
        $.ajax({
            url: '/cart/update',
            type: 'get',
            data: data,
            dataType: 'json',
            async: false,
            success:function (data) {
                console.log(data);
                if (data.status == 1){
                    total_price();
                    status = true;
                } else {
                    alert(data.msg);
                }
            }
        });
        return status
    }

    // 点击增加商品的数量
    $('.add').click(function () {
        var sku_id = $('#sku_id').text();
        var count = $('.num_show').val();
        var newCount = parseInt(count) + 1;
        var status = update_cart_info(sku_id, newCount);
        if (status){
            $('.num_show').val(newCount);
            total_price();
        }
    });


    // 减少商品的数量
    $('.minus').click(function () {
        var sku_id = $('#sku_id').text();
        var count = $('.num_show').val();
        if (count > 1) {
            var newCount = parseInt(count) - 1;
        } else {
            var newCount = 1;
        }
        var status = update_cart_info(sku_id, newCount);
        if (status){
            $('.num_show').val(newCount);
            total_price();
        }
    });

    //保存输入框之前的数据
    var pre_count ;

    //鼠标点击输入框时
    $('.num_show').focus(function () {
        pre_count = $(this).val();
        console.log(pre_count);
    });

    //手动输入商品的数量
    $('.num_show').blur(function () {
        var sku_id = $('#sku_id').text();
        var count = $(this).val();
        console.log(count);
        // 校验数据
         if (isNaN(count) || count.trim().length == 0 || parseInt(count) <1){
             $(this).val(parseInt(pre_count));

         } else {
              var status = update_cart_info(sku_id, count);
              if (status){
                 $(this).val(parseInt(count));
                 total_price();
              } else {
                 $(this).val(parseInt(pre_count));
              }
         }
    });



});