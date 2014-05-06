angular.module('flatman').controller("messageCtrl", function($scope, $route, messageService, Util){
    $scope.chats = messageService.message.get();
    $scope.messages = [];
    $scope.chatView = true;
    $scope.chatPartner = null;
    $scope.unreadCounter = [];
    $scope.summertime = true;


    $scope.newMess = {sender_id: "", receiver_id: "", text: "", header: "", read: false};

    $scope.getMessages = function (chat){
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
                messageService.message.destroy(chat.id, function(){
                    $scope.chats = _($scope.chats).without(chat);
                });
            }
        });
    };

    $scope.countUnread=function(chat, index){
        $scope.unreadCounter[index] = messageService.message.count(chat.id);
        //alert(JSON.stringify($scope.unreadCounter.header));
        return $scope.unreadCounter.header;
    };

    $scope.getUnreadCounter=function(index){
        return $scope.unreadCounter[index].header;
    };

    $scope.parseTime = function(time, modus){
        $scope.dateTime = time.split("T");
        $scope.date = $scope.dateTime[0];
        //2014-05-05 $scope.date
        $scope.time = $scope.dateTime[1].split(".");
        $scope.time = $scope.time[0]


        //letzter So im März um 2:00 +1h
        //letzter So im Oktober um 3:00 -1h
        var timediff = 1;
        if ($scope.summertime === true){
            timediff = 2;
        }

        //12:13:57,495Z $scope.time
        var timeArray = $scope.time.split(":");         // split hh:mm:ss
        var dateArray = $scope.date.split("-");         // split yyyy:mm:dd
        if (parseInt(timeArray[0],10) === 22 && $scope.summertime){
            timeArray[0] = "00";
            dateArray[2] = (parseInt(dateArray[2],10) + 1).toString();
        }
        else if (parseInt(timeArray[0],10) === 23){
            timeArray[0] = "01";
            dateArray[2] = (parseInt(dateArray[2],10) + 1).toString();
        }
        else{
            timeArray[0] = (parseInt(timeArray[0],10) + timediff).toString();
            if (timeArray[0].length < 2){
                timeArray[0] = "0" + timeArray[0];
            }
        }

        // rebuild time and date
        $scope.time = "";
        $scope.date = "";
        $scope.time = timeArray[0] + ":" + timeArray[1] + ":" + timeArray[2];
        $scope.date = dateArray[0] + "-" + dateArray[1] + "-" + dateArray[2];
        

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

});
