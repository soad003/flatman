angular.module('flatman').controller("newsfeedCtrl", 
	function($scope, newsfeedService, userService, shoppingService,resourceService,financesService, Util) {
	$scope.current_user = userService.get();
	$scope.news = newsfeedService.newsfeed.get();

	  $scope.get_you_owe=function(){return financesService.finance.get_sum($scope.overviewMates);};

	$scope.get_resource_usage = function() {
		return resourceService.resource.getSumCosts($scope.dashboardResources);
	};

	$scope.get_items_to_buy = function() {
		return shoppingService.list.get_item_count($scope.shoppinglists);
	};

	$scope.get_shoppinglist_summary = function(list) {
		return shoppingService.list.get_summary_string(list) + "...";
	};

	$scope.shoppinglists = shoppingService.list.get();
	$scope.dashboardResources = resourceService.resource.getDashboard();
	$scope.overviewMates = financesService.finance.get_overview_mates(0,1);

	$scope.addMessage = function (){
		newsfeedService.newsfeed.create($scope.newsText, function(data){
                data.items=[];
                $scope.news = newsfeedService.newsfeed.get();
                $scope.newsText='';
        });
	}

	$scope.addComment = function (newsitem){
        newsfeedService.comment.create(newsitem.id, newsitem.new_Text, function(data){
        	data.name = $scope.current_user.name
            newsitem.comments.push(data);
            newsitem.new_Text='';
        });
    };

	$scope.redirectToSource = function (type){
		if (type == 'finance')
			Util.redirect_to.finances()
		else if (type == 'resource')
			Util.redirect_to.resources()
		else if (type == 'shopping')
			Util.redirect_to.shopping()
	}
});