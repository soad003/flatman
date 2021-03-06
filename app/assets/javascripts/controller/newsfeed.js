angular.module('flatman').controller("newsfeedCtrl", 
	function($scope, newsfeedService, userService, shoppingService,resourceService,financesService,todoService, Util) {
	
	$scope.tileClass=function(text){
		var strclass = "col-lg-3 col-sm-6 col-xs-6 "
		if ($scope.get_resource_usage() === 0)
			strclass = "col-lg-4 col-sm-4 col-xs-4 ";
		switch(text) {
			case "shopping":
				strclass += "reduce-padding-xs-right"; break;
			case "todo": 
				strclass += (($scope.get_resource_usage() === 0) ? "reduce-padding-xs" : "reduce-padding-xs-left"); break;
			case "finance":
				strclass += (($scope.get_resource_usage() === 0) ? "reduce-padding-xs-left" : "reduce-padding-xs-right"); break;
			case "resource":
				strclass += "reduce-padding-xs-left"; break;
		}
		return strclass
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
		if ($scope.newsfeed_length >= $scope.newsitemLoaded){
			newsfeedService.newsfeed.get($scope.newsitemLoaded, $scope.newsitemLoaded + $scope.newsitemCount, function(data){
				$scope.newsitemLoaded +=  $scope.newsitemCount;
				$scope.newsfeed_length = data.newsfeed_length;
				$scope.news = $scope.news.concat(data.data);
			});
		}
	}

	$scope.getTextWithNewline = function (text){
		return text.split("\n");
	}

	$scope.shoppinglists = shoppingService.list.get();
	$scope.todos = todoService.list.get();

	$scope.dashboardResources = resourceService.resource.getDashboard();
	$scope.overviewMates = financesService.finance.get_overview_mates(0,1);

	$scope.addMessage = function (){
		newsfeedService.newsfeed.create($scope.newsText, function(data){
			$scope.setNewsfeed()
			$scope.loadNews()
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
			data.name = $scope.current_user.name;
            newsitem.comments.push(data);
            newsitem.new_Text='';
        });
    };

	$scope.redirectToSource = function (type){
		if (type == 'finance')
			Util.redirect_to.finances();
		else if (type == 'resource')
			Util.redirect_to.resources();
		else if (type == 'shopping')
			Util.redirect_to.shopping();
		else if (type == 'todo')
			Util.redirect_to.todo();
	}

	$scope.switchChevron = function(index){

        $('#collapseComments' + index).on('show.bs.collapse', function () {
            $("#chevron" + index).removeClass("glyphicon-chevron-right").addClass("glyphicon-chevron-down");
        });

        $('#collapseComments' + index).on('hide.bs.collapse', function () {
            $("#chevron" + index).removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-right");
        });
    };

    $scope.setNewsfeed = function (){
		$scope.newsitemLoaded = 0;
		$scope.newsitemCount = 20;
		$scope.newsfeed_length = 0;
		$scope.news = [];
    }
    $scope.setNewsfeed()
    $scope.current_user = userService.get();
	$scope.loadNews();
});