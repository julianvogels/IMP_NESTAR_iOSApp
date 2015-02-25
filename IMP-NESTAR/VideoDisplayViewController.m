//
//  VideoDisplayViewController.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 3/7/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "VideoDisplayViewController.h"

@interface VideoDisplayViewController ()

@end

@implementation VideoDisplayViewController

@synthesize moviePlayer;
@synthesize url;
@synthesize activityIndicator;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackStateChanged)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadPlayerWithMediaType:(NSUInteger) mediaType {
    NSLog(@"Here VideoDisplay. URL is %@", url);
    moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
    
    if (mediaType==1) {
        float barHeight = 38.0f;
        CGRect containerBounds = self.view.frame;
        UIImageView *placeholderImage = [[UIImageView alloc] initWithFrame:CGRectMake(containerBounds.origin.x, containerBounds.origin.y, containerBounds.size.width, containerBounds.size.height-barHeight)];
        [placeholderImage setContentMode:UIViewContentModeScaleAspectFit];
        [placeholderImage setImage:[UIImage imageNamed:@"audioPlaceholder.png"]];
        placeholderImage.frame = containerBounds;
        [self.view addSubview:placeholderImage];
        [moviePlayer.view setFrame:CGRectMake(containerBounds.origin.x, containerBounds.origin.y+containerBounds.size.height-barHeight, containerBounds.size.width, barHeight)];
        [moviePlayer setScalingMode:MPMovieScalingModeFill];
    } else {
        [moviePlayer.view setFrame:self.view.frame];
    }
    
    
    [self.view addSubview:moviePlayer.view];
    
    moviePlayer.fullscreen=NO;
    moviePlayer.allowsAirPlay=YES;
    moviePlayer.shouldAutoplay=NO;
    moviePlayer.controlStyle=MPMovieControlStyleEmbedded;
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.center = moviePlayer.view.center;
    activityIndicator.hidesWhenStopped = YES;
    [activityIndicator startAnimating];
    [moviePlayer.view addSubview:activityIndicator];
}

- (void) playbackStateChanged {
    
    if (moviePlayer.playbackState == MPMoviePlaybackStatePlaying) {
        [activityIndicator stopAnimating];
    }
    
}
@end
