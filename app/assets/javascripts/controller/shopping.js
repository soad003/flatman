angular.module('flatman').controller("shoppingCtrl",function($scope,shoppingService){
    $scope.lists = shoppingService.get();

    $scope.removeTodo=function(list,item){
        list.todos = _(list.todos).without(item);
        shoppingService.save($scope.lists);
    };

    $scope.removeTodoList=function(list){
        $scope.lists=_($scope.lists).without(list);
        shoppingService.save($scope.lists);
    };

    $scope.addTodo=function(list){
        list.todos.push({text:list.new_Text,done:false});
        list.new_Text=''
        shoppingService.save($scope.lists);
    };

    $scope.addTodoList=function(){
        $scope.lists.push({name:$scope.todoListName,todos:new Array()});
        $scope.todoListName=''
        shoppingService.save($scope.lists);
    };
});
