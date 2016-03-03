angular.module('flatman').controller("shoppingCtrl",function($scope,shoppingService,Util){
    $scope.removeItem=function(list,item){
        shoppingService.item.destroy(item.id,list.id,function(){
                list.items = _(list.items).without(item);
        });
    };

    $scope.removeList=function(list){
        shoppingService.list.destroy(list.id,function(){
            $scope.lists = _($scope.lists).without(list);
        });
    };

    $scope.addItem=function(list){
        shoppingService.item.create(list.id,list.new_Text,function(data){
                list.items.push(data);
                list.new_Text='';
        });
    };

    $scope.addList=function(){
        shoppingService.list.create($scope.ListName, function(data){
                data.items=[];
                $scope.lists.push(data);
                $scope.ListName='';
        });
    };

    $scope.changeChecked=function(list,item){
        shoppingService.item.update(item,list.id,null, function(){
            item.checked=!item.checked;
        });
    };

    $scope.getColor=function(index){
        var colors=['success','info','warning','danger'];
        return colors[index%4];
    };

    $scope.doneShopping=function(list){
       Util.redirect_to.finances_done_shopping(list.name);
    };

    $scope.deleteChecked=function(list){
        shoppingService.list.destroy_checked(list.id, function(data){
            list.items= _(list.items).reject(function(i){ return i.checked});
        });
    };

    $scope.lists = shoppingService.list.get();

});
