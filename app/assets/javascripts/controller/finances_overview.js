angular.module('flatman').controller("financesOverviewCtrl", function($scope, financesService, Util){
    $scope.finances= financesService.finance.get_all();
});
