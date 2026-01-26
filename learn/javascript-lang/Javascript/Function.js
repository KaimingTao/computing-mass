function add(x, y) {
    var total = x + y;
    return total;
}


// parameter
add(); // NaN
// You can't perform addition on undefined

add(2, 3, 4); // 5
// added the first two; 4 was ignored


// argument object
function add() {
    var sum = 0;
    for (var i = 0, j = arguments.length; i < j; i++) {
      sum += arguments[i];
    }
    return sum;
  }
  
add(2, 3, 4, 5); // 14

function avg() {
    var sum = 0;
    for (var i = 0, j = arguments.length; i < j; i++) {
      sum += arguments[i];
    }
    return sum / arguments.length;
  }
  
avg(2, 3, 4, 5); // 3.5



// rest parameter

function avg(...args) {
    var sum = 0;
    for (let value of args) {
      sum += value;
    }
    return sum / args.length;
  }
  
avg(2, 3, 4, 5); // 3.5

// pass array rather than comma separated argument
function avgArray(arr) {
    var sum = 0;
    for (var i = 0, j = arr.length; i < j; i++) {
      sum += arr[i];
    }
    return sum / arr.length;
  }
  
avgArray([2, 3, 4, 5]); // 3.5

// reusing previous avg() and pass array rather than comma separated argument
avg.apply(null, [2, 3, 4, 5]); // 3.5


// annonymous function and block scope
var a = 1;
var b = 2;

(function() {
  var b = 3;
  a += b;
})();

a; // 4
b; // 2


// recursion in DOM
function countChars(elm) {
    if (elm.nodeType == 3) { // TEXT_NODE
      return elm.nodeValue.length;
    }
    var count = 0;
    for (var i = 0, child; child = elm.childNodes[i]; i++) {
      count += countChars(child);
    }
    return count;
  }


// counter is only visible in its scope
var charsInBody = (function counter(elm) {
    if (elm.nodeType == 3) { // TEXT_NODE
      return elm.nodeValue.length;
    }
    var count = 0;
    for (var i = 0, child; child = elm.childNodes[i]; i++) {
      count += counter(child);
    }
    return count;
  })(document.body);


// nested/inner function

function parentFunc() {
  var a = 1;

  function nestedFunc() {
    var b = 4; // parentFunc can't use this
    return a + b; 
  }
  return nestedFunc(); // 5
}