angular.module('flatman').factory("newsfeedService",function($resource) {
    var newsfeedService = $resource('/api/newsfeed/:id',{},
                        {
                            'get': {method: "GET"},
                            'create': {method: "POST"},
                            'destroy': {method: "DELETE"}
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
            },
            destroy: function(newsitem_id, succH,errH){
                newsfeedService.destroy({id: newsitem_id},succH,errH);
            }
        },
        comment: {
            create: function(newsitem_id, text,succH,errH){
                commentService.create({newsitem_id: newsitem_id, text: text},succH,errH);
            }
        }
    }
});