angular.module('flatman').service("resourceService",function($resource) {
  var resourceService = $resource('/api/resource/:id',{},
                        {
                            'getAll': {method: "GET", isArray:true},
                            'get': {method: "GET"},
                            'create': {method: "POST"},
                            'destroy': {method: "DELETE"},
                            'update': {method: "PUT"}
                        });

   var entryService = $resource('/api/resource/:r_id/resourceentry/:id',{},
                        {
                            'get': {method: "GET", isArray:true},
                            'create': {method: "POST"},
                            'destroy': {method: "DELETE"}                        
                        });
    return {
        resource: {
            getAll: function(succH, errH){
                return resourceService.getAll(null,succH, errH);
            },
            get: function(resource_id, succH, errH){
                return resourceService.get({id: resource_id},succH, errH);
            },
            create: function(resource,succH,errH) {
                resourceService.create(null,resource,succH,errH);
            },
            destroy: function(resource_id,succH,errH){
                resourceService.destroy({id: resource_id},succH,errH);
            },
            update: function(resource,succH,errH){
                resourceService.update({id: resource.id},resource,succH,errH);
            }
        },
        entry: {
            get: function(resource_id, page, succH, errH){
                return entryService.get({r_id: resource_id, id: page},succH, errH);
            },
            create: function(resource_id,entry,succH,errH){
                entryService.create({r_id: resource_id},entry,succH,errH);
            },
            destroy: function(resource_id, entry_id, succH,errH){
                entryService.destroy({r_id: resource_id,id: entry_id},succH,errH);
            }
        }

    };
});