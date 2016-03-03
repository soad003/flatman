angular.module('flatman').controller("pinboardCtrl",function($scope,$location,shoppingService,todoService,Util){

    var SHOP_TYPE="shop";
    var TODO_TYPE="todo";

    function get_service(list){
        return (list.type==TODO_TYPE)? todoService : shoppingService;
    }

    $scope.filter_type=($location.path()==="/shopping")? SHOP_TYPE: TODO_TYPE;
    $scope.lists = [];
    
    $scope.filtered_shopping=function(){return $scope.filter_type===SHOP_TYPE; };
    $scope.filtered_todo=function(){return $scope.filter_type===TODO_TYPE; };

    $scope.is_shopping = function(list){ return list.type===SHOP_TYPE; };

    $scope.is_todo = function(list){ return list.type===TODO_TYPE; };

    $scope.only_shopping=function(){ $scope.filter_type=SHOP_TYPE; };

    $scope.only_todo=function(){ $scope.filter_type=TODO_TYPE; };

    $scope.only_all=function(){ $scope.filter_type=""; };

    $scope.create_todo=function(result){ 
        todoService.list.create(result, function(data){
                data.items=[];
                data.type=TODO_TYPE;
                $scope.lists.push(data);
        });                                          
    };

    $scope.create_shoppinglist=function(result){
        shoppingService.list.create(result, function(data){
                data.items=[];
                data.type=SHOP_TYPE;
                $scope.lists.push(data);
        });
    };

    $scope.remove_item=function(list,item){
        get_service(list).item.destroy(item.id,list.id,function(){
            list.items = _(list.items).without(item);
        });
    };

    $scope.remove_list=function(list){
        get_service(list).list.destroy(list.id,function(){
            $scope.lists = _($scope.lists).without(list);
        });
    };

    $scope.add_item=function(list){
        get_service(list).item.create(list.id,list.new_Text,function(data){
                list.items.push(data);
                list.new_Text='';
        });
    };

    $scope.delete_checked=function(list){
        get_service(list).list.destroy_checked(list.id, function(data){
            list.items= _(list.items).reject(function(i){ return i.checked});
       });
    };

    $scope.change_checked=function(list,item){
        get_service(list).item.update(item,list.id,null, function(){
            item.checked=!item.checked;
        });
    };

    $scope.get_color=function(index){
        var colors=['success','info','warning','danger'];
        return colors[index%4];
    };

    $scope.done_shopping=function(list){
       Util.redirect_to.finances_done_shopping(list.name);
    };

    shoppingService.list.get(function(data){
        $scope.lists = $scope.lists.concat(data);
    });  

    todoService.list.get(function(data){
        $scope.lists = $scope.lists.concat(data);
    });  
    

});
