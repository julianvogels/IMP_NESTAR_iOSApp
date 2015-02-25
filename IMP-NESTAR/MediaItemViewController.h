//
//  MediaItemViewController.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/4/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit+AFNetworking.h>
#import "ConnectionManager.h"
#import <AFHTTPSessionManager.h>
#import "constants.h"
#import "VideoDisplayViewController.h"
#import "ImageDisplayViewController.h"


@interface MediaItemViewController : UIViewController <ConnectionManagerDelegate> {
    ConnectionManager *connectionManager;
}
@property (strong, nonatomic) IBOutlet UILabel *resultText;
@property (strong, nonatomic) NSString *mediaItemID;
@property (strong, nonatomic) IBOutlet UILabel *requestResponseLabel;
@property (strong, nonatomic) ConnectionManager *connectionManager;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;

@property (strong, nonatomic) NSURL *mediaURL;
@property (nonatomic, assign) MediaType mediaType;

@property (strong, nonatomic) IBOutlet UIView *container;

@property (strong, nonatomic) VideoDisplayViewController *videoDisplay;

@end
