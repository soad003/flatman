angular.module('flatman').controller("newsfeedCtrl", function($scope, $filter, newsfeedService, userService, Util) {
	$scope.current_user = userService.get();
	$scope.news = newsfeedService.newsfeed.get();

	$scope.getDateString = function (date){
		return "vor 1 Std."
	}

	$scope.addMessage = function (){
		newsfeedService.newsfeed.create($scope.newsText, function(data){
                data.items=[];
                $scope.news = newsfeedService.newsfeed.get();
                $scope.newsText='';
        });
	}
});