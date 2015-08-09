NewsReader.Routers.ApiRouter = Backbone.Router.extend({
  routes: {
    '': "feedIndex",
    'feeds/new': "feedNew",
    'feeds/:id': "feedShow",
  },

  initialize: function (options) {
    this.feedCollection = new NewsReader.Collections.Feeds();
    this.$rootEl = options.$rootEl;
  },

  feedIndex: function () {
    this.feedCollection.fetch();
    var view = new NewsReader.Views.FeedIndex({collection: this.feedCollection});
    this.swapView(view);
  },

  feedShow: function (id) {
    // this.feedCollection.fetch()
    var feed = this.feedCollection.getOrFetch(id);
    var view = new NewsReader.Views.FeedShow({collection: this.feedCollection, model: feed});
    this.swapView(view);
  },

  feedNew: function () {
    var model = new NewsReader.Models.Feed();
    var view = new NewsReader.Views.FeedNew({collection: this.feedCollection, model: model});
    this.swapView(view);
  },

  swapView: function (newView) {
    if (this._currentView) {
      this._currentView.remove();
    }
    this._currentView = newView;
    this.$rootEl.html(this._currentView.render().$el);
  },


});
