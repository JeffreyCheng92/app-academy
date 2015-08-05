Pokedex.Views.PokemonDetail = Backbone.View.extend({
  template: JST["pokemon_detail"],

  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click li.toy-list-item": "selectToyFromList"
  },

  render: function() {
    var content = this.template({pokemon: this.model});
    var that = this;
    this.$el.html(content);

    this.model.toys().forEach( function(toy) {
      var content = JST["toy_list_item"] ({toy: toy});

      that.$el.find('ul.toys').append(content);
    });

    return this;
  },

  selectToyFromList: function (event) {
    var toyId = $(event.currentTarget).data("toy-id");
    var toy = this.model.toys().get(toyId);
    var view = new Pokedex.Views.ToyDetail({model: toy});
    $("#pokedex .toy-detail").html(view.render().$el);
  }
});
