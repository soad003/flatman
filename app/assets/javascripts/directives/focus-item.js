angular.module('focus-item', []).directive('focusItem', function() {
  return {
    link: function(scope, element, attrs) {
      scope.$watch(attrs.focusItem, function() {
            element[0].focus();
      });
    }
  };
});