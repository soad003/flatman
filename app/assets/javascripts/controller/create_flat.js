angular.module('flatman').controller("createFlatCtrl",function($scope,flatService,Util){
    $scope.newFlat={ city:"", name:"", zip:"", street:"" };

    $scope.create_flat=function(){
        flatService.create({},$scope.newFlat, function(){
            location.href="/"; //real pege reload to get all menues
        });
    };

});
