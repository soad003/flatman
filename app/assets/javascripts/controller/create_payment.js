angular.module('flatman').controller("createPaymentCtrl",function($scope, financesService, flatService, userService, Util){
	$scope.createPayment = function (){
		financesService.payment.create($scope.newPayment.payer_id, $scope.newPayment.date, $scope.newPayment.value, 
		function(data){
				Util.redirect_to.back();
			});
	};

	$scope.getMatesWithoutCurrentUser = function (){
		return _.filter($scope.mates, function(mate){return mate.id !== $scope.current_user.id;});
	};

	$scope.current_user = userService.get();
	$scope.mates = flatService.mates.get();
	$scope.newPayment={ date: new Date(), value:"", payer_id:""};

});
