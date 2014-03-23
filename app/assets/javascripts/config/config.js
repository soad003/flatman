// Angular Config / Routes
angular.module('flatman', ['ngRoute','ngResource']).config(function($httpProvider, $routeProvider){
  $httpProvider.defaults.headers.common = {'X-CSRF-Token': $("meta[name='csrf-token']").attr("content"),
                                          'Content-Type': 'application/json'};
  $routeProvider.
      when('/create_flat', {
        templateUrl: '/templates/create_flat',
        controller: 'createFlatCtrl'
      }).
      when('/shopping', {
        templateUrl: '/templates/shopping',
        controller: 'shoppingCtrl'
      }).
      when('/dashboard', {
        templateUrl: '/templates/dashboard',
        controller: 'shoppingCtrl'
      }).
      when('/share', {
        templateUrl: '/templates/share',
        controller: 'shoppingCtrl'
      }).
      when('/finances', {
        templateUrl: '/templates/finances',
        controller: 'shoppingCtrl'
      }).
      when('/messages', {
        templateUrl: '/templates/messages',
        controller: 'shoppingCtrl'
      }).
      when('/resources', {
        templateUrl: '/templates/resources',
        controller: 'shoppingCtrl'
      }).
      when('/user_settings', {
        templateUrl: '/templates/user_settings',
        controller: 'userSettingsCtrl'
      }).
      when('/flat_settings', {
        templateUrl: '/templates/flat_settings',
        controller: 'flatSettingsCtrl'
      }).
      when('/search/:term', {
        templateUrl: '/templates/search',
        controller: 'searchCtrl'
      }).
      otherwise({
        redirectTo: '/dashboard'
      });

      $httpProvider.interceptors.push(function ($q,Util) {
        return {
            'response': function (response) {
              Util.clear_server_errors();
              return response;
            },
            'responseError': function (rejection) {
               Util.set_server_errors(rejection.data.errors);
               return $q.reject(rejection);
            }
        };
      });

      $httpProvider.interceptors.push(function($q,$rootScope) {
          return {
              request: function(config){ $rootScope.is_loading=true; return config; },
              response: function(response) { $rootScope.is_loading=false;  return response }
          };
      });


}).run(function($rootScope){
  $rootScope.$on('$routeChangeStart',function(){
    $('.modal.in').modal('hide'); //dirty nasty ugly hack!!! DON'T DO THIS AT HOME
  });
});
