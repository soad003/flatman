angular.module('flatman').controller("rootCtrl",function($scope,$timeout,$location,Util,statusService){
    $scope.Util=Util;

    $scope.isActive = function(route) {
        return route === $location.path();
    }

    $scope.search=function(){
        Util.redirect_to.search($scope.search_term);
    };

    (function tick() {
        $scope.server_status=statusService.get(function(){
            $timeout(tick, 50000);
        });
    })();

});
