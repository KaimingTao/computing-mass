// Number

console.log(0.1 + 0.2 == 0.30000000000000004);

console.log(Math.sin(3.5));

r = 2;
var circumference = 2 * Math.PI * r;
console.log(circumference);

console.log(parseInt('123', 10));
console.log(parseInt('010', 10));

// convert binary
parseInt('11', 2);

// convert string to integer
a = + '42';   // 42
console.log(a);
+ '010';  // 10
+ '0x10'; // 16

a = parseInt('hello', 10); // NaN
console.log(a);
NaN + 5; // NaN
isNaN(NaN); // true

a = 1 / 0; //  Infinity
console.log(a);
-1 / 0; // -Infinity

isFinite(1 / 0); // false
isFinite(-Infinity); // false
isFinite(NaN); // false

a = parseFloat('10.2abc')
console.log(a)
a = + '10.2abc' // NaN
console.log(a)