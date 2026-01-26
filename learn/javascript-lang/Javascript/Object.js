// Object

// Check null object before using it
console.log(typeof(o));
o = null;
var name = o && o.getName();

// Cache value if not exist
cachedName = null;
var name = cachedName || (cachedName = getName());


// empty object
var obj = new Object();
var obj = {};


var obj = {
    name: 'Carrot',
    for: 'Max', // 'for' is a reserved word, use '_for' instead.
    details: {
      color: 'orange',
      size: 12
    }
};
obj.details.color; // orange
obj['details']['size']; // 12


// object prototype and instance
function Person(name, age) {
    this.name = name;
    this.age = age;
}
  
// Define an object
var you = new Person('You', 24); 
// We are creating a new person named "You" aged 24.

// dot notation
obj.name = 'Simon';
var name = obj.name;

// bracket notation
obj['name'] = 'Simon';
var name = obj['name'];
// can use a variable to define a key
var user = prompt('what is your key?')
obj[user] = prompt('what is its value?')