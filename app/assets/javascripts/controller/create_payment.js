angular.module('flatman').controller("createPaymentCtrl",function($scope, financesService, flatService ,Util){
	$scope.createPayment = function (){
		financesService.payment.create($scope.newPayment.payer_id, $scope.newPayment.date, $scope.newPayment.value, 
		function(data){
				Util.redirect_to.back();
			});
	};

	$scope.mates = flatService.mates.get();
	$scope.newPayment={ date: new Date(), value:"", payer_id:""};

});
