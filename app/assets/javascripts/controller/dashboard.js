angular.module('flatman').controller("dashboardCtrl",
    function($scope,shoppingService,resourceService,shareService,Util){

        $scope.shoppinglists=shoppingService.list.get();
        $scope.dashboardResources=resourceService.resource.getDashboard();

        $scope.get_you_owe=function(){ return -300; };

        $scope.get_items_borrowed=function(){ return 11; };

        $scope.get_resource_usage=function(){ return resourceService.resource.getSumCosts($scope.dashboardResources); };

        $scope.get_items_to_buy=function(){
            return shoppingService.list.get_item_count($scope.shoppinglists);
        };

        $scope.get_shoppinglist_summary=function(list){
            return shoppingService.list.get_summary_string(list)+"...";
        };

    }
);
