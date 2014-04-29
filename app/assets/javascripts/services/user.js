angular.module('flatman').factory("userService",function($resource) {
    var userService = $resource('/api/user/',{},
            {
                'get': {method: "GET"}
            });

    return {
    	get: function(){return userService.get();},
    }

});
