angular.module('flatman').controller("dashboardCtrl",
    function($scope,shoppingService,resourceService,financesService,Util){

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

	$('.panel-tooltip, .tooltip').tooltip({
		placement : "bottom"
	});

});
