angular.module('flatman').controller("pinboardCtrl",function($scope,$q,$location,$modal,$timeout,shoppingService,todoService,Util){

    var SHOP_TYPE="shop";
    var TODO_TYPE="todo";

    function get_service(list){ return (list.type==TODO_TYPE)? todoService : shoppingService; }

    //hack sublist change
    function rebind_ui() {
        $timeout(function() {
            $scope.$emit('iso-method', {name:null, params:null});
        },100);
    }

    function load_data() { 
        return $q.all([shoppingService.list.get().$promise,
                        todoService.list.get().$promise, 
                        shoppingService.item.get_most_bought_items().$promise]);
    }

    function insert_data(data){ 
        $scope.lists = data[0].concat(data[1]);
        $scope.most_bought = _(data[2]).map(function(x){ return x[0]; });
    }

    function open_modal_create_list(callback_succ, todo) {
        var modalinst = $modal.open({
                      animation: true,
                      templateUrl: 'create_list.html',
                      controller: 'createListCtrl',
                      size: null,
                      resolve: { is_todo: function() {return todo;} }
                    });
        modalinst.result.then(function(res){
            $scope.focus_items_on_add=true;
            callback_succ(res);
        });
        // Ugly hack due to bug https://github.com/angular-ui/bootstrap/issues/2017
        modalinst.opened.then(function() {
                                        $timeout(function() {
                                            $(".modal").find('input:text:visible:first').focus();
                                        },200) 
                                    });
    }

    $scope.filter_type=($location.path()==="/shopping")? SHOP_TYPE: TODO_TYPE;
    $scope.lists = [];
    $scope.most_bought = [];
    $scope.focus_items_on_add=false;

    $scope.get_typeahead_data=function(list) {return $scope.is_todo(list) ? [] : $scope.most_bought ;}

    $scope.track_via=function(item) { return item.type + ":" + item.id; };
    
    $scope.filtered_shopping=function(){ return $scope.filter_type===SHOP_TYPE; };
    $scope.filtered_todo=function(){ return $scope.filter_type===TODO_TYPE; };
    $scope.filtered_all=function(){ return $scope.filter_type===""; };

    $scope.is_shopping = function(list){ return list.type===SHOP_TYPE; };
    $scope.is_todo = function(list){ return list.type===TODO_TYPE; };

    $scope.only_shopping=function(){ $scope.filter_type=SHOP_TYPE; rebind_ui(); };
    $scope.only_todo=function(){ $scope.filter_type=TODO_TYPE; rebind_ui();};
    $scope.only_all=function(){ $scope.filter_type=""; rebind_ui();};

    $scope.create_todo=function(){ 
        open_modal_create_list(function(result){
            todoService.list.create(result.text, result.priv, function(data){
                data.items=[];
                data.type=TODO_TYPE;
                $scope.lists.push(data);
            });  
        },true);                                     
    };

    $scope.create_shoppinglist=function(){
        open_modal_create_list(function(result){
            shoppingService.list.create(result.text, result.priv, function(data){
                    data.items=[];
                    data.type=SHOP_TYPE;
                    $scope.lists.push(data);
            });
        },false); 
    };

    $scope.remove_item=function(list,item){
        get_service(list).item.destroy(item.id,list.id,function(){
            list.items = _(list.items).without(item);
            rebind_ui();
        });
    };

    $scope.remove_list=function(list){
        get_service(list).list.destroy(list.id,function(){
            $scope.lists = _($scope.lists).without(list);
        });
    };

    $scope.add_item=function(list){
        get_service(list).item.create(list.id,list.new_Text,function(data){
                list.items.push(data);
                list.new_Text='';
                rebind_ui();
        });
    };

    $scope.delete_checked=function(list){
        get_service(list).list.destroy_checked(list.id, function(data){
            list.items= _(list.items).reject(function(i){ return i.checked});
            rebind_ui();
       });
    };

    $scope.change_checked=function(list,item){
        get_service(list).item.update(item,list.id,null, function(){
            item.checked=!item.checked;
        });
    };

    $scope.get_color=function(index){
        var colors=['success','info','warning','danger'];
        return colors[index%4];
    };

    $scope.done_shopping=function(list){
        $modal.open({
                      animation: true,
                      templateUrl: 'done_shopping.html',
                      controller: 'doneShoppingCtrl'
                    }).result.then(function(res){
                        shoppingService.list.was_shopping(list.id, function(data){
                            list.items= _(list.items).reject(function(i){ return i.checked});
                        });
                        if(res==="done_bill")
                            Util.redirect_to.finances_done_shopping(list.name + ": " +
                                         shoppingService.list.get_summary_string(list,true,150));
                    });
    };

    load_data().then(insert_data); 
   
});

angular.module('flatman').controller('createListCtrl', function ($scope, $modalInstance, is_todo) {
    $scope.item = {text:"", priv:false};
    $scope.is_todo = is_todo;
   
    $scope.ok = function () {
        $modalInstance.close($scope.item);
    };

    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
});

angular.module('flatman').controller('doneShoppingCtrl', function ($scope, $modalInstance) {  
    $scope.done_shopping = function () {
        $modalInstance.close('done');
    };

    $scope.done_shopping_bill = function () {
        $modalInstance.close('done_bill');
    };

    $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
    };
});