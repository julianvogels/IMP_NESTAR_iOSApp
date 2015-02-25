//
//  ThankYouViewController.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 3/7/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "ThankYouViewController.h"

@interface ThankYouViewController ()

@end

@implementation ThankYouViewController

@synthesize textView;
@synthesize imageView;
@synthesize imageViewURL;
@synthesize textMessage;

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
    
    // Set image
    if (imageViewURL) {
        // set custom thank you image
        [imageView setImageWithURL:imageViewURL];
    } else {
        // set default thank you image
        [imageView setImage:[UIImage imageNamed:@"thankyouimage.png"]];
    }
    
    // Set text
    if (textMessage == (id)[NSNull null] || textMessage.length == 0 ) {
        textView.text = @"Thank you for your paticipation in this experiment.";
    } else {
        textView.text = textMessage;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToExperimentsList:(id)sender {
    
    [self performSegueWithIdentifier:@"experimentCancelled" sender:self];
}

#pragma mark – Navigation Bar Delegate Methods

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem     *)item
{
    [self backToExperimentsList:navigationBar.backItem];
    // don't let the pop happen
    return NO;
}

@end
