var app = angular.module('flatman');

app.filter('customCurrency', ["$filter", function ($filter) {
    return function(amount, currencySymbol){
        var currency = $filter('currency');

        if(amount < 0){
             var res = currency(amount, currencySymbol).replace("(", "").replace(")", "").split(" ");
             return res[0] + " -" + res[1]; 
        }

        return currency(amount, currencySymbol);
    };
}]);