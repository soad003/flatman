angular.module('flatman').controller("shareCtrl", function($scope, shareService, Util, $location) {
	$scope.shareditems = shareService.items.get();

	//add tooltips (data in title="") to classes.
	$('.panel-tooltip').tooltip({
		placement : "bottom"
	});

	//add a new fucking item. just title.
	$scope.addItem = function() {
		shareService.items.create($scope.newItemName, function(data) {
			data.items = [];
			$scope.shareditems.push(data);
			$scope.newItemName = '';
			window.location = "#/shareditem/" + data.id;
		}, function() {
			//errorhandling
		});

	};

	$scope.removeItem = function(item) {
		bootbox.confirm("Are you sure?", function(result) {
			if (result) {
				shareService.items.remove(item, function(data) {
					$scope.shareditems = _($scope.shareditems).without(item);
				}, function() {
				});
			}
		});

	};

	$scope.hideItem = function(item, hide) {
		item.hidden = hide;
		shareService.items.update(item, function(data) {

		}, function() {

		});
	};

	$scope.borrowItem = function(item) {
		item.available = !item.available;
		shareService.items.update(item, function(data) {

		}, function() {
		});
	};

});
