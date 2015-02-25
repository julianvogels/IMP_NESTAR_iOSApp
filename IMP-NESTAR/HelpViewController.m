//
//  SecondViewController.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/1/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

@synthesize url;
@synthesize helpTitle;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // User presses text fields
    if (indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
                url = [NSURL URLWithString:@"http://example.com/"];
                helpTitle = @"General Help";
                [self performSegueWithIdentifier:@"helpDetailSegue" sender:self];
                break;
                
            case 1:
                url = [NSURL URLWithString:@"http://example.com/kIMPhelpBugsURL"];
                helpTitle = @"Bug Report";
                [self performSegueWithIdentifier:@"helpDetailSegue" sender:self];
                break;
                
            default:
                break;
        }
    }
    if (indexPath.section == 2)
    {
        switch (indexPath.row) {
            case 0:
                url = [NSURL URLWithString:@"http://example.com/kIMPhelpInvestigatorURL"];
                helpTitle = @"Become an IMP investigator";
                [self performSegueWithIdentifier:@"helpDetailSegue" sender:self];
                break;
            case 1:
                url = [NSURL URLWithString:@"http://example.com/kIMPhelpScannerURL"];
                helpTitle = @"Scanner HowTo";
                [self performSegueWithIdentifier:@"helpDetailSegue" sender:self];
                break;
            default:
                break;
        }
    }
    
    if (indexPath.section == 3)
    {
        switch (indexPath.row) {
            case 0:
                url = [NSURL URLWithString:@"http://example.com/kIMPhelpAboutURL"];
                helpTitle = @"About";
                [self performSegueWithIdentifier:@"helpDetailSegue" sender:self];
                break;
            case 1:
                url = [NSURL URLWithString:@"http://example.com/kIMPhelpContactURL"];
                helpTitle = @"Contact us";
                [self performSegueWithIdentifier:@"helpDetailSegue" sender:self];
                break;
            default:
                break;
        }
    }
    
}


// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    HelpDetailViewController *detailViewController = (HelpDetailViewController *)segue.destinationViewController;
    
    detailViewController.url = url;
    detailViewController.titleString = helpTitle;
}


- (IBAction)watchTutorial:(id)sender {
    
//    NSLog(@"displayTutorial");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TutorialViewController *tutorial = (TutorialViewController*)[storyboard instantiateViewControllerWithIdentifier:@"TutorialViewController"];
    
    // present
    [self presentViewController:tutorial animated:YES completion:nil];
    
    // dismiss
    //[self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
