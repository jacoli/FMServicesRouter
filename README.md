# FMServicesRouter
A services router decoupling modules base on service name.

## Installation

With [CocoaPods](http://cocoapods.org/), add this line to your `Podfile`.

```
pod 'FMServicesRouter'
```

and run `pod install`, then you're all done!

Or copy `*.h *.m` files in `source` folder to your project.

## How to use

* Implement `FMServicesRouterServiceProtocol` in service.

```
/**
 * Farword client call to service.
 */
- (void)calledWithParams:(NSDictionary *)params
               successed:(void(^)(NSDictionary *responseObj))successed
                  failed:(void(^)(NSError *error))failed {
                  }
```

* Register

```
	[[FMServicesRouter sharedInstance] registerServiceInstance:serviceInstance withName:@"custom.service"];

```

* Call in client

```
	[FMServicesRouter sharedInstance]

```

## Requirements

* iOS 7.0+ 
* ARC