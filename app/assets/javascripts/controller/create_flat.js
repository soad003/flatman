angular.module('flatman').controller("createFlatCtrl",function($scope,flatService,Util){
    $scope.newFlat={ city:"", name:"", zip:"", street:"" };

    $scope.create_flat=function(){
        flatService.flat.create({},$scope.newFlat, function(){
            $scope.newFlat ={};
            location.href="/"; //real page reload to get all menues
        });
    };

});
