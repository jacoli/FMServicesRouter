//
//  FMServicesRouter.h
//  Fanmei
//
//  Created by 李传格 on 2017/5/18.
//  Copyright © 2017年 Fanmei. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * A protocol service should implement.
 */
@protocol FMServicesRouterServiceProtocol <NSObject>

/**
 * Farword client call to service.
 */
- (void)calledWithParams:(NSDictionary *)params
               successed:(void(^)(NSDictionary *responseObj))successed
                  failed:(void(^)(NSError *error))failed;

@end

/**
 * A services router decoupling modules base on service name.
 */
@interface FMServicesRouter : NSObject

/**
 * Default instance.
 */
+ (instancetype)sharedInstance;

/**
 * Register service instance.
 */
- (void)registerServiceInstance:(__weak id<FMServicesRouterServiceProtocol>)serviceInstance withName:(NSString *)serviceName;

/**
 * Call service, return NO if service cann't found, else YES.
 */
- (BOOL)callService:(NSString *)serviceName
         withParams:(NSDictionary *)params
          successed:(void(^)(NSDictionary *responseObj))successed
             failed:(void(^)(NSError *error))failed;

@end
