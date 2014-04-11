// Angular Config / Routes

angular.module('flatman', ['ngRoute','ngResource','google-maps','angles','ui.bootstrap','ngAnimate','ngLocale', 'number_localized']).config(function($httpProvider, $routeProvider){
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
        controller: 'dashboardCtrl'
      }).
      when('/share', {
        templateUrl: '/templates/share',
        controller: 'shareCtrl'
      }).
      when('/shareditem', {
        templateUrl: '/templates/shareditem',
        controller: 'shareCtrl'
      }).
      when('/finances', {
        templateUrl: '/templates/finances',
        controller: 'shoppingCtrl'
      }).
      when('/messages', {
        templateUrl: '/templates/messages',
        controller: 'shoppingCtrl'
      }).
      when('/message_window', {
        templateUrl: '/templates/message_window',
        controller: 'messageCtrl'
      }).
      when('/message_new', {
        templateUrl: '/templates/message_new',
        controller: 'messageCtrl'
      }).
      when('/resources', {
        templateUrl: '/templates/resources',
        controller: 'resourceCtrl'
      }).
      when('/create_resource', {
        templateUrl: '/templates/create_resource',
        controller: 'update_resourceCtrl'
      }).
      when('/update_resource/:id', {
        templateUrl: '/templates/create_resource',
        controller: 'update_resourceCtrl'
      }).
      when('/user_settings', {
        templateUrl: '/templates/user_settings',
        controller: 'userSettingsCtrl'
      }).
      when('/flat_settings', {
        templateUrl: '/templates/flat_settings',
        controller: 'flatSettingsCtrl'
      }).
      when('/finances_new', {
        templateUrl: '/templates/finances_new',
        controller: 'shoppingCtrl'
      }).
      when('/finances_overview', {
        templateUrl: '/templates/finances_overview',
        controller: 'shoppingCtrl'
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
              response: function(response) { $rootScope.is_loading=false;  return response; },
              responseError: function(rejection) {
                                                  $rootScope.is_loading=false;
                                                  return $q.reject(rejection);
                                                 }
          };
      });


}).run(function($rootScope,Util){
  $rootScope.$on('$routeChangeStart',function(){
    Util.clear_server_errors();     //clear errors on view change
    $('.modal.in').modal('hide');   //dirty nasty ugly hack!!! DON'T DO THIS AT HOME
  });
});
