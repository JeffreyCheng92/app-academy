NewsReader.Views.FeedShow = Backbone.View.extend ({
  template: JST['feed_show'],

  initialize: function(options) {
    this.listenTo(this.model, "sync", this.render);
    this.render();
    window.model = this.model;
  },

  events: {
    "click button.refresh": "refreshFeed"
  },

  render: function() {
    this.$el.html(this.template());
    this.model.entries().each( function(entry) {
      var view = new NewsReader.Views.EntryListItem({model: entry});
      this.$('.entry-list').append(view.render().$el);
    }.bind(this));
    return this;
  },

  refreshFeed: function(e) {
    this.model = this.collection.getOrFetch(this.model.id);
    this.render();
  },

});
