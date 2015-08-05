Pokedex.Views.PokemonIndex = Backbone.View.extend({
 template: JST['pokemon_list_item'],

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
    var that = this;
    this.$el.html("");
    this.collection.each(function(poke) {
      that.addPokemonToList(poke);
    });
  },

  addPokemonToList: function (pokemon) {
    var content = JST["pokemon_list_item"] ({pokemon: pokemon});

    this.$el.append(content);
  },

  selectPokemonFromList: function (event) {
    var id = $(event.currentTarget).data('id');
    var poke = this.collection.get(id);
    var view = new Pokedex.Views.PokemonDetail({model: poke});
    poke.fetch(); // get the toys as well
    $("#pokedex .pokemon-detail").html(view.$el);
  },


  refreshPokemon: function () {
    this.collection.fetch();
  }
});
