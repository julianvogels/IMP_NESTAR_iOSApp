//
//  ThankYouViewController.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 3/7/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ThankYouViewController : UIViewController <UINavigationBarDelegate>

@property (nonatomic, assign) BOOL hasQuestionnaire;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSURL *imageViewURL;

@property (strong, nonatomic) NSString *questionnaireDescription;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSString *textMessage;

@property (assign, nonatomic) NSUInteger pageIndex;

@property (strong, nonatomic) IBOutlet UIButton *continueButton;
- (IBAction)backToExperimentsList:(id)sender;

@end
