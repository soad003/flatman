angular.module('flatman').controller("financesOverviewMateCtrl", function($scope, $routeParams,  financesService, userService, Util){

    $scope.setPage = function(page) {
        $scope.currentOverviewMate.page = page;
        $scope.setPaymentEntries();
    };

    $scope.setCurrentOverviewMate = function (overviewMate){
        $scope.currentOverviewMate = overviewMate;
    }

    $scope.removeBill=function(id){
        financesService.bill.destroy(id, function(){
            $scope.setPaymentEntries();
        });
    };

    $scope.removePayment = function(id) {
        financesService.payment.destroy(id, $scope.currentOverviewMate.id, function(data) {
            $scope.setPaymentEntries();
        });
    };

    $scope.setPaymentEntries = function() {
        if ($scope.currentOverviewMate.entryLength === $scope.entriesPerPage){
                $scope.currentOverviewMate.page = 1;
        }

        financesService.finance.get_overview_mate($scope.currentOverviewMate.id, 
            ($scope.currentOverviewMate.page - 1) * $scope.entriesPerPage, 
            $scope.currentOverviewMate.page * $scope.entriesPerPage,
            function (data){
                $scope.currentOverviewMate.value = data.value;
                $scope.currentOverviewMate.entries = data.entries;
                $scope.currentOverviewMate.entryLength = data.entryLength;
            }
        );
    };

    $scope.sliceText = function(entry){
        if (entry === null)
            return "-";
        var textlength = entry.length;
        if (textlength < 25){
            return entry;
        }
        else {
            var words = entry.slice(0,20) +"...";
            return words;
        }
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
