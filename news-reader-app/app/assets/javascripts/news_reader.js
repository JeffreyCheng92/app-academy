window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    //alert('Hello from Backbone!');
    var $rootEl = $("#content")
    new NewsReader.Routers.ApiRouter({$rootEl: $rootEl});
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
