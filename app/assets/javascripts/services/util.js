angular.module('flatman').factory("Util",function($rootScope,$location) {
    return {
        has_server_errors: function(){ return ($rootScope.server_errors=!null); },
        get_server_errors: function(){ return $rootScope.server_errors;},
        set_server_errors: function(errors){$rootScope.server_errors=errors;},
        clear_server_errors: function(){$rootScope.server_errors=null;},
        delete_server_error: function(i){$rootScope.server_errors.splice(i,1);},
        redirect_to: {
            create_flat: function(){$location.path("create_flat");},
            shopping: function(){$location.path("shopping");},
            dashboard: function(){$location.path("dashboard");},
            share: function(){$location.path("share");},
            finances: function(){$location.path("finances");},
            messages: function(){$location.path("messages");},
            resources: function(){$location.path("resources");},
            user_settings: function(){$location.path("user_settings");},
            bills_overview: function(){$location.path("bills_overview");},
            finance_overview_mate: function(id){$location.path("finance_overview_mate/"+id);},
            flat_settings: function(){$location.path("flat_settings");},
            search: function(term){$location.path("search/"+encodeURIComponent(term));},
            finances_done_shopping: function(name){$location.path("finances_done_shopping/"+encodeURIComponent(name));},
            back: function(url){if (url !== undefined) $location.path(url); else history.back();}
        }
    };


});
