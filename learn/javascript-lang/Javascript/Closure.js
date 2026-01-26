function makeAdder(a) {
    return function(b) {
      return a + b;
    };
  }
var add5 = makeAdder(5);
var add20 = makeAdder(20);
add5(6); // [function]
add20(7); // [function]
add5(6); // returns 11
add20(7); // returns 27