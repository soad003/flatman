angular.module('flatman').controller("createFlatCtrl",function($scope,flatService,Util){
    $scope.newFlat={ city:"", name:"", zip:"", street:"" };

    $scope.create_flat=function(){
        flatService.create({},$scope.newFlat, function(){
            if(!Util.has_server_errors()){
                $scope.newFlat ={};
                location.href="/"; //real page reload to get all menues
            }
        });
    };

});
