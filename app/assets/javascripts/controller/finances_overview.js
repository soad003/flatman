angular.module('flatman').controller("financesOverviewCtrl", function($scope, $routeParams,  financesService, Util){

    $scope.setSelectedOverviewMateIndex = function (index){
		$scope.selectedIndex = index;
    };

    $scope.getSelectedOverviewMate = function(){
		return $scope.overviewMates[$scope.selectedIndex];
    };

    $scope.setPage = function(member, page) {
        member.page = page;
        $scope.setPaymentEntries(member);
    };

    $scope.removePayment = function(payment, member) {
        financesService.payment.destroy(payment.id, member.id, member.page, function(data) {
            if (member.entryLength == $scope.entriesPerPage)
                member.page = 1;
            $scope.setPaymentEntries(member);
        });
    };

    $scope.setPaymentEntries = function(member) {
        financesService.finance.get_table(member.id, (member.page - 1) * $scope.entriesPerPage, member.page * $scope.entriesPerPage, function(data) {
            $scope.overviewMates[$scope.selectedIndex].value = data.value;
            $scope.overviewMates[$scope.selectedIndex].entries = data.entries;
            $scope.overviewMates[$scope.selectedIndex].entryLength = data.entryLength;
        });
    };

    $scope.finances= financesService.bill.get_range(0,1000);
    $scope.overviewMates=financesService.finance.get_overview_mates(0, 15, function (data){
		_.each(data, function(overviewMate, i) {
            if (overviewMate.id == $routeParams.id){
				$scope.selectedIndex = i;
            }
        });

    });
    $scope.entriesPerPage = 15;
    $scope.selectedIndex = 0;

});
