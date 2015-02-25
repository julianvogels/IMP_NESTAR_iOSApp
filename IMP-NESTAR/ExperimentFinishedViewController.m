//
//  ExperimentFinishedViewController.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/20/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "ExperimentFinishedViewController.h"

@interface ExperimentFinishedViewController ()

@end

@implementation ExperimentFinishedViewController

@synthesize delegate;
@synthesize imageView;
@synthesize textView;
@synthesize continueButton;
@synthesize hasQuestionnaire;
@synthesize questionnaireDescription;

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

        // A questionnaire is to be filled out after clicking the button
        if (hasQuestionnaire) {
            
            [[self navigationItem] setTitle:@"Questionnaire"];
            
            // set default questionnaire image
            [imageView setImage:[UIImage imageNamed:@"questionnaireimage.png"]];
            [continueButton setTitle:@"Proceed to Questionnaire" forState:UIControlStateNormal];
            
            // Set text
            if (questionnaireDescription == (id)[NSNull null] || questionnaireDescription.length == 0 ) {
                textView.text = @"Thank you for your ratings. Please fill out the questionnaire now.";
            } else {
                textView.text = questionnaireDescription;
            }
            
        } else {
            // Clicking the button directly uploads the experiment data
            
            [[self navigationItem] setTitle:@"Submit your data"];
            
            [continueButton setTitle:@"Send experiment data" forState:UIControlStateNormal];
            
            [imageView setImage:[UIImage imageNamed:@"thankyouimage.png"]];
            textView.text = @"Please tap the button below to upload your experiment data. By tapping the button you agree to the conditions of the experiment.";
            
        }
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startVisualisationButtonTapped:(id)sender {
    
    // calling delegate method
    if([delegate respondsToSelector:@selector(sendExperimentResults:)]) {
        [delegate sendExperimentResults:self];
    }
}
@end
