angular.module('flatman').controller("messageCtrl", function($scope, messageService, Util){
	$scope.messages = messageService.message.get();

    $scope.createMessage=function(){
        messageService.message.create($scope.Username, $scope.newText,function(data){
                $scope.messages.push(data);
                $scope.Username='';
        });
    };
    

});
