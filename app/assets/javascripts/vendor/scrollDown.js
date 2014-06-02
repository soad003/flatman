function scrolldown() {
	$("#scrollarea").animate({ scrollTop: 100000 }, "fast");
};

function start(time, send){
	if (!send){
		var scroll = document.getElementById('scrollarea');
		if (scroll != null){
			scroll.style.height = ($(window).height()-270).toString() + "px";
			var checkHeight = scroll.style.height.split("p")[0];
		}
	}
	if (document.getElementById('scrollarea') != null){
		// don't work on mobile phone
		scrolldown();
		var myVar = window.setTimeout(function() {
		    var elem = document.getElementById('scrollarea');
		    elem.scrollTop = elem.scrollHeight;
		}, time);
		// slow connections needs a longer timeout
		start2(2000);
	}
};

function start2(time){
	var myVar2 = window.setTimeout(function() {
		var elem2 = document.getElementById('scrollarea');
		elem2.scrollTop = elem2.scrollHeight;
	}, time);
};