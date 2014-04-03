angular.module('flatman').controller("rootCtrl",function($scope,$timeout,$location,Util,statusService){
    $scope.Util=Util;
    $scope.error_type="danger";

    $scope.isActive = function(route) {
        return route === $location.path();
    }

    $scope.search=function(){
        Util.redirect_to.search($scope.search_term);
    };

    $scope.delete_error=function(index){
        Util.delete_server_error(index);
    };

    (function tick() {
        $scope.server_status=statusService.get(function(){
            $timeout(tick, 5000);
        });
    })();

});
