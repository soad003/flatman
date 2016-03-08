angular.module('flatman').controller("rootCtrl",function($scope,$rootScope,$window,$timeout,$location,$route,Util,statusService){
    $scope.Util=Util;
    $scope.error_type="danger";
    $rootScope.pending_status_requests=0;
    $scope.online = navigator.onLine;

    $scope.isLoading = function(){ return ($rootScope.pending_requests - $rootScope.pending_status_requests)>0; };

    $scope.isActive = function(route) {
        return route === $location.path();
    };

    $scope.delete_error=function(index){
        Util.delete_server_error(index);
    };

    $scope.reload_view=function(){$route.reload();}

    $scope.go_right=function(){Util.redirect_to.next_view($location.path());}
    $scope.go_left=function(){Util.redirect_to.previous_view($location.path());}

    $window.addEventListener("offline", function() {
        $scope.$apply(function() {
          $scope.online = false;
        });
      }, false);

    $window.addEventListener("online", function() {
        $scope.$apply(function() {
          $scope.online = true;
        });
    }, false);

    // (function tick() {
    //     $scope.pending_status_requests++;
    //     statusService.get(function(data){
    //         if($scope.old_status){   
    //             $scope.emitEvents($scope.old_status,data);
    //         }
    //         $scope.old_status = data;
    //         $timeout(tick, 5000);
    //         $scope.pending_status_requests--;
    //     },
    //     function(){ $scope.pending_status_requests--; });
    // })();

    // $scope.emitEvents=function(old_status,new_status) {
        //$scope.$broadcast('message_count_changed', new_status);
    // };

});
