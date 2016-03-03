angular.module('flatman').factory("newsfeedService",function($resource) {
    var newsfeedService = $resource('/api/newsfeed/',{},
                        {
                            'get': {method: "GET", isArray:true},
                            'create': {method: "POST"}
                        });
     var commentService = $resource('/api/newsfeed/comment/',{},
                        {
                            'create': {method: "POST"}
                        });
    return {
        newsfeed: {
            get: function(from, to, succH,errH){
                return newsfeedService.get({from: from, to: to}, succH,errH);
            },
            create: function(text,succH,errH) {
                newsfeedService.create(null,{text: text},succH,errH);
            }
        },
        comment: {
            create: function(newsitem_id, text,succH,errH){
                commentService.create({newsitem_id: newsitem_id, text: text},succH,errH);
            }
        }
    }
});