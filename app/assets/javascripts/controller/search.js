angular.module('flatman').controller("searchCtrl",function($scope,$routeParams,searchService,Util){
    $scope.term = $routeParams.term;

    searchService.search($scope.term, function(data){
        $scope.searchdata=data;
    });
	
	$scope.showImage = function(source) {
		$.magnificPopup.open({
		    items: {
		      src: source
		    },
		    type: 'image'
		});
	 
	};
  

});
