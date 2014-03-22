angular.module('flatman').controller("flatCtrl",function($scope,flatService,Util){
    $scope.newFlat={};

    $scope.create_flat=function(){
        flatService.create({},$scope.newFlat, function(){
            if(!Util.has_server_errors()){
                $scope.newFlat ={};
                Util.redirect_to.dashboard();
            }
        });
    };

});
