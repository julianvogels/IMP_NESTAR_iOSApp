//
//  ExperimentInstructionViewController.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/20/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExperimentInstructionViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIWebView *instructionsWebView;
@property (strong, nonatomic) NSDictionary *experimentDetail;


- (IBAction)startExperimentsButtonTapped:(id)sender;

@end
