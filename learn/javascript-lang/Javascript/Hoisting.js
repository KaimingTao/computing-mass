// ReferenceError: noSuchVariable is not defined
console.log(noSuchVariable);



// Outputs: undefined
console.log(declaredLater);

var declaredLater = "Now it's defined!";

// Outputs: "Now it's defined!"
console.log(declaredLater);