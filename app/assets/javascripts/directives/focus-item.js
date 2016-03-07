angular.module('focus-item', []).directive('focusItem', function($timeout, $parse) {
  return {
    scope: false,   // optionally create a child scope
    link: function(scope, element, attrs) {
      var model = $parse(attrs.focusItem);

      if(model(scope) === true) { 
        $timeout(function() {
          element[0].focus(); 
        });
      }
      // maybe not suitable for every use needed for modal (creates sub scope!?) maybe 
      // insert scope.$eval ...
      scope.$parent.$eval(attrs.focusItem + " = false ");
    }
  };
});