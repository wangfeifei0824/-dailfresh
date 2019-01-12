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

    // 增加商品的数量
    $('.add').click(function () {
       var count = $('.num_show').val();
       var newCount = parseInt(count) + 1;
       $('.num_show').val(newCount);
       total_price();
    });
    // 减少商品的数量
    $('.minus').click(function () {
       var count = $('.num_show').val();
       if (count > 1) {
          var newCount = parseInt(count) - 1;
       } else {
           var newCount = 1;
       }
       $('.num_show').val(newCount);
       total_price();
    });

    //手动输入商品的数量
    $('.num_show').blur(function () {
        var count = $(this).val();
        // 校验数据
         if (isNaN(count) || count.trim().length == 0 || parseInt(count) <=1){
             count = 1;
         }
         $(this).val(parseInt(count));
         total_price();
    });

    //加入购物车
    $('#add_cart').click(function () {

    })


});