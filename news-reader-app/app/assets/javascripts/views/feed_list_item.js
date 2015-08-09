NewsReader.Views.FeedListItem = Backbone.View.extend ({
  template: JST['feed_list_item'],

  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click button.delete-button": "deleteFeed"
  },

  render: function () {
    this.$el.empty();
    var content = this.template({entry: this.model});
    this.$el.html(content);
    return this;
  },

  deleteFeed: function (event) {
    this.model.destroy();
  }

});
