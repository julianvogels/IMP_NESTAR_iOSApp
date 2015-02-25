//
//  RatingContent01ViewController.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/27/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "RatingContentViewController.h"
#import <UIImageView+AFNetworking.h>

@interface RatingContentViewController ()

@end

@implementation RatingContentViewController


@synthesize itemIndex;
@synthesize gridResolution;

@synthesize dimensionLabels;
@synthesize sliderValues;

@synthesize mediaType;
@synthesize container;

@synthesize videoDisplay;

@synthesize slider01;
@synthesize slider02;
@synthesize slider03;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // +++ UI +++
    
    // if gridResolution is nil or zero, default to five step resolution
    gridResolution = (gridResolution == 0.0f) ? 4.0f : gridResolution-1;
    
    // fix height of content container
    CGRect newContainerFrame = CGRectMake(self.container.frame.origin.x, self.container.frame.origin.y, self.container.frame.size.width, 200.0f);
    [self.container setFrame:newContainerFrame];
    
    // programmatically create UISlider elements
    float containerHeight = 40.0f;
    float leftRightInset = 16.0f;
    float sliderSpaceHeight = (self.view.frame.origin.y+self.view.frame.size.height-49.0f-20.0f-44.0f-containerHeight)-(self.container.bounds.origin.y+self.container.bounds.size.height);
    float yOffset = sliderSpaceHeight*0.1;

    CGRect container01Frame = CGRectMake(leftRightInset, self.container.bounds.origin.y+self.container.bounds.size.height+yOffset, self.view.bounds.size.width-(leftRightInset*2), containerHeight);
    CGRect container03Frame = CGRectMake(leftRightInset, self.view.frame.origin.y+self.view.frame.size.height-20.0f-44.0f-containerHeight-yOffset, self.view.bounds.size.width-(leftRightInset*2), containerHeight);
    CGRect container02Frame = CGRectMake(leftRightInset, (container01Frame.origin.y+container03Frame.origin.y)/2, self.view.bounds.size.width-(leftRightInset*2), containerHeight);
    
    [self setupSliderContainerWithSlider:slider01 frame:container01Frame];
    [self setupSliderContainerWithSlider:slider02 frame:container02Frame];
    [self setupSliderContainerWithSlider:slider03 frame:container03Frame];
    
    [self.slider01 setMinimumValue:0.0f];
    [self.slider02 setMinimumValue:0.0f];
    [self.slider03 setMinimumValue:0.0f];
    
    [self.slider01 setMaximumValue:gridResolution];
    [self.slider02 setMaximumValue:gridResolution];
    [self.slider03 setMaximumValue:gridResolution];
    
    
    if (sliderValues.count != 3) {
        [slider01 setValue:(gridResolution-1)/2];
        [slider02 setValue:(gridResolution-1)/2];
        [slider03 setValue:(gridResolution-1)/2];
    } else {
        NSLog(@"page viewDidLoad: Page index %lu here. Setting slider values. %f %f %f \n\n", (unsigned long)self.pageIndex, [[sliderValues objectAtIndex:0] floatValue], [[sliderValues objectAtIndex:1] floatValue], [[sliderValues objectAtIndex:2] floatValue]);
    [slider01 setValue:[[sliderValues objectAtIndex:0] floatValue]];
    [slider02 setValue:[[sliderValues objectAtIndex:1] floatValue]];
    [slider03 setValue:[[sliderValues objectAtIndex:2] floatValue]];
    }

    
    // Set up content display
    if (mediaType == image) {
        [self imageDisplayWithURL:self.mediaURL];
    } else if (mediaType == audio) {
        [self audioDisplayWithURL:self.mediaURL];
    } else if (mediaType == video) {
        [self videoDisplayWithURL:self.mediaURL];
    }
}

