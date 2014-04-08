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
		financeService.destroy(.id,function(){
            $scope.finance = _($scope.finance).without(finance);
        });
	};

	$scope.updateEntry=function(){
		financeService.update(.id,function(){
			$scope.finance = _($scope.finance).without(finance);
		})
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

	$scope.initChart=function(resource){
        finance.chart = {
            "labels":[],
            "datasets":[
                {
                    "fillColor":"rgba(151,187,205,0.5)",
                    "strokeColor":"rgba(151,187,205,1)",
                    "pointColor":"rgba(151,187,205,1)",
                    "pointStrokeColor":"#fff",
                    "data":[]
                }]
            };
    }; 
});