//
//  RatingViewController.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/20/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "RatingViewController.h"
#import <MobileCoreServices/UTType.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface RatingViewController ()

@end

@implementation RatingViewController

@synthesize ratings;
@synthesize experimentDetail;
@synthesize itemCount;

@synthesize itemIndex;
@synthesize gridResolution;
@synthesize barButtonArray;
@synthesize dimensionLabels;

@synthesize nextButton;
@synthesize previousButton;
@synthesize exitButton;

@synthesize items;
@synthesize itemURLs;
@synthesize itemFormats;

@synthesize questionnaire;

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
    
    // +++ INITS +++
    
    itemIndex = 0;

    // +++ UI +++
    
    // NavigationItem hide back button
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *cancelButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(cancelExperiment:)];
    [[self navigationItem] setLeftBarButtonItem:cancelButton];
    
    
    // BARBUTTONITEMS add two bar button items for navigation of media items
    
    // Previous Button
    UIImage* previousButtonImage = [UIImage imageNamed:@"09-arrow-west"];
    CGRect previousButtonFrame = CGRectMake(0, 0, previousButtonImage.size.width, previousButtonImage.size.height);
    previousButton = [[UIButton alloc] initWithFrame:previousButtonFrame];
    [previousButton setTitle:@"Previous" forState:UIControlStateNormal & UIControlStateHighlighted];
    [previousButton setImage:previousButtonImage forState:UIControlStateNormal & UIControlStateSelected];
    [previousButton addTarget:self action:@selector(previousButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *previousBarButton = [[UIBarButtonItem alloc] initWithCustomView:previousButton];
    [previousBarButton setEnabled:NO];
    
    // Fixed Space
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 30.0f;
    
    // Next Button
    UIImage* nextButtonImage = [UIImage imageNamed:@"02-arrow-east"];
    CGRect nextButtonFrame = CGRectMake(0, 0, nextButtonImage.size.width, nextButtonImage.size.height);
    nextButton = [[UIButton alloc] initWithFrame:nextButtonFrame];
    [nextButton setTitle:@"Next" forState:UIControlStateNormal & UIControlStateHighlighted];
    [nextButton setImage:nextButtonImage forState:UIControlStateNormal & UIControlStateSelected];
    [nextButton addTarget:self action:@selector(nextButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *nextBarButton = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
    
    barButtonArray = [[NSMutableArray alloc] initWithObjects:nextBarButton, fixedItem, previousBarButton, nil];
    
    [self.navigationItem setRightBarButtonItems:barButtonArray animated:YES];
    
    
    // Set slider resolution according to experiment grid resolution (5x5x5 or 7x7x7)
    gridResolution = [[experimentDetail objectForKey:@"grid_resolution"] floatValue];
    
    // +++ Media Data Retrieval +++
    
    items = [experimentDetail objectForKey:@"items"];
    NSLog(@"items COUNT: %d", [items count]);
    itemURLs = [[NSArray alloc] initWithArray:[items objectForKey:@"url"]];
    itemFormats = [[NSArray alloc] initWithArray:[items objectForKey:@"format"]];
    
    itemCount = itemURLs.count;
    
    // TBD get these values form experimentDetail
    dimensionLabels = [experimentDetail objectForKey:@"dimension_labels"];
    
    // +++ Data Acquisition +++
    // change properties of ratings dictionary according to experiment properties
    ratings = [[NSMutableArray alloc] initWithCapacity:itemCount];
    
    for (int i = 0; i < itemCount; i++) {
        if (gridResolution == 5) {
            [ratings insertObject:[NSMutableArray arrayWithObjects:  @"2",@"2",@"2",nil] atIndex:i];
        } else if (gridResolution == 7) {
            [ratings insertObject:[NSMutableArray arrayWithObjects:  @"3",@"3",@"3",nil] atIndex:i];
        } else {
            NSLog(@"gridResolution out of bounds");
        }
    }
    
    [self updateInterfaceWithItemIndex:0];
    
    
    // Fetch questionnaire data (array of dictionaries)
    questionnaire = [experimentDetail objectForKey:@"questionnaire"];

    // increment itemCount to make place for experimentFinishedView
    itemCount++;

    // +++ Page View Controller +++
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RatingPageViewController"];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    // Watch out! First view HAS to be a rating view
    RatingContentViewController *startingViewController = (RatingContentViewController *)[self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    // TBD check frame size, is probably too biaaag
//    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 20 );
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    // Hide PageControl indicators
    NSArray *subviews = self.pageViewController.view.subviews;
    UIPageControl *thisControl = nil;
    for (int i=0; i<[subviews count]; i++) {
        if ([[subviews objectAtIndex:i] isKindOfClass:[UIPageControl class]]) {
            thisControl = (UIPageControl *)[subviews objectAtIndex:i];
        }
    }
    [thisControl setHidden:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([segue.identifier isEqualToString:@"gotoQuestionnaireSegue"]) {
        
        QuestionnaireViewController *questionnaireViewController = (QuestionnaireViewController *)segue.destinationViewController;
        
        questionnaireViewController.experimentDetail = self.experimentDetail;
        questionnaireViewController.questionnaire = [questionnaire mutableCopy];
        
    }
    if ([segue.identifier isEqualToString:@"fromRatingToThankYouSegue"]) {
        
        ThankYouViewController *thankYou = (ThankYouViewController *)segue.destinationViewController;
        
        thankYou.textMessage = [self.experimentDetail objectForKey:@"thankyoutext"];
        thankYou.imageViewURL = [self.experimentDetail objectForKey:@"thankyouimage"];
        
    }
    
}

- (void) previousButtonTapped:(id)sender {
    itemIndex--;
    NSLog(@"Previous Button was Tapped, itemIndex is now %ld", (long)itemIndex);
    [self pageBack:sender withIndex:itemIndex];
}

- (void) nextButtonTapped:(id)sender {
    itemIndex++;
    NSLog(@"Next Button was Tapped, itemIndex is now %ld of %ld", (long)itemIndex, (long)itemCount);
    [self pageForward:sender withIndex:itemIndex];
}

- (void)  updateInterfaceWithItemIndex:(NSInteger)index {

    
    // Set Navigation Item Title
    [self.navigationItem setTitle:[NSString stringWithFormat:@"%d of %ld", index+1, (long)itemCount]];
    
    // +++ Button functionality +++
    
    // first item, no previous button functionality required
    if (index==0) {
        // Previous button was tapped to come back to first item, disable button
        [[[self.navigationItem rightBarButtonItems] objectAtIndex:2] setEnabled:NO];
    } else {
        [[[self.navigationItem rightBarButtonItems] objectAtIndex:2] setEnabled:YES];
    }
        
    // second-to-last item
    if (index==itemCount-2) {
        NSLog(@"will restore nextbutton");
        // Previous button was tapped to come back for second-to-last item, change Next button back to next icon
        UIBarButtonItem *nextBarButton = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
        [barButtonArray replaceObjectAtIndex:0 withObject:nextBarButton];
        [self.navigationItem setRightBarButtonItems:barButtonArray animated:NO];
    }
    
    // UI
    if (index == itemCount-1) {

        [[[self.navigationItem rightBarButtonItems] objectAtIndex:0] setEnabled:NO];
    } else {
        [[[self.navigationItem rightBarButtonItems] objectAtIndex:0] setEnabled:YES];
    }
    
    
}


-(void) pageBack:(id)sender withIndex:(NSInteger)index {
    
    [self updateInterfaceWithItemIndex:index];
    
    // Calling the PageViewController to obtain the current left page
    UIViewController *currentPage = [self.pageViewController.viewControllers objectAtIndex:0];
    
    NSArray *newPages = nil;
    UIViewController *newPage = nil;
    
    newPage = [self pageViewController:self.pageViewController viewControllerBeforeViewController:currentPage];
    newPages = [[NSArray alloc] initWithObjects:newPage, nil];
    
    if (newPage) {
        __weak RatingViewController *rv = self;
        [self.pageViewController setViewControllers:newPages direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL success){
            [rv autoPlayWithPageController:rv.pageViewController];
        }];
    }
}

-(void) pageForward:(id)sender withIndex:(NSInteger)index {
    
    [self updateInterfaceWithItemIndex:index];
    
    // Calling the PageViewController to obtain the current left page
    UIViewController *currentPage = [self.pageViewController.viewControllers objectAtIndex:0];
    
    NSArray *newPages = nil;
    UIViewController *newPage = nil;
    
    newPage = [self pageViewController:self.pageViewController viewControllerAfterViewController:currentPage];
    newPages = [[NSArray alloc] initWithObjects:newPage, nil];
    
    if (newPage) {
        __weak RatingViewController *rv = self;
        [self.pageViewController setViewControllers:newPages direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL success){
            [rv autoPlayWithPageController:rv.pageViewController];
        }];
    }
}


-(NSString *) getMediaType:(NSString *)filePath {

    CFStringRef fileExtension = (__bridge CFStringRef) [filePath pathExtension];
    CFStringRef fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, NULL);
    
    if (UTTypeConformsTo(fileUTI, kUTTypeImage))        return @"image";
    else if (UTTypeConformsTo(fileUTI, kUTTypeMovie))   return @"movie";
    else if (UTTypeConformsTo(fileUTI, kUTTypeAudio))   return @"audio";
    else                                                return @"not recognized";
    
    CFRelease(fileUTI);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) cancelExperiment:(id)sender {
    NSString *actionSheetTitle = @"Do you really want to cancel the experiment? All your data will be lost.";
    NSString *destructiveTitle = @"Cancel Experiment";
    NSString *cancelTitle = @"Continue";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:destructiveTitle
                                  otherButtonTitles:nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

-(void) sendExperimentResults:(ExperimentFinishedViewController *)sender {
    NSMutableDictionary *itemsKeys = [(NSMutableDictionary *)[experimentDetail objectForKey:@"items"] mutableCopy];
    [itemsKeys setObject:ratings forKey:@"ratings"];
//    NSLog(@"itemsKeys description %@", [itemsKeys description]);
    [experimentDetail setObject:itemsKeys forKey:@"items"];
    if (questionnaire) {
        [self performSegueWithIdentifier:@"gotoQuestionnaireSegue" sender:self];
        // TBD configure segue and pass experimentDetail with results
    } else {
        // Questionnaire is not required, upload data directly
        [self uploadExperimentData:experimentDetail];
    }
}

-(void) uploadExperimentData:(NSMutableDictionary *)data {
    UploadExperimentData *uploadTask = [[UploadExperimentData alloc] initWithData:data andURL:[NSURL URLWithString:kIMPuploadURL]];
    uploadTask.delegate = self;
    [uploadTask upload];
}

-(void) hasUploadedData:(UploadExperimentData *)sender withStatus:(BOOL)success {
    NSLog(@"Upload finished. Status: %hhd", success);
    [self performSegueWithIdentifier:@"fromRatingToThankYouSegue" sender:self];
}

#pragma mark – Action Sheet Delegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:@"Cancel Experiment"]) {
        
        [self performSegueWithIdentifier:@"experimentCancelled" sender:self];
        
    }
    
    if  ([buttonTitle isEqualToString:@"Continue"]) {
        
        
    }

}


#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = NSNotFound;
    
    if ([viewController isKindOfClass:[RatingContentViewController class]]) {
        NSLog(@"before: isKindOfClass: RatingContent01ViewController");
        RatingContentViewController *beforeViewController = ((RatingContentViewController*) viewController);
        index = beforeViewController.pageIndex;
        
        //    NSLog(@"Before. Written values: %d, %d, %d at index %d", (int)afterViewController.slider01.value, (int)afterViewController.slider02.value, (int)afterViewController.slider03.value, index);
        
        [ratings replaceObjectAtIndex:index withObject:[NSMutableArray arrayWithObjects:  [NSString stringWithFormat:@"%d", (int)beforeViewController.slider01.value], [NSString stringWithFormat:@"%d", (int)beforeViewController.slider02.value], [NSString stringWithFormat:@"%d", (int)beforeViewController.slider03.value], nil]];
    } else if ([viewController isKindOfClass:[ExperimentFinishedViewController class]]) {
        NSLog(@"before: isKindOfClass: ExperimentFinishedViewController");
        ExperimentFinishedViewController *beforeViewController = ((ExperimentFinishedViewController*) viewController);
        index = beforeViewController.pageIndex;
        
    }
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}



- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = NSNotFound;
    
    if ([viewController isKindOfClass:[RatingContentViewController class]]) {
        NSLog(@"after: isKindOfClass: RatingContent01ViewController");
        RatingContentViewController *afterViewController = ((RatingContentViewController*) viewController);
        index = afterViewController.pageIndex;
        
        //    NSLog(@"After. Written values: %d, %d, %d at index %d", (int)afterViewController.slider01.value, (int)afterViewController.slider02.value, (int)afterViewController.slider03.value, index);
        
        [ratings replaceObjectAtIndex:index withObject:[NSMutableArray arrayWithObjects:  [NSString stringWithFormat:@"%d", (int)afterViewController.slider01.value], [NSString stringWithFormat:@"%d", (int)afterViewController.slider02.value], [NSString stringWithFormat:@"%d", (int)afterViewController.slider03.value], nil]];
    } else if ([viewController isKindOfClass:[ExperimentFinishedViewController class]]) {
        NSLog(@"after: isKindOfClass: ExperimentFinishedViewController");
        ExperimentFinishedViewController *afterViewController = ((ExperimentFinishedViewController*) viewController);
        index = afterViewController.pageIndex;
        
    }

    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    // TBD end page slide logic here
    if (index == itemCount) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}




- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if ((itemCount == 0) || (index >= itemCount)) {
        return nil;
    }
    
    [self updateInterfaceWithItemIndex:index];
    
    itemIndex = index;
    
    if (index==itemCount-1) {
        // last page of pageviewcontroller is set
        ExperimentFinishedViewController *experimentFinishedViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ExperimentFinishedViewController"];
        [experimentFinishedViewController setDelegate:self];
        // pass variables
        experimentFinishedViewController.pageIndex = index;

        if (questionnaire) {
            experimentFinishedViewController.navigationItem.title = @"Questionnaire";
            if ([experimentDetail objectForKey:@"questionnaire_description"]) {
                experimentFinishedViewController.questionnaireDescription = [NSString stringWithString:[experimentDetail objectForKey:@"questionnaire_description"]];
                experimentFinishedViewController.hasQuestionnaire = YES;
            }
        }
        
        return experimentFinishedViewController;
        
    } else {
    
        // Create a new view controller and pass suitable data.
        RatingContentViewController *ratingContent01ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RatingContent01ViewController"];

        // pageviewcontroller variables
        // TBD consolidate buttons and swipe
        ratingContent01ViewController.dimensionLabels = dimensionLabels;
        ratingContent01ViewController.sliderValues = [ratings objectAtIndex:index];
        ratingContent01ViewController.gridResolution = gridResolution;
        ratingContent01ViewController.pageIndex = index;
        
        ratingContent01ViewController.mediaURL = [NSURL URLWithString:[itemURLs objectAtIndex:index]];
        MediaType mediaType;
        if ([[itemFormats objectAtIndex:index] isEqualToString:@"image"]) {
            mediaType = image;
        } else if ([[itemFormats objectAtIndex:index] isEqualToString:@"audio"]) {
            mediaType = audio;
        } else if ([[itemFormats objectAtIndex:index] isEqualToString:@"video"]) {
            mediaType = video;
        }
        ratingContent01ViewController.mediaType = mediaType;
        
        if ([ratingContent01ViewController.container isKindOfClass:[VideoDisplayViewController class]]) {
            VideoDisplayViewController *display = (VideoDisplayViewController *) ratingContent01ViewController.container;
            [display.moviePlayer play];
        }
           
        return ratingContent01ViewController;
    }
    
    
}



- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return itemCount;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

// Video Autoplay functionality
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    // If the page did not turn
    if (!completed)
    {
        // You do nothing because whatever page you thought
        // the book was on before the gesture started is still the correct page
        return;
    }
    [self autoPlayWithPageController:pageViewController];
    }

- (void)autoPlayWithPageController:(UIPageViewController *)pageViewController{
    if ([[pageViewController.viewControllers objectAtIndex:0] isKindOfClass:[RatingContentViewController class]]) {
        RatingContentViewController *currentViewController = (RatingContentViewController *)[pageViewController.viewControllers objectAtIndex:0];
        if (currentViewController.pageIndex == itemIndex) {
            if (currentViewController.mediaType == video || currentViewController.mediaType == audio) {
                [currentViewController.videoDisplay.moviePlayer play];
            }
            
        }
    }

}


@end
