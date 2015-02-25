//
//  TextCell.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 3/4/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (assign, nonatomic) BOOL required;
@property (assign, nonatomic) NSIndexPath *path;

@end
