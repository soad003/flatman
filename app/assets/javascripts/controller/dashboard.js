angular.module('flatman').controller("dashboardCtrl",
    function($scope,shoppingService,resourceService,shareService,financesService,Util){

    $scope.get_you_owe=function(){return financesService.finance.get_sum($scope.dashboardFinances);};

	//sharing
	$scope.shareditems = shareService.items.get();

	$scope.count_sharedItems = function(flag_available) {
		return shareService.items.count_items($scope.shareditems, flag_available);
	};

	$scope.get_sharedItems = function(flag_available) {
		return shareService.items.get_summary_string($scope.shareditems, flag_available);
	};
	//sharing end

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
	$scope.dashboardFinances = financesService.finance.get_tables();

	$('.panel-tooltip, .tooltip').tooltip({
		placement : "bottom"
	});

});
