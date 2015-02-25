//
//  DummyConnection.m
//  WDUploadProgressViewSample
//
//  Created by Guilherme Moura on 10/02/2013.
//  Copyright (c) 2013 Guilherme Moura. All rights reserved.
//

#import "ConnectionManager.h"

@implementation ConnectionManager

@synthesize connectionManagerDelegate;
@synthesize connectionStatus;

- (id) init {
    NSLog(@"Connection Mananger initialized");
    self = [super init];
    if (self!= nil) {
        // initializations
        
        NSURL *baseURL = [NSURL URLWithString:kIMPbaseURL];
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
        
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];

        NSOperationQueue *operationQueue = manager.operationQueue;
        [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [operationQueue setSuspended:NO];
                    NSLog(@"status: yes");
                    connectionStatus = YES;
                    [connectionManagerDelegate connectionStatusDidChangeToBOOL:connectionStatus];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                default:
                    NSLog(@"status: no");
                    connectionStatus = NO;
                    [connectionManagerDelegate connectionStatusDidChangeToBOOL:connectionStatus];
                    [operationQueue setSuspended:YES];
                    break;
            }
        }];
        [manager.reachabilityManager startMonitoring];
    }
    return self;
}


@end