-(void)setupSliderContainerWithSlider: (UISlider *)slider frame: (CGRect) containerFrame {

    UIFont *font = [UIFont systemFontOfSize:10.0f];
    
    CGRect sliderFrame = CGRectMake(0.0f, 15.0f, containerFrame.size.width, 10.0);
    UIImageView *sliderContainer = [[UIImageView alloc] initWithFrame:containerFrame];
    
    float labelYPos = 26.0f;
    float labelLeftRightInset = 14.0f;
    
    CGRect leftLabelFrame = CGRectMake(labelLeftRightInset, labelYPos, containerFrame.size.width/2-10.0f, containerFrame.size.height-labelYPos);
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:leftLabelFrame];
    [leftLabel setFont:font];
    [leftLabel setTextAlignment:NSTextAlignmentLeft];
    CGRect rightLabelFrame = CGRectMake(containerFrame.size.width/2+10.0f-labelLeftRightInset, labelYPos, containerFrame.size.width/2-10.0f, containerFrame.size.height-labelYPos);
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:rightLabelFrame];
    [rightLabel setFont:font];
    [rightLabel setTextAlignment:NSTextAlignmentRight];
    
    UIImage *sliderContainerBackground = [[UIImage alloc] init];
    if (gridResolution == 4.0f) {
        sliderContainerBackground = [UIImage imageNamed:@"uisliderbg5.png"];
    } else if (gridResolution == 6.0f){
        sliderContainerBackground = [UIImage imageNamed:@"uisliderbg7.png"];
    } else {
        sliderContainerBackground = [UIImage imageNamed:@"uisliderbg.png"];
    }
    if (slider==slider01) {
        slider01 = [self setupSliderWithFrame:sliderFrame];
        
        [leftLabel setText:[dimensionLabels objectAtIndex:0]];
        [rightLabel setText:[dimensionLabels objectAtIndex:1]];
        [sliderContainer addSubview:leftLabel];
        [sliderContainer addSubview:rightLabel];
        
        [sliderContainer addSubview:slider01];
        
    } else if(slider==slider02) {
        slider02 = [self setupSliderWithFrame:sliderFrame];
        
        [leftLabel setText:[dimensionLabels objectAtIndex:2]];
        [rightLabel setText:[dimensionLabels objectAtIndex:3]];
        [sliderContainer addSubview:leftLabel];
        [sliderContainer addSubview:rightLabel];
        
        [sliderContainer addSubview:slider02];
    } else if(slider==slider03) {
        slider03 = [self setupSliderWithFrame:sliderFrame];
        
        [leftLabel setText:[dimensionLabels objectAtIndex:4]];
        [rightLabel setText:[dimensionLabels objectAtIndex:5]];
        [sliderContainer addSubview:leftLabel];
        [sliderContainer addSubview:rightLabel];
        
        [sliderContainer addSubview:slider03];
    }
    
    [sliderContainer setImage:sliderContainerBackground];
    sliderContainer.userInteractionEnabled = YES;
    
    [self.view addSubview:sliderContainer];
}

-(UISlider*)setupSliderWithFrame:(CGRect)frame{
    
    JVEasySlider *slider = [[JVEasySlider alloc] initWithFrame:frame];
    [slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
//    UIImage *clearImage = [[UIImage imageNamed:@"clearImage"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [slider setMinimumTrackImage:clearImage forState:UIControlStateNormal];
//    [slider setMaximumTrackImage:clearImage forState:UIControlStateNormal];
    [slider setBackgroundColor:[UIColor clearColor]];
    [slider setMaximumTrackTintColor:[UIColor clearColor]];
    [slider setMinimumTrackTintColor:[UIColor clearColor]];
    slider.minimumValue = 0.0f;
    slider.maximumValue = gridResolution;
    slider.continuous = NO;
    return slider;
}

- (void) imageDisplayWithURL:(NSURL *)url {

    ImageDisplayViewController *containerDisplay = [[ImageDisplayViewController alloc] init];
    containerDisplay.imageView = [[UIImageView alloc] initWithFrame:container.bounds];
    [containerDisplay.view addSubview:containerDisplay.imageView];
    [self addChildViewController:containerDisplay];
    [containerDisplay didMoveToParentViewController:self];
    containerDisplay.view.frame = container.bounds;
    [containerDisplay.imageView setImageWithURL:url];
    containerDisplay.imageView.contentMode = UIViewContentModeScaleAspectFit;
    containerDisplay.imageView.backgroundColor = [UIColor blackColor];
    [self.container addSubview:containerDisplay.view];
}

- (void) audioDisplayWithURL:(NSURL *)url {
    videoDisplay = [[VideoDisplayViewController alloc] init];
    
    videoDisplay.view.frame = container.frame;
    videoDisplay.url = url;
    [videoDisplay loadPlayerWithMediaType:audio];
    [self addChildViewController:videoDisplay];
    [videoDisplay didMoveToParentViewController:self];
    [self.container addSubview:videoDisplay.view];
}

- (void) videoDisplayWithURL:(NSURL *)url {
    videoDisplay = [[VideoDisplayViewController alloc] init];
    videoDisplay.view.frame = container.bounds;
    videoDisplay.url = url;
    [videoDisplay loadPlayerWithMediaType:video];
    [self addChildViewController:videoDisplay];
    [videoDisplay didMoveToParentViewController:self];
    [self.container addSubview:videoDisplay.view];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)valueChanged:(id)sender {
    if (sender == self.slider01) {
        NSLog(@"value changed by slider01");
        float roundedValue = roundf(self.slider01.value);
        [self.slider01 setValue:roundedValue animated:YES];
    } else if (sender == self.slider02) {
        float roundedValue = roundf(self.slider02.value);
        [self.slider02 setValue:roundedValue animated:YES];
    } else if (sender == self.slider03) {
        float roundedValue = roundf(self.slider03.value);
        [self.slider03 setValue:roundedValue animated:YES];
    }
    
}

@end
