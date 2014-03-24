angular.module('flatman').service("sharingService",function() {

	this.get = function() {
		return 	{name: 'Lötkolben', available: true};
	}
/*
    this.get = function() {
    	return JSON.parse(localStorage.getItem('sharingitems')) || new Array(); 
    };
    
    this.save = function(lists) { 
    	localStorage.setItem('sharingitems',JSON.stringify(lists)); 
   	};
*/
});
