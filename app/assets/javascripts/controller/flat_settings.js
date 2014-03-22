angular.module('flatman').controller("flatSettingsCtrl",function($scope,flatService,Util){
    $scope.flat=flatService.get();

    $scope.is_dirty=function(){
       return $scope.content_form.$dirty;
    };

    $scope.update_flat=function(){
        flatService.update({},$scope.flat);
        $scope.content_form.$setPristine();
    };

});
