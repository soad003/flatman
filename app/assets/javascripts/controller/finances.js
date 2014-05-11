angular.module('flatman').controller("financesCtrl", function($scope, financesService, Util){

	$scope.finTmp={ text:"", value:"", date:"", user_id:"", cat_name:"", payer:"", payee1: "false", payee2:"false", payee3:"false", payee4:"false",payee5:"false"};	
	$scope.debtTmp={payer_name:"", payee_name:"", debt:""};
	$scope.finances= financesService.finance.get();
	$scope.AllCategories = financesService.category.get_all();
	$scope.getFlatMates = financesService.mates.get();
	$scope.allDebts = financesService.debts.get();
	$scope.initChart = financesService.chart.get(); 
	$scope.select = {month: ""};
	var dataChart = financesService.category.get_all();
	var colors = ["green", "black", "blue", "yellow", "red", "magenta", "purple"];


	$scope.chart = [
		{
			value: [],
			color: []
		}
	];

	$scope.dataChart = function (){
		//5 displayed categories
		for(var i = 0; i < 0; i++){
			//alert("test");
			$scope.chart[i].value = dataChart[i].listValue;
			//alert(dataChart[i].listValue);		
			$scope.chart[i].color = colors[i];
		}
	};

	$scope.intro = function(){
		var bool = true;
		if ($scope.finances.length === 0){
			bool = false;
			return bool;
		}
		else
			return bool;
	};

	$scope.addEntry=function(){
		//$scope.finTmp.payee1 = 
		financesService.finance.create($scope.finTmp, function(data){
			$scope.finances.push(data);
		});

	};

	$scope.removeEntry=function(finance){
		financesService.finance.destroy(finance.id, function(){
            $scope.finances = _($scope.finances).without(finance);
        });
	};

	$scope.updateEntry=function(finance){
	//	financesService.finance.update(finance.id,function(){

	//	})
	};
	$scope.payDebt = function(debt){
		financesService.debts.pay_debt(debt.id, function(){
			$scope.allDebts = _($scope.allDebts).without(debt);
		})
	};

	//continue
	$scope.getMonthEntries=function(nr){
		$scope.select.month = nr;
		//alert($scope.select.month);
		financesService.month.get($scope.select);
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
