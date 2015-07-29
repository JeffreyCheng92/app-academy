function Clock () {

}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  var time = this.date;

  console.log(time.getHours() + ":" + time.getMinutes() + ":" + time.getSeconds());
};

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
  this.date = new Date();
  this.printTime();
  setInterval(this._tick.bind(this), Clock.TICK);
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  // 2. Call printTime.
  var time = this.date;
  var seconds = time.getSeconds();
  time.setSeconds(seconds + 5);
  this.printTime();
};

var clock = new Clock();
clock.run();
