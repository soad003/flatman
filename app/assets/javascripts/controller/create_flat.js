angular.module('flatman').controller("createFlatCtrl",function($scope,flatService,Util){
    $scope.create_flat=function(){
        flatService.flat.create({},$scope.newFlat, function(){
            $scope.newFlat ={};
            location.href="/"; //real page reload to get all menues
        });
    };

    $scope.add_invite=function(){
        $scope.newFlat.invites.push($scope.invite_email);
    };

    $scope.remove_invite=function(invite){
        $scope.newFlat.invites=_($scope.newFlat.invites).without(invite);
    };

    $scope.newFlat={ name:"", invites: [] };

});
