//
//  internals.js
//  Vega
//
//  Created by Idriss on 12/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//
//  V:0.1.1

var Base64 = {
  
  // private property
  _keyStr : "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",
  
  // public method for encoding
  encode : function (input) {
    var output = "";
    var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
    var i = 0;
    
    input = Base64._utf8_encode(input);
    
    while (i < input.length) {
      
      chr1 = input.charCodeAt(i++);
      chr2 = input.charCodeAt(i++);
      chr3 = input.charCodeAt(i++);
      
      enc1 = chr1 >> 2;
      enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
      enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
      enc4 = chr3 & 63;
      
      if (isNaN(chr2)) {
        enc3 = enc4 = 64;
      } else if (isNaN(chr3)) {
        enc4 = 64;
      }
      
      output = output +
      this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) +
      this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);
      
    }
    
    return output;
  },
  
  // public method for decoding
  decode : function (input) {
    var output = "";
    var chr1, chr2, chr3;
    var enc1, enc2, enc3, enc4;
    var i = 0;
    
    input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
    
    while (i < input.length) {
      
      enc1 = this._keyStr.indexOf(input.charAt(i++));
      enc2 = this._keyStr.indexOf(input.charAt(i++));
      enc3 = this._keyStr.indexOf(input.charAt(i++));
      enc4 = this._keyStr.indexOf(input.charAt(i++));
      
      chr1 = (enc1 << 2) | (enc2 >> 4);
      chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
      chr3 = ((enc3 & 3) << 6) | enc4;
      
      output = output + String.fromCharCode(chr1);
      
      if (enc3 != 64) {
        output = output + String.fromCharCode(chr2);
      }
      if (enc4 != 64) {
        output = output + String.fromCharCode(chr3);
      }
      
    }
    
    output = Base64._utf8_decode(output);
    
    return output;
    
  },
  
  // private method for UTF-8 encoding
  _utf8_encode : function (string) {
    
    string = string.replace(/\r\n/g,"\n");
    var utftext = "";
    
    for (var n = 0; n < string.length; n++) {
      
      var c = string.charCodeAt(n);
      
      if (c < 128) {
        utftext += String.fromCharCode(c);
      }
      else if((c > 127) && (c < 2048)) {
        utftext += String.fromCharCode((c >> 6) | 192);
        utftext += String.fromCharCode((c & 63) | 128);
      }
      else {
        utftext += String.fromCharCode((c >> 12) | 224);
        utftext += String.fromCharCode(((c >> 6) & 63) | 128);
        utftext += String.fromCharCode((c & 63) | 128);
      }
      
    }
    
    return utftext;
  },
  
  // private method for UTF-8 decoding
  _utf8_decode : function (utftext) {
    var string = "";
    var i = 0;
    var c = c1 = c2 = 0;
    
    while ( i < utftext.length ) {
      
      c = utftext.charCodeAt(i);
      
      if (c < 128) {
        string += String.fromCharCode(c);
        i++;
      }
      else if((c > 191) && (c < 224)) {
        c2 = utftext.charCodeAt(i+1);
        string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
        i += 2;
      }
      else {
        c2 = utftext.charCodeAt(i+1);
        c3 = utftext.charCodeAt(i+2);
        string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
        i += 3;
      }
      
    }
    
    return string;
  }
  
}

var VGLogger = {
  
logStartFeature: function(featurename) {
  UIALogger.logMessage("Feature: " + featurename);
},
  
logStartScenario: function(scenarioName) {
  UIALogger.logStart(scenarioName);
},
  
logPass: function(scenarioName, message) {
  UIALogger.logPass(message);
},
  
logFail: function(scenarioName, message) {
  UIALogger.logFail(message);
},
  
logIssue: function(scenarioName, message) {
  UIALogger.logIssue(message);
},
  
logMessage: function(message) {
  UIALogger.logMessage(message);
},
  
logDebug: function(message) {
  UIALogger.logMessage("VGDEBUG: " + message);
}
  
}

