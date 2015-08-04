
$(function(){
  $.Tabs = function (el) {
    this.$el = $(el);
    this.$contentTabs = $(this.$el.attr("data-content-tabs"));
    this.$activeTab = $(this.$contentTabs).find(".active");
    this.$el.on("click", "a", this.clickTab.bind(this));
  };

  $.Tabs.prototype.clickTab = function(event) {
    this.$el.find("a").removeClass("active");
    $(event.currentTarget).addClass("active"); //link
      var id = $(event.currentTarget).attr("for");
    this.$activeTab.removeClass("active").addClass("transitioning");  //tab
    this.$activeTab.one("transitionend", function(e) {
      this.$activeTab.removeClass("transitioning");
      this.$activeTab = this.$contentTabs.find("#" + id).addClass("active");
    }.bind(this));

  };


  $.fn.tabs = function () {
    return this.each(function () {
      new $.Tabs(this);
    });
  };
});
