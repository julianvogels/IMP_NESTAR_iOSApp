//
//  ExperimentsTableViewController.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/20/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "constants.h"
#import "TutorialViewController.h"
#import "ExperimentCell.h"

@interface ExperimentsTableViewController : UITableViewController <UITableViewDataSource>


@property (nonatomic, strong) NSArray *experimentsArrayFromWeb;
@property (nonatomic, strong) NSArray *finishedExperimentsArray;

- (IBAction)experimentCancelledCallback:(UIStoryboardSegue *)segue;

@end
