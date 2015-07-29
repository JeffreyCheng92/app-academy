Function.prototype.myBind = function(context) {
  var fn = this;
  var anon = function() {
    anon_context = context;
    anon_fn = fn;
    anon_fn.apply(anon_context);
  }
  return anon;
}
