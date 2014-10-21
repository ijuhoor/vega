#Vega

Vega is an cucumber style BDD testing tool relying on UIAutomation over Instruments. It supports only iOS. 

## Quick Start

In your Project Folder, create a folder called ```Automation```. 

``` sh
	$pwd
	/Users/idrissj/src/myProject
	$mkdir Automation
	$cd Automation
	
```


Your Project Folder will look like this:

```
	MyProject
	 |- MyProject
	 |- MyProject.xcodeproj
	 |- Automation
	       |

``` 

Run ```vega -init``` to setup the folder:

``` sh
	$vega -init
	$ls
	Feature1.feature	   core			steps
```

It created 3 items: 

* ```core``` is where all the utilities vega will use to run the steps code
* ```steps``` contains all the steps for your automation
* ```Feature1.feature``` is an example feature with an associated step in the step folder

To run the example:

``` sh
	vega -features Feature1.feature -deviceid <your device id> -bundleid <your bundle id>
``` 

If you don't know the simulator device ids run:

``` sh
	$instruments -s
```
	
and your bundle id will be something like: 

``` sh
	com.mycompany.appid
```

### Note:

Vega will **not** install the app on the device. For this you can use [iDeviceInstaller](http://www.libimobiledevice.org)

**tldr**: ```brew install ideviceinstaller```


### More info:

```vega -help```



### More More info

email me at:
ijuhoor .at. gmail .dot. com


