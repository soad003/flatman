angular.module('flatman').controller("messageCtrl", function($scope, $route, messageService, Util){
    $scope.chats = messageService.message.get();
    $scope.messages = []
    $scope.chatView = true
    $scope.chatPartner = null
    

    $scope.newMess = {sender_id: "", receiver_id: "", text: "", header: "", read: true};
    
	$scope.getMessages = function (chat){
		$scope.chatView = false
		$scope.messages = messageService.messages.get(chat.id);
        $scope.chatPartner = messageService.partner.getPartner(chat.id)
    };

    $scope.toggleView = function(){
        $scope.chats = messageService.message.get();
    	if($scope.chatView == true)
    		$scope.chatView = false
    	else
    		$scope.chatView = true
    };

    $scope.sendMessage=function(){
        $scope.newMess.receiver_id = $scope.chatPartner.id
        messageService.message.create($scope.newMess,function(data){
                $scope.messages.push(data);
                //alert(JSON.stringify(data));
                $scope.newMess.text='';
                
        });
    };
	
});