angular.module('flatman').controller("pinboardCtrl",function($scope,shoppingService,Util){

    $scope.create_todo=function(result){                                           
        $scope.lists.push({name: result, items: [], todo:true});
    };

    $scope.create_shoppinglist=function(result){
        $scope.lists.push({name: result, items: [], todo:false});
    };

    $scope.create_note=function(result){                                     
        $scope.notes.push({name: result, text: "i'm a banana"});
    };

    $scope.only_shopping=function(){
        $scope.lists = _($scope.data).reject(function(i){ return i.todo})
    };

    $scope.only_todo=function(){
        $scope.lists = _($scope.data).reject(function(i){ return !i.todo})
    };

    $scope.only_all=function(){
        $scope.lists=angular.copy($scope.data);
    };

    $scope.remove_item=function(list,item){
        list.items = _(list.items).without(item);
    };

    $scope.remove_list=function(list){
        $scope.lists = _($scope.lists).without(list);
    };

    $scope.add_item=function(list){
        list.items.push({checked:false, text: list.new_Text });
        list.new_Text='';
    };


    $scope.change_checked=function(list,item){
        $scope.lists=$scope.data;
    };

    $scope.get_color=function(index){
        var colors=['success','info','warning','danger'];
        return colors[index%4];
    };

    $scope.done_shopping=function(list){
       Util.redirect_to.finances_done_shopping(list.name);
    };

    $scope.delete_checked=function(list){
        list.items= _(list.items).reject(function(i){ return i.checked});
    };

    $scope.data = [
            {name: "Merkur", items: [
                                        {checked: false, text:"Brot"},
                                        {checked: false, text:"Milch"},
                                        {checked: false, text:"Butter"},
                                        {checked: false, text:"Hefe"},
                                        {checked: false, text:"Bier"}

                                    ], todo:false},
            {name: "Bauhaus", items: [
                                        {checked: false, text:"Hammer"},
                                        {checked: false, text:"Sichel"},
                                        {checked: false, text:"Rotes Tuch"}

                                    ], todo:false},
            {name: "Todos vor Auszug", items: [
                                                {checked: false, text:"Wand streichen"},
                                                {checked: false, text:"Löcher ausbessern"},
                                                {checked: false, text:"Putzen"},
                                                {checked: false, text:"Nachmieter finden"},
                                                {checked: false, text:"Kaution!!!"}

                                               ], todo:true},
            {name: "Important", items: [
                                                {checked: true, text:"be nice"},
                                                {checked: false, text:"clean"},
                                                {checked: false, text:"talk to your mates"}

                                               ], todo:true}

        ];

    $scope.lists=angular.copy($scope.data);
    

    $scope.notes = [
            {name: "Nicht vergessen", text:"Termin bei Makler"}
        ];

    

});


