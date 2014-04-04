angular.module('flatman').controller("resourceCtrl",function($scope, resourceService, Util){
    $scope.resources = resourceService.resource.getAll(function(){
        _.each($scope.resources, function(resource){
                                        resource.date = new Date();
                                        resource.page = 1;
                                        resource.chartDateRange.startDate = moment (resource.chartDateRange.startDate);
                                        resource.chartDateRange.endDate = moment (resource.chartDateRange.endDate);
                                        $scope.setEntries(resource);
                                        $scope.initChart(resource);
                                        $scope.getChartData(resource);
                                    });
    });


    $scope.showChart = true;

    $scope.showInfos = function (flag){
        $scope.showChart=flag;
    };


     $scope.removeResource=function(resource){
        resourceService.resource.destroy(resource.id,function(){
            $scope.resources = _($scope.resources).without(resource);
        });
    };

    $scope.getChartData=function (resource){
        var response = resourceService.chart.get(resource.id,resource.chartDateRange.startDate, resource.chartDateRange.endDate, 
            function (response){ 
                resource.chart = {
                    "labels":response.labels,
                    "datasets":[
                    {
                        "fillColor":"rgba(151,187,205,0.5)",
                        "strokeColor":"rgba(151,187,205,1)",
                        "pointColor":"rgba(151,187,205,1)",
                        "pointStrokeColor":"#fff",
                        "data":response.data
                    }]
            };


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
                 $scope.getChartData(resource);
        });
    };

    $scope.removeEntry=function(resource, entry){
        resourceService.entry.destroy(resource.id, entry.id, function(){
            $scope.setEntries(resource);                 
            resource.entryLength--;
            $scope.getChartData(resource);
        });
    };

    $scope.getRange=function (resource){
        var pages = $scope.getPages(resource);

        if (pages <= 5){
            return _.range(1, pages+1);
        }else{
            if (resource.page <= 3){
                return _.range(1, 6);
            } else if (resource.page >= (pages-2)){
                return _.range(pages-4, pages+1);
            }
            return _.range((resource.page-2), (resource.page+3));
        } 
    };

    $scope.setEntriesForPage=function (i, resource){
        resource.page = i;
        $scope.setEntries(resource);
    };

    $scope.getPages = function (resource){
        return Math.round(resource.entryLength/5);
    }

    $scope.changePage=function(resource, value){
        var pages = $scope.getPages(resource);
        var changeflag = true;
        resource.page += value;
        if (resource.page > pages){
            resource.page = pages;
            changeflag =false;
        }
        if(resource.page < 1){
            resource.page = 1;
            changeflag = false;
        }
        if (changeflag){
            $scope.setEntries(resource);
        }
    };

    $scope.initChart=function(resource){
        resource.chart = {
            "labels":[],
            "datasets":[
                {
                    "fillColor":"rgba(151,187,205,0.5)",
                    "strokeColor":"rgba(151,187,205,1)",
                    "pointColor":"rgba(151,187,205,1)",
                    "pointStrokeColor":"#fff",
                    "data":[]
                }]
            };
    }; 
    

});