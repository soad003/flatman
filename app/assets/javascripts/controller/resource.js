angular.module('flatman').controller("resourceCtrl",function($scope, resourceService, Util){
    $scope.resources = resourceService.resource.getAll(function(){
        _.each($scope.resources, function(resource){
                                        resource.date = new Date(); 
                                        resource.page = 1;
                                        $scope.setEntries(resource);
                                    });
    });


     $scope.removeResource=function(resource){
        resourceService.resource.destroy(resource.id,function(){
            $scope.resources = _($scope.resources).without(resource);
        });
    };



    $scope.setEntries=function(resource){
        resource.entries = resourceService.entry.get(resource.id, resource.page);
        resource.entryvalue = "";
    }

     $scope.addEntry=function(resource){
        resourceService.entry.create(resource.id,{date:resource.date,value:resource.entryvalue}, function(data){
                 $scope.setEntries(resource);
                 resource.entryLength++;
        });
    };

    $scope.removeEntry=function(resource, entry){
        resourceService.entry.destroy(resource.id, entry.id, function(){
            $scope.setEntries(resource);                 
            resource.entryLength--;
        });
    };

    $scope.getRange=function (length){
        max = length/5;

        return _.range (1, max+1);
    };

    $scope.setEntriesForPage=function (i, resource){
        resource.page = i;
        $scope.setEntries(resource);
    };

    $scope.changePage=function(resource, value){
        resource.page += value;
        if (resource.page > resource.pages){
            resource.page = resource.pages;
        }
        if(resource.page < 1){
            resource.page = 1;
        }
        $scope.setEntries(resource);
    };
});