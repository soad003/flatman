angular.module('flatman').factory("shareService", function($resource) {
	
	var shareService = $resource('/api/share/:id', {
		
	}, {
	    'get': {method: "GET", isArray:true},
	    'create': {method: "POST"},
	    'destroy': {method: "DELETE"}
	});
	

	return {
		get: 
			function(){ 
				return shareService.get();
			},

        create: function(name, succH, errH) {
        		console.log(name);
                shareService.create(null, {name: name}, succH, errH);
            },
	}
	
});