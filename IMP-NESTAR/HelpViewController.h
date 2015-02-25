//
//  SecondViewController.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/1/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorialViewController.h"
#import "HelpDetailViewController.h"
#import "constants.h"

@interface HelpViewController : UITableViewController <UITableViewDelegate> {

}

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *helpTitle;

- (IBAction)watchTutorial:(id)sender;

@end
