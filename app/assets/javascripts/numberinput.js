angular.module('number_localized', []).directive('numberinput', function () {
      return {
        restrict: 'A',
        require: 'ngModel',
        link: function(scope, element, attrs, ngModelController) {

          ngModelController.$parsers.push(function(data) {
              //convert data from view format to model format
              return data.replace(',', "."); //converted
          });

          ngModelController.$formatters.push(function(data) {
              //convert data from model format to view format
              return data.replace('.', ","); //converted
          });
            
          // http://docs.angularjs.org/api/ng.directive:ngModel.NgModelController
            
        }
      };
});