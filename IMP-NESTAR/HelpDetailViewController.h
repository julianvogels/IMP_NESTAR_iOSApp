//
//  HelpDetailViewController.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2014-03-17.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *titleString;
@end
