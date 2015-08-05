Pokedex.Routers.Router = Backbone.Router.extend({
  routes: {
    "": 'index',
    "pokemon/:id": 'show'
  },

  index: function () {
    var indexView = new Pokedex.Views.PokemonIndex({
      collection: new Pokedex.Collections.Pokemon()
    });

    indexView.refreshPokemon();
    $("#pokedex .pokemon-list").html(indexView.$el);
  },

  show: function(id) {
    var pokemon = Pokedex.Models.Pokemon.get(id);
    var showView = new Pokedex.Views.PokemonDetail();

    $("#pokedex .pokemon-detail").html(showView.$el);

  }
});
