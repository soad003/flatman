function scrolldown() {$("#scrollarea").animate({ scrollTop: 0 }, "fast");}

function start(time){
	//scrolldown();
    var myVar = window.setTimeout(function() {
        var elem = document.getElementById('scrollarea');
        elem.scrollTop = elem.scrollHeight;
    }, time);
};