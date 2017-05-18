//
//  FMServicesRouter.m
//  Fanmei
//
//  Created by 李传格 on 2017/5/18.
//  Copyright © 2017年 Fanmei. All rights reserved.
//

#import "FMServicesRouter.h"

NSString * const FMServiceNotFoundErrorDomain = @"FMServiceNotFoundErrorDomain";

@interface FMServicesRouterModel : NSObject

@property (nonatomic, strong) id<FMServicesRouterServiceProtocol> service;

+ (instancetype)modelWithService:(id<FMServicesRouterServiceProtocol>)service;

@end

@implementation FMServicesRouterModel

+ (instancetype)modelWithService:(id<FMServicesRouterServiceProtocol>)service {
    FMServicesRouterModel *model = [[FMServicesRouterModel alloc] init];
    model.service = service;
    return model;
}

@end

@interface FMServicesRouter ()

@property (nonatomic, strong) NSMutableDictionary *services; // Instance of registered services.

@end

@implementation FMServicesRouter

+ (instancetype)sharedInstance {
    static FMServicesRouter *__sharedInstance;
    static dispatch_once_t __once;
    dispatch_once(&__once, ^{
        __sharedInstance = [[FMServicesRouter alloc] init];
    });
    return __sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.services = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)registerServiceInstance:(id<FMServicesRouterServiceProtocol>)serviceInstance withName:(NSString *)serviceName {
    if (serviceInstance && serviceName.length > 0) {
        self.services[serviceName] = [FMServicesRouterModel modelWithService:serviceInstance];
    }
}

- (void)unregisterService:(NSString *)serviceName {
    if (serviceName.length > 0) {
        self.services[serviceName] = nil;
    }
}

- (void)callService:(NSString *)serviceName withParams:(NSDictionary *)params
          successed:(void(^)(NSDictionary *responseObj))successed failed:(void(^)(NSError *error))failed {
    if (serviceName.length == 0) {
        [self notifyServiceNotFoundFailed:failed];
        return;
    }
    
    FMServicesRouterModel *model = self.services[serviceName];
    if (model && model.service && [model.service respondsToSelector:@selector(serviceCalledWithParams:successed:failed:)]) {
        [model.service serviceCalledWithParams:params successed:^(NSDictionary *responseObj) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (successed) {
                    successed(responseObj);
                }
            });
        } failed:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failed) {
                    failed(error);
                }
            });
        }];
    } else {
        [self notifyServiceNotFoundFailed:failed];
    }
}

- (void)callApi:(NSString *)apiName
      ofService:(NSString *)serviceName
     withParams:(NSDictionary *)params
      successed:(void(^)(NSDictionary *responseObj))successed
         failed:(void(^)(NSError *error))failed {
    if (serviceName.length == 0) {
        [self notifyServiceNotFoundFailed:failed];
        return;
    }
    
    FMServicesRouterModel *model = self.services[serviceName];
    if (model && model.service && [model.service respondsToSelector:@selector(serviceCalledWithApiName:params:successed:failed:)]) {
        [model.service serviceCalledWithApiName:apiName params:params successed:^(NSDictionary *responseObj) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (successed) {
                    successed(responseObj);
                }
            });
        } failed:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failed) {
                    failed(error);
                }
            });
        }];
    } else {
        [self notifyServiceNotFoundFailed:failed];
    }
}

- (void)notifyServiceNotFoundFailed:(void(^)(NSError *error))failed {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (failed) {
            failed([NSError errorWithDomain:FMServiceNotFoundErrorDomain code:0 userInfo:@{}]);
        }
    });
}

@end
