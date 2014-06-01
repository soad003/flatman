angular.module('flatman').controller("searchCtrl",function($scope,$routeParams,searchService,Util){
    $scope.term = $routeParams.term;

    searchService.search($scope.term, function(data){
        $scope.searchdata=data;
    });
	
	$scope.showImage = function(source) {
		console.log(source);
		 $(".show-image").magnificPopup({
		    items: {
		      src: source
		    },
		    type: 'image' // this is default type
		});
	 
	};
  

});
