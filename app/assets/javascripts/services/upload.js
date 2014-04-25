angular.module('flatman').factory("uploadService", function($resource) {
	
	
	var uploadService = $resource('/api/upload/', {
		
	}, {
		'upload'	: {method: 'POST'}
	})
	
	return {
			upload:
				function(file, succH, errH) { 
					return uploadService.upload({file:file}, {}, succH, errH); 
				}
	}
	
});