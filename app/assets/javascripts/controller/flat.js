angular.module('flatman').controller("flatCtrl",function($scope,flatService){
    $scope.newFlat={};

    $scope.createFlat=function(){
        flatService.create({},$scope.newFlat);
    };

});
