angular.module('flatman').controller("financesService", function($resource){
	var financeService = $resource('/api/finances/:id',{},
                        {
                           // 'getAll': {method: "GET", isArray:true},
                            'create': {method: "POST"},
							'get': {method: "GET"},
							'update': {method:"POST"},
							'destroy': {method:"DELETE"}
                        });

	return {
        finance: {
            get: function(succH, errH){
                return financeService.get();
            },
/*            get: function(finance_id, succH, errH){
                return financeService.get({id: finance_id},succH, errH);
            },*/
            create: function(finance,succH,errH) {
                financeService.create(finance,succH,errH);
            },
            destroy: function(finance_id,succH,errH){
                financeService.destroy({id: finance_id},succH,errH);
            },
            update: function(finance,succH,errH){
                financeService.update({id: finance.id},finance,succH,errH);
            },
            getSum: function(finance){
                return _(finance).reduce(function(memo, l){return memo + _(l.fin).length;}, 0);
            },
        },
    }

});