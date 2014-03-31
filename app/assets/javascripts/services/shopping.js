angular.module('flatman').factory("shoppingService",function($resource) {
    var listService = $resource('/api/shoppinglist/:id',{},
                        {
                            'get': {method: "GET", isArray:true},
                            'create': {method: "POST"},
                            'destroy': {method: "DELETE"}
                        });

   var itemService = $resource('/api/shoppinglist/:l_id/shoppingitem/:id',{},
                        {
                            'create': {method: "POST"},
                            'destroy': {method: "DELETE"},
                            'update': {method: "PUT"}
                        });
    return {
        list: {
            get: function(){ return listService.get();},
            create: function(name,succH,errH) {
                listService.create(null,{name: name},succH,errH);
            },
            destroy: function(list_id,succH,errH){
                listService.destroy({id: list_id},succH,errH);
            }
        },
        item: {
            create: function(list_id,text,succH,errH){
                itemService.create({l_id: list_id},{name:text},succH,errH);
            },
            update: function(item,list_id,succH,errH){
                itemService.update({l_id: list_id,id: item.id},item,succH,errH);
            },
            destroy: function(item_id,list_id,succH,errH){
                itemService.destroy({l_id: list_id,id: item_id},succH,errH);
            }
        }

    }

});
