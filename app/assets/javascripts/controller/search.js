angular.module('flatman').controller("searchCtrl",function($scope,$routeParams,Util){
    $scope.term = $routeParams.term;
});
