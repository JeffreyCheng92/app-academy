Function.prototype.inherits = function(ParentClass) {
  function Surrogate() {};
  Surrogate.prototype = ParentClass.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this; //optional
}

Dog.inherits(Animal)

var inherits = function(ChildClass, ParentClass) {
  function Surrogate() {};
  Surrogate.prototype = ParentClass.prototype;
  ChildClass.prototype = new Surrogate();
  ChildClass.prototype.constructor = ChildClass; //optional
}

inherits(Dog, Animal)
