angular.module('flatman').factory("financesService", function($resource){
    var billService = $resource('/api/bill/:id',{},
                        {
                            'create': {method: "POST"},
                            'get': {method: "GET"},
                            'get_range': {method: "GET", isArray:true},
                            'destroy': {method:"DELETE"},
                            'update': {method:"PUT"}
                        });
    var ctgService = $resource('api/finance/category',{},
                        {
                            'get_all': {method: "GET", isArray:true}
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
            get_sum: function(finance){
                var sum = 0;
                _(finance).each (function (entry){
                    sum += entry.value;
                })
                return Math.round(sum);
            },
            get_tables: function (succH, errH){
                return financeTables.get(null,succH, errH);
            }
        },
        bill: {
            get: function(id, succH, errH){
                return billService.get({id: id},succH,errH);
            },
            get_range: function(from,to, succH, errH){
                return billService.get_range({from: from, to: to},succH,errH);
            },
            create: function(finance,succH,errH) {
                billService.create(finance,succH,errH);
            },
            destroy: function(finance_id,succH,errH){
                billService.destroy({id: finance_id},succH,errH);
            },
            update: function(finance,succH,errH){
                billService.update({id: finance.id},finance,succH,errH);
            }
        },
        category:{
            get_all: function(succH, errH){
                return ctgService.get_all(null, succH, errH);
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
