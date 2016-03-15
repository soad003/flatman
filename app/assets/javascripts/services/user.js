angular.module('flatman').factory("userService",function($resource) {
    var userService = $resource('/api/user/',{},
            {
                'get': {method: "GET"},
                'update': {method: "POST"}
            });

    return {
        get: function(succH,errH){return userService.get(succH,errH);},
        update: function(pushflag, succH, errH){return userService.update({pushflag: pushflag}, succH, errH);}
    }

});
