angular.module('flatman').controller("financesCtrl", function($scope, financesService, Util){

	$scope.intro = false;
	$scope.finTmp={ name:"", value:"", date:"", user_id:"", cat:""};
	//$scope.finTmp.user_id=current_user.id;
	$scope.finances= financesService.finance.get();//{
/*		if($scope.finances.length === 0){
			$scope.intro = true;
		}
		_.each($scope.finances, function(finance){
			$scope.init(finance);
			$scope.setEntries(finance);
		}); */
	//});

/*	$scope.init=function(finance){
		resource.date = new Date();
	};
*/

	$scope.addEntry=function(){
		financesService.finance.create($scope.finTmp, function(data){
			$scope.finances.push(data);
			location.href="/#/finances";
		});
	};

	$scope.removeEntry=function(finance, entry){
		financesService.finance.destroy(entry.id, function(){
            finance.entries = _(finance.entries).without(entry);
        });
	};

	$scope.updateEntry=function(){
	//	financesService.finance.update(.id,function(){

	//	})
	};

});