angular.module('flatman').factory("flatService",function($resource) {
    return  $resource('/api/flat/:id',{},
            {
                'create': { method: "POST"}
            });

});
