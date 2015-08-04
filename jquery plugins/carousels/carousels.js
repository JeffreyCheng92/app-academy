$(function(){


  $.Carousel = function (el) {
    this.$el = $(el);

    this.activeIdx = 0;

    this.$images = $('.items > ');
    this.$currentItem = this.$images.eq(this.activeIdx)
                            .addClass("active");


    this.$slideEl = $(".slide-right, .slide-left");
    this.$slideEl.on("click", this.slideCallback.bind(this));


  };

  $.Carousel.prototype.slideCallback = function(event) {

      if ($(event.currentTarget).attr("class") === "slide-right") {
        this.slide("right");
      } else {
        this.slide('left');
      }

  };

  $.Carousel.DIRECTION = {"left": -1, "right": 1};
  $.Carousel.OPP_DIR = {"left": "right", "right": "left"};

  $.Carousel.prototype.slide = function(dir) {

      //0
      this.activeIdx += $.Carousel.DIRECTION[dir];
      if (this.activeIdx > 3) {
        this.activeIdx = 4 - this.activeIdx;
      } else if (this.activeIdx < 0) {
        this.activeIdx = 4 + this.activeIdx;
      }
      //1 put the next image in the dom but out of view
      this.$newCurrentItem = this.$images.eq(this.activeIdx)
                                         .addClass("active")
                                         .addClass($.Carousel.OPP_DIR[dir]);
      //2
      setTimeout(function(){
        //4
        this.$currentItem.addClass(dir);
        //5
        this.$newCurrentItem.removeClass($.Carousel.OPP_DIR[dir]);
      }.bind(this), 0);

      //3
      this.$currentItem.one("transitionend", function(){
        //6
        this.$currentItem.removeClass("active left right");
        //7
        this.$currentItem = this.$newCurrentItem;
      }.bind(this));

  };

  $.Carousel.prototype.slideOutCallback = function(event) {
    this.$currentItem.removeClass("active left right");
    this.$currentItem = this.$newCurrentItem;
  };

  $.fn.carousel = function () {
    return this.each(function () {
      new $.Carousel(this);
    });
  };

});
