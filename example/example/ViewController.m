//
//  ViewController.m
//  example
//
//  Created by 李传格 on 2017/5/18.
//  Copyright © 2017年 fanmei. All rights reserved.
//

#import "ViewController.h"
#import "FMServicesRouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[FMServicesRouter sharedInstance] callService:@"custom.service" withParams:nil successed:^(NSDictionary *responseObj) {
        NSLog(@"Service response success : %@", responseObj);
    } failed:^(NSError *error) {
        NSLog(@"Service response failed.");
    }];
    
    [[FMServicesRouter sharedInstance] callApi:@"api" ofService:@"custom.service" withParams:nil successed:^(NSDictionary *responseObj) {
        NSLog(@"Service response success : %@", responseObj);
    } failed:^(NSError *error) {
        NSLog(@"Service response failed.");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
