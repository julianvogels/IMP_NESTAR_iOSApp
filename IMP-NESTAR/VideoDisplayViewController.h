//
//  VideoDisplayViewController.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 3/7/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VideoDisplayViewController : UIViewController

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSURL *url;

-(void)loadPlayerWithMediaType:(NSUInteger)mediaType;

@end
