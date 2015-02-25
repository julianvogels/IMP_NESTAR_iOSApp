//
//  ExperimentInstructionViewController.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/20/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "ExperimentInstructionViewController.h"
#import "RatingViewController.h"
#import <UIWebView+AFNetworking.h>

@interface ExperimentInstructionViewController ()

@end

@implementation ExperimentInstructionViewController

@synthesize instructionsWebView;

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
	// Load HTML instructions into webview
    // TBD insert URL from dictionary
    NSURL *url = [NSURL URLWithString:[self.experimentDetail objectForKey:@"instruction_url"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [instructionsWebView loadRequest:request progress:^(NSUInteger bytesWritten,  NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
        // TBD: activity indicator
    } success:^NSString *(NSHTTPURLResponse *response, NSString *HTML) {
        // on success
        return HTML;
    } failure:^(NSError *error) {
        // on error
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
    }];
    
    [[[self navigationItem] backBarButtonItem] setTitle:@"Back"];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToRatingSegue"]) {
        
        RatingViewController *detailViewController = (RatingViewController *)segue.destinationViewController;
        detailViewController.hidesBottomBarWhenPushed = YES;
        detailViewController.experimentDetail = [self.experimentDetail mutableCopy];
        
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startExperimentsButtonTapped:(id)sender {
    
}
@end
