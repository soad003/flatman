angular.module('flatman').controller("rootCtrl",function($scope,$rootScope,$timeout,$location,Util,statusService){
    $scope.Util=Util;
    $scope.error_type="danger";
    $scope.pending_status_requests=0;
    $scope.message_status_changed=true;

    $scope.isLoading = function(){ return ($rootScope.pending_requests - $scope.pending_status_requests)>0; };

    $scope.isActive = function(route) {
        return route === $location.path();
    };

    $scope.search=function(){
        Util.redirect_to.search($scope.search_term);
    };

    $scope.delete_error=function(index){
        Util.delete_server_error(index);
    };

    (function tick() {
        $scope.pending_status_requests++;
        statusService.get(function(data){
            if($scope.server_status){
                $scope.emitEvents($scope.server_status,data);
            }

            $scope.server_status=data;

            $timeout(tick, 5000);
            $scope.pending_status_requests--;
        },
        function(){ $scope.pending_status_requests--; });
    })();

    $scope.emitEvents=function(old_status,new_status) {
        if(old_status.unread_messages!==new_status.unread_messages) {
            $scope.message_status_changed = true;
        }
    };

});
