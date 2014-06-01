angular.module('flatman').controller("resourceCtrl", function($scope, $filter, resourceService, Util) {

    $scope.formatNumber = function(number) {
        return (locale != 'en') ? number.toString().replace('.', ',') : number;
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

    $scope.convertAndSetChartData = function(data, resource) {
        var colors = ["92,184,92", "66,139,202", "240,173,78", "217,83,79"];
        for (var i = 0; i < data.labels.length; i++) {
            data.labels[i] = $filter('date')(new Date(data.labels[i]), "shortDate");
        }
        $scope.resources[resource.index].chart = {
            "labels": data.labels,
            "datasets": [{
                "fillColor": "rgba(" + colors[resource.index % 4] + ",0.5)",
                "strokeColor": "rgba(" + colors[resource.index % 4] + ",1)",
                "pointColor": "rgba(" + colors[resource.index % 4] + ",1)",
                "pointStrokeColor": "#fff",
                "data": data.costs
            }]
        };
    };

    $scope.getChartData = function(resource) {
        resourceService.chart.get(resource.id, resource.chartDateRange.startDate, resource.chartDateRange.endDate,
            function(response) {
                $scope.convertAndSetChartData(response, resource);
            });
    };

    $scope.setOverview = function(resource) {
        resourceService.overview.get(resource.id, resource.chartDateRange.startDate, resource.chartDateRange.endDate,
            function(response) {
                resource.overview = response;
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
        $scope.showIntro = $scope.resources.length === 0;
        _.each($scope.resources, function(resource, i) {
            resource.index = i;
            resource.showChart = true;
            $scope.convertAndSetChartData(resource.chart, resource);
            resource.date = new Date();
        });
    });
    $scope.showIntro = false;
    $scope.entriesPerPage = 5;
});
