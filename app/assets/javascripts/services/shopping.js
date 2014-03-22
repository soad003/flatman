angular.module('flatman').factory("shoppinglistService",function($resource) {
    return $resource('/api/shoppinglist/:id',{},
        {
            'get': {method: "GET", isArray:true},
            'create': {method: "POST"},
            'destroy': {method: "DELETE"}
        });

}).factory("shoppingitemService",function($resource){
    return $resource('/api/shoppinglist/:l_id/shoppingitem/:id',{},
        {
            'create': {method: "POST"},
            'destroy': {method: "DELETE"}
        });

});
