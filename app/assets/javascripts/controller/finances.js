angular.module('flatman').controller("financesCtrl", function($scope, financesService, Util){
	$scope.chartData = [];
	$scope.finTmp={ text:"", value:"", date:"", user_id:"", cat_name:"", payer:""};	
	$scope.debtTmp={payer_name:"", payee_name:"", debt:""};
	$scope.finances= financesService.finance.get();
	$scope.colors = ["green", "black", "blue", "yellow", "red", "magenta", "purple", "grey"];

	//condition for max colors
	$scope.AllCategories = financesService.category.get_all(function(data){
		var tmp = [];
		for(var i = 0; i < data.length; i++){
			
			var entry = {color: $scope.colors[i], value: data[i].listValue};
			tmp.push(entry);
		}
		$scope.chartData = tmp;
				
	});

	$scope.getFlatMates = financesService.mates.get();

	$scope.allDebts = financesService.debts.get();
	//$scope.balance = financesService.debts.get_balance();
	$scope.initChart = financesService.chart.get(); 
	//$scope.select = {month: ""};

	$scope.intro = function(){
		return ($scope.finances.length !== 0);
	};

	$scope.addEntry=function(){
		financesService.finance.create($scope.finTmp, function(data){
			$scope.finances.push(data);
		});

	};

	$scope.removeEntry=function(finance){
		financesService.finance.destroy(finance.id, function(){
            $scope.finances = _($scope.finances).without(finance);
        });
	};

	//not finished
	$scope.updateEntry=function(finance){
		$scope.finTmp.text = finance.name;
		//financesService.finance.update(finance.id,function(){

	//	})
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
		var bool = false;
		if ($scope.AllCategories.length > 2){
			bool = true;
		}
		return bool;
	};
});
