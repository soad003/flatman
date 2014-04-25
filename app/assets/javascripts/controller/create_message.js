angular.module('flatman').controller("create_messageCtrl", function($scope, messageService, userService, Util){
	$scope.messages = messageService.message.get();
	
	$scope.newMess = {sender_id: "", receiver_id: "", text: "", header: "", read: true};
	
	//userService.find($scope.newMess.receiver_id); find receiverlist for suggestions
	
    $scope.createMessage=function(){
        messageService.message.create($scope.newMess,function(data){
                $scope.messages.push(data);
                $scope.newMess.text='';
        });
    };
    

});