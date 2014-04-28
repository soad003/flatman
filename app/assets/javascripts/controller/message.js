angular.module('flatman').controller("messageCtrl", function($scope, $route, messageService, Util){
	$scope.intro = false
    $scope.chats = messageService.message.get(function(){
        if ($scope.resources.length === 0){
            $scope.intro = true;
        }
    });
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
    	if($scope.chatView == true)
    		$scope.chatView = false
    	else
    		$scope.chatView = true
    };

    $scope.sendMessage=function(){
        $scope.newMess.receiver_id = $scope.chatPartner.name
        messageService.message.create($scope.newMess,function(data){
                $scope.messages.push(data);
                $scope.newMess.text='';
                
        });
        $route.reload();                                            // todo fix actualization
    };
	
});