$(function(){

  $.Thumbnail = function (el) {
    this.$el = $(el);
    this.$activeImg = $.Thumbnail.activate($('.gutter-images img').eq(0));
    this.$images = $('.gutter-images img');
    this.gutterIdx = 0;

    this.$images.on("click", function(e) {
      this.$activeImg = $.Thumbnail.activate($(e.currentTarget));
    }.bind(this));

    this.$images.on("mouseenter", function(e) {
      $.Thumbnail.activate($(e.currentTarget));
    }.bind(this));

    this.$images.on("mouseleave", function(e) {
      $.Thumbnail.activate(this.$activeImg);
    }.bind(this));


   };

  $.Thumbnail.prototype.fillGutterImages = function() {

  };

  $.Thumbnail.activate = function($img) {
    var $newImg = $('<img></img>');
    $newImg.attr("src", $img.attr('src'));
    if ($(".active").children().length === 0) {
      $(".active").append($newImg);
    } else {
      $(".active").children().replaceWith($newImg);
    }

    return $newImg;
  };

  $.fn.thumbnail = function () {
    return this.each(function () {
      new $.Thumbnail(this);
    });
  };
});
