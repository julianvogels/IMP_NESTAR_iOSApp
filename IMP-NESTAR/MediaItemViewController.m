//
//  MediaItemViewController.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/4/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "MediaItemViewController.h"

@interface MediaItemViewController ()

@end

@implementation MediaItemViewController

@synthesize mediaItemID;
@synthesize resultText;
@synthesize connectionManager;
@synthesize requestResponseLabel;
@synthesize activityIndicator;
@synthesize progressView;
@synthesize mediaType;
@synthesize videoDisplay;
@synthesize container;

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
    [resultText setText:mediaItemID];
    
    // Set up content display
    if (mediaType == image) {
        [self imageDisplayWithURL:self.mediaURL];
        [[self navigationItem] setTitle:@"Image"];
    } else if (mediaType == audio) {
        [self audioDisplayWithURL:self.mediaURL];
        [[self navigationItem] setTitle:@"Audio"];
    } else if (mediaType == video) {
        [self videoDisplayWithURL:self.mediaURL];
        [[self navigationItem] setTitle:@"Video"];
    }
}

- (void) imageDisplayWithURL:(NSURL *)url {
    
    ImageDisplayViewController *containerDisplay = [[ImageDisplayViewController alloc] init];
    containerDisplay.imageView = [[UIImageView alloc] initWithFrame:container.bounds];
    [containerDisplay.view addSubview:containerDisplay.imageView];
    [self addChildViewController:containerDisplay];
    [containerDisplay didMoveToParentViewController:self];
    containerDisplay.view.frame = container.bounds;
    [containerDisplay.imageView setImageWithURL:url];
    containerDisplay.imageView.contentMode = UIViewContentModeScaleAspectFit;
    containerDisplay.imageView.backgroundColor = [UIColor blackColor];
    [self.container addSubview:containerDisplay.view];
}

- (void) audioDisplayWithURL:(NSURL *)url {
    videoDisplay = [[VideoDisplayViewController alloc] init];
    
    videoDisplay.view.frame = container.frame;
    videoDisplay.url = url;
    [videoDisplay loadPlayerWithMediaType:audio];
    [self addChildViewController:videoDisplay];
    [videoDisplay didMoveToParentViewController:self];
    [self.container addSubview:videoDisplay.view];
}

- (void) videoDisplayWithURL:(NSURL *)url {
    videoDisplay = [[VideoDisplayViewController alloc] init];
    videoDisplay.view.frame = container.bounds;
    videoDisplay.url = url;
    [videoDisplay loadPlayerWithMediaType:video];
    [self addChildViewController:videoDisplay];
    [videoDisplay didMoveToParentViewController:self];
    [self.container addSubview:videoDisplay.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connectionStatusDidChangeToBOOL:(BOOL)connectionStatus {
    if (connectionStatus) {
        if (mediaType == image) {
            [self imageDisplayWithURL:self.mediaURL];
        } else if (mediaType == audio) {
            [self audioDisplayWithURL:self.mediaURL];
        } else if (mediaType == video) {
            [self videoDisplayWithURL:self.mediaURL];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet connection"
                                                        message:@"Please connect to the internet in order to load the media item."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}


@end
