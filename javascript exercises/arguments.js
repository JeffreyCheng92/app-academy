var sum = function() {
  var result = 0;
  for (var i = 0; i < arguments.length; i++) {
    result += arguments[i]
  }
  return result
}

// console.log(sum(1,2,3,4))

Function.prototype.myBind = function (context) {
  var fn = this;
  var args = [].slice.call(arguments, 1);
  return function () {
    var callargs = [].slice.call(arguments)
    return fn.call(context, args.concat(callargs))
  }
}

// function Cat(name) {
//   this.name = name;
// };
//
// Cat.prototype.says = function (sound) {
//   console.log(this.name + " says " + sound + "!");
// }
// markov = new Cat("Markov");
// breakfast = new Cat("Breakfast");
//
// markov.says("meow");
// // Markov says meow!
//
// markov.says.myBind(breakfast, "meow")();
// // Breakfast says meow!
//
// markov.says.myBind(breakfast)("meow");
// // Breakfast says meow!
//
// var notMarkovSays = markov.says.myBind(breakfast);
// notMarkovSays("meow");
// // Breakfast says meow!

function curriedSum(numArgs) {
  var numbers = [];
  function _curriedSum(num){
    numbers.push(num);

    if (numbers.length === numArgs) {
      var sum = 0;
      for (var i = 0; i < numbers.length; i++) {
        sum += numbers[i];
      };
      return sum;
    } else {
      return _curriedSum;
    };

  };
  return _curriedSum;
};

var sum = curriedSum(4)(5);
console.log(sum(20)(30)(1)); // => 56)
