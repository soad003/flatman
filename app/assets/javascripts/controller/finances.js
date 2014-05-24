angular.module('flatman').controller("financesCtrl", function($scope, financesService,flatService, Util){
	$scope.chartData = [];
	$scope.finances= financesService.bill.get_range(0,5);
	$scope.colors = ["#428bca", "#5cb85c","#5bc0de", "#f0ad4e", "#d9534f", "black", "grey"];

	//load categories and chart data
	$scope.AllCategories = financesService.category.get_all(function(data){
		$scope.chartData = _(data).map(function(item,i){ return {color: $scope.colors[i % ($scope.colors.length)],
																 value: item.listValue,
																 cat_name: item.cat_name }; });
	});

	$scope.getFlatMates = flatService.mates.get();

	$scope.intro = function(){
		return ($scope.finances.length !== 0);
	};

	$scope.removeEntry=function(finance){
		financesService.bill.destroy(finance.id, function(){
            $scope.finances = _($scope.finances).without(finance);
        });
	};

	$scope.payDebt = function(debt){
		financesService.debts.pay_debt(debt.id, function(){
			$scope.allDebts = _($scope.allDebts).without(debt);
		})
	};

	$scope.total = function(){

		var sum = 0;
		for(var i = 0; i < $scope.finances.length; i++){
			sum = sum + $scope.finances[i].value;
		}
		return sum;
	};

	$scope.enoughEntries = function(){
		return $scope.AllCategories.length > 2;
	};

	$scope.setFinanceTables = function (){
		$scope.financeTables = financesService.finance.get_tables(function (data){
			_.each($scope.financeTables, function(table){
                                       table.date = new Date();
            });
		}, function(){});
	};
	$scope.setFinanceTables();

	$scope.addPayment = function (finance_member){
		financesService.payment.create(finance_member.id, finance_member.date, finance_member.entryvalue ,function(data){},function(data){});
		$scope.setFinanceTables();
	};
});
