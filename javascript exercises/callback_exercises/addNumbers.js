var readline = require('readline');

reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback) {
    if (numsLeft > 0) {
      reader.question("What number?", function(number1) {
        var num1 = parseInt(number1);
        sum += num1;
        console.log(sum);
        addNumbers(sum, numsLeft - 1, completionCallback);
      })
    } else if (numsLeft === 0) {
      completionCallback(sum);
      reader.close();
    }
}

addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
});
