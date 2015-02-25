//
//  ExperimentDetailViewController.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/20/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExperimentDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *experimentImageView;
@property (strong, nonatomic) IBOutlet UITextView *experimentTitleTextView;
@property (strong, nonatomic) IBOutlet UITextView *experimentDescriptionTextView;
@property (strong, nonatomic) IBOutlet UILabel *institutionLabel;
@property (strong, nonatomic) IBOutlet UILabel *investigatorLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *buttonContainer;
@property (strong, nonatomic) IBOutlet UIButton *participateButton;
@property (strong, nonatomic) UIButton *displayScannerButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *participateButtonWidth;

@property (strong, nonatomic) NSDictionary *experimentDetail;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *experimentTitleTextViewHeightContraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *experimentDescriptionTextViewHeightContraint;

-(void)displayScannerButtonPressed;

@end