var VGReport = {
currentFeature:undefined,
currentScenario:undefined,
reportData:{
features:[]
},
startTime:0,
tests:0,
passed:0,
failed:0,
issues:0,
overral: {
tests:0,
passed:0,
failed:0,
issues:0,
},
  
reportStartFeature: function (featurename) {
  VGReport.currentFeature = {
  title:featurename,
  scenarios:[]
  };
  startTime = timestamp()
},
  
reportEndFeature: function (featurename) {
  
  VGReport.overral.tests  += VGReport.tests
  VGReport.overral.passed += VGReport.passed
  VGReport.overral.issues += VGReport.issues
  VGReport.overral.failed += VGReport.failed
  
  VGReport.currentFeature.__summary__ = {"total":VGReport.tests,
    "passed": VGReport.passed,
    "failed": VGReport.failed,
    "issues": VGReport.issues,
    "time"  : startTime}
  
  VGReport.reportData.features.push(VGReport.currentFeature);
  
  VGReport.tests  = 0
  VGReport.passed = 0
  VGReport.issues = 0
  VGReport.failed = 0
  
  VGReport.reportData.__summary__ = {"total":VGReport.overral.tests,
    "passed": VGReport.overral.passed,
    "failed": VGReport.overral.failed,
    "issues": VGReport.overral.issues,
    "time"  : startTime}
  VGReport.currentFeature = undefined
  
},
  
  
reportStartScenario: function (scenarioName) {
  VGReport.tests += 1;
},
  
reportEndScenario: function (scenarioName) {
  VGReport.currentFeature.scenarios.push(VGReport.currentScenario);
  VGReport.currentScenario = undefined;
},
  
reportPass: function (scenarioName, message) {
  VGReport.currentScenario = {"title":scenarioName, "result": "PASS", "reason": message, "time": timestamp()};
  VGReport.passed += 1;
},
  
reportFail: function (scenarioName, message) {
  var screenshotName = scenarioName;
  var target  = UIATarget.localTarget();
  target.captureScreenWithName(screenshotName);
  VGReport.currentScenario = {"title":scenarioName, "result": "FAIL", "reason": message, "screenshot":screenshotName + ".png", "time": timestamp()};
  VGReport.failed += 1;
},
  
reportIssue: function (scenarioName, message) {
  VGReport.currentScenario = {"title":scenarioName, "result": "ISSUE", "reason": message, "time": timestamp()};
  VGReport.issues += 1;
},
  
report:function (location, reportname){
  VGLogger.logMessage("Tests run: " + VGReport.overral.tests + ", " + VGReport.overral.passed + " passed, " + VGReport.overral.failed + " failed, " + VGReport.overral.issues + " issues");
  var target = UIATarget.localTarget();
  
  var host = target.host();
  
  var data = JSON.stringify(VGReport.reportData);
  var b64Data = Base64.encode(data);
  
  var reporter = location + "/core/saveReport"
  var reportfile = location + "/" + reportname
  var result = host.performTaskWithPathArgumentsTimeout("/bin/bash", [reporter, reportfile, b64Data], 5);
  
}
  
}





var performScenario = function (scenarioName, steps) {
  
  VGReport.reportStartScenario(scenarioName);
  VGLogger.logStartScenario(scenarioName)
  
  for (var stepKey in steps) {
    
    var step = steps[stepKey]
    VGLogger.logMessage("Step: " + step.expr)
    var result = perform(step)
    if (result.status === "NOT_FOUND") {
      VGLogger.logIssue(scenarioName, result.message)
      VGReport.reportIssue(scenarioName, result.message);
      VGReport.reportEndScenario(scenarioName);
      return
    } else if (result.status === "FAILED") {
      VGLogger.logFail(scenarioName, result.message)
      VGReport.reportFail(scenarioName, result.message);
      VGReport.reportEndScenario(scenarioName);
      return
    }
    
  }
  
  VGLogger.logPass(scenarioName, scenarioName)
  VGReport.reportPass(scenarioName);
  VGReport.reportEndScenario(scenarioName);
}

var performBackground = function(steps) {
  
  var backgroundName = "Background"
  VGReport.reportStartScenario(backgroundName);
  VGLogger.logStartScenario(backgroundName)
  
  for (var stepKey in steps) {
    
    var step = steps[stepKey]
    VGLogger.logMessage("Background Step: " + step.expr)
    var result = perform(step)
    if (result.status === "NOT_FOUND") {
      VGLogger.logIssue(scenarioName, result.message)
      VGReport.reportIssue(scenarioName, result.message);
      VGReport.reportEndScenario(backgroundName);
      return
    } else if (result.status === "FAILED") {
      VGLogger.logFail(scenarioName, result.message)
      VGReport.reportFail(scenarioName, result.message);
      VGReport.reportEndScenario(backgroundName);
      return
    }
    
  }
  
  VGLogger.logPass(backgroundName, backgroundName)
  VGReport.reportPass(backgroundName);
  VGReport.reportEndScenario(backgroundName);
}

function timestamp () {
  return Math.round(new Date().getTime() / 1000)
}
