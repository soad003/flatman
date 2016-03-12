angular.module('flatman').factory("flatService",function($resource) {
    var mateService  = $resource('api/flat/mates', {},
                    {
                        'get': {method: "GET", isArray:true}
                    });
    var flatService = $resource('/api/flat/:id',{}, 
                    {
                    'create': { method: "PUT"},
                    'get': {method: "GET"},
                    'update': {method: "POST"}

                    });
    var userService = $resource('/api/flat/user',{}, 
                    {
                    'leave_flat': {method: "DELETE"},
                    'join_flat': {method: "PUT"}
                    });
    return {
        flat: flatService,
        mates: mateService,
        user: {
            leave_flat: function(succH,errH){ return userService.leave_flat(null,succH,errH);},
            join_flat: function(token,succH,errH){ return userService.join_flat({},{token: token},succH,errH);}
        }
    };

});
