//
//  HelpDetailViewController.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2014-03-17.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "HelpDetailViewController.h"
#import <AFNetworking/UIWebView+AFNetworking.h>

@interface HelpDetailViewController ()

@end

@implementation HelpDetailViewController

@synthesize url;
@synthesize webView;
@synthesize titleString;

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
	// Do any additional setup after loading the view.

    [[self navigationItem] setTitle:titleString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request progress:^(NSUInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
        // TBD: activity indicator
    } success:^NSString *(NSHTTPURLResponse *response, NSString *HTML) {
        // on success
        return HTML;
    } failure:^(NSError *error) {
        // on error
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
        NSString *errorString = [NSString stringWithFormat:@"Sorry, there was a problem loading the page you requested (%@).", error.localizedDescription];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Error requesting website"
                              message:errorString
                              delegate:Nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
        [alert show];
    }];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
