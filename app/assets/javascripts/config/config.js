// Angular Config / Routes

angular.module('flatman', ['ngRoute',
                            'ngResource',
                            'ngSanitize',
                            'google-maps',
                            'angles',
                            'ui.bootstrap',
                            'ngLocale',
                            'number_localized',
                            'checklist-model',
                            'focus-item',
                            'infinite-scroll',
                            'iso.directives',
                            'angular-gestures'])
        .config(function($httpProvider, $routeProvider, hammerDefaultOptsProvider){

  $httpProvider.defaults.headers.common = {'X-CSRF-Token': $("meta[name='csrf-token']").attr("content"),
                                          'Content-Type': 'application/json'};
  $routeProvider.
      when('/create_flat', {
        templateUrl: '/templates/create_flat',
        controller: 'createFlatCtrl'
      }).
      when('/shopping', {
        templateUrl: '/templates/pinboard',
        controller: 'pinboardCtrl'
      }).
      when('/todo', {
        templateUrl: '/templates/pinboard',
        controller: 'pinboardCtrl'
      }).
      when('/dashboard', {
        templateUrl: '/templates/newsfeed',
        controller: 'newsfeedCtrl'
      }).
      when('/newsfeed', {
        templateUrl: '/templates/newsfeed',
        controller: 'newsfeedCtrl'
      }).
      when('/pinboard', {
        templateUrl: '/templates/pinboard',
        controller: 'pinboardCtrl'
      }).
      when('/finances', {
        templateUrl: '/templates/finances',
        controller: 'financesCtrl'
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
      when('/finance_overview_mate/:id', {
        templateUrl: '/templates/finance_overview_mate',
        controller: 'financesOverviewMateCtrl'
      }).
      when('/bills_overview/', {
        templateUrl: '/templates/bills_overview',
        controller: 'billsOverviewCtrl'
      }).
      when('/create_payment', {
        templateUrl:'/templates/create_payment',
        controller: 'createPaymentCtrl'
      }).
      otherwise({
        redirectTo: '/newsfeed'
      });

      hammerDefaultOptsProvider.set({
          dragBlockHorizontal: true,
          dragLockToAxis: true,
          preventDefault: false,
          recognizers: [
                    [Hammer.Swipe,{
                                    direction: Hammer.DIRECTION_HORIZONTAL,
                                    // threshold: 0,
                                    // delta: 10,
                                    // flickTreshold: 0.6,  
                                    // drag_min_distance:1,
                                    // swipe_velocity:0.1
                                    dragBlockHorizontal: true,
                                    dragLockToAxis: true,
                                    preventDefault: false
                                  }]
                        ]
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
    $('.modal.in').modal('hide');   //dirty nasty ugly hack!!! DON'T DO THIS AT
    fix_android_stock_select();
  });
});
