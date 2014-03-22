angular.module('flatman').controller("userSettingsCtrl",function($scope,userService,Util){
    $scope.user=userService.get();
});
