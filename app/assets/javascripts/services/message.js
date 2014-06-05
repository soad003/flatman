angular.module('flatman').service("messageService", function($resource) {
    var messageSer = $resource('/api/message/:id',{},
                        {
                            'get': {method: "GET", isArray:true},
                            'create': {method: "POST", isArray:true},
                            'destroy': {method: "DELETE"}                            
                        });
    var messagesSer = $resource('/api/message/messages/:id/:quantity', {},
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

    var usersSer = $resource('/api/message/users/:id', {},
                        {
                            'getUsers': {method: "GET", isArray:true},
                            'getFlatUsers': {method: "GET"}
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
            destroy: function(chat_id) {
                messageSer.destroy({id: chat_id});
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
            getUserId: function(){ return userSer.getUserId();},
            getFlatUsers: function(flat_id, succH){
                usersSer.getFlatUsers({id: flat_id}, succH);
            }
        },
        messages: {
            get: function(mesId, quantity){ return messagesSer.get({id: mesId, quantity: quantity});}
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