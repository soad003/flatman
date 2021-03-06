angular.module('flatman').controller("financesCtrl", function($scope, financesService, userService, flatService, Util) {

    $scope.switchChevron = function(index){
        $('#collapse' + index).on('show.bs.collapse', function () {
            $(this).parent("div").find(".glyphicon-chevron-down").removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-up");
        });

        $('#collapse' + index).on('hide.bs.collapse', function () {
            $(this).parent("div").find(".glyphicon-chevron-up").removeClass("glyphicon-chevron-up").addClass("glyphicon-chevron-down");
        });
    };

	$scope.removeEntry=function(finance){
		financesService.bill.destroy(finance.id, function(){
            $scope.finances = financesService.bill.get_range(0, 5);
        });
        $scope.overviewMates = financesService.finance.get_overview_mates(0,5);
    };

    $scope.enoughEntries = function() {
        return $scope.AllCategories.length > 0;
    };

    $scope.arePaymentsToShow = function (){
        var sum = _.reduce($scope.overviewMates, function(mem, overviewMate) { return mem + overviewMate.entryLength;},0);
        return sum !== 0;
    };

    $scope.removePayment = function(payment, overviewMate) {
        financesService.payment.destroy(payment.id, overviewMate.id, function(data) {
            $scope.setFinanceOverviewMate(overviewMate);
        });
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

    $scope.setSelectedOverviewMateIndex = function (index){
        $scope.selectedIndex = index;
        $scope.switchChevron(index);
    };

    $scope.setFinanceOverviewMate = function(mate) {
        financesService.finance.get_overview_mate(mate.id, 0,5, function (data){
            $scope.overviewMates[$scope.selectedIndex].value = data.value;
            $scope.overviewMates[$scope.selectedIndex].entries = data.entries;
        });
    };

    $scope.getChartData = function() {
        return financesService.category.get_in_periode($scope.chartFrom, $scope.chartTo, function(data) {
            $scope.chartData = financesService.category.get_chart_view(data);
        });
    };

    $scope.chartTo = new Date();
    $scope.chartFrom = new Date();
    $scope.chartFrom.setMonth($scope.chartTo.getMonth() - 1);
    $scope.Textcut = [];
    $scope.chartData = [];
    $scope.Math = Math;
    $scope.finances = financesService.bill.get_range(0, 5);
    $scope.overviewMates = financesService.finance.get_overview_mates(0, 5);
    $scope.AllCategories = $scope.getChartData();
    $scope.current_user = userService.get();
    $scope.getFlatMates = flatService.mates.get();

});
