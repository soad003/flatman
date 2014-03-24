angular.module('flatman').controller("sharingCtrl", function($scope, sharingService) {
	

	$scope.lists = sharingService.get();


	$scope.addSharingItem = function() {
		console.log("he du pferd");
		alert("murli");
	}
	
})
