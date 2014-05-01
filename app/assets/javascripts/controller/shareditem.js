var baseUrl = 'http localhost:3000';
angular.module('flatman')
	.controller("sharedItemCtrl", function($scope, $routeParams, shareService, uploadService, Util){
	  	//register tagsinput
		$('bootstrap-tagsinput').tagsinput({confirmKeys: [13, 44]});
		
		//shadowbox for images
		$('.image-popup').magnificPopup({type: 'image'});
		
	  	
	  	//fetch the data
	  	$scope.item = shareService.item.get($routeParams.itemid);
	  	
	
		$scope.openFileWindow = function () {
	  		angular.element( document.querySelector( '#fileUpload' ) ).trigger('click');
	  		console.log('triggering click');
		};
		
	  	
		
		$scope.updateItem = function() {
			shareService.item.update($scope.item, function() {
				console.log("successful");
			}, function() {
				console.log("shitty");
			});
		};
		
		
		$scope.uploadImage = function (path) {
			  shareService.item.upload($scope.item, 
			  	function(result){
			  		$scope.userImageLink = baseUrl + result.image_url;
			  	}, function (error) {
			  		console.log("scheißn. ", JSON.stringify(error));
			  });
		};
			
		   
		
	})
	//html: upload-image
	.directive('uploadImage', function () {
		//creates the hidden input file.
		return {
		 	restrict: 'A',
		 	link: function (scope, elem, attrs) {
		  		var reader = new FileReader();
		  			reader.onload = function (e) {
			    		scope.item.imageData = btoa(e.target.result);
			    		scope.uploadImage(scope.item.imagePath);
					    scope.$apply();
				  	};
				  	
					// listens on change event
					elem.on('change', function() {
					    console.log('entered change function');
					    var file = elem[0].files[0];
					    
					    // gathers file data (filename and type) to send in json
					    console.log(scope.item);
					    
					    scope.item.imageContent = file.type;
					    scope.item.imagePath = file.name;
					    // updates scope; not sure if this is needed here, I can not remember with the testing I did...and I do not quite understand the apply method that well, as I have read limited documentation on it.
					    scope.$apply();
					    // converts file to binary string
					    reader.readAsBinaryString(file);
					  });
				
			
			}
			
		}
		
	});
