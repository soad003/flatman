angular.module('flatman').controller("createPaymentCtrl",function($scope, financesService, flatService ,Util){
	$scope.mates = flatService.mates.get();
	$scope.newPayment={ date: new Date(), value:"", payer_id:""};
	$scope.createPayment = function (){
		financesService.payment.create($scope.newPayment.payer_id, $scope.newPayment.date, $scope.newPayment.value, 
		function(data){
				location.href ="/#/finances";
			});
	};

});
