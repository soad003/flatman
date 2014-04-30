angular.module('number_localized', ['ngLocale']).directive('numberinput', function ($filter) {
      return {
        restrict: 'A',
        require: 'ngModel',
        link: function(scope, element, attrs, ngModelController) {

          ngModelController.$parsers.push(function(data) {
              data = data.replace(',', '.');
              if ((data.split(".").length - 1) > 1){
                data = "";
              }
              return data;
          });

          ngModelController.$formatters.push(function(data) {
              if (locale != 'en'){
                data = (data + "" ).replace('.',',');
              }
              return data;
          });
        }
      };
});