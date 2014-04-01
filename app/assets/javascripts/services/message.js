angular.module('flatman').factory("messageService", function($resource) {
	

	return {
		get: 
			function(){ 
				return messageService.get();
			},

        create: function() {
            },
	}
	
});