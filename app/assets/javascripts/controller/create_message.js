angular.module('flatman').controller("create_messageCtrl", function($scope, messageService, Util){
    $scope.messages = messageService.message.get();
    $scope.users = [];
    $scope.newMess = {sender_id: "", receiver_id: "", text: "", header: "", read: true};

    $scope.createMessage=function(){
        messageService.message.create($scope.newMess,function(data){
            $scope.messages.push(data);
            $scope.newMess.text='';
        });
    };

    $scope.fetchUsers=function(){
        $scope.users = messageService.user.getUsers();
    };
});
