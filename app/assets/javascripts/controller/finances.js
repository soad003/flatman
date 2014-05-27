angular.module('flatman').controller("financesCtrl", function($scope, financesService,flatService, Util){
	$scope.chartData = [];
	$scope.finances= financesService.bill.get_range(0,5);

	//load categories and chart data
	$scope.AllCategories = financesService.category.get_all(function(data){
		$scope.chartData = financesService.category.get_chart_view(data);
	});

	$scope.getFlatMates = flatService.mates.get();

	$scope.intro = function(){
		return ($scope.finances.length !== 0);
	};

	$scope.removeEntry=function(finance){
		financesService.bill.destroy(finance.id, function(){
            $scope.finances = _($scope.finances).without(finance);
        });
	};

	$scope.payDebt = function(debt){
		financesService.debts.pay_debt(debt.id, function(){
			$scope.allDebts = _($scope.allDebts).without(debt);
		})
	};

	$scope.total = function(){

		var sum = 0;
		for(var i = 0; i < $scope.finances.length; i++){
			sum = sum + $scope.finances[i].value;
		}
		return sum;
	};

	$scope.enoughEntries = function(){
		return $scope.AllCategories.length > 2;
	};

	$scope.setFinanceTables = function (){
		var i = 0;
		$scope.financeTables = financesService.finance.get_tables(function (data){
			_.each($scope.financeTables, function(table){
                                       table.date = new Date();
                                       table.index = i;
                                       i++;
                                       table.page = 1;
            });
		}, function(){});
	};
	$scope.setFinanceTables();


	$scope.math = Math;
	
	$scope.removePayment = function (payment, member){
		if (member.entryLength == 6){
			member.page = 1;
		}
		financesService.payment.destroy(payment.id, member.id, member.page, function (data){
			$scope.financeTables[member.index].value = data.value;
			$scope.financeTables[member.index].entries = data.entries;
			$scope.financeTables[member.index].entryLength = data.entryLength;
		});
	};

	$scope.getRange=function (member){
        var pages = $scope.getPages(member);
        if (pages <= 5){
            return _.range(1, pages+1);
        }else{
            if (member.page <= 3){
                return _.range(1, 6);
            } else if (member.page >= (pages-2)){
                return _.range(pages-4, pages+1);
            }
            return _.range((member.page-2), (member.page+3));
        }
    };

    $scope.setEntriesForPage=function (i, member){
        member.page = i;
        $scope.setEntries(member);
    };

    $scope.getPages = function (member){
        return Math.ceil(member.entryLength/5);
    };

    $scope.setEntries=function(member){
        financesService.finance.get_table(member.id, member.page, function (data){
        member.entries = data.entries;
    	member.value = data.value;    	}, function () {});
    };

    $scope.changePage=function(member, value){
        var pages = $scope.getPages(member);
        var changeflag = true;
        member.page += value;
        if (member.page > pages){
            member.page = pages;
            changeflag =false;
        }
        if(member.page < 1){
            member.page = 1;
            changeflag = false;
        }
        if (changeflag){
            $scope.setEntries(member);
        }
    };
});
