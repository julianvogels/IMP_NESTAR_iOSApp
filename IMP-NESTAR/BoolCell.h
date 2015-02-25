//
//  BoolCell.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 3/4/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoolCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (assign, nonatomic) BOOL required;
@property (assign, nonatomic) NSNumber *selectedValue;

- (IBAction)segmentedControlValueChanged:(id)sender;

@end
