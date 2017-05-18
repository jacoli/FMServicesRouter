//
//  FMServicesRouter.m
//  Fanmei
//
//  Created by 李传格 on 2017/5/18.
//  Copyright © 2017年 Fanmei. All rights reserved.
//

#import "FMServicesRouter.h"

@interface FMServicesRouterModel : NSObject

@property (nonatomic, weak) id<FMServicesRouterServiceProtocol> service;

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

- (void)registerServiceInstance:(__weak id<FMServicesRouterServiceProtocol>)serviceInstance withName:(NSString *)serviceName {
    if (serviceInstance && serviceName.length > 0) {
        self.services[serviceName] = [FMServicesRouterModel modelWithService:serviceInstance];
    }
}

- (BOOL)callService:(NSString *)serviceName withParams:(NSDictionary *)params
          successed:(void(^)(NSDictionary *responseObj))successed failed:(void(^)(NSError *error))failed {
    if (serviceName) {
        FMServicesRouterModel *model = self.services[serviceName];
        if (model && model.service) {
            [model.service calledWithParams:params successed:successed failed:failed];
            return YES;
        }
    }
    
    return NO;
}

@end
