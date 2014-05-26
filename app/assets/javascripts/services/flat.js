angular.module('flatman').factory("flatService",function($resource) {
    var mateService  = $resource('api/flat/mates', {},
                    {
                        'get': {method: "GET", isArray:true}
                    });
    var flatService = $resource('/api/flat/:id',{}, {
                'create': { method: "PUT"},
                'get': {method: "GET"},
                'update': {method: "POST"}
                 });
    return {
        flat: flatService,
        mates: mateService
    };

});
