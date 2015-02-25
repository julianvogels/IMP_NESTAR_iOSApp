//
//  BoolCell.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 3/4/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "BoolCell.h"

@implementation BoolCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (self.selectedValue) {
            [self.segmentedControl setSelectedSegmentIndex:[self.selectedValue integerValue]];
        }
        self.segmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment;
    }
    return self;
}

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)segmentedControlValueChanged:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    self.selectedValue = [NSNumber numberWithInt:segmentedControl.selectedSegmentIndex];
}
@end
