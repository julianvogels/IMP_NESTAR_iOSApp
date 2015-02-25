//
//  ExperimentVisualisationViewController.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/20/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "ExperimentVisualisationViewController.h"


@interface ExperimentVisualisationViewController ()

@end

@implementation ExperimentVisualisationViewController

@synthesize visualisationWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[[self navigationItem] backBarButtonItem] setTitle:@"Back"];

    NSURL *url = [NSURL URLWithString:kIMPvisualisationURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [visualisationWebView loadRequest:request progress:^(NSUInteger bytesWritten,  NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
        // TBD: activity indicator
    } success:^NSString *(NSHTTPURLResponse *response, NSString *HTML) {
        // on success
        return HTML;
    } failure:^(NSError *error) {
        // on error
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
