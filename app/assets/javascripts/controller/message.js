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
                        start(500);
                    }   // two people write at the same time
                    else if (mass.flat_messages.length > 1 && mass.flat_messages[mass.flat_messages.length-2].readers.indexOf($scope.currentUserId.id) == -1){
                        $scope.setAllRead = false;
                        $scope.messages = messageService.messages.get($scope.activeChat.id);
                        start(500);
                    }   // three people write at the same time
                    else if (mass.flat_messages.length > 2 && mass.flat_messages[mass.flat_messages.length-3].readers.indexOf($scope.currentUserId.id) == -1){
                        $scope.setAllRead = false;
                        $scope.messages = messageService.messages.get($scope.activeChat.id);
                        start(500);
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
                            start(500);
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
        start(1000);
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
                    $scope.newMess.header = "";
                }
                messageService.message.create($scope.newMess,function(data){
                    $scope.messages.push(data);
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
        var date = new Date();
        var min = date.getMinutes();
        var sec = date.getSeconds();
        // message will be marked as unread ~5 sec
        if (sec >= 0 && sec <= 5){
            sec = 58;
            if (min !== 0){
                min = min - 1;
            }
        }
        else {
            sec = sec - 5;
        }
        date.setMilliseconds(0);
        date.setSeconds(sec);
        date.setMinutes(min);
        return (date.toISOString() < mes.updated_at);
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
        if (time === null){
            return null;
        }
        if (time === undefined){
            return null;
        }

        if (time !== undefined){
            $scope.dateTime = time.split("T");
            $scope.date = $scope.dateTime[0];
            //2014-05-05 $scope.date
            $scope.time = $scope.dateTime[1].split(".");
            $scope.time = $scope.time[0]


            //letzter So im März um 2:00 +1h
            //letzter So im Oktober um 3:00 -1h

            var todayDay = new Date().getDate().toString();
            var todayMonth = (new Date().getMonth() + 1).toString();
            if (todayMonth.length < 2)
                todayMonth = "0" + todayMonth;
            var todayYear = new Date().getFullYear().toString();
            if (todayDay.length < 2)
                todayDay = "0" + todayDay;
            var todayDate = todayYear + "-" + todayMonth + "-" + todayDay;
            if (todayDay == "01")
                if (todayMonth == "01"){
                    todayYear = (parseInt(todayYear, 10) - 1).toString();
                    todayDay = "31";
                }
                else 
                    switch(todayMonth){
                        case "05":
                        case "07":
                        case "10":
                        case "12": todayMonth = (parseInt(todayMonth, 10) - 1).toString();
                            todayDay = "30";
                            break;
                        //  das durch 4, aber nicht auch durch 100 ohne Rest teilbar ist, mit der Ausnahme, dass ein durch 400 ohne Rest teilbares Jahr wiederum ein Schaltjahr ist
                        case "03":  if ((parseInt(todayYear, 10)%4 === 0 && parseInt(todayYear, 10)%100 !== 0) || parseInt(todayYear, 10)%400 === 0)
                                        {todayDay = "29";}
                                    else {todayDay = "28";}
                            todayMonth = (parseInt(todayMonth, 10) - 1).toString();
                            if (todayMonth.length < 2)
                                todayMonth = "0" + todayMonth;
                            break;
                        case "02": 
                        case "04":
                        case "06":
                        case "08":
                        case "09":
                        case "11": todayMonth = (parseInt(todayMonth, 10) -1).toString();
                                    if (todayMonth.length < 2)
                                        todayMonth = "0" + todayMonth;
                                    todayDate = "31";
                                    break;

                }
            else {
                todayDay = (parseInt(todayDay, 10) -1).toString();
                if (todayDay.length < 2)
                    todayDay = "0" + todayDay;
            }
            var yesterday = todayYear + "-" + todayMonth + "-" + todayDay;
            if (todayDate == $scope.date)
                return "today" +" "+ $scope.time;
            else if (yesterday == $scope.date && modus == "0")  // chat view
                return "yesterday";
            else if (yesterday == $scope.date && modus == "1")  // messages view
                return "yesterday" +" "+ $scope.time;
            else if (modus == "0")
                return $scope.date;
            else if (modus == "1")
                return $scope.date +" "+ $scope.time;
        }
    };

})