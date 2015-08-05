Pokedex.Views.PokemonForm = Backbone.View.extend({
  template: JST['pokemon_form'],

  events: {
    "submit form": 'savePokemon'
  },

  render: function() {
    var content = JST["pokemon_form"] ({pokemon: this.model});
    this.$el.html(content);
    return this;
  },

  savePokemon: function(event) {
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON();
    this.model.save(formData.pokemon, {
      success: function(pokemon) {
        this.collection.add(pokemon);
        Backbone.history.navigate('pokemon/' + pokemon.id , {trigger: true});
        this.model = new Pokedex.Models.Pokemon();
        this.render();
      }.bind(this)
    });
  }

});
