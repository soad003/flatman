angular.module('flatman').factory("financesService", function($resource){
    var billService = $resource('/api/bill/:id',{},
                        {
                            'create': {method: "POST"},
                            'get': {method: "GET"},
                            'get_range': {method: "GET"},
                            'destroy': {method:"DELETE"},
                            'update': {method:"PUT"}
                        });
    var ctgService = $resource('api/finance/category',{},
                        {
                            'get_all': {method: "GET", isArray:true}
                        });

    var overviewMates = $resource('/api/finance/overviewMates/',{},
                        {
                            'get': {method: "GET", isArray:true}
                        });
    var overviewMate = $resource('/api/finance/overviewMates/:id/',{},
                        {
                            'get': {method: "GET"}
                        });
    var paymentService = $resource('/api/payment/:id/:mate_id',{},
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
                return sum;
            },
            get_overview_mates: function (from, to, succH, errH){
                return overviewMates.get({from: from, to: to},succH, errH);
            },
            get_overview_mate: function (mate_id, from, to, succH, errH){
                return overviewMate.get({id: mate_id, from: from, to: to},succH, errH);
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
                return ctgService.get_all({from: new Date('2011','01','02'), to: new Date()}, succH, errH);
            },
            get_chart_view: function(categories){
                var colors = ["#428bca", "#5cb85c","#5bc0de", "#f0ad4e", "#d9534f", "black"];
                return _.chain(categories).sortBy(function(item){ return item.listValue; })
                                          .reverse()
                                          .take(6)
                                          .map(function(item,i){ return {color:       colors[i % (colors.length)],
                                                                   value:       item.listValue,
                                                                   cat_name:    item.cat_name }; })
                                           .value();
            },
            get_category_names: function(categories){
                return _.uniq(_(categories).pluck('cat_name'));
            }
        },
        payment: {
            create: function(payer_id, date, value, description, succH,errH) {
                paymentService.create(null,{payer_id: payer_id, date: date, value: value, description: description}, succH,errH);
            },
            destroy: function(payment_id, mate_id, succH,errH){
                paymentService.destroy({id: payment_id, mate_id: mate_id},succH,errH);
            }
        }
    };

});
