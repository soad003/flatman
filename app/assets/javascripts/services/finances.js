angular.module('flatman').factory("financesService", function($resource){
	var financeService = $resource('/api/finance/:id',{},
                        {
                            'create': {method: "POST"},
							'get': {method: "GET", isArray: true},
                            'destroy': {method:"DELETE"},
							'update': {method:"POST"}
                        });
    var ctgService = $resource('api/finance/category',{},
                        {
                            'get_all': {method: "GET", isArray:true}
                        });

    var chartService    = $resource('/api/finance/chart',{},
                        {
                            'get': {method: "GET", isArray:true}

                        });

    var debtService     = $resource('api/finance/debts',{},
                        {
                            'get': {method: "GET", isArray:true},
                            'create_debt': {method:"POST"},
                            'destroy': {method:"DELETE"}
                        });
    var mateService     = $resource('api/finance/mates', {},
                        {
                            'get': {method: "GET", isArray:true}
                        });
    var monthService    = $resource('api/finance/month', {},
                        {
                            'get': {method: "GET"}
                        });

    var financeTables = $resource('/api/finance/financeTables',{},
                        {
                            'get': {method: "GET", isArray:true}
                        });
    var paymentService = $resource('/api/payment/:id',{},
                        {
                            'create': {method: "POST"},
                            'destroy': {method: "DELETE"}
                       });

	return {
        finance: {
            get: function(succH, errH){
                return financeService.get();
            },
            create: function(finance,succH,errH) {
                financeService.create(finance,succH,errH);
            },
            destroy: function(finance_id,succH,errH){
                financeService.destroy({id: finance_id},succH,errH);
            },
            update: function(finance,succH,errH){
                financeService.update({id: finance.id},finance,succH,errH);
            },
            get_sum: function(finance){
                return null;
            },
            get_tables: function (succH, errH){
                return financeTables.get(succH, errH);
            }
        },
        chart:{
            get: function(succH, errH){
                return chartService.get(succH, errH);
            }
        },
        category:{
            get_all: function(succH, errH){        
                return ctgService.get_all(null, succH, errH);
            }
        },
        debts:{
            get: function(){
                return debtService.get();
            },
            create_debt: function(){
                
            },
            pay_debt: function(debt, succH, errH){
                debtService.destroy({id: debt}, succH, errH);
            }
        },
        mates:{
            get: function(){
                return mateService.get();
            }
        },
        month:{
            get: function(month_from, month_to, succH, errH){
                return monthService.get(month_from, month_to, succH, errH);
            }
        },
        payment: {
            create: function(payer_id, date, value ,succH,errH) {
                paymentService.create(null,{payer_id: payer_id, date: date, value: value}, succH,errH);
            },
            destroy: function(payment_id, succH,errH){
                paymentService.destroy({id: payment_id},succH,errH);
            }
        }
    };

});
