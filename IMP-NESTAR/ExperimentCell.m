//
//  ExperimentCell.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2014-04-07.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "ExperimentCell.h"

@implementation ExperimentCell

@synthesize thumbnail;
@synthesize titleLabel;
@synthesize subTitleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        [thumbnail.layer setBorderColor: [[UIColor blueColor] CGColor]];
//        [thumbnail.layer setBorderWidth: 1.0];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
