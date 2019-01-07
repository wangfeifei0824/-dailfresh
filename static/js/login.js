$(function () {
    $('#log_form').submit(function() {
        console.log( $('#issave').attr('checked'));
        if($('#username').val().length == 0 || $('#pwd').val().length == 0) {
            return false;
        } else {
            return true;
        }

    });
})