angular.module('flatman').controller("shareCtrl", function($scope, shareService, Util){
    
  	$scope.shareditems = shareService.get();
	
	//$scope.items={ name: "", tags:"", description:"", sharingNote:"" };
  	
  	$scope.addItem = function() {
  		//console.log($scope);
  	 	
  	 	shareService.create($scope.newItemName, function(data) {
  	 		data.items = [];
  	 		$scope.shareditems.push(data);
  	 		$scope.newItemName = '';
  	 	}, function() {
  	 		console.log("aiaiai");
  	 	});
  	 
    
  	 }

    

});
