angular.module('flatman').controller("financesCtrl", function($scope, financesService, flatService, Util) {
    $scope.intro = function() {
        return $scope.arePaymentsToShow();
    };

    $scope.removeEntry = function(finance) {
        financesService.bill.destroy(finance.id, function() {
            $scope.finances = _($scope.finances).without(finance);
        });
        $scope.financeTables = financesService.finance.get_tables();
    };

    $scope.payDebt = function(debt) {
        financesService.debts.pay_debt(debt.id, function() {
            $scope.allDebts = _($scope.allDebts).without(debt);
        })
    };

    $scope.enoughEntries = function() {
        return $scope.AllCategories.length > 2;
    };

    $scope.setPage = function(member, page, index) {
        member.page = page;
        $scope.setPaymentEntries(member, index);
    };

    $scope.removePayment = function(payment, member, index) {
        financesService.payment.destroy(payment.id, member.id, member.page, function(data) {
            if (member.entryLength == 5)
                member.page = 1;
            $scope.setPaymentEntries(member, index);
        });
    };

    $scope.setPaymentEntries = function(member, index) {
        financesService.finance.get_table(member.id, (member.page - 1) * 5, member.page * 5, function(data) {
            $scope.financeTables[index].value = data.value;
            $scope.financeTables[index].entries = data.entries;
            $scope.financeTables[index].entryLength = data.entryLength;
        });
    };

    $scope.arePaymentsToShow = function (){
        var sum = _.reduce($scope.financeTables, function(mem, financeTable) { return mem + financeTable.entryLength;},0);
        return sum != 0;
    };

    $scope.chartData = [];
    $scope.finances = financesService.bill.get_range(0, 5);
    $scope.entriesPerPage = 5;
    $scope.math = Math;

    $scope.financeTables = financesService.finance.get_tables();

    //load categories and chart data
    $scope.AllCategories = financesService.category.get_all(function(data) {
        $scope.chartData = financesService.category.get_chart_view(data);
    });

    $scope.getFlatMates = flatService.mates.get();
});
