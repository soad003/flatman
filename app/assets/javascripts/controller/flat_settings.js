angular.module('flatman').controller("flatSettingsCtrl",function($scope,flatService,inviteService,Util){

    $scope.is_dirty=function(){
       return $scope.content_form.$dirty;
    };

    $scope.update_flat=function(){
        $scope.set_location();
        flatService.update({},$scope.flat);
        if(!Util.has_server_errors()) { $scope.content_form.$setPristine(); }
    };

    $scope.get_address_string=function(){
        return $scope.flat.street + ", " + $scope.flat.zip + ", " + $scope.flat.city;
    };

    $scope.set_location=function(){
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode( { 'address': $scope.get_address_string()}, function(results, status) {
              if (status == google.maps.GeocoderStatus.OK) {
                    $scope.map.center.latitude= results[0].geometry.location.lat();
                    $scope.map.center.longitude=results[0].geometry.location.lng();
                    $scope.map.marker.latitude= results[0].geometry.location.lat();
                    $scope.map.marker.longitude=results[0].geometry.location.lng();
                }
        });

    };

    $scope.send_invite=function(){
        inviteService.invite($scope.invite_email,function(data){
            if(!data.already_registred) $scope.flat.invites.push(data.invite);
            else $scope.flat.users.push(data.user);
            $scope.invite_email='';
        });
    };

    $scope.remove_invite=function(invite){
        inviteService.destroy(invite.id ,function(){
            $scope.flat.invites=_($scope.flat.invites).without(invite);
        });
    };

    $scope.map = {
        center: {
            latitude: 47.236,
            longitude: 11.38
        },
        marker: {
            latitude: 47.236,
            longitude: 11.38
        },
        zoom: 13
    };


    $scope.flat=flatService.get(function(){
        $scope.set_location();
    });

});
