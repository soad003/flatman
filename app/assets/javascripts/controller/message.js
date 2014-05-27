angular.module('flatman').controller("messageCtrl", function($scope, $route, $timeout, $sce, messageService, statusService, Util){
    $scope.flatchat = messageService.message.getFlatChat();
    $scope.chats = messageService.message.get();
    $scope.flatchatActive = false;
    $scope.flatchatMessages = [];
    $scope.messages = [];
    $scope.chatView = true;
    $scope.chatPartner = null;
    $scope.currentUserId = messageService.user.getUserId();
    $scope.unreadCounter = [];
    $scope.flatchatUnreadCounter = null;
    $scope.mesStatus = null;
    $scope.activeChat = null;
    $scope.chatTexts = [];

    $scope.$on('message_count_changed', function(event, mass){
        
        //console.log(JSON.stringify($scope.currentChats));
        if ($scope.chatView === true){
            $scope.chats = messageService.message.get();
            $scope.flatchat = messageService.message.getFlatChat();
        }
        
        $scope.currentFlatChatMessages = mass.flat_messages[mass.flat_messages.length-1];    // flat_messages fetch last
        $scope.currentChats = mass.chats;                       // last message of each chat

        $scope.countUnreadFlatChat();
        
        if ($scope.flatchatActive === true){
            if ($scope.currentFlatChatMessages !== undefined){
                if ($scope.currentFlatChatMessages.readers.indexOf($scope.currentUserId.id) == -1){
                    $scope.flatchatMessages = messageService.messages.getFlatChatMessages($scope.flatchat.id);
                    start(500);
                }   // two people write at the same time
                else if (mass.flat_messages.length > 1 && mass.flat_messages[mass.flat_messages.length-2].readers.indexOf($scope.currentUserId.id) == -1){
                    $scope.flatchatMessages = messageService.messages.getFlatChatMessages($scope.flatchat.id);
                    start(500);
                }   // three people write at the same time
                else if (mass.flat_messages.length > 2 && mass.flat_messages[mass.flat_messages.length-3].readers.indexOf($scope.currentUserId.id) == -1){
                    $scope.flatchatMessages = messageService.messages.getFlatChatMessages($scope.flatchat.id);
                    start(500);
                }
            }
        }
       
        if ($scope.activeChat !== null){
            for (var i = 0; i < $scope.currentChats.length; i++) {
                if (($scope.currentChats[i].sender_id == $scope.activeChat.sender_id && $scope.currentChats[i].receiver_id == $scope.activeChat.receiver_id) ||
                    ($scope.currentChats[i].receiver_id == $scope.activeChat.sender_id && $scope.currentChats[i].sender_id == $scope.activeChat.receiver_id)){
                    if ($scope.currentChats[i].sender_id != $scope.currentUserId.id){
                        $scope.messages = messageService.messages.get($scope.activeChat.id);
                        start(500);
                    }
                }
            }
        }
    });

    $scope.newMess = {sender_id: "", receiver_id: "", text: "", header: "", read: false, readers: [], deleted: [] };

    $scope.getMessages = function (chat, index){
        $scope.chatView = false;
        $scope.messages = messageService.messages.get(chat.id);
        $scope.chatPartner = messageService.partner.getPartner(chat.id);
        $scope.activeChat = chat;
        //console.log(JSON.stringify($scope.flatchat));
    };

    $scope.getFlatChatMessages = function (){
        $scope.chatView = false;
        $scope.flatchatActive = true;
        $scope.flatchatMessages = messageService.messages.getFlatChatMessages($scope.flatchat.id);
    };

    $scope.setChatView = function(){
	$scope.chats = messageService.message.get();
    $scope.flatchat = messageService.message.getFlatChat();
    $scope.flatchatUnreadCounter = messageService.message.count($scope.flatchat.id);
    $scope.chatView = true;
    $scope.flatchatActive = false;
    $scope.activeChat = null;
    };

    $scope.setMessView = function(){
        $scope.chatView = false;
        $scope.flatchatActive = false;
    };

    $scope.sendMessage=function(){
        if ($scope.flatchatActive === true){
            $scope.sendFlatChatMessage();
        }
        else {
            $scope.newMess.receiver_id = $scope.chatPartner.id
            $scope.newMess.header = "";
            messageService.message.create($scope.newMess,function(data){
                $scope.messages.push(data);
                //alert(JSON.stringify(data));
                $scope.newMess.text='';
            });
        }
    };

    $scope.sendFlatChatMessage=function(){
        // to say controller that this is a flatchat message
        $scope.newMess.header = "flatchat";
        // set some value. later current_user.id will be set
        $scope.newMess.receiver_id = 13;
        $scope.newMess.sender_id = 13;
        $scope.newMess.readers = [3];
        messageService.message.create($scope.newMess, function(data){
            $scope.flatchatMessages.push(data);
            $scope.newMess.text='';
        });
    };


    $scope.removeChat=function(chat, question){
        bootbox.confirm(question, function(result) {
            if (result){
                messageService.message.destroy(chat.id);
                $scope.chats = _($scope.chats).without(chat);
                $scope.messages = [];
            }
            $scope.chatView = true;
        });

    };

    $scope.removeFlatChat=function(question){
        bootbox.confirm(question, function(result) {
            if (result){
                $scope.flatchat = null;
                $scope.messages = [];
            }
            $scope.chatView = true;
            $scope.flatchatActive = false;
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
        //console.log($scope.flatchat);
        if ($scope.flatchat.id !== undefined && $scope.flatchatUnreadCounter !== null){
            return $scope.flatchatUnreadCounter.counter;
        }
        else return 0;
    };

    $scope.checkLastSender = function(sender){
        return sender == $scope.currentUserId.id;
    };

    $scope.currentUserIsSender = function(mes){
        var ret = (mes.sender_id == $scope.currentUserId.id);
        return ret;
    };
    // check if message.read is just now set to true. if this is the case the message should be shown as unread for few seconds
    $scope.currentlyRead = function(mes){
        var date = new Date();
        var min = date.getMinutes();
        var sec = date.getSeconds();
        // message will be marked as unread 10 - 19 sec
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
        //console.log(date.toISOString() + "---" + mes.updated_at);
        // console.log(date.toISOString() < mes.updated_at);
        // 2014-05-12T12:25:38.612Z---------2014-05-12T12:07:07.780Z
        //Mon May 12 2014 14:13:36 GMT+0200 (CEST)
        //Mon, 12 May 2014 12:07:07 UTC +00:00
        return (date.toISOString() < mes.updated_at);
    };

    $scope.parseText = function(text, flatchat, index){
        var data = "";
        var result = "";
        if (text === undefined || text === null)
            return null;
        if (text.indexOf("<br>") == -1){
            if (flatchat) {
                data = text;
                result = data.replace(/\n/g, "<br>");
                $scope.flatchat.text = result; 
            }
            else {
                data = text;
                result = data.replace(/\n/g, "<br>");
                $scope.chatTexts[index] = result;
            }
        }
        else {
            if (flatchat){
                $scope.flatchat.text = text; 
            }
            else{
                $scope.chatTexts[index] = text;
            }
            
        }

    };

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
        // Mon May 05 2014 09:29:33 GMT+0200 (CEST)
    };

}).filter('to_trusted', ['$sce', function($sce){
        return function(text) {
            return $sce.trustAsHtml(text);
        };
    }]);