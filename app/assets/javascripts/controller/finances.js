angular.module('flatman').controller("financesCtrl", function($scope, financeService, Util){
	$scope.newFinance={ date:"", name:"", categorie:"", value:"" };


	$scope.addEntry=function(){
		financeService.create({}, $scope.newFinance function(){
			if(!Util.has_server_errors()){
				$scope.newFinance ={};
				location.href="/"
			}
		});
	};

	$scope.removeEntry=function(){

	};

	$scope.updateEntry=function(){

	};

	$scope.showAll=function(){


	};

	$scope.switchMonth=function(){

	};

	$scope.addFin=function(){

	};

	$scope.removeFin=function(){

	};

	$scope.updateFin=function(){

	};

});