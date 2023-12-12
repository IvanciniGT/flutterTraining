

// In JS we dont call Futures like that... but Promises

async function futureExample() {
    let myPromise = new Promise(function(myResolve, myReject) {
        setTimeout(()=> {
            console.log("parallel task");
            myResolve("HELLO")
        }, 5000);
    });
    return myPromise;
}

async function mainFunction() {
    
    console.log("First task");
    let futureValue = futureExample()
    console.log(futureValue)
    console.log("Second task");
    console.log(futureValue)
    let receivedValue = await futureValue
    console.log("Now I did receive the value "+receivedValue);
}

mainFunction()
