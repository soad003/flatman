angular.module('flatman').controller("financeEntryCtrl", function($scope,$routeParams, financesService, flatService, Util){
    $scope.id = $routeParams.id;

    financesService.category.get_all(function(data){
         $scope.categories = _.uniq(_(data).pluck('cat_name'));
    });

    if($scope.id){
        $scope.finTmp=financesService.bill.get($scope.id);
        $scope.mates = flatService.mates.get();
        $scope.edit=true;
    }else{
        flatService.mates.get(function(data){
            $scope.finTmp= {     text:$routeParams.list,
                                 value:"",
                                 date:new Date(),
                                 user_id:"",
                                 cat_name:$routeParams.list,
                                 user_ids: _(data).map(function(i){return i.id; })
                         };// alle vorselektieren

            $scope.mates = data;
        });
    }

     $scope.process_entry=function(){
        alert("info");
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
