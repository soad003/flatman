angular.module('flatman').controller("financesService", function($resource){
	return $resource('/api/flat/:id',{}, {
				'create': {method: "PUT"},
				'get': {method: "GET"},
				'update': {method:"POST"},
				'destroy'_ {method:"DELETE"}
	});



});