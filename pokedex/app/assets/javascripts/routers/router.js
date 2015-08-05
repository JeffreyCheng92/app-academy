Pokedex.Routers.Router = Backbone.Router.extend({
  routes: {
    "": 'index',
    "pokemon/:id": 'show'
  },

  index: function (callback) {
    this._indexView = new Pokedex.Views.PokemonIndex({
      collection: new Pokedex.Collections.Pokemon()
    });

    this._indexView.refreshPokemon(callback);
    $("#pokedex .pokemon-list").html(this._indexView.$el);
  },

  show: function(id, callback) {
    if (this._indexView === undefined ) {
      this.index(this.show.bind(this, id, callback));
      return;
    }

    var pokemon = this._indexView.collection.get(id);
    pokemon.fetch({
      success: function () { callback && callback(); }
    });

    this._showView = new Pokedex.Views.PokemonDetail( {model: pokemon} );

    $("#pokedex .pokemon-detail").html(this._showView.$el);

  }
});
