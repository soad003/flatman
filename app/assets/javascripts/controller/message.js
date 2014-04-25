angular.module('flatman').controller("messageCtrl", function($scope, messageService, userService, Util){
	$scope.messages = messageService.message.get();
	
    $scope.createMessage=function(){
        messageService.message.create($scope.newMess,function(data){
                $scope.messages.push(data);
                $scope.newMess.text='';
        });
    };
    

});