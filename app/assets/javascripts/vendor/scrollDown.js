function scrolldown() {$("#scrollarea").animate({ scrollTop: 1000000 }, "fast");}

function test() {}

function start(){
	scrolldown();
    var myVar = window.setInterval(function() {
        var elem = document.getElementById('scrollarea');
        elem.scrollTop = elem.scrollHeight;
    }, 1000);

    function myStopFunction() {
    clearInterval(myVar);
};

$('#scrollarea').scroll(function(){
    myStopFunction();
  });
};