angular.module('flatman').controller("create_messageCtrl", function($scope, messageService, Util){
    $scope.messages = messageService.message.get();
    $scope.users = [];
    $scope.selectedUser = undefined;
    $scope.newMess = {sender_id: "", receiver_id: "", text: "", header: "", read: false, readers: [], deleted: [] };

    $scope.createMessage=function(){
        if ($scope.selectedUser === undefined){
            messageService.message.create($scope.newMess, function(data){
                $scope.newMess.text='';
            });
            $scope.selectedUser=''
        }
        else if ($scope.selectedUser.id === undefined) {
            messageService.message.create($scope.newMess, function(data){
                $scope.newMess.text='';
            });
            $scope.selectedUser=''
        }
        else {
            $scope.newMess.receiver_id = $scope.selectedUser.id;
            messageService.message.create($scope.newMess,function(data){
                $scope.messages.push(data);
                $scope.newMess.text='';
                location.href ="/#/messages";
            });
        }
    };

    $scope.fetchUsers=function(){
        $scope.users = messageService.user.getUsers();
    };
});
