angular.module('flatman').factory("tagService", function($resource) {
	var tagService = $resource('/api/tag/:term', {}, {
		'get' : {
			method : "GET"
		}
	});
	
	return {
		get : function(slug, succH, errH) {
			return tagService.get({
					term : slug
			}, {}, succH, errH);
		}
	};
});


    