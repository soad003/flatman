/*global btoa:false */

angular.module('flatman').controller("sharedItemCtrl", function($scope, $routeParams, $location, shareService, Util, tagService) {
	$scope.item = shareService.item.get($routeParams.itemid);

	//register tagsinput
	
	

	/*shadowbox for images
	$('.image-popup').magnificPopup({
		type : 'image'
	});
//	*/

	//not working?
	//$('#tags').tagsinput();
	
	$('#tags').tagsinput({
	    typeahead: {
	        source: function (query, process) {
	            cities = [];
	            map = {};
	
	            var data = [{
	                "value": 1,
	                    "text": "Amsterdam"
	            }, {
	                "value": 4,
	                    "text": "Washington"
	            }, {
	                "value": 7,
	                    "text": "Sydney"
	            }, {
	                "value": 10,
	                    "text": "Beijing"
	            }, {
	                "value": 13,
	                    "text": "Cairo"
	            }];
	
	            $.each(data, function (i, city) {
	                map[city.text] = city;
	                cities.push(city.text);
	            });
	
	            return (cities);
	        }
	    }
	});
	
	
	$scope.queryTags = tagService.get("a");
	
	//dummy, get all tags which starts which a
	//console.log($scope.tags);
	//...aand working.
	
	$('#lului').bootstrapSwitch($scope.item);

	$('#lului').on('switchChange.bootstrapSwitch', function(event, state) {
		$scope.item.available = state;
		console.log(this);
		// DOM element
		console.log(event);
		// jQuery event
		console.log(state);
		// true | false
	});
	
	//fetch the data
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
