angular.module('flatman').controller("messageCtrl", function($scope, $route, $timeout, messageService, statusService, Util){
    $scope.chats = messageService.message.get();
    $scope.messages = [];
    $scope.chatView = true;
    $scope.chatPartner = null;
    $scope.unreadCounter = [];
    $scope.mesStatus = null;

    (function check() {
        if($scope.message_status_changed){
            $scope.chats = messageService.message.get();
        }
        $scope.message_status_changed = false;
        $timeout(check, 2000);
    })();


    $scope.newMess = {sender_id: "", receiver_id: "", text: "", header: "", read: false};

    $scope.getMessages = function (chat, index){
        $scope.chatView = false;
        $scope.messages = messageService.messages.get(chat.id);
        $scope.chatPartner = messageService.partner.getPartner(chat.id);
    };

    $scope.toggleView = function(){
	$scope.chats = messageService.message.get();
        if($scope.chatView === true)
            $scope.chatView = false;
        else
            $scope.chatView = true;
    };

    $scope.sendMessage=function(){
        $scope.newMess.receiver_id = $scope.chatPartner.id
        messageService.message.create($scope.newMess,function(data){
                $scope.messages.push(data);
                //alert(JSON.stringify(data));
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

    $scope.countUnread=function(chat, index){
        $scope.unreadCounter[index] = messageService.message.count(chat.id, index);
    };

    $scope.getUnreadCounter=function(index){
        return $scope.unreadCounter[index].counter;
    };

    $scope.checkLastSender = function(sender, partner){
        return sender == partner;
    };

    $scope.parseTime = function(time, modus){
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

        // Mon May 05 2014 09:29:33 GMT+0200 (CEST)
    };

    /*$scope.$on('message_count_changed', function(event, message){
        $scope.chats = messageService.message.get();
        alert("get broadcast");
    });*/

});
