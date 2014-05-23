angular.module('flatman').controller("financeEntryCtrl", function($scope,$routeParams, financesService, Util){
    $scope.id = $routeParams.id;

    if($scope.id){
        $scope.finTmp=financesService.bill.get($scope.id);
        $scope.edit=true;
    }else{
       $scope.finTmp={   text:$routeParams.list,
                         value:"",
                         date:new Date(),
                         user_id:"",
                         cat_name:$routeParams.list,
                         user_ids:[]};
    }

    $scope.mates = financesService.mates.get();

    $scope.process_entry=function(){
        if($scope.edit){
            financesService.bill.update($scope.finTmp, function(data){
                Util.redirect_to.finances();
            });
        }else{
            financesService.bill.create($scope.finTmp, function(data){
                Util.redirect_to.finances();
            });
        }
    };

});
