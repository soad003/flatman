angular.module('flatman').factory("messageService", function($resource) {
    var messageSer = $resource('/api/message/:id',{},
                        {
                            'get': {method: "GET", isArray:true},
                            'create': {method: "POST"},
                            'destroy': {method: "DELETE"}
                        });
    var messagesSer = $resource('/api/message/:id/messages/', {}, 
                        {
                            'get': {method: "GET", isArray:true},
                        });

    var partnerSer = $resource('/api/message/:id/partner/', {},
                        {
                            'getPartner': {method: "GET"},
                        });


    return {
        message: {
            get: function(){ return messageSer.get();},
            create: function(mes,succH,errH) {
                messageSer.create(mes,succH,errH);
            },

        },
        messages: {
            get: function(mesId){ return messagesSer.get({id:mesId});},
        },
        partner: {
            getPartner: function(mesId) {
                return partnerSer.get({id:mesId});
            },
        }
    }
    
});