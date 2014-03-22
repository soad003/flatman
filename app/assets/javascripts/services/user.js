angular.module('flatman').factory("userService",function($resource) {
    return $resource('/api/user/',{},
            {
                'get': {method: "GET"}
            });

});
