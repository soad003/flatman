angular.module('flatman').controller("financesCtrl", function($scope, financesService, flatService, Util) {
    
 

    $scope.test = function(index){
        $('#collapse' + index).on('show.bs.collapse', function () {
            $(this).parent("div").find(".glyphicon-chevron-right").removeClass("glyphicon-chevron-right").addClass("glyphicon-chevron-down");
        });

        $('#collapse' + index).on('hide.bs.collapse', function () {
            $(this).parent("div").find(".glyphicon-chevron-down").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-right");
        });
    };

    $scope.intro = function() {
        return $scope.finances.length !== 0 || $scope.arePaymentsToShow();
    };

	$scope.removeEntry=function(finance){
		financesService.bill.destroy(finance.id, function(){
            $scope.finances = _($scope.finances).without(finance);
        });
        $scope.overviewMates = financesService.finance.get_overview_mates(0,5);
    };

    $scope.payDebt = function(debt) {
        financesService.debts.pay_debt(debt.id, function() {
            $scope.allDebts = _($scope.allDebts).without(debt);
        })
    };

    $scope.enoughEntries = function() {
        return $scope.AllCategories.length > 2;
    };

    $scope.arePaymentsToShow = function (){
        var sum = _.reduce($scope.overviewMates, function(mem, overviewMate) { return mem + overviewMate.entryLength;},0);
        return sum !== 0;
    };

    $scope.sliceText = function(data){
        
    };

    $scope.chartData = [];
    $scope.finances = financesService.bill.get_range(0, 5);
    
    $scope.overviewMates = financesService.finance.get_overview_mates(0, 5);

    $scope.AllCategories = financesService.category.get_all(function(data) {
        $scope.chartData = financesService.category.get_chart_view(data);
    });

    $scope.getFlatMates = flatService.mates.get();

      
});
