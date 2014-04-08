angular.module('flatman').controller("financesService", function($finance){
	var financeService = $finance('/api/finance/:id',{},
                        {
                            'getAll': {method: "GET", isArray:true},
                            'create': {method: "PUT"},
							'get': {method: "GET"},
							'update': {method:"POST"},
							'destroy' {method:"DELETE"}
                        });

	var chartService = $finance('/api/finance/:id/chart',{},
                        {
                            'get': {method: "GET"}
                        });

	var overviewService = $finance('/api/finance/:id/overview',{},
                        {
                            'get': {method: "GET"}
                        });

    /*var entryService = $finance('/api/finance/:r_id/resourceentry/:id',{},
                        {
                            'get': {method: "GET", isArray:true},
                            'create': {method: "POST"},
                            'destroy': {method: "DELETE"}                        
                        });*/

	return {
        finance: {
            getAll: function(succH, errH){
                return financeService.getAll(null,succH, errH);
            },
            get: function(finance_id, succH, errH){
                return financeService.get({id: finance_id},succH, errH);
            },
            create: function(finance,succH,errH) {
                financeService.create(null,finance,succH,errH);
            },
            destroy: function(finance_id,succH,errH){
                financeService.destroy({id: finance_id},succH,errH);
            },
            update: function(finance,succH,errH){
                financeService.update({id: finance.id},finance,succH,errH);
            }
        },
        chart:{

        },
        overview:{

        };

});