angular.module('flatman').factory("todoService",function($resource) {
    var listService = $resource('/api/todo/:id',{},
                        {
                            'get': {method: "GET", isArray:true},
                            'create': {method: "POST"},
                            'destroy': {method: "DELETE"},
                            'destroy_checked': {method: "DELETE", url: "delete_checked"}
                        });
    var listDeleteCheckedService = $resource('/api/todo/:id/delete_checked',{},
                        {
                            'destroy_checked': {method: "DELETE"}
                        });
    var itemService = $resource('/api/todo/:l_id/todo_item/:id',{},
                        {
                            'create': {method: "POST"},
                            'destroy': {method: "DELETE"},
                            'update': {method: "PUT"}
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
            get_item_count: function(lists){
                return _(lists).reduce(function(memo, l){ return memo + _(l.items).filter(function(item){return !item.checked;}).length; }, 0);
            },
            get_summary_string: function(list){
                return _.chain(list.items).filter(function(item){return !item.checked;})
                                .take(3)
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
            }
        }

    }

});
