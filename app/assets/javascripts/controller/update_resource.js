angular.module('flatman').controller("update_resourceCtrl",function($scope, $routeParams, resourceService, Util){
    if ($routeParams.id === undefined){
        $scope.isUpdate = false;
        $scope.resourceTmp={name:"",unit:"", pricePerUnit: "", description:"", monthlyCost:"", annualCost: "", startValue: "", startDate: new Date()};
    }else{
        $scope.isUpdate = true;
        $scope.resourceTmp = resourceService.resource.get($routeParams.id);
    }

    $scope.update=function (){
        if ($scope.isUpdate){
            $scope.updateResource();
        }else{
            $scope.addResource();
        }
    };

    $scope.addResource=function(){
        resourceService.resource.create($scope.resourceTmp, function(data){location.href ="/#/resources";});
    };

    $scope.updateResource=function(){
        resourceService.resource.update($scope.resourceTmp, function(){location.href ="/#/resources";});
    };
});
