angular.module('flatman').controller("shoppingCtrl",function($scope,shoppinglistService,shoppingitemService,Util){
    $scope.lists = shoppinglistService.get();

    $scope.removeItem=function(list,item){
        shoppingitemService.destroy({l_id: list.id,id: item.id},function(){
            if(!Util.has_server_errors()){
                list.items = _(list.items).without(item);
            }
        });
    };

    $scope.removeList=function(list){
        shoppinglistService.destroy({id: list.id},function(){
            if(!Util.has_server_errors()){
                $scope.lists = _($scope.lists).without(list);
            }
        });
    };

    $scope.addItem=function(list){
        shoppingitemService.create({l_id: list.id},{name:list.new_Text},function(data){
            if(!Util.has_server_errors()){
                list.items.push(data);
                list.new_Text='';
            }
        });
    };

    $scope.addList=function(){
        shoppinglistService.create(null,{name:$scope.ListName},function(data){
            if(!Util.has_server_errors()){
                $scope.lists.push(data);
                $scope.ListName='';
                list.lists = _(list.lists).without(list);
            }
        });
    };
});
