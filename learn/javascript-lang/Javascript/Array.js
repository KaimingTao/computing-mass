var a = new Array();
a[0] = 'dog';
a[1] = 'cat';
a[2] = 'hen';
a.length; // 3


var a = ['dog', 'cat', 'hen'];
a.length; // 3


// Caution!
var a = ['dog', 'cat', 'hen'];
a[100] = 'fox';
a.length; // 101
typeof a[90]; // undefined



// iterate array
for (var i = 0; i < a.length; i++) {
    // Do something with a[i]
}

for (const currentValue of a) {
    // Do something with currentValue
}

['dog', 'cat', 'hen'].forEach(function(currentValue, index, array) {
    // Do something with currentValue or array[index]
  });


// add new item
a.push(item);
