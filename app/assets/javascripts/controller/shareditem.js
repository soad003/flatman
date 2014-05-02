/*global btoa:false */
var baseUrl = 'http localhost:3000';
angular.module('flatman').controller("sharedItemCtrl", function($scope, $routeParams, $location, shareService, Util) {
	$scope.item = shareService.item.get($routeParams.itemid);

	/*register tagsinput
	('bootstrap-tagsinput').tagsinput({
		confirmKeys : [13, 44]
	});

	//shadowbox for images
	$('.image-popup').magnificPopup({
		type : 'image'
	})*/;

	$('#itemavailable').bootstrapSwitch($scope.item.available);

	$('#itemavailable').on('switchChange.bootstrapSwitch', function(event, state) {
		$scope.item.available = state;
		console.log(this);
		// DOM element
		console.log(event);
		// jQuery event
		console.log(state);
		// true | false
	});

	console.log($scope.item);

	//fetch the data
	$scope.openFileWindow = function() {
		angular.element(document.querySelector('#fileUpload')).trigger('click');
	};

	$scope.removeItem = function() {
		bootbox.confirm("Are you sure?", function(result) {
			if (result) {
				shareService.items.remove($scope.item, function(data) {
					$location.path("/share");
				}, function() {
				});
			}
		});

	};

	$scope.updateItem = function() {
		console.log($scope.item);
		shareService.item.update($scope.item, function() {
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
		$scope.item.image = null;
		shareService.item.upload($scope.item, function(result) {
			$scope.item = shareService.item.get($routeParams.itemid);
		}, function(error) {
		});
	};

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
	}

});
