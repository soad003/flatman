angular.module('flatman').controller("rootCtrl",function($scope,Util,$location){
    $scope.Util=Util;

    $scope.isActive = function(route) {
        return route === $location.path();
    }

    $scope.search=function(){
        Util.redirect_to.search($scope.search_term);
    };

});
