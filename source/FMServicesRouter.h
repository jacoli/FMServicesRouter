//
//  FMServicesRouter.h
//  Fanmei
//
//  Created by 李传格 on 2017/5/18.
//  Copyright © 2017年 Fanmei. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString * const FMServiceNotFoundErrorDomain;

/**
 * A protocol service should implement.
 */
@protocol FMServicesRouterServiceProtocol <NSObject>

@optional

/**
 * Forwarding client service call to service.
 */
- (void)serviceCalledWithParams:(NSDictionary *)params
                      successed:(void(^)(NSDictionary *responseObj))successed
                         failed:(void(^)(NSError *error))failed;

/**
 * Forwarding client api call to service.
 */
- (void)serviceCalledWithApiName:(NSString *)apiName
                          params:(NSDictionary *)params
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
- (void)registerServiceInstance:(id<FMServicesRouterServiceProtocol>)serviceInstance withName:(NSString *)serviceName;

/**
 * Unregister service instance.
 */
- (void)unregisterService:(NSString *)serviceName;

/**
 * Call service, callback failed if service cann't found or protocol not implement, else successed. Callbacks is scheduled async in main queue.
 */
- (void)callService:(NSString *)serviceName
         withParams:(NSDictionary *)params
          successed:(void(^)(NSDictionary *responseObj))successed
             failed:(void(^)(NSError *error))failed;

/**
 * Call api of service, callback failed if service cann't found or protocol not implement, else successed. Callbacks is scheduled async in main queue.
 */
- (void)callApi:(NSString *)apiName
      ofService:(NSString *)serviceName
     withParams:(NSDictionary *)params
      successed:(void(^)(NSDictionary *responseObj))successed
         failed:(void(^)(NSError *error))failed;

@end
