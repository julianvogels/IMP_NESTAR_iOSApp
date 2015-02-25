//
//  JVEasySlider.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2014-04-07.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "JVEasySlider.h"
#define SIZE_EXTENSION_Y -10 // Adjust this value as required in your project
#define SIZE_EXTENSION_X -10 // Adjust this value as required in your project

@implementation JVEasySlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

/* How many extra touchable pixels you want above and below
 the 23px (default height) slider */



// Define another value if you want to extend size in x-axis

- (BOOL) pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    
    NSLog(@"pointSide");
    
    CGRect bounds = self.bounds;
    
    bounds = CGRectInset(bounds, SIZE_EXTENSION_X, SIZE_EXTENSION_Y);
    
    return CGRectContainsPoint(bounds, point);
    
}

@end
