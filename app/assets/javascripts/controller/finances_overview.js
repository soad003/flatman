angular.module('flatman').controller("financesOverviewCtrl", function($scope, financesService, Util){
    $scope.finances= financesService.bill.get_range(0,1000);
});
