angular.module('flatman').controller("sharedItemCtrl", function($scope, $routeParams, $location, shareService, Util, tagService) {
	$scope.item = shareService.item.get($routeParams.itemid, function() {

		$scope.openFileWindow = function() {
			angular.element(document.querySelector('#fileUpload')).trigger('click');
		};

		$scope.removeItem = function(asktext) {
			bootbox.confirm(asktext, function(result) {
				if (result) {
					shareService.item.remove($scope.item, function(data) {
						$location.path("/share");
					}, function() {
					});
				} else
					return;
			});

		};

		$scope.updateItem = function() {
			shareService.item.update($scope.item, function() {
				$location.path("/share");
			}, function() {
			});
		};

		$scope.uploadImage = function(path) {
			shareService.item.upload($scope.item, function(result) {
				$scope.item = shareService.item.get($routeParams.itemid);
			}, function(error) {
			});
		};

		$scope.removeImage = function() {
			$scope.item.imagePath = null;
			shareService.item.upload($scope.item, function(result) {
				$scope.item = shareService.item.get($routeParams.itemid);
			}, function(error) {
			});
		};
		
		$scope.showImage = function(source) {
		$.magnificPopup.open({
		    items: {
		      src: source
		    },
		    type: 'image'
		});
	 
	};

	});

});
