angular.module('flatman').controller("newsfeedCtrl", 
	function($scope, newsfeedService, userService, shoppingService,resourceService,financesService, Util) {
	

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

	$scope.loadNews = function (){
		newsfeedService.newsfeed.get($scope.newsitemLoaded, $scope.newsitemLoaded + $scope.newsitemCount, function(data){
			$scope.newsitemLoaded +=  $scope.newsitemCount
			$scope.news = $scope.news.concat(data)
		});
	}

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
	}

	$scope.switchChevron = function(index){

        $('#collapseComments' + index).on('show.bs.collapse', function () {
            $("#chevron" + index).removeClass("glyphicon-chevron-right").addClass("glyphicon-chevron-down");
        });

        $('#collapseComments' + index).on('hide.bs.collapse', function () {
            $("#chevron" + index).removeClass("glyphicon-chevron-down").addClass("glyphicon-chevron-right");
        });
    };

   $scope.getDocHeight =  function () {
		var D = document;
		return Math.max(
			D.body.scrollHeight, D.documentElement.scrollHeight,
			D.body.offsetHeight, D.documentElement.offsetHeight,
			D.body.clientHeight, D.documentElement.clientHeight
		);
	}

	$(window).scroll(function() {
       if($(window).scrollTop() + $(window).height() == $scope.getDocHeight()) {
           $scope.loadNews()
       }
	});

    $scope.current_user = userService.get();
	$scope.newsitemLoaded = 0
	$scope.newsitemCount = 9
	$scope.news = []
	$scope.loadNews()

});