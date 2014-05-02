angular.module('flatman').controller("sharedItemCtrl", function($scope, $routeParams, shareService, uploadService, Util){
    $('bootstrap-tagsinput').tagsinput({
        confirmKeys: [13, 44]
    });


     $('.image-popup').magnificPopup({
      type: 'image'
        // other options
    });



    $scope.item = shareService.item.get($routeParams.itemid);


    $scope.updateItem = function() {
        shareService.item.update($scope.item, function() {
            console.log("successful");
        }, function() {
            console.log("shitty");
        });
    };

    /*$scope.uploadFile = uploadService.get();

    $scope.upload = function() {
        console.log($scope.uploadFile);
    };


    $scope.onFileSelect = function($files) {
        console.log($files);
     };
*/
});
