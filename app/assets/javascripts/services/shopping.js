angular.module('flatman').factory("shoppingService",function($resource) {
    var listService = $resource('/api/shoppinglist/:id',{},
                        {
                            'get': {method: "GET", isArray:true},
                            'create': {method: "POST"},
                            'destroy': {method: "DELETE"},
                            'destroy_checked': {method: "DELETE", url: "delete_checked"}
                        });
    var listDeleteCheckedService = $resource('/api/shoppinglist/:id/delete_checked',{},
                        {
                            'destroy_checked': {method: "DELETE"}
                        });
    var wasShoppingService = $resource('/api/shoppinglist/:id/was_shopping',{},
                    {
                            'was_shopping': {method: "DELETE"}
                    });
    var itemService = $resource('/api/shoppinglist/:l_id/shoppingitem/:id',{},
                        {
                            'create': {method: "POST"},
                            'destroy': {method: "DELETE"},
                            'update': {method: "PUT"}
                        });

    var summaryService = $resource('/api/shopping/get_most_bought_items',{},
                        {
                            'get_most_bought_items': {method: "GET", isArray:true}
                        });
    return {
        list: {
            get: function(succH,errH){ return listService.get(null,succH,errH);},
            create: function(name,privat,succH,errH) {
                listService.create(null,{name: name, privat:privat},succH,errH);
            },
            destroy: function(list_id,succH,errH){
                listService.destroy({id: list_id},succH,errH);
            },
            destroy_checked: function(list_id,succH,errH){
                listDeleteCheckedService.destroy_checked({id: list_id},succH,errH);
            },
            was_shopping: function(list_id,succH,errH){
                wasShoppingService.was_shopping({id: list_id},succH,errH);
            },
            get_item_count: function(lists){
                return _(lists).reduce(function(memo, l){ return memo + _(l.items).filter(function(item){return !item.checked;}).length; }, 0);
            },
            get_summary_string: function(list, checked, characters){
                checked = checked || false;
                characters = characters || 100;
                return _.chain(list.items).filter(function(item){return item.checked === checked;})
                                .value()
                                .reduce(function(mem,item){
                                                            return mem + item.name + ", "
                                                        },"")
                                .slice(0,50);
            }
        },
        item: {
            create: function(list_id,text,succH,errH){
                itemService.create({l_id: list_id},{name:text, checked: false},succH,errH);
            },
            update: function(item,list_id,succH,errH){
                itemService.update({l_id: list_id,id: item.id},item,succH,errH);
            },
            destroy: function(item_id,list_id,succH,errH){
                itemService.destroy({l_id: list_id,id: item_id},succH,errH);
            },
            get_most_bought_items: function(succH,errH){
                return summaryService.get_most_bought_items({},succH,errH);
            }
        }

    }

});
