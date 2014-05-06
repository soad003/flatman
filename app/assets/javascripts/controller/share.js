angular.module('flatman').controller("shareCtrl", function($scope, shareService, Util, $location) {
	$scope.shareditems = shareService.items.get();

	$('.panel-tooltip, .tooltip').tooltip({
		placement : "bottom"
	});

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

	$scope.removeItem = function(asktext, item) {
		bootbox.confirm(asktext, function(result) {
			if (result) {
				shareService.items.remove(item, function(data) {
					$scope.shareditems = _($scope.shareditems).without(item);
				}, function() {
				});
			}
		});

	};

	$scope.hideItem = function(item) {
		item.hidden = !item.hidden;
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
