//
//  FirstViewController.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/1/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionManager.h"
#import "MediaItemViewController.h"
#import "constants.h"


@interface ScanViewController : UIViewController <ZBarReaderViewDelegate, ConnectionManagerDelegate> {
    ZBarCameraSimulator *cameraSim;
    ZBarReaderView *readerView;
    ConnectionManager *connectionManager;
}
@property (strong, nonatomic) IBOutlet ZBarReaderView *readerView;
@property (strong, nonatomic) IBOutlet UIButton *scanOnOffButton;
@property (strong, nonatomic) ConnectionManager *connectionManager;
@property (strong, nonatomic) NSString *scannedID;
@property (strong, nonatomic) UIImageView *scanSucceesedImageView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, assign) MediaType mediaType;
@property (nonatomic, strong) NSURL *mediaURL;

@property (strong, nonatomic) NSDictionary *experimentDetail;

- (IBAction)scanOnOffButtonTapped:(id)sender;

@end
