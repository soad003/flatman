// Angular Config / Routes
angular.module('flatman', ['ngRoute','ngResource']).config(function($httpProvider, $routeProvider){
  $httpProvider.defaults.headers.post = {'X-CSRF-Token': $("meta[name='csrf-token']").attr("content"),
                                          'Content-Type': 'application/json'};

  $routeProvider.
      when('/new_flat', {
        templateUrl: '/templates/new_flat',
        controller: 'flatCtrl'
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
        controller: 'shoppingCtrl'
      }).
      when('/flat_settings', {
        templateUrl: '/templates/flat_settings',
        controller: 'shoppingCtrl'
      }).
      otherwise({
        redirectTo: '/dashboard'
      });

});
