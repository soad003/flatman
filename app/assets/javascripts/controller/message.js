angular.module('flatman').controller("messageCtrl", function($scope, messageService, Util){
	$scope.messages = messageService.message.get();
	
});