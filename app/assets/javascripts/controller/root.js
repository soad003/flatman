angular.module('flatman').controller("rootCtrl",function($scope,Util){
    $scope.Util=Util;

    $scope.search=function(){
        Util.redirect_to.search($scope.search_term);
    };

});
