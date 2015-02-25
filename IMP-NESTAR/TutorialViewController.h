//
//  TutorialViewController.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/8/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorialContentViewController.h"

@interface TutorialViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

- (IBAction)dismissTutorial:(id)sender;

@end
