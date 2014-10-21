
if (this.expTable === undefined) {
    this.expTable = []
}


if (this.funcTable === undefined) {
    this.funcTable = []
}

var Given = function (regexp, callback) {
    var index = this.expTable.push(regexp) - 1
    this.funcTable[index] = callback
}

var When = function (regexp, callback) {
    var index = this.expTable.push(regexp) - 1
    this.funcTable[index] = callback
}

var Then = function (regexp, callback) {
    var index = this.expTable.push(regexp) - 1
    this.funcTable[index] = callback
}

var And = function (regexp, callback) {
    var index = this.expTable.push(regexp) - 1
    this.funcTable[index] = callback
}



var perform = function (invocation) {

    var expr = invocation.expr;
    var args = invocation.args;

    var found = false
    for (var key in this.expTable) {
        if (this.expTable[key].test(expr)) {
	    var matchedItems = this.expTable[key].exec(expr)

	    var capturedGroups = [];
	    if (matchedItems.length > 1) {
		capturedGroups = matchedItems.slice(1, matchedItems.length)
	    }

	    var target = UIATarget.localTarget()
	    var window = target.frontMostApp().mainWindow()

	    var regexpArgs = [target, window]
	    if (capturedGroups.length > 0) {
		regexpArgs = regexpArgs.concat(capturedGroups)
	    }


	    //add any arguments passed to the function (i.e. data tables)
	    var allArgs = regexpArgs;
	    if(args) {
		allArgs.push(args);
	    }
	    
	    try {
		var passed = this.funcTable[key].apply(this, allArgs)
		found = true; 		
	    } catch (error) {
		return {status: "FAILED",
		        message: error}
	    }
            
	    return {status: "PASSED",
		    message: expr}
        }
    }

    if (!found) {
        return {status: "NOT_FOUND",
	        message: "Can't find step matching: " + expr}
    }
}


var httpRequest = function (method, url, timeout) {
  
  var target = UIATarget.localTarget();
  var host = target.host();
  var args = [];
  
  args.push("-X")
  if (method !== undefined) {
    args.push(method)
  } else {
    args.push("GET")
  }
  
  args.push(url)
  
  return host.performTaskWithPathArgumentsTimeout("/usr/bin/curl", args, timeout);
  
}

var ASSERT = function (result, message) {
    if (!result) {
	throw(message)
    }
}

var ASSERT_EQUAL = function (exp1, exp2, message) {
    if (exp1 !== exp2) {
	throw(message + " (" + exp1 + " != " + exp2 + ")")
    }
}

var ASSERT_EXISTS = function (element, timeout, message) {
    
    
}

var LOG = function (message) {
  UIALogger.logMessage("Debug> " + message);
}