NewsReader.Views.FeedIndex = Backbone.View.extend ({
  template: JST['feed_index'],

  initialize: function (options) {
    this.listenTo(this.collection, "sync remove", this.render);
  },


  render: function () {
    this.$el.html(this.template());
    this.collection.each(function (entry) {
      var item = new NewsReader.Views.FeedListItem({model: entry});
      this.$(".feed-list").append(item.render().$el);
    }.bind(this));
    return this;
  },

});
