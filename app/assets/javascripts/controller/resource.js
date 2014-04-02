angular.module('flatman').controller("resourceCtrl",function($scope, resourceService, Util){
    $scope.resources = resourceService.resource.getAll(function(){
        _.each($scope.resources, function(resource){
                                        resource.date = new Date(); 
                                        resource.page = 1;
                                        $scope.setEntries(resource);
                                        $scope.initChart(resource);

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

   

    
    $scope.initChart=function(resource){
        resource.chart = {
        labels : ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday","bla","bla","Monday", "Tuesday", "Wednesday", "Thursday", "Friday","bla","bla","Monday", "Tuesday", "Wednesday", "Thursday", "Friday","bla","bla","Monday", "Tuesday", "Wednesday", "Thursday", "Friday","Monday", "Tuesday", "Wednesday", "Thursday", "Friday","Monday", "Tuesday", "Wednesday", "Thursday", "Friday","bla","bla","Monday", "Tuesday", "Wednesday", "Thursday", "Friday","bla","bla","Monday", "Tuesday", "Wednesday", "Thursday", "Friday","bla","bla","Monday", "Tuesday", "Wednesday", "Thursday", "Friday","Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
        datasets : [
            {
                
                  fillColor : "rgba(151,187,205,0.5)",
                  strokeColor : "rgba(151,187,205,1)",
                  pointColor : "rgba(151,187,205,1)",
                  pointStrokeColor : "#fff",
                 data : [65,59,90,81,56,55,40,65,59,90,81,56,55,40,65,59,90,81,56,55,40,5,59,90,81,56,55,40,65,59,90,81,56,55,40,65,59,90,81,56,55,40]
            },
            {
                fillColor : "rgba(151,187,205,0)",
                strokeColor : "#f1c40f",
                pointColor : "rgba(151,187,205,0)",
                pointStrokeColor : "#f1c40f",
                data : [8, 3, 2, 5, 4]
            }
        ]
        };


      /*  _.each($scope.resources, function(resource){
             var data = {
                labels : ["January","February","March","April","May","June","July"],
                datasets : [
                  {
                    fillColor : "rgba(220,220,220,0.5)",
                    strokeColor : "rgba(220,220,220,1)",
                    pointColor : "rgba(220,220,220,1)",
                    pointStrokeColor : "#fff",
                    data : [65,59,90,81,56,55,40]
                  }
                ]
              }
                 //var ctx = document.getElementsByClassName("myChart")[0].getContext("2d");//document.getElementById("myChart");
            //chart.height =  document.getElementById('chartdiv').offsetHeight +100;
              //      chart.width = document.getElementById('chartdiv').offsetWidth;
             //var ctx =  $('.myChart').getContext("2d");
             var ctx = document.getElementById("chart"+resource.id).getContext("2d");
             new Chart(ctx).Line(data,null);
           });
       */   
    }; 
    

});