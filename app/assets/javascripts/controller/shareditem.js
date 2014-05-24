/*global btoa:false */

angular.module('flatman').controller("sharedItemCtrl", function($scope, $routeParams, $location, shareService, Util, tagService) {
	$scope.item = shareService.item.get($routeParams.itemid, function(){
		
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
		
	    
	   
	});
	

	
	
	
	
	
	//fetch the data
	
	
	
	
})
//html: upload-image
.directive('uploadImage', function() {
	//creates the hidden input file.
	return {
		restrict : 'A',
		link : function(scope, elem, attrs) {
			var reader = new FileReader();
			reader.onload = function(e) {
				scope.item.imageData = btoa(e.target.result);
				scope.uploadImage(scope.item.imagePath);
				scope.$apply();
			};

			// listens on change event
			elem.on('change', function() {
				var file = elem[0].files[0];
				scope.item.imageContent = file.type;
				scope.item.imagePath = file.name;
				scope.$apply();

				// converts file to binary string
				reader.readAsBinaryString(file);
			});
		}
	};

});
