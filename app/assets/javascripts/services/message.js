angular.module('flatman').service("messageService", function($resource) {
    var messageSer = $resource('/api/message/:id',{},
                        {
                            'get': {method: "GET", isArray:true},
                            'create': {method: "POST"},
                            'destroy': {method: "DELETE", isArray:true},
                            'count': {method: "GET", isArray:true}
                        });
    var messagesSer = $resource('/api/message/:id/messages/', {},
                        {
                            'get': {method: "GET", isArray:true}
                        });

    var partnerSer = $resource('/api/message/:id/partner/', {},
                        {
                            'getPartner': {method: "GET"}
                        });

    var userSer = $resource('/api/message/users/', {},
                        {
                            'getUsers': {method: "GET", isArray:true}
                        });

    var countSer = $resource('/api/message/:id/counter/', {},
                        {
                            'count': {method: "GET"}
                        });


    return {
        message: {
            get: function(){ return messageSer.get();},
            create: function(mes,succH,errH) {
                messageSer.create(mes,succH,errH);
            },
            destroy: function(chat_id, succH, errH) {
                return messageSer.destroy({id: chat_id}, succH, errH);
            },  
            count: function(chat_id, index) {
                return countSer.count({id: chat_id});
            }
        },
        user: {
            getUsers: function(){ return userSer.getUsers();}
        },
        messages: {
            get: function(mesId){ return messagesSer.get({id:mesId});}
        },
        partner: {
            getPartner: function(mesId) {
                return partnerSer.getPartner({id:mesId});
            }
        }
    }
    
});