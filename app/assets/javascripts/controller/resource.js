angular.module('flatman').controller("resourceCtrl",function($scope, $filter, resourceService, Util){
    $scope.intro = false;
    $scope.resources = resourceService.resource.getAll(function(){
        if ($scope.resources.length == 0){
            $scope.intro = true;
        }
        _.each($scope.resources, function(resource){
                                        resource.enoughEntriesForChart = (resource.entryLength > 2)                   
                                        $scope.init(resource);
                                        $scope.setEntries(resource);
                                        $scope.initChart(resource);
                                        $scope.getChartData(resource);
                                        $scope.setOverview(resource);
                                    });
    });

    $scope.init = function (resource) {
        resource.date = new Date();
        resource.page = 1;
        $scope.showInfos(resource,true);
        resource.chartDateRange.startDate = new Date(resource.chartDateRange.startDate);
        resource.chartDateRange.endDate = new Date(resource.chartDateRange.endDate);
    }

    $scope.showInfos = function (resource, flag){
        resource.showChart=flag;
    };


     $scope.removeResource=function(resource){
        resourceService.resource.destroy(resource.id,function(){
            $scope.resources = _($scope.resources).without(resource);
        });
    };

    $scope.getChartData=function (resource){
        var response = resourceService.chart.get(resource.id,resource.chartDateRange.startDate, resource.chartDateRange.endDate, 
            function (response){ 
                //convert labes date to local format
                for (var i = 0; i < response.labels.length; i++){
                    response.labels[i] = $filter('date')(new Date(response.labels[i]), "shortDate");
                }
                resource.chart = {
                    "labels":response.labels,
                    "datasets":[
                    {
                        "fillColor":"rgba(151,187,205,0.5)",
                        "strokeColor":"rgba(151,187,205,1)",
                        "pointColor":"rgba(151,187,205,1)",
                        "pointStrokeColor":"#fff",
                        "data":response.costs
                    }]
            };


            });
    };

    $scope.setOverview =function (resource){
        resourceService.overview.get(resource.id,resource.chartDateRange.startDate, resource.chartDateRange.endDate, 
            function (response){ 
                resource.infos = response;
            });
    };



    $scope.setEntries=function(resource){
        resource.entries = resourceService.entry.get(resource.id, resource.page);
        resource.entryvalue = "";
    }

     $scope.addEntry=function(resource){
        //resource.entryvalue =  $filter('number')(resource.entryvalue, 2);
        //alert(resource.entryvalue);
        resourceService.entry.create(resource.id,{date:resource.date,value:resource.entryvalue}, function(data){
                 $scope.setEntries(resource);
                 resource.entryLength++;
                 $scope.getChartData(resource);
                 $scope.setOverview(resource);
                 resource.enoughEntriesForChart = (resource.entryLength > 2)  
        });
    };

    $scope.removeEntry=function(resource, entry){
        resourceService.entry.destroy(resource.id, entry.id, function(){
            $scope.setEntries(resource);                 
            resource.entryLength--;
            $scope.getChartData(resource);
            $scope.setOverview(resource);
            resource.enoughEntriesForChart = (resource.entryLength > 2)  
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
        return Math.ceil(resource.entryLength/5);
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