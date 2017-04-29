
<p align="center" >
<img src="" alt="" title="">
</p>

## KG_GCDTimer

GCDTimer is use replace NSTimer, so it can ellipsis invalited Timer, and use simple. 
Support merge previous task of the same timer, or abandoned previous task of the same timer.
Efficiency than NSTimer.

## Adding KG_GCDTimer to your project

### CocoaPods

[CocoaPods](http://cocoapods.org) is the recommended way to add KG_GCDTimer to your project.

1. Add a pod entry for KG_GCDTimer to your Podfile `pod 'KG_GCDTimer', '~> 0.0.1'`
2. Install the pod(s) by running `pod install`.
3. Include KG_GCDTimer wherever you need it with `#import "KG_GCDTimer.h"`.

### Source files

Alternatively you can directly add the `KG_GCDTimer.h` and `KG_GCDTimer.m` source files to your project.

1. Download the [latest code version](https://github.com/KunkkaQI/KG_GCDTimer/archive/master.zip) or add the repository as a git submodule to your git-tracked project.
2. Open your project in Xcode, then drag and drop `KG_GCDTimer.h` and `KG_GCDTimer.h.m` onto your project. Make sure to select Copy items when asked if you extracted the code archive outside of your project.
3. Include KG_GCDTimer wherever you need it with `#import "KG_GCDTimer.h"`.

## Usage

```objective-c
[[KG_GCDTimer sharedInstance] scheduledDispatchTimerWithName:@"timerName"
                                                timeInterval:3.0f
                                                       queue:nil                      /* dispatch_get_global_queue */
                                                    repeats:YES
                                                actionOption:KG_AbandonPreviousAction /* KG_MergePreviousAction */
                                                action:^{
                                                // do somthing 
}];
```

```objective-c
[[KG_GCDTimer sharedInstance] cancelTimerWithName:@"timerName"];
```

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).

## Change-log

A brief summary of each KG_GCDTimer release can be found in the [CHANGELOG](CHANGELOG.mdown). 


