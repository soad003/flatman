angular.module('flatman').factory("shareService", function($resource) {
	var sharedItemService = $resource('/api/shareditem/:id', {}, {
		'get' : {
			method : "GET"
		},
		'update' : {
			method : "PUT"
		},
		'destroy' : {
			method : "DELETE"
		},
		'upload' : {
			method : "PUT"
		}
	});

	var shareService = $resource('/api/share/:id', {
	//:id
	}, {
		'get' : {
			method : "GET",
			isArray : true
		},
		'create' : {
			method : "POST"
		},
		'destroy' : {
			method : "DELETE"
		}
	});

	return {
		item : {
			get : function(itemid, succH, errH) {
				return sharedItemService.get({
					id : itemid
				}, {}, succH, errH);
			},
			update : function(item, succH, errH) {
				return sharedItemService.update({
					id : item.id
				}, item, succH, errH);

			},
			remove : function(item, succH, errH) {
				return shareService.destroy({
					id : item.id
				}, succH, errH);

			},
			upload : function(item, succH, errH) {
				return sharedItemService.upload({
					id : item.id
				}, item, succH, errH);
			}
		},

		//overview
		items : {

			update : function(item, succH, errH) {
				console.log(item);
				return sharedItemService.update({
					id : item.id
				}, item, succH, errH);

			},
			remove : function(item, succH, errH) {
				shareService.destroy({
					id : item.id
				}, succH, errH);

			},
			get : function() {
				return shareService.get();
			},

			create : function(name, succH, errH) {
				console.log(name);
				shareService.create(null, {
					name : name
				}, succH, errH);
			},

			get_summary_string : function(items, flag_available) {
				return _.chain(items).filter(function(item) {
					return item.available == flag_available;
				}).take(3).value().reduce(function(meem, item) {
					return meem + item.name + ", ";
				}, "").slice(0, 50);
			},

			count_items : function(items, flag_available) {
				return _(items).filter(function(item) {
					return item.available == flag_available;
				}).length;
			}
		}

	};

});
