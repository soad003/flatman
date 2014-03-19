angular.module('flatman').service("shoppingService",function() {

    this.get = function() {return JSON.parse(localStorage.getItem('todolists')) || new Array(); };
    this.save = function(lists) { localStorage.setItem('todolists',JSON.stringify(lists)); }

});
