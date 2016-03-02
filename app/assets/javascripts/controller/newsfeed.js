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

	$scope.redirectToSource = function (type){
		if (type == 'finance')
			Util.redirect_to.finances()
		else if (type == 'resource')
			Util.redirect_to.resources()
		else if (type == 'shopping')
			Util.redirect_to.shopping()
	}
});