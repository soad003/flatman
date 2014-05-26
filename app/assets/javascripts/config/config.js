// Angular Config / Routes

angular.module('flatman', ['ngRoute','ngResource','google-maps','angles','ui.bootstrap','ngLocale', 'ngTagsInput', 'number_localized','checklist-model'])
        .config(function($httpProvider, $routeProvider){

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
      when('/shareditem/:itemid', {
        templateUrl: '/templates/shareditem',
        controller: 'sharedItemCtrl'
      }).
      when('/finances', {
        templateUrl: '/templates/finances',
        controller: 'financesCtrl'
      }).
      when('/messages', {
        templateUrl: '/templates/messages',
        controller: 'messageCtrl'
      }).
      when('/create_message', {
        templateUrl: '/templates/create_message',
        controller: 'create_messageCtrl'
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
        templateUrl: '/templates/finance_entry',
        controller: 'financeEntryCtrl'
      }).
      when('/finances_edit/:id', {
        templateUrl: '/templates/finance_entry',
        controller: 'financeEntryCtrl'
      }).
      when('/finances_done_shopping/:list', {
        templateUrl: '/templates/finance_entry',
        controller: 'financeEntryCtrl'
      }).
      when('/finances_overview', {
        templateUrl: '/templates/finances_overview',
        controller: 'financesOverviewCtrl'
      }).
      when('/create_payment', {
        templateUrl:'/templates/create_payment',
        controller: 'createPaymentCtrl'
      }).
      when('/search/:term', {
        templateUrl: '/templates/search',
        controller: 'searchCtrl'
      }).
      otherwise({
        redirectTo: '/dashboard'
      });

      $httpProvider.interceptors.push(function($q,$rootScope,Util) {
          return {
              request: function(config){
                        $rootScope.pending_requests++;
                        return config;
                      },
              response: function(response) {
                        $rootScope.pending_requests--;
                        return response;
                      },
              responseError: function(rejection) {
                        $rootScope.pending_requests--;

                        if(rejection.status === 409) {
                          /* special case no flat redirection of templates see
                          templates_controller.rb*/
                          Util.redirect_to.create_flat();
                        }else {
                          Util.set_server_errors(rejection.data.errors);
                        }
                        return $q.reject(rejection);
                      }
          };
      });


}).run(function($rootScope,Util){
  $rootScope.pending_requests=0;
  $rootScope.$on('$routeChangeStart',function(){
    Util.clear_server_errors();     //clear errors on view change
    $('.modal.in').modal('hide');   //dirty nasty ugly hack!!! DON'T DO THIS AT HOME
  });
});
