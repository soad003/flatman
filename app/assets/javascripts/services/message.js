angular.module('flatman').service("messageService", function($resource) {
    var messageSer = $resource('/api/message/:id',{},
                        {
                            'get': {method: "GET", isArray:true},
                            'create': {method: "POST"},
                            'destroy': {method: "DELETE", isArray:true}                            
                        });
    var messagesSer = $resource('/api/message/messages/:id', {},
                        {
                            'get': {method: "GET", isArray:true}
                            
                        });

    var flatChatSer = $resource('/api/message/flatChat', {},
                        {
                            'getFlatChat': {method: "GET"}
                        });

    var partnerSer = $resource('/api/message/:id/partner/:option', {},
                        {
                            'getPartner': {method: "GET"},
                            'getActiveChat': {method: "GET"}
                        });

    var usersSer = $resource('/api/message/users/', {},
                        {
                            'getUsers': {method: "GET", isArray:true}
                        });
    var userSer = $resource('/api/message/user/', {},
                        {
                            'getUserId': {method: "GET"}
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
            count: function(chat_id) {
                return countSer.count({id: chat_id});
            },
            countFlat: function(){
                return countSer.count();
            },
            getFlatChat: function(){
                return flatChatSer.getFlatChat();
            }
        },
        user: {
            getUsers: function(){ return usersSer.getUsers();},
            getUserId: function(){ return userSer.getUserId();}
        },
        messages: {
            get: function(mesId){ return messagesSer.get({id: mesId});}
        },
        partner: {
            getPartner: function(mesId) {
                return partnerSer.getPartner({id:mesId});
            },
            getActiveChat: function(mesId, active){ 
                return partnerSer.getActiveChat({id:mesId, option: active});
            }
        }
    }
    
});