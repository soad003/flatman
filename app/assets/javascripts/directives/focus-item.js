angular.module('focus-item', []).directive('focusItem', function($timeout, $parse) {
  return {
    link: function(scope, element, attrs) {
      scope.$watch($parse(attrs.focusItem), function(val) {
        if (val) {
            $timeout(function() {
               element[0].focus(); 
            },100);
        }
      });
    }
  };
});