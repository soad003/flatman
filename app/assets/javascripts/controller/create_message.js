angular.module('flatman').controller("create_messageCtrl", function($scope, $timeout, $q, messageService, Util){
    $scope.users = [];
    $scope.selectedUser = undefined;
    $scope.newMess = {sender_id: "", receiver_id: "", text: "", header: "", read: false, readers: [], deleted: []};
    $scope.labels = [];
    $scope.userNames = [];
    
    $scope.createMessage=function(){
        if ($scope.labels.length === 0){
            messageService.message.create($scope.newMess, function(data){
                $scope.newMess.text='';
            });
            $scope.selectedUser=''
        }
        else {
            $scope.newMess.header = "";
            for (var i = 0; i < $scope.labels.length; i++) {
                if ($scope.newMess.header === ""){
                    $scope.newMess.header = $scope.labels[i].id.toString();
                }
                else {
                    $scope.newMess.header = $scope.newMess.header + "," + $scope.labels[i].id.toString();
                }
            }
            $scope.newMess.receiver_id = $scope.labels[0].id
            messageService.message.create($scope.newMess ,function(data){
                $scope.newMess.text='';
                location.href ="/#/chats";
            });
            
        }
    };

    $scope.sendMessageToFlat=function(flat_id){
        messageService.user.getFlatUsers(flat_id, function(data){
            for (var i = 0; i < data.users.length; i++) {
                $scope.labels[i] = data.users[i];
            }
        })

    };

    (function check(){
        var dub = false;
        if ($scope.selectedUser !== undefined){
            if ($scope.selectedUser.id !== undefined){
                for (var i = 0; i < $scope.labels.length; i++) {
                    if ($scope.labels[i].id == $scope.selectedUser.id){
                        dub = true;
                        $scope.selectedUser=''
                        $scope.newMess.header = "dub";
                        messageService.message.create($scope.newMess, function(data){
                            $scope.newMess.text='';
                        });
                    }
                }
                if (!dub){
                    $scope.labels[$scope.labels.length] = ({text: $scope.selectedUser.name , id: $scope.selectedUser.id});
                    $scope.selectedUser='';
                }
            }
        }
        $timeout(check, 100);
    })();

    $scope.removeTag=function(index){
        $scope.labels.splice(index, 1);
    };

    $scope.fetchUsers=function(){
        $scope.users = messageService.user.getUsers();
    };
});
