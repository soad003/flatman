angular.module('flatman').controller("resourceCtrl",function($scope, resourceService, Util){
    $scope.resources = resourceService.resource.get(function(){
        _.each($scope.resources, function(resource){
                                        resource.date = new Date(); 
                                        resource.page = 1;
                                        resource.entries = $scope.getEntries(resource);
                                    });
    });


   /* $scope.recalcEntryValues=function(resource, index){
        resource.entries[index].usage = resource.entries[index].value - resource.entries[index+1].value;
        resource.entries[index].costs = parseInt(resource.entries[index].usage) * parseFloat(resource.pricePerUnit);
    };*/

     $scope.removeResource=function(resource){
        resourceService.resource.destroy(resource.id,function(){
            $scope.resources = _($scope.resources).without(resource);
        });
    };

    $scope.addResource=function(){
        resourceService.resource.create($scope.resourceTmp, function(data){});
    };

    $scope.updateResource=function(){
        resourceService.resource.update($scope.resourceTmp, function(){});
    };

    $scope.getEntries=function(resource){
        resource.entries = resourceService.entry.get(resource.page);
    }

     $scope.addEntry=function(resource){
        resourceService.entry.create(resource.id,{date:resource.date,value:resource.entryvalue}, function(data){
                $scope.resources = resourceService.resource.get();
        });
    };

    $scope.removeEntry=function(resource, entry){
        resourceService.entry.destroy(resource.id, entry.id, function(){
            $scope.resources = resourceService.resource.get();
            /*resource.entries = _(resource.entries).without(entry);
            if (index != 0){
                $scope.recalcEntryValues(resource, --index);
            }*/
        });
    };

   

    $scope.setUpdateResource=function (typ, resource){
    	if (typ == "add"){
    		$scope.resourceTmp={"name":"","unit":"", "pricePerUnit": "", "monthlyCost":"", "annualCost": "", "startValue": "", "startDate":""};
    	}else{
    		$scope.resourceTmp= resource;
   		}
   		localStorage.setItem ("resourceTmp", JSON.stringify($scope.resourceTmp));
   		localStorage.setItem ("updateTyp", typ);
    };

	$scope.updateInit=function (){
    	$scope.resourceTmp = JSON.parse(localStorage.getItem ("resourceTmp"));
    	$scope.updateTyp = localStorage.getItem ("updateTyp");
        $scope.resourceTmp.startDate = new Date();
	};	

	$scope.update_resource=function (){
		if ($scope.updateTyp == "add"){
          $scope.addResource();
		}else{
		  $scope.updateResource();
		}
    	location.href ="/#/resources";
    };    
});
