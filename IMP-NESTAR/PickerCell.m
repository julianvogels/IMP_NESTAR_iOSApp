//
//  PickerCell.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2014-04-07.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "PickerCell.h"

@implementation PickerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
        
    }
    return self;
}

- (void)awakeFromNib
{
//    [self setup];
}

-(void) setup{
    self.picker.dataSource = self;
    self.picker.delegate = self;
    self.picker.showsSelectionIndicator = YES;
    [self.picker reloadAllComponents];
//    if (self.values.count > 0) {
//        [self.picker selectRow:floor([self.values count]/2) inComponent:1 animated:NO];
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.values.count > 0)
        return 1;
    else
        return 0;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.values.count == 0)
        return 1;
    return self.values.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.values.count == 0) {
        return nil;
    }
    return [self.values objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedValue = [NSNumber numberWithInt:row];
}

@end
