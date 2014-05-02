angular.module('flatman').factory("shareService", function($resource) {
	
	var sharedItemService = $resource('/api/shareditem/:id', {
		
	}, {
		'get': {method: "GET"},
		'update': {method: "POST"},
		'destroy': {method: "DELETE"},
		'upload': {method: "PUT"}
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
					return sharedItemService.update({id:item.id}, item, succH, errH);
		
				},
			upload: 
				function(item, succH, errH) {
					return sharedItemService.upload({id : item.id}, item, succH, errH);
				},
			
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
					console.log(item);
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
