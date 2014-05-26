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

    var financeTables = $resource('/api/finance/financeTables/:id/:page',{},
                        {
                            'get': {method: "GET", isArray:true}
                        });
    var financeTable = $resource('/api/finance/financeTables/:id/:page',{},
                        {
                            'get': {method: "GET"}
                        });
    var paymentService = $resource('/api/payment/:id/:member_id',{},
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
            },
            get_table: function (member_id, page, succH, errH){
                return financeTable.get({id: member_id, page: page},succH, errH);
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
            },
            get_chart_view: function(categories){
                var colors = ["#428bca", "#5cb85c","#5bc0de", "#f0ad4e", "#d9534f", "black"];
                return _.chain(categories).map(function(item,i){ return {color:       colors[i % (colors.length)],
                                                                   value:       item.listValue,
                                                                   cat_name:    item.cat_name }; })
                                    .sortBy(function(item){ return item.value; })
                                    .reverse()
                                    .take(6)
                                    .value();
            },
            get_category_names: function(categories){
                return _.uniq(_(data).pluck('cat_name'));
            }
        },
        payment: {
            create: function(payer_id, date, value ,succH,errH) {
                paymentService.create(null,{payer_id: payer_id, date: date, value: value}, succH,errH);
            },
            destroy: function(payment_id, member_id, page, succH,errH){
                paymentService.destroy({id: payment_id, member_id: member_id, page: page},succH,errH);
            }
        }
    };

});
