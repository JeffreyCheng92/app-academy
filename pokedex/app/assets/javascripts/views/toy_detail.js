Pokedex.Views.ToyDetail = Backbone.View.extend({
  template: JST["toy_detail"],

  render: function(pokemon) {
    var content = this.template({toy: this.model, pokes: []});
    var that = this;
    this.$el.html(content);
    return this;
  }

});
