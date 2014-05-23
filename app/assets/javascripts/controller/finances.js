angular.module('flatman').controller("financesCtrl", function($scope, financesService,flatService, Util){
	$scope.chartData = [];
	// $scope.finTmp={ text:"", value:"", date:new Date(), user_id:"", cat_name:"", payer:""};
	// $scope.debtTmp={payer_name:"", payee_name:"", debt:""};
	$scope.finances= financesService.finance.get_all();
	$scope.colors = ["#428bca", "#5cb85c","#5bc0de", "#f0ad4e", "#d9534f", "black", "grey"];

	//condition for max colors
	$scope.AllCategories = financesService.category.get_all(function(data){
		$scope.chartData = _(data).map(function(item,i){ return {color: $scope.colors[i % ($scope.colors.length)],
																 value: item.listValue,
																 cat_name: item.cat_name }; });
	});

	$scope.getFlatMates = flatService.mates.get();

	$scope.allDebts = financesService.debts.get();
	//$scope.balance = financesService.debts.get_balance();
	//$scope.initChart = financesService.chart.get();
	//$scope.select = {month: ""};

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

	//not finished
	$scope.getMonthEntries=function(nr){
		//date = new Date(2014, 1, 1);
		/*
		switch(nr){
			case "1":
			financesService.month.get(2014.01.01, 2014.01.31);
			break;
			case "2":
			financesService.month.get(2014.02.01, 2014.02.29);
			break;
			case "3":
			financesService.month.get(2014.03.01, 2014.03.31);
			break;
			case "4":
			financesService.month.get(2014.04.01, 2014.04.30);
			break;
			case "5":
			financesService.month.get(2014.05.01, 2014.05.31);
			break;
			case "6":
			financesService.month.get(2014.06.01, 2014.06.30);
			break;
			case "7":
			financesService.month.get(2014.07.01, 2014.07.31);
			break;
			case "8":
			financesService.month.get(2014.08.01, 2014.08.31);
			break;
			case "9":
			financesService.month.get(2014.09.01, 2014.09.30);
			break;
			case "10":
			financesService.month.get(2014.10.01, 2014.10.31);
			break;
			case "11":
			financesService.month.get(2014.11.01, 2014.11.30);
			break;
			case "12":
			financesService.month.get(2014.12.01, 2014.12.31);
			break;
		}
		//alert($scope.select.month);
		financesService.month.get($scope.select);*/
	};

	$scope.total = function(){

		var sum = 0;
		for(var i = 0; i < $scope.finances.length; i++){
			sum = sum + $scope.finances[i].value;
		}
		return sum;
	};

	$scope.debts = function(){
		var sum = 0;
		for(var i = 0; i < $scope.allDebts.length; i++){
			sum = sum + $scope.allDebts[i].debt;
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
