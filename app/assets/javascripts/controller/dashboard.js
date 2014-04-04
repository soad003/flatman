angular.module('flatman').controller("dashboardCtrl",
    function($scope,shoppingService,resourceService,shareService,Util){

        $scope.shoppinglists=shoppingService.list.get();

        $scope.get_you_owe=function(){ return -300; };

        $scope.get_items_borrowed=function(){ return 11; };

        $scope.get_resource_usage=function(){ return 102; };

        $scope.get_items_to_buy=function(){
            return shoppingService.list.get_item_count($scope.shoppinglists);
        };

        $scope.get_shoppinglist_summary=function(list){
            return _(list.items).take(3)
                                .reduce(function(mem,item){
                                                            return mem + item.name + ", "
                                                        },"")
                                .slice(0,50)+"...";
        };

    }
);
