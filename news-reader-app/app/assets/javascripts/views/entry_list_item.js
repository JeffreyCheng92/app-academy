NewsReader.Views.EntryListItem = Backbone.View.extend({
  template: JST["entry_list_item"],

  render: function() {
    var description = JSON.parse(this.model.get("json")).description;
    this.$el.html(this.template({entry: this.model, description: description}));
    return this;
  }

});
