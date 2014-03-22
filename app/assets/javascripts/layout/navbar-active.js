$(function(){
    $(".flatman-navbar-item").click(function(){
        $(".flatman-navbar-item").removeClass("active");
        $(this).addClass("active");
    });
});
