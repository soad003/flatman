angular.module('flatman').factory("financesService", function($resource){
	var financeService = $resource('/api/finance/:id',{},
                        {
                            'create': {method: "POST"},
							'get': {method: "GET", isArray: true},
                            'destroy': {method:"DELETE"},
							'update': {method:"POST"}
                        });
    //no service neede, merge witch financeService!
    var ctgService = $resource('api/finance/category',{},
                        {
                            'get_all': {method: "GET", isArray:true},
                        });

    var chartService    = $resource('/api/finance/chart',{},
                        {
                            'get': {method: "GET", isArray:true}

                        });

    var debtService     = $resource('api/finance/debts',{},
                        {
                            'get': {method: "GET", isArray:true},
                            'create_debt': {method:"POST"},
                            'pay_debt': {method:"DELETE"}
                        });
    var mateService     = $resource('api/finance/mates', {},
                        {
                            'get': {method: "GET", isArray:true}
                        });
    var monthService    = $resource('api/finance/month', {},
                        {
                            'get': {method: "GET"}
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
            }
        },
        chart:{
            get: function(succH, errH){
                //with date!!
                return chartService.get(succH, errH);
            }
        },
        category:{
            get_all: function(){           
                return ctgService.get_all();
            }
        },
        debts:{
            get: function(){
                return debtService.get();
            },
            create_debt: function(){
                
            },
            pay_debt: function(){

            }
        },
        mates:{
            get: function(){
                return mateService.get();
            }
        },
        month:{
            get: function(month){
                return monthService.get(month);
            }
        }
    };

});
