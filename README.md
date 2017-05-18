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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (successed) {
                successed(@{@"result" : @"hello world!"});
            }
        });
    });
}
```

* Register

```
    [[FMServicesRouter sharedInstance] registerServiceInstance:[CustomService new] withName:@"custom.service"];

```

* Call in client

```
    if ([[FMServicesRouter sharedInstance] callService:@"custom.service" withParams:nil successed:^(NSDictionary *responseObj) {
        NSLog(@"Service response success : %@", responseObj);
    } failed:^(NSError *error) {
        NSLog(@"Service response failed.");
    }]) {
        NSLog(@"Call service success.");
    } else {
        NSLog(@"Call service failed.");
    }

```

## Requirements

* iOS 7.0+ 
* ARC

## License

* MIT