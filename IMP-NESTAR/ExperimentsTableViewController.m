//
//  ExperimentsTableViewController.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/20/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "ExperimentsTableViewController.h"
#import "ExperimentDetailViewController.h"
#import "AFNetworking.h"
#import <UIImageView+WebCache.h>

@interface ExperimentsTableViewController ()

@end

@implementation ExperimentsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent= NO;
    
    self.finishedExperimentsArray = [[NSArray alloc] init];
    [self makeExperimentsRequest];
    
    // set Tabbar to opaque
    [[[self tabBarController] tabBar] setOpaque:YES];
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    refreshControl.tintColor = [UIColor redColor];
    [refreshControl addTarget:self action:@selector(makeExperimentsRequest) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        // app already launched
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        // This is the first launch ever
        [self displayTutorial];
    }
}

- (void) displayTutorial {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TutorialViewController *tutorial = (TutorialViewController*)[storyboard instantiateViewControllerWithIdentifier:@"TutorialViewController"];
    
    // present
    [self presentViewController:tutorial animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.experimentsArrayFromWeb count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"experimentCell";
    
    ExperimentCell *cell = [[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath] init];
    
    NSDictionary *tempDictionary= [self.experimentsArrayFromWeb objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [tempDictionary objectForKey:@"title"];
//    NSLog(@"%@", [tempDictionary objectForKey:@"icon"]);
    
    [cell.thumbnail setImageWithURL:[NSURL URLWithString:[tempDictionary objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@"111-user.png"] completed:nil];
    
//    [cell.thumbnail setImageWithURL:[NSURL URLWithString:[tempDictionary objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@"111-user.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//        [tableView beginUpdates];
//        [tableView reloadRowsAtIndexPaths:@[indexPath]
//                         withRowAnimation:UITableViewRowAnimationFade];
//        [tableView endUpdates];
//    }];
    
    NSURL* url = [NSURL URLWithString:[tempDictionary objectForKey:@"icon"]];
    if (url != nil && url) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        __weak ExperimentCell *weakView = cell;
        [weakView.thumbnail setImageWithURLRequest:request
                        placeholderImage:[UIImage imageNamed:@"111-user.png"]
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                     
                                     weakView.thumbnail.image = image;
                                     UIImageView *strongImageView = weakView.thumbnail; // make local strong reference to protect against race conditions
                                     if (!strongImageView) return;
                                     
                                     [UIView transitionWithView:strongImageView
                                                       duration:0.3
                                                        options:UIViewAnimationOptionTransitionCrossDissolve
                                                     animations:^{
                                                         strongImageView.image = image;
                                                     }
                                                     completion:nil];
                                     
                                 } failure:nil];
    } else {
        [cell.thumbnail setImage:[UIImage imageNamed:@"111-user.png"]];
    }

    
    
    if([tempDictionary objectForKey:@"institution"] != NULL)
    {
        cell.subTitleLabel.text = [NSString stringWithFormat:@"%@",[tempDictionary   objectForKey:@"institution"]];
        
    } else {
        
        cell.subTitleLabel.text = [NSString stringWithFormat:@"no institution affiliated"];
    }

    return cell;
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    ExperimentDetailViewController *detailViewController = (ExperimentDetailViewController *)segue.destinationViewController;
    
    detailViewController.experimentDetail = [self.experimentsArrayFromWeb objectAtIndex:indexPath.row];
}


-(void)makeExperimentsRequest
{
    NSURL *url = [NSURL URLWithString:kIMPexperimentsURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        self.experimentsArrayFromWeb = [responseObject objectForKey:@"experiments"];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
    }];
    [operation start];

    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0f;
}

#pragma mark – Unwind segue

- (IBAction)experimentCancelledCallback:(UIStoryboardSegue *)segue {
    NSLog(@"And now we are back.");
}

@end
