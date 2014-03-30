angular.module('flatman').factory("flatService",function($resource) {
    return $resource('/api/flat/:id',{}, {
                'create': { method: "PUT"},
                'get': {method: "GET"},
                'update': {method: "POST"}
    });

});
