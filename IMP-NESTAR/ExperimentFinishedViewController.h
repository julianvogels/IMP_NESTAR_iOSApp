//
//  ExperimentFinishedViewController.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/20/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ExperimentFinishedViewController;
@protocol ExperimentFinishedDelegate <NSObject>
@optional

-(void) sendExperimentResults:(ExperimentFinishedViewController *)sender;

@end

@interface ExperimentFinishedViewController : UIViewController {
}

@property (nonatomic, weak) id <ExperimentFinishedDelegate> delegate;

@property (nonatomic, assign) BOOL hasQuestionnaire;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) NSString *questionnaireDescription;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (assign, nonatomic) NSUInteger pageIndex;

@property (strong, nonatomic) IBOutlet UIButton *continueButton;


- (IBAction)startVisualisationButtonTapped:(id)sender;

@end
