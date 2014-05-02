var baseUrl = 'http localhost:3000';
angular.module('flatman')
	.controller("sharedItemCtrl", function($scope, $routeParams, shareService, uploadService, Util){
	  	//register tagsinput
		$('bootstrap-tagsinput').tagsinput({confirmKeys: [13, 44]});
		
		//shadowbox for images
		$('.image-popup').magnificPopup({type: 'image'});
		
		
		$scope.item = shareService.item.get($routeParams.itemid);
		
	//	$("#itemavailable").bootstrapSwitch();
	/*$("#itemavailable").on("init", function(){
			.setState($scope.item.available)
		}*/
		
		console.log($scope.item);
		console.log($scope.item.name);
		
		
		
		$('#itemavailable').bootstrapSwitch($scope.item.available);
		
		
	  	$('#itemavailable').on('switchChange.bootstrapSwitch', function(event, state) {
	  	  $scope.item.available = state;
		  console.log(this); // DOM element
		  console.log(event); // jQuery event
		  console.log(state); // true | false
		});
		
		
	  	//fetch the data
	  	
	  	
	
		$scope.openFileWindow = function () {
	  		angular.element( document.querySelector( '#fileUpload' ) ).trigger('click');
	  		console.log('triggering click');
		};
		
	  	
		
		$scope.updateItem = function() {
			console.log($scope.item);
			shareService.item.update($scope.item, function() {
				console.log("successful");
			}, function() {
				console.log("shitty");
			});
		};
		
		
		$scope.uploadImage = function (path) {
			  shareService.item.upload($scope.item, 
			  	function(result){
			  		
			  		console.log("gut. ", result);
			  		$scope.userImageLink = result.image_url;
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
