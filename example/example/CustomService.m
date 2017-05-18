//
//  CustomService.m
//  example
//
//  Created by 李传格 on 2017/5/18.
//  Copyright © 2017年 fanmei. All rights reserved.
//

#import "CustomService.h"

@implementation CustomService

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

@end
