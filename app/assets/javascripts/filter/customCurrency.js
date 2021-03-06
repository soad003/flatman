var app = angular.module('flatman');

app.filter('customCurrency', ["$filter", function ($filter) {
    return function(amount, currencySymbol){
        var currency = $filter('currency');
		var res = currency(amount, ''); //currencySymbol);
        if(res.indexOf("(") != -1){
             res = res.replace("(", "").replace(")", "");
             return "-" + res;
        }


        return currency(amount, ''); //currencySymbol);
    };
}]);