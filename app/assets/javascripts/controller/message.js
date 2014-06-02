angular.module('flatman').controller("messageCtrl", function($scope, $route, $q, $timeout, $sce, messageService, statusService, Util){
    $scope.activeChat = {sender_id: "", receiver_id: "", id: "" };

    $scope.loc = window.location.href.toString().split("/")
    $scope.activeChat.id = $scope.loc[$scope.loc.length -1];
    $scope.flatchatActive = false;
    if ($scope.activeChat.id == "chats"){
        $scope.flatchat = messageService.message.getFlatChat();
        $scope.chats = messageService.message.get();
    }
    else {
        $scope.flatchatActive = messageService.partner.getActiveChat($scope.activeChat.id, "option");
    }
    $scope.chatPartner = null;
    $scope.currentUserId = messageService.user.getUserId();
    $scope.unreadCounter = [];
    $scope.flatchatUnreadCounter = null;
    $scope.chatTexts = [];
    $scope.flatTexts = [];
    $scope.messages = [];
    $scope.setAllRead = false;
    


    $scope.$on('message_count_changed', function(event, mass){
        $scope.chats = messageService.message.get();
        $scope.flatchat = messageService.message.getFlatChat();
        $scope.currentFlatChatMessages = mass.flat_messages[mass.flat_messages.length-1];       // flat_messages fetch last
        $scope.currentChats = mass.chats;                                                       // last message of each chat
        $scope.countUnreadFlatChat();
        $q.all([$scope.flatchatActive.$promise, $scope.activeChat.$promise  // http://stackoverflow.com/questions/19944897/angularjs-run-code-after-multiple-resources-load
            ]).then(function() {
            if ($scope.flatchatActive.active === true){
                if ($scope.currentFlatChatMessages !== undefined){
                    if ($scope.currentFlatChatMessages.readers.indexOf($scope.currentUserId.id) == -1){
                        $scope.setAllRead = false;
                        $scope.messages = messageService.messages.get($scope.activeChat.id);
                        start(500, true);
                    }   // two people write at the same time
                    else if (mass.flat_messages.length > 1 && mass.flat_messages[mass.flat_messages.length-2].readers.indexOf($scope.currentUserId.id) == -1){
                        $scope.setAllRead = false;
                        $scope.messages = messageService.messages.get($scope.activeChat.id);
                        start(500, true);
                    }   // three people write at the same time
                    else if (mass.flat_messages.length > 2 && mass.flat_messages[mass.flat_messages.length-3].readers.indexOf($scope.currentUserId.id) == -1){
                        $scope.setAllRead = false;
                        $scope.messages = messageService.messages.get($scope.activeChat.id);
                        start(500, true);
                    }
                }
            }
            if (!isNaN($scope.activeChat.id)){
                for (var i = 0; i < $scope.currentChats.length; i++) {
                    if (($scope.currentChats[i].sender_id == $scope.activeChat.sender_id.id && $scope.currentChats[i].receiver_id == $scope.activeChat.receiver_id.id) ||
                        ($scope.currentChats[i].receiver_id == $scope.activeChat.sender_id.id && $scope.currentChats[i].sender_id == $scope.activeChat.receiver_id.id)){
                        if ($scope.currentChats[i].sender_id != $scope.currentUserId.id){
                            $scope.setAllRead = false;
                            $scope.messages = messageService.messages.get($scope.activeChat.id);
                            start(500, true);
                        }
                    }
                }
            }
        });
    });

    $scope.newMess = {sender_id: "", receiver_id: "", text: "", header: "", read: false, readers: [], deleted: [] };


    $scope.getMessages = function (){
        $scope.setAllRead = false;
        $scope.messages = messageService.messages.get($scope.activeChat.id);
        start(1000, false);
        if (!isNaN($scope.activeChat.id)){
            $scope.chatPartner = messageService.partner.getPartner($scope.activeChat.id);
            $scope.activeChat.sender_id = messageService.partner.getPartner($scope.activeChat.id);
            $scope.activeChat.receiver_id = messageService.user.getUserId();
        }
    };

    $scope.sendMessage=function(){
        $q.all([$scope.flatchatActive.$promise
            ]).then(function() {
                if ($scope.flatchatActive.active){
                    // to say controller that this is a flatchat message
                    $scope.newMess.header = "flatchat";
                    // set some value. later current_user.id will be set
                    $scope.newMess.receiver_id = 13;
                    $scope.newMess.sender_id = 13;
                    $scope.newMess.readers = [3];
                }
                else {
                    $scope.newMess.receiver_id = $scope.chatPartner.id
                    $scope.newMess.header = $scope.chatPartner.id.toString();
                }
                messageService.message.create($scope.newMess,function(data){
                    for (var i = 0; i < data.length; i++) {
                        $scope.messages.push(data[i]);
                    }
                    
                    $scope.newMess.text='';
                });
                $scope.setAllRead = true;
        });
    };

    $scope.removeChat=function(chat, question){
        bootbox.confirm(question, function(result) {
            if (result){
                messageService.message.destroy(chat.id);
                $scope.chats = _($scope.chats).without(chat);
                $scope.messages = [];

            }
            location.href="/#/chats";
        });

    };

    $scope.sendToFlat=function(flat_id){

    };

    $scope.countUnread=function(chat, index){
        $scope.unreadCounter[index] = messageService.message.count(chat.id);
    };

    $scope.countUnreadFlatChat=function(){
        $scope.flatchatUnreadCounter = messageService.message.countFlat();
    };

    $scope.getUnreadCounter=function(index){
        return $scope.unreadCounter[index].counter;
    };

    $scope.getFlatUnreadCounter=function(){
        if ($scope.flatchat.id !== undefined && $scope.flatchatUnreadCounter !== null){
            return $scope.flatchatUnreadCounter.counter;
        }
        else return 0;
    };

    $scope.checkLastSender = function(sender){
        return sender == $scope.currentUserId.id;
    };

    $scope.currentUserIsSender = function(mes){
        return (mes.sender_id == $scope.currentUserId.id);
    };

    // check if message.read is just now set to true. if this is the case the message should be shown as unread for few seconds
    $scope.currentlyRead = function(mes, allRead){
        if (allRead){
            return false;
        }
        var date = new Date().toISOString();
        var millis = Date.parse(date) - 5000;
        var compareDate = new Date(millis).toISOString();
        
        return (compareDate < mes.updated_at);
    };

    $scope.parseNewline = function(text, flatchat, index){
        if (text === undefined || text === null)
            return null;
        var data = "";
        data = text.split('\n');
        if (flatchat){
            $scope.flatTexts = data; 
        }
        else {
            $scope.chatTexts[index] = data;
        }
    }

    $scope.parseTime = function(time, modus){
        if (time === null || time === undefined){
            return null;
        }
        
        else {
            var millis = Date.parse(time);
            var day = new Date(millis).toISOString().split("T")[0];
            var daytime = new Date(millis).toISOString().split("T")[1].split(".")[0];
            var today = new Date().toISOString().split("T")[0];
            var yesterday = new Date(Date.parse(new Date().toISOString()) - 86400000).toISOString().split("T")[0];
            if (today == day)
                return "today" +" "+ daytime;
            else if (yesterday == day && modus == "0")  // chat view
                return "yesterday";
            else if (yesterday == day && modus == "1")  // messages view
                return "yesterday" +" "+ daytime;
            else if (modus == "0")
                return day;
            else if (modus == "1")
                return day +" "+ daytime;
        }
    };

})