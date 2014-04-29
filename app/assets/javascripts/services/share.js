angular.module('flatman').factory("shareService", function($resource) {
	
	
	var sharedItemService = $resource('/api/shareditem/:id', {
		
	}, {
		'get': {method: "GET"},
		'update': {method: "POST"},
		'destroy': {method: "DELETE"}
	})
	
	var shareService = $resource('/api/share/:id', {
		
	}, {
	    'get': {method: "GET", isArray:true},
	    'create': {method: "POST"},
	    'destroy': {method: "DELETE"}
	});
	

	return {
		item: {
			get:
				function(itemid, succH, errH) { 
					return sharedItemService.get({id:itemid}, {}, succH, errH); 
				},
			update: 
				function(item, succH, errH) {
					console.log("schian is do");
					sharedItemService.update({id:item.id}, item, succH, errH);
					return "yeah yeah";
		
				}
		},
		
		//overview
		/*warum is die reihenfolge von die services relevanta?!?!??!?*/
		items: {	
			remove:
				function(item, succH, errH) {
					shareService.destroy({id : item.id}, succH, errH);
					
				},
			update:
				function(item, succH, errH) {
					sharedItemService.update({id:item.id}, item, succH, errH);
				},
			get: 
				function(){ 
					return shareService.get();
				},

       		create: 
       			function(name, succH, errH) {
	        		console.log(name);
	                shareService.create(null, {name: name}, succH, errH);
            	},
			},
		
	
		}
		
		
	
});