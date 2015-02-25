//
//  RatingViewController.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/20/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingContentViewController.h"
#import "QuestionnaireViewController.h"
#import "ExperimentFinishedViewController.h"
#import "UploadExperimentData.h"
#import <AFNetworking/AFNetworking.h>
#import "constants.h"

@interface RatingViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIActionSheetDelegate, ExperimentFinishedDelegate, UploadExperimentDataDelegate>


@property (strong, nonatomic) NSMutableArray *barButtonArray;

@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) UIButton *previousButton;
@property (strong, nonatomic) UIButton *exitButton;


@property (strong, nonatomic) NSMutableDictionary *experimentDetail;

@property (assign, nonatomic) NSInteger itemCount;
@property (assign, nonatomic) NSInteger itemIndex;

@property (strong, nonatomic) NSMutableArray *ratings;
@property (strong, nonatomic) NSDictionary *items;
@property (strong, nonatomic) NSArray *itemURLs;
@property (strong, nonatomic) NSArray *itemFormats;
@property (strong, nonatomic) NSArray *dimensionLabels;
@property (assign, nonatomic) float gridResolution;
@property (strong, nonatomic) NSArray *questionnaire;


@property (strong, nonatomic) UIPageViewController *pageViewController;

-(void) previousButtonTapped:(id)sender;
-(void) nextButtonTapped:(id)sender;
-(void) cancelExperiment:(id)sender;

-(void) sendExperimentResults:(ExperimentFinishedViewController *)sender;

-(void) uploadExperimentData:(NSMutableDictionary *)data;

@end
