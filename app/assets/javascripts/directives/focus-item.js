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

// angular.module('focus-item', []).directive('focusItem', function($timeout, $parse) {
//   return {
//     //scope: true,   // optionally create a child scope
//     link: function(scope, element, attrs) {
//       var model = $parse(attrs.focusItem);

//       console.log('value=',model(scope));
//       if(model(scope) === true) { 
//         $timeout(function() {
//           element[0].focus(); 
//         });
//       }

//       // to address @blesh's comment, set attribute value to 'false'
//       // on blur event:
//       element.bind('blur', function() {
//          console.log('blur');
//          model.assign(scope, false);
//          scope.$apply();
//          console.log('value=',model(scope));
//       });
//     }
//   };
// });