angular.module('flatman').controller("billsOverviewCtrl", function($scope, $routeParams, flatService, financesService, userService, Util){
    $scope.setPage = function(page) {
        $scope.current_page = page;
        financesService.bill.get_range(($scope.current_page-1) * $scope.entriesPerPage, $scope.current_page * $scope.entriesPerPage, function (data){
            $scope.finances.subset = data.subset;
        });
    };

    $scope.removeEntry=function(finance){
        financesService.bill.destroy(finance.id, function(){
            $scope.setPage($scope.current_page);
        });
    };

    $scope.current_page = 1;
    $scope.mates = flatService.mates.get();
    $scope.entriesPerPage = 13;
    $scope.current_user = userService.get();
    $scope.finances = financesService.bill.get_range(0,$scope.entriesPerPage);
});
