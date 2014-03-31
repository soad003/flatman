angular.module('flatman').factory("searchService",function($resource) {
    var res=$resource('/api/search/:term',{},
            {
                'get': {method: "GET"}
            });

    return {
        search: function(searchterm,succ,err) { return res.get({term:searchterm},{},succ,err); }
    }
});
