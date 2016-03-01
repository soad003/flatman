angular.module('flatman').factory("newsfeedService",function($resource) {
    var newsfeedService = $resource('/api/newsfeed/',{},
                        {
                            'get': {method: "GET", isArray:true},
                            'create': {method: "POST"},
                        });
    return {
        newsfeed: {
            get: function(succH,errH){ return newsfeedService.get(succH,errH);},
            create: function(text,succH,errH) {
                newsfeedService.create(null,{text: text},succH,errH);
            }
        }
    }

});
