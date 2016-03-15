angular.module('flatman').controller("userSettingsCtrl",function($scope,userService,Util){
    $scope.user=userService.get();

    $scope.is_dirty=function(){
       return $scope.content_form.$dirty;
    };

    $scope.update_user=function(){
        userService.update($scope.user.pushflag, function(data){$scope.content_form.$setPristine(); });
    };
});
