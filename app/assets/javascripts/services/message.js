angular.module('flatman').factory("messageService", function($resource) {
	var messageSer = $resource('/api/message/:id',{},
                        {
                            'get': {method: "GET", isArray:true},
                            'create': {method: "POST"},
                            'destroy': {method: "DELETE"}
                        });

	return {
		message: {
            get: function(){ return messageSer.get();},
            create: function(mess,text,succH,errH) {
                messageSer.create(mess.id, {text: text},succH,errH);
            },
        },
    }
	
});