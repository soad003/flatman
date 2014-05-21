angular.module('flatman').controller("financeEntryCtrl", function($scope,$routeParams, financesService, Util){
    $scope.id = $routeParams.id;

    if($scope.id){
        $scope.finTmp={ text:"there was an id passed",
                        value:"",
                        date:new Date(),
                        user_id:"",
                        cat_name:"",
                        payer:""};
        $scope.edit=true;
    }else{
       $scope.finTmp={   text:$routeParams.list, value:"",
                         date:new Date(),
                         user_id:"",
                         cat_name:$routeParams.list, payer:""};
    }

    $scope.getFlatMates = financesService.mates.get();


    $scope.addEntry=function(){
        financesService.finance.create($scope.finTmp, function(data){
            Util.redirect_to.finances();
        });
    };


    $scope.updateEntry=function(finance){
        financesService.finance.update($scope.finTmp, function(data){
            Util.redirect_to.finances();
        });
    };

});
