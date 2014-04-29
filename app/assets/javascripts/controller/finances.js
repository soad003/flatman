angular.module('flatman').controller("financesCtrl", function($scope, financesService, Util){

	$scope.finTmp={ text:"", value:"", date:"", user_id:"", cat:""};
	$scope.finances= financesService.finance.get();
	$scope.category={cat:""};


	$scope.addEntry=function(){
		financesService.finance.create($scope.finTmp, function(data){
			$scope.finances.push(data);
			//location.href="/#/finances";
		});

	};

	$scope.removeEntry=function(finance){
		//alert(finance.id);
		financesService.finance.destroy(finance.id, function(){
            $scope.finances = _($scope.finances).without(finance);
        });
	};

	$scope.updateEntry=function(finance){
	//	financesService.finance.update(.id,function(){

	//	})
	};

	$scope.total = function(){
		var sum = 0;
		for(var i = 0; i < $scope.finances.length; i++){
			sum = sum + $scope.finances[i].value
		}
		return sum;
	}
});