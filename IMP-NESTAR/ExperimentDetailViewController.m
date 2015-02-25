//
//  ExperimentDetailViewController.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/20/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "ExperimentDetailViewController.h"
#import "ExperimentInstructionViewController.h"
#import "ScanViewController.h"
#import <UIImageView+AFNetworking.h>

@interface ExperimentDetailViewController ()

@end

@implementation ExperimentDetailViewController

@synthesize scrollView;
@synthesize participateButton;
@synthesize buttonContainer;
@synthesize displayScannerButton;

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
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"displayScanner"]) {
        NSLog(@"should display scanner button");
//        [participateButton setFrame:CGRectMake(participateButton.frame.origin.x, participateButton.frame.origin.y, participateButton.frame.size.width/2-5.0f, participateButton.frame.size.height)];
        self.participateButtonWidth.constant = self.participateButtonWidth.constant/2-5.0f;
        
        displayScannerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [displayScannerButton addTarget:self
                   action:@selector(displayScannerButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
        displayScannerButton.frame = CGRectMake(buttonContainer.frame.origin.x+buttonContainer.frame.size.width-self.participateButtonWidth.constant, 0.0f, self.participateButtonWidth.constant, participateButton.frame.size.height);
        [displayScannerButton setTitle:@"Scanner" forState:UIControlStateNormal];
        [[displayScannerButton titleLabel] setFont:[UIFont boldSystemFontOfSize:17.0f]];
        [displayScannerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [displayScannerButton setBackgroundColor:[UIColor colorWithHue:211.0f/360.0f saturation:1.0 brightness:1.0 alpha:1.0]];
        
        [buttonContainer addSubview:displayScannerButton];
        NSLog(@"button frame: %@", [displayScannerButton description]);
        
    }

    
    // set Tabbar to opaque
    [[[self tabBarController] tabBar] setOpaque:YES];
    
    UIFont *titleFont = [UIFont boldSystemFontOfSize:14.0f];
    
    self.experimentTitleTextView.text = [self.experimentDetail objectForKey:@"title"];
    [self.experimentTitleTextView setFont:titleFont];
    [self.experimentTitleTextView setTextAlignment:NSTextAlignmentCenter];
    [self.experimentTitleTextView sizeToFit];
    NSURL* url = [NSURL URLWithString:[self.experimentDetail objectForKey:@"image"]];
    if (url != nil && url) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        __weak UIImageView *weakView = self.experimentImageView;
        [weakView setImageWithURLRequest:request
                                        placeholderImage:[UIImage imageNamed:@"experiment_placeholder_image"]
                                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                     
                                                     weakView.image = image;
                                                     UIImageView *strongImageView = weakView; // make local strong reference to protect against race conditions
                                                     if (!strongImageView) return;
                                                     
                                                     [UIView transitionWithView:strongImageView
                                                                       duration:0.3
                                                                        options:UIViewAnimationOptionTransitionCrossDissolve
                                                                     animations:^{
                                                                         strongImageView.image = image;
                                                                     }
                                                                     completion:nil];
                                                     
                                                 } failure:nil];
    } else {
        [self.experimentImageView setImage:[UIImage imageNamed:@"experiment_placeholder_image"]];
    }
    self.experimentDescriptionTextView.text = [self.experimentDetail objectForKey:@"description"];
    // TBD: add data programmatically to labels
    self.investigatorLabel.text = [self.experimentDetail objectForKey:@"investigator"];
    self.institutionLabel.text = [self.experimentDetail objectForKey:@"institution"];
    
    [self.experimentDescriptionTextView setTextContainerInset:UIEdgeInsetsMake(-2,-4,0,0)];
    [self.experimentTitleTextView setTextContainerInset:UIEdgeInsetsMake(-2,-4,0,0)];
    
    // Prevents scrollview from being vertically offset
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSLog(@"Scrollview: %@", [scrollView description]);
    
    
    // Set NavigationItem title to Experiment title
    [[self navigationItem] setTitle:[self.experimentDetail objectForKey:@"title"]];
    
    CGSize sizeThatShouldFitTheContent01 = [self.experimentTitleTextView sizeThatFits:self.experimentTitleTextView.frame.size];
    self.experimentTitleTextViewHeightContraint.constant = sizeThatShouldFitTheContent01.height;

    CGSize sizeThatShouldFitTheContent02 = [self.experimentDescriptionTextView sizeThatFits:self.experimentDescriptionTextView.frame.size];
    self.experimentDescriptionTextViewHeightContraint.constant = sizeThatShouldFitTheContent02.height;
    
}   

//-(void)viewDidAppear:(BOOL)animated {
//    [self.experimentDescriptionTextView.layoutManager ensureLayoutForTextContainer:self.experimentDescriptionTextView.textContainer];
//    [self.experimentDescriptionTextView layoutIfNeeded];
//    [self.scrollView setContentSize:CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height-47.0f)];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToInstructionsSegue"]) {
        
        ExperimentInstructionViewController *detailViewController = (ExperimentInstructionViewController *)segue.destinationViewController;
    
        detailViewController.experimentDetail = self.experimentDetail;
    
    }
    
    if ([segue.identifier isEqualToString:@"displayScannerSegue"]) {
        ScanViewController *detailViewController = (ScanViewController *) segue.destinationViewController;
        detailViewController.experimentDetail = self.experimentDetail;
    }

}

-(void)displayScannerButtonPressed{
   [self performSegueWithIdentifier:@"displayScannerSegue" sender:self];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
