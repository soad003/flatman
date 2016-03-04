angular.module('flatman').controller("pinboardCtrl",function($scope,$location,$modal,shoppingService,todoService,Util){

    var SHOP_TYPE="shop";
    var TODO_TYPE="todo";

    function get_service(list){
        return (list.type==TODO_TYPE)? todoService : shoppingService;
    }

    function open_modal(callback_succ, todo) {
        $modal.open({
                      animation: true,
                      templateUrl: 'create_list.html',
                      controller: 'createListCtrl',
                      size: null,
                      resolve: { is_todo: function() {return todo;} }
                    }).result.then(callback_succ);
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

    $scope.create_todo=function(){ 
        open_modal(function(result){
            todoService.list.create(result.text, result.priv, function(data){
                data.items=[];
                data.type=TODO_TYPE;
                $scope.lists.push(data);
            });  
        },true);                                     
    };

    $scope.create_shoppinglist=function(){
        open_modal(function(result){
            shoppingService.list.create(result.text, result.priv, function(data){
                    data.items=[];
                    data.type=SHOP_TYPE;
                    $scope.lists.push(data);
            });
        },false); 
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


angular.module('flatman').controller('createListCtrl', function ($scope, $modalInstance, is_todo) {
  $scope.item = {text:"", priv:false};
  $scope.is_todo = is_todo;

    // Ugly hack due to bug https://github.com/angular-ui/bootstrap/issues/2017
    setTimeout(function() {
        $(".modal").find('input:text:visible:first').focus();
    }, 200);
    
  $scope.ok = function () {
    $modalInstance.close($scope.item);
  };

  $scope.cancel = function () {
    $modalInstance.dismiss('cancel');
  };
});