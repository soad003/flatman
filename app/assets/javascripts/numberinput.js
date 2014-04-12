angular.module('number_localized', ['ngLocale']).directive('numberinput', function ($filter) {
      return {
        restrict: 'A',
        require: 'ngModel',
        link: function(scope, element, attrs, ngModelController) {

          ngModelController.$parsers.push(function(data) {
              //convert data from view format to model format
              data = data.replace(',', '.');
              if ((data.split(".").length - 1) > 1){
                data = "";
              }
              return data;
          });

          ngModelController.$formatters.push(function(data) {
              //convert data from model format to view format
              if (locale != 'en'){
                data = (data + "" ).replace('.',',');
              }
              return data;
          })          
        }
      };
});