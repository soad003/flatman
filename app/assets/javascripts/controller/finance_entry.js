angular.module('flatman').controller("financeEntryCtrl", function($scope,$routeParams, financesService, userService, flatService, Util){

    $scope.process_entry=function(){
        if($scope.edit){
            financesService.bill.update($scope.finTmp, function(data){
                Util.redirect_to.back();
            });
        }else{
            financesService.bill.create($scope.finTmp, function(data){
                Util.redirect_to.back();
            });
        }
    };
    $scope.is_editable=true;
    $scope.id = $routeParams.id;

    financesService.category.get_all(function(data){
         $scope.categories = financesService.category.get_category_names(data);
    });

    if($scope.id){
        financesService.bill.get($scope.id,function(data){
            $scope.finTmp=data;
            $scope.is_editable = $scope.finTmp.is_editable;
        });
        $scope.mates = flatService.mates.get();
        $scope.edit=true;
    }else{
        flatService.mates.get(function(data){
            $scope.finTmp= {     text:$routeParams.list,
                                 value:"",
                                 date:new Date(),
                                 user_id:2,
                                 cat_name: ($routeParams.list) ? $routeParams.list.split(":")[0] : "",
                                 user_ids: _(data).map(function(i){return i.id; })
                         };
            userService.get().$promise.then(function(data){$scope.finTmp.user_id = data.id});
            $scope.mates = data;
        });
    }
});
