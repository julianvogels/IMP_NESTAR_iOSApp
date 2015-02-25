//
//  RatingContent01ViewController.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/27/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDisplayViewController.h"
#import "VideoDisplayViewController.h"
#import "RatingViewController.h"
#import "constants.h"
#import "JVEasySlider.h"

@interface RatingContentViewController : UIViewController


@property (strong, nonatomic) UISlider *slider01;
@property (strong, nonatomic) UISlider *slider02;
@property (strong, nonatomic) UISlider *slider03;


@property (strong, nonatomic) NSDictionary *experimentDetail;
@property (assign, nonatomic) NSInteger itemIndex;
@property (assign, nonatomic) NSInteger gridResolution;

@property (strong, nonatomic) NSArray *dimensionLabels;
@property (strong, nonatomic) NSArray *sliderValues;

@property (strong, nonatomic) NSURL *mediaURL;
@property (nonatomic, assign) MediaType mediaType;

@property (strong, nonatomic) IBOutlet UIView *container;

@property (strong, nonatomic) VideoDisplayViewController *videoDisplay;

@property NSUInteger pageIndex;

- (IBAction)valueChanged:(id)sender;

@end
