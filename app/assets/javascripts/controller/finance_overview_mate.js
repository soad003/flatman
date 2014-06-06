angular.module('flatman').controller("financesOverviewMateCtrl", function($scope, $routeParams,  financesService, userService, Util){

    $scope.setPage = function(page) {
        $scope.currentOverviewMate.page = page;
        $scope.setPaymentEntries();
    };

    $scope.removePayment = function(payment) {
        financesService.payment.destroy(payment.id, $scope.currentOverviewMate.id, function(data) {
            if ($scope.currentOverviewMate.entryLength === $scope.entriesPerPage)
                $scope.currentOverviewMate.page = 1;
            $scope.setPaymentEntries();
        });
    };

    $scope.setPaymentEntries = function() {
        financesService.finance.get_overview_mate(
            $scope.currentOverviewMate.id,
            ($scope.currentOverviewMate.page - 1) * $scope.entriesPerPage,
            $scope.currentOverviewMate.page * $scope.entriesPerPage,
            function (data){
                $scope.currentOverviewMate.value = data.value;
                $scope.currentOverviewMate.entries = data.entries;
                $scope.currentOverviewMate.entryLength = data.entryLength;
            }
        );
    };

    $scope.current_user = userService.get();
    $scope.overviewMates=financesService.finance.get_overview_mates(0, $scope.entriesPerPage, function (data){
		_.each(data, function(overviewMate, i) {
            if (overviewMate.id == $routeParams.id){
				$scope.currentOverviewMate = overviewMate;
            }
        });

    });
    $scope.math = Math;
    $scope.entriesPerPage = 15;
});
