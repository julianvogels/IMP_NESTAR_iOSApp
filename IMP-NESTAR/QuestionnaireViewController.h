//
//  RatingContent02ViewController.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 3/4/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextCell.h"
#import "BoolCell.h"
#import "PickerCell.h"
#import "PlaceHolderTextView.h"
#import <BSKeyboardControls/BSKeyboardControls.h>
#import "UploadExperimentData.h"
#import "constants.h"
#import "ThankYouViewController.h"

@interface QuestionnaireViewController : UITableViewController <UITextViewDelegate, UITextFieldDelegate, BSKeyboardControlsDelegate, UploadExperimentDataDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) NSMutableArray *questionnaire;

@property NSUInteger pageIndex;

@property (strong, nonatomic) NSMutableArray *textFields;
@property (strong, nonatomic) BSKeyboardControls *keyboardControls;

@property (strong, nonatomic) NSMutableDictionary *experimentDetail;

@property (strong, nonatomic) IBOutlet UITableView *questionnaireTableView;


-(void)textFieldDidChange:(id)sender;
- (IBAction)continueButtonTapped:(id)sender;

-(void) uploadExperimentData:(NSMutableDictionary *)data;


@end
