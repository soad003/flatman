angular.module('flatman').controller("rootCtrl",function($scope,$rootScope,$timeout,$location,Util,statusService){
    $scope.Util=Util;
    $scope.error_type="danger";
    $scope.pending_status_requests=0;

    $scope.isLoading = function(){ return ($rootScope.pending_requests - $scope.pending_status_requests)>0; };

    $scope.isActive = function(route) {
        return route === $location.path();
    };

    $scope.search=function(){
        var tmp=$scope.search_term;
        $scope.search_term='';
        Util.redirect_to.search(tmp);
    };

    $scope.delete_error=function(index){
        Util.delete_server_error(index);
    };

    (function tick() {
        $scope.pending_status_requests++;
        statusService.get(function(data){
            if($scope.old_status){   
                $scope.emitEvents($scope.old_status,data);
            }
            if (data.unread_messages !== 0)
                $scope.server_status=data;
            else {
                $scope.server_status=null;
            }
            $scope.old_status = data;
            $timeout(tick, 5000);
            $scope.pending_status_requests--;
        },
        function(){ $scope.pending_status_requests--; });
    })();

    $scope.emitEvents=function(old_status,new_status) {
        var unread = 0;
        if (old_status.unread_messages !== null){
            unread = old_status.unread_messages;
        }
        if (unread!==new_status.unread_messages){
            $scope.$broadcast('message_count_changed', new_status);
        }
        else{
            for (var i = 0; i < new_status.msg_id.length; i++) {
                if (old_status.msg_id.indexOf(new_status.msg_id[i]) == -1){
                    $scope.$broadcast('message_count_changed', new_status);
                    break;
                }
            };
        }
    };

});
