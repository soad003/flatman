angular.module('flatman').controller("resourceCtrl", function($scope, $filter, resourceService, Util) {

    $scope.getColor=function(index){
        var colors=['success','info','warning','danger'];
        return colors[index%4];
    };

    $scope.formatNumber = function(number) {
        return (locale != 'en') ? number.toString().replace('.', ',') : number;
    };

    $scope.init = function(resource) {
        resource.date = new Date();
        resource.page = 1;

        $scope.showInfos(resource, true);
        resource.chartDateRange.startDate = new Date(resource.chartDateRange.startDate);
        resource.chartDateRange.endDate = new Date(resource.chartDateRange.endDate);
    };

    $scope.showInfos = function(resource, flag) {
        $scope.getChartData(resource);
        $scope.setOverview(resource);
        resource.showChart = flag;
    };

    $scope.removeResource = function(resource, text) {
        bootbox.confirm(text, function(result) {
            if (result) {
                resourceService.resource.destroy(resource.id, function() {
                    $scope.resources = _($scope.resources).without(resource);
                });
            }
        });
    };

    $scope.getChartData = function(resource) {
    //green, blue, yellow, red
    // bootstrap colors from shoppinglist 
    //var colors = ["223,240,216", "212, 237,247","252, 248,227", "242,222,222"];
    var colors = ["92,184,92", "66,139,202","240,173,78", "217,83,79"];
        var response = resourceService.chart.get(resource.id, resource.chartDateRange.startDate, resource.chartDateRange.endDate,
            function(response) {
                //convert labes date to local format
                for (var i = 0; i < response.labels.length; i++) {
                    response.labels[i] = $filter('date')(new Date(response.labels[i]), "shortDate");
                }
                resource.chart = {
                    "labels": response.labels,
                    "datasets": [{
                        "fillColor": "rgba("+colors[resource.index%4]+",0.5)",//"rgba(151,187,205,0.5)",
                        "strokeColor": "rgba("+colors[resource.index%4]+",1)",
                        "pointColor": "rgba("+colors[resource.index%4]+",1)",
                        "pointStrokeColor": "#fff",
                        "data": response.costs
                    }]
                };
            });
    };

    $scope.setOverview = function(resource) {
        resourceService.overview.get(resource.id, resource.chartDateRange.startDate, resource.chartDateRange.endDate,
            function(response) {
                resource.infos = response;
            });
    };

    $scope.setPage = function(resource, page) {
        resource.page = page;
        $scope.setEntries(resource);
    };


    $scope.setEntries = function(resource) {
        resource.entries = resourceService.entry.get_range(resource.id, (resource.page - 1) * $scope.entriesPerPage, resource.page * $scope.entriesPerPage);
        resource.entryvalue = "";

    };

    $scope.addEntry = function(resource) {
        resourceService.entry.create(resource.id, {
            date: resource.date,
            value: resource.entryvalue
        }, function(data) {
            $scope.setEntries(resource);
            resource.entryLength++;
            $scope.getChartData(resource);
            $scope.setOverview(resource);
        });
    };

    $scope.removeEntry = function(resource, entry) {
        resourceService.entry.destroy(resource.id, entry.id, function() {
            $scope.setEntries(resource);
            resource.entryLength--;
            $scope.getChartData(resource);
            $scope.setOverview(resource);
        });
    };


    $scope.resources = resourceService.resource.getAll(function() {
        if ($scope.resources.length === 0) {
            $scope.showIntro = true;
        }
        _.each($scope.resources, function(resource, i) {
            resource.index = i;
            $scope.init(resource);
            $scope.setEntries(resource);
        });
    });
    $scope.showIntro = false;
    $scope.entriesPerPage = 5;
});
