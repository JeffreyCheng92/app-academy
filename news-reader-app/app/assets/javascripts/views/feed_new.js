NewsReader.Views.FeedNew = Backbone.View.extend({
  template: JST['feed_new'],

  events: {
    "submit form": "newFeed"
  },

  render: function() {
    this.$el.html(this.template());
    return this;
  },

  newFeed: function(e) {
    e.preventDefault();
    var feedData = $(e.currentTarget).serializeJSON();
    this.model.save(feedData.feed, {
      success: function (model) {
        this.collection.add(model);
        Backbone.history.navigate('feeds/' + model.id, {trigger: true});
      }.bind(this)});
  },

});
