angular.module('flatman').factory("Util",function($rootScope,$location) {
    return {
        has_server_errors: function(){$rootScope.server_errors=!null;},
        get_server_errors: function(){$rootScope.server_errors},
        set_server_errors: function(errors){$rootScope.server_errors=errors;},
        clear_server_errors: function(errors){$rootScope.server_errors=null;},
        redirect_to: {
            create_flat: function(){$location.path("create_flat");},
            shopping: function(){$location.path("shopping");},
            dashboard: function(){$location.path("dashboard");},
            share: function(){$location.path("share");},
            finances: function(){$location.path("finances");},
            messages: function(){$location.path("messages");},
            message_window: function(){$location.path("message_window")},
            resources: function(){$location.path("resources");},
            user_settings: function(){$location.path("user_settings");},
            flat_settings: function(){$location.path("flat_settings");},
            search: function(term){$location.path("search/"+escape(term));}
        }
    };


});
