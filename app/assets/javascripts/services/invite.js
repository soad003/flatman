angular.module('flatman').factory("inviteService",function($resource) {
    var res=$resource('/api/invite/:id',{},
            {
                'invite': {method: "POST"},
                'destroy': {method: "DELETE"}
            });

    return {
        invite: function(mail,succ,err) { return res.invite({},{email:mail},succ,err); },
        destroy: function(invite_id,succ,err) { return res.destroy({id:invite_id},{},succ,err); }
    }
});
