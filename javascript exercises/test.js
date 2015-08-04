Array.prototype.uniq = function (){
  results = [];
  for(var i=0; i <this.length; i++ ) {
    found_match = false;
    for (var j=0; j<results.length; j++) {
      if (results[j]===this[i]){
        found_match = true;
      }
    }
    if (!(found_match)){
      results.push(this[i]);
    }
  }
  return results;
}

Array.prototype.twoSum = function () {
 results = []


  for(var i = 0; i < this.length - 1; i++) {
    for (var j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        results.push([i, j]);
      }
    }
  }
  return results;
}

Array.prototype.transpose = function () {
  results = [0]
  for (var i=0; i < this.length - 1; i++) {
    results.concat([0]);
  }

  for (var i=0; i < this.length; i++) {
    results[i] = [];
  }

  for (var i = 0; i < this.length; i++) {
    for (var j = 0; j < this.length; j++) {
      results[j][i] = this[i][j];
    }
  }
  return results;
}

var multiply = function (num) {
  console.log(num * 2)
}

Array.prototype.myEach = function (eachFx) {

  for (var i = 0; i < this.length; i++) {
    eachFx(this[i]);
  }

  return this
}

var thrice = function (num, _ ) {
  return num * 3
}

var add = function (num, accum) {
  return num + accum
}

Array.prototype.myMap = function (mapFx) {
  result = []

  var map_helper = function (el) {
    result.push(mapFx(el));
  }
  this.myEach(map_helper);
  return result;
}

Array.prototype.myInject = function (injectFx) {
  accum = this[0]
  rest = this.slice(1)

  var inject_helper = function (el) {
    accum = injectFx(el, accum);
  }

  rest.myEach(inject_helper);
  return accum;
}

Array.prototype.bubbleSort = function () {
  var swapped = true;
  while (swapped){
    swapped = false;
    for (var i = 0; i < this.length - 1; i++) {
      if (this[i] > this[i+1]) {
        swap = this[i];
        this[i] = this[i+1];
        this[i+1]=swap;
        swapped = true;
      }
    }
  }
  return this
}

b = [2,3,6,1,1,9];

String.prototype.substrings = function () {
  sub = []

  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j < this.length + 1; j++) {
      sub.push(this.substring(i, j));
    }
  }
  return sub.uniq();
}

function ranger (start, end) {
  if (end < start) {
    return [];
  }
  else if (end === start) {
    return [end];
  }
  else {
    return [start].concat(ranger(start+1, end));
  }
}

function sumr(array) {
  if (array.length === 1){
    return array[0]
  }
  else {
    return array[0] + sumr(array.slice(1));
  }
}

function exp1(base, e){
  if (e===0){
    return 1;
  }
  else {
    return (base * exp1(base, e - 1));
  }
}

function exp2(b, n){
  if (n===0){
    return 1;
  }
  else if (n ===1){
    return b;
  }
  else if (n % 2 === 0){
    var x = exp2(b, n/2);
    return x * x;
  }
  else {
    var x = exp2 (b, (n-1) /2 );
    return (b * (x * x));
  }
}

function fib(num) {
  if (num === 0) {
    return [];
  }
  else if (num === 1) {
    return [0];
  }
  else if (num === 2) {
    return [0, 1];
  }
  else {
    var last_num = fib(num - 1)
    return last_num.concat(last_num[last_num.length - 1] + last_num[last_num.length - 2])
  }
}

var a = [1,2,3,4,5,6,7,8,9,10]

function bsearch(array, num) {

  if (array.length ===0){
    return null;
  }

  var middle = Math.floor(array.length / 2);
  var pivot = array[middle];

  if (pivot === num) {
    return middle;
  }
  else if (pivot > num) {
    return bsearch(array.slice(0, middle), num);
  }
  else {
    var sub_answer = bsearch(array.slice(middle + 1, array.length), num);
    return ((sub_answer === null) ? null : (sub_answer + middle + 1));
  }
}

function make_change(total, coins) {
  if ((coins.length === 0) ||( total === 0)){
    return [];
  }
  num_largest = Math.floor(total / coins[0]);
  remainder = total - coins[0]*num_largest;
  other_coins = coins.slice(1);
  new_coins = [];

  for (var i = 0; i < num_largest; i++) {
    new_coins.push(coins[0]);
  }
  result = make_change(remainder, other_coins).concat(new_coins);
  return result;
}

// var array_coins = [10, 7, 1];
// function makeChange(total, coins) {
//
//   if (coins.length === 0 || total === 0) {
//     return [];
//   }
//
//   if (total > coins[0] ) {
//     var remainder = total - coins[0];
//     return makeChange(remainder, coins)
//   }


function mergeSort(array) {
  if (array.length <= 1) {
    return array;
  }
  var middle = array.length / 2;
  var left = array.slice(0, middle);
  var right = array.slice(middle, array.length);
  var left_sorted = mergeSort(left);
  var right_sorted = mergeSort(right);
  return merge(left_sorted, right_sorted);
}

function merge(arr1, arr2) {
  var results = [];
  while ((arr1.length !== 0) && (arr2.length !== 0)) {
    if (arr1[0] < arr2[0]){
      results.push(arr1.shift());
    }
    else {
      results.push(arr2.shift());
    }
  }
  results = results.concat(arr1);
  results = results.concat(arr2);
  return results;
}

function subsets(array) {
  if (array.length === 0) {
    return [[]];
  }
  var number = array[0];
  var subs = subsets(array.slice(1));

  for (var i = 0; i < array.length; i++) {
    new_arr = subs[i].concat([number]);
    subs.push(new_arr);
  }
  return subs;
}
