Pokedex.Routers.Router = Backbone.Router.extend({
  routes: {
    "": 'index',
    "pokemon/:id": 'show',
    "pokemon/:pokeId/toys/:toyId": 'toyDetail'
  },

  index: function (callback) {
    this._indexView = new Pokedex.Views.PokemonIndex({
      collection: new Pokedex.Collections.Pokemon()
    });

    this._indexView.refreshPokemon(callback);

    $("#pokedex .pokemon-list").html(this._indexView.$el);
    this.pokemonForm();
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
    $('#pokedex .toy-detail').empty();

  },

  toyDetail: function(pokeId, toyId) {
    if (this._showView === undefined) {
      this.show( pokeId, this.toyDetail.bind(this, pokeId, toyId) );
      return;
    }

    var toy = this._showView.model.toys().get(toyId);
    var toyView = new Pokedex.Views.ToyDetail({model: toy});

    $("#pokedex .toy-detail").html(toyView.render().$el);
  },

  pokemonForm: function() {
    var view = new Pokedex.Views.PokemonForm({
      model: new Pokedex.Models.Pokemon(),
      collection: this._indexView.collection
    });

    $('#pokedex .pokemon-form').html(view.render().$el);
  }
});
