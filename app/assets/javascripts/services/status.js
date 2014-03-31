angular.module('flatman').factory("statusService",function($resource) {
    var res=$resource('/api/status/',{},
            {
                'get': {method: "GET"}
            });

    return {
        get: function(succ,err) { return res.get({},{},succ,err); }
    }
});
