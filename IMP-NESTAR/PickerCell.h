//
//  PickerCell.h
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2014-04-07.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerCell : UITableViewCell <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSArray *values;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (assign, nonatomic) BOOL required;
@property (assign, nonatomic) NSNumber *selectedValue;

@end
