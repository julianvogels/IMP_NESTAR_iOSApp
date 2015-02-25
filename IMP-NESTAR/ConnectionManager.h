//
//  DummyConnection.h
//  WDUploadProgressViewSample
//
//  Created by Guilherme Moura on 10/02/2013.
//  Copyright (c) 2013 Guilherme Moura. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "UIDeviceHardware.h"
#import "constants.h"

@class ConnectionManager;
@protocol ConnectionManagerDelegate <NSObject>
@required
- (void)connectionStatusDidChangeToBOOL:(BOOL)connectionStatus;
@optional
@end

@interface ConnectionManager : NSObject <UIAlertViewDelegate> {
    __weak id <ConnectionManagerDelegate> connectionManagerDelegate;
}

@property (nonatomic, weak) id <ConnectionManagerDelegate> connectionManagerDelegate;

@property (nonatomic, weak) NSString* scannedID;
@property (nonatomic, readwrite) NSInteger mediaType;
@property (nonatomic, readwrite) BOOL connectionStatus;


@end
