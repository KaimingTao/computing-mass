// Variable definition

// myLetVariable is *not* visible out here

for (let myLetVariable = 0; myLetVariable < 5; myLetVariable++) {
    // myLetVariable is only visible in here
  }
  
// myLetVariable is *not* visible out here


// myVarVariable *is* visible out here

for (var myVarVariable = 0; myVarVariable < 5; myVarVariable++) { 
    // myVarVariable is visible to the whole function 
  } 
  
  // myVarVariable *is* visible out here 