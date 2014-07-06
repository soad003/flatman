//called on every route change. config.js
function fix_android_stock_select(){
    $(function () {
      var nua = navigator.userAgent
      var isAndroid = (nua.indexOf('Mozilla/5.0') > -1 && nua.indexOf('Android ') > -1 && nua.indexOf('AppleWebKit') > -1 && nua.indexOf('Chrome') === -1);
      if (isAndroid) {
        $('select.form-control').removeClass('form-control').css('width', '100%');
      }
    });
}

