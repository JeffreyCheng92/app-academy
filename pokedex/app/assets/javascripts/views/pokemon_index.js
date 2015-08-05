Pokedex.Views.PokemonIndex = Backbone.View.extend({

  initialize: function () {
    // this.collection = new Pokedex.Collections.Pokemon();
    this.refreshPokemon();
    this.listenTo(this.collection, 'sync', this.render); //bind this maybe'
    this.listenTo(this.collection, 'add', this.addPokemonToList);
  },

  events: {
    'click li.poke-list-item': 'selectPokemonFromList'
  },

  render: function () {
    this.$el.html("");
    this.collection.each(this.addPokemonToList.bind(this));
  },

  addPokemonToList: function (pokemon) {
    var content = JST["pokemon_list_item"] ({pokemon: pokemon});

    this.$el.append(content);
  },

  selectPokemonFromList: function (event) {
    var id = $(event.currentTarget).data('id');
    Backbone.history.navigate('/pokemon/' + id, { trigger: true });
  },


  refreshPokemon: function (callback) {
    this.collection.fetch({
      success: function() {
        callback && callback();
      }
    });
  }
});
