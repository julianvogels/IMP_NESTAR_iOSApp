//
//  FirstViewController.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/1/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "ScanViewController.h"

@interface ScanViewController ()

@end

@implementation ScanViewController

@synthesize connectionManager;
@synthesize readerView;
@synthesize scanOnOffButton;
@synthesize scannedID;
@synthesize activityIndicator;
@synthesize scanSucceesedImageView;
@synthesize experimentDetail;

- (void) viewDidAppear: (BOOL) animated
{
    // run the reader when the view is visible
    [readerView start];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[[self navigationItem] backBarButtonItem] setTitle:@"Back"];

    [scanOnOffButton setSelected:YES];
    
    // the delegate receives decode results
    readerView.readerDelegate = self;
    readerView.trackingColor = [UIColor greenColor];
    
    
    // you can use this to support the simulator
    if(TARGET_IPHONE_SIMULATOR) {
        cameraSim = [[ZBarCameraSimulator alloc]
                     initWithViewController: self];
        cameraSim.readerView = readerView;
    }
    
    
    ZBarImageScanner *scanner = readerView.scanner;
    // TODO: (optional) additional reader configuration here
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    connectionManager = [[ConnectionManager alloc] init];
}


- (void) dealloc
{
    [self cleanup];
}
- (void) viewDidUnload
{
    [self cleanup];
    [super viewDidUnload];
}
- (void) cleanup
{
    cameraSim = nil;
    readerView.readerDelegate = nil;
    readerView = nil;
}

- (void) viewWillDisappear: (BOOL) animated
{
    [readerView stop];
    if (scanSucceesedImageView) {
        [scanSucceesedImageView removeFromSuperview];
    }
}

- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    // do something useful with results
    for(ZBarSymbol *sym in syms) {
        scannedID = sym.data;
        NSLog(@"Scanned ID: %@" , scannedID);
        if (connectionManager.connectionStatus) {
            // TDB activity indicator
            if (!scanSucceesedImageView) {
            scanSucceesedImageView = [[UIImageView alloc] initWithFrame:self.readerView.bounds];
            [scanSucceesedImageView setImage:[UIImage imageNamed:@"scanSucceeded"]];
            [scanSucceesedImageView setContentMode:UIViewContentModeScaleAspectFit];
            }
            scanSucceesedImageView.alpha = 0.0;
            [self.view addSubview:scanSucceesedImageView];
            [UIView animateWithDuration:0.5
                                  delay:0.0
                                options: UIViewAnimationCurveEaseInOut
                             animations:^{scanSucceesedImageView.alpha = 1.0;}
                             completion:nil];
            
            activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            activityIndicator.color = [UIColor colorWithRed:0.04f green:0.7f blue:0.18f alpha:1.0f];
            activityIndicator.center = CGPointMake(self.readerView.center.x, self.readerView.center.y + 30.0f);
            activityIndicator.transform = CGAffineTransformMakeScale(1.5, 1.5);
            activityIndicator.hidesWhenStopped = YES;
            [activityIndicator startAnimating];
            [self.readerView addSubview:activityIndicator];
            
            [self mediaItemURLRequestWithID:sym.data];
        }
        break;
        
    }
}

- (void)mediaItemURLRequestWithID: (NSString *)barcodeID {
    
    // UIDeviceHardware Utility
    // TBD: Move later for performance
    UIDeviceHardware *hardware = [[UIDeviceHardware alloc] init];
    
    NSLog(@"Experiment ID to [be passed: %@", [NSNumber numberWithInteger:[[experimentDetail objectForKey:@"experiment_id"] integerValue]]);
    NSDictionary *parameters = @{@"scanned_id": [NSNumber numberWithInteger:[barcodeID integerValue]],
                                 @"device": [hardware platformString],
                                 @"experiment_id": [NSNumber numberWithInteger:[[experimentDetail objectForKey:@"experiment_id"] integerValue]]};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
 
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:kIMPrequestURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        NSLog(@"Dict: %@", responseObject[@"result"]);
        NSArray *jsonArray = (NSArray *) responseObject[@"result"];
        NSDictionary *jsonDict = (NSDictionary *) [jsonArray objectAtIndex:0];
        NSString *responseType = [jsonDict objectForKey:@"type"];
        NSLog(@"responseType: %@", responseType);
        if ([responseType isEqualToString:@"success"]) {
            // Response type is 'success' -> URL was found
            NSLog(@"%@",[jsonDict objectForKey:@"url"]);
            self.mediaURL = [NSURL URLWithString:[jsonDict objectForKey:@"url"]];
            NSString *mediaTypeStr = [jsonDict objectForKey:@"media"];
            NSLog(@"contentType: %@", mediaTypeStr);
            if ([mediaTypeStr isEqualToString:@"image"]) {
                self.mediaType = image;
            } else if ([mediaTypeStr isEqualToString:@"audio"]) {
                self.mediaType = audio;
            } else if ([mediaTypeStr isEqualToString:@"video"]) {
                self.mediaType = video;
            }
            
            [activityIndicator stopAnimating];
            
            [self performSegueWithIdentifier: @"scanSucceededSegue" sender: self];

            
        } else if ([responseType isEqualToString:@"notFound"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Media not found"
                                                            message:@"The scanned barcode ID doesn't correspond to a media item in our database."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            if (scanSucceesedImageView) {
                [scanSucceesedImageView removeFromSuperview];
            }
            [activityIndicator stopAnimating];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"An unknown error occured"
                                                            message:@"Please contact the developers. "
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            [alert show];
            if (scanSucceesedImageView) {
                [scanSucceesedImageView removeFromSuperview];
            }
            [activityIndicator stopAnimating];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([[segue identifier] isEqualToString:@"scanSucceededSegue"]) {

        MediaItemViewController *destViewController = (MediaItemViewController* ) segue.destinationViewController;
        
        destViewController.mediaType = self.mediaType;
        destViewController.mediaURL = self.mediaURL;
        
        destViewController.mediaItemID = scannedID;
        destViewController.connectionManager = connectionManager;
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    // auto-rotation is supported
    return YES;
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration
{
    // compensate for view rotation so camera preview is not rotated
    [readerView willRotateToInterfaceOrientation: orient
                                        duration: duration];
}


- (void) connectionStatusDidChangeToBOOL:(BOOL)connectionStatus {
    NSLog(@"TBD: Alert the user. Connection status changed to value %d", connectionStatus);
}

- (IBAction)scanOnOffButtonTapped:(id)sender {
//    NSLog(@"on off %d", scanOnOffButton.selected);
    if (scanOnOffButton.selected) {
        [readerView stop];
        [scanOnOffButton setSelected:NO];
    } else {
        [readerView start];
        [scanOnOffButton setSelected:YES];
    }

}
@end
