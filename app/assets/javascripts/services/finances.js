angular.module('flatman').factory("financesService", function($resource){
	var financeService = $resource('/api/finance/:id',{},
                        {
                            'create': {method: "POST"},
							'get': {method: "GET", isArray: true},
                            'destroy': {method:"DELETE"},
							'update': {method:"POST"}
                        });

    var chartService = $resource('/api/finance/:id/chart',{},
                        {
                            'get': {method: "GET"}

                        });


	return {
        finance: {
            get: function(succH, errH){
                return financeService.get();
            },
            create: function(finance,succH,errH) {
                console.log("hello");
                financeService.create(finance,succH,errH);
            },
            destroy: function(finance_id,succH,errH){
                console.log("test");
                financeService.destroy({id: finance_id},succH,errH);
            },
            update: function(finance,succH,errH){
                financeService.update({id: finance.id},finance,succH,errH);
            },
            getSum: function(finance){
                return null;
            }
        },
        chart:{
            get: function(finance_id, dateFrom, dateTo, succH, errH){
                return chartService.get({id: finance_id, from: dateFrom, to: dateTo}, succH, errH);
            }
        }
    };

});
