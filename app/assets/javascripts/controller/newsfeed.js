angular.module('flatman').controller("newsfeedCtrl", 
	function($scope, newsfeedService, userService, shoppingService,resourceService,financesService,todoService, Util) {
	
	$scope.tileClass=function(){
		if ($scope.get_resource_usage() === 0)
			return "col-lg-4 col-sm-4 col-xs-12";
		return "col-lg-3 col-sm-6 col-xs-12";
	}

	$scope.get_you_owe=function(){return financesService.finance.get_sum($scope.overviewMates);};

	$scope.get_resource_usage = function() {
		return resourceService.resource.getSumCosts($scope.dashboardResources);
	};

	$scope.get_items_to_buy = function() {
		return shoppingService.list.get_item_count($scope.shoppinglists);
	};

	$scope.get_items_todos = function() {
		return todoService.list.get_item_count($scope.todos);
	};


	$scope.loadNews = function (){
		newsfeedService.newsfeed.get($scope.newsitemLoaded, $scope.newsitemLoaded + $scope.newsitemCount, function(data){
			$scope.newsitemLoaded +=  $scope.newsitemCount
			$scope.news = $scope.news.concat(data)
		});
	}

	$scope.shoppinglists = shoppingService.list.get();
	$scope.todos = todoService.list.get();

	$scope.dashboardResources = resourceService.resource.getDashboard();
	$scope.overviewMates = financesService.finance.get_overview_mates(0,1);

	$scope.addMessage = function (){
		newsfeedService.newsfeed.create($scope.newsText, function(data){
                data.items=[];
                $scope.news = newsfeedService.newsfeed.get();
                $scope.newsText='';
        });
	}

	$scope.removeMessage=function(newsitem){
        newsfeedService.newsfeed.destroy(newsitem.id,function(){
            $scope.news = _($scope.news).without(newsitem);
        });
    };

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
		else if (type == 'todo')
			Util.redirect_to.todo()
	}

	$scope.switchChevron = function(index){

        $('#collapseComments' + index).on('show.bs.collapse', function () {
            $("#chevron" + index).removeClass("glyphicon-chevron-right").addClass("glyphicon-chevron-down");
        });

        $('#collapseComments' + index).on('hide.bs.collapse', function () {
            $("#chevron" + index).removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-right");
        });
    };

    $scope.current_user = userService.get();
	$scope.newsitemLoaded = 0
	$scope.newsitemCount = 9
	$scope.news = []
	$scope.loadNews()
});