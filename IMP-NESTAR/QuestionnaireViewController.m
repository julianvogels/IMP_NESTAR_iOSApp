//
//  RatingContent02ViewController.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 3/4/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "QuestionnaireViewController.h"

@interface QuestionnaireViewController ()

@end

@implementation QuestionnaireViewController

@synthesize questionnaire;
@synthesize textFields;

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
    textFields = [[NSMutableArray alloc] initWithCapacity:[questionnaire count]];
    
    // NavigationItem hide back button
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *cancelButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(cancelExperiment:)];
    [[self navigationItem] setLeftBarButtonItem:cancelButton];
    
    
    // Gather text questions
    for (int i = 0; i<[questionnaire count]; i++) {
        if ([[[questionnaire objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"text"]) {
            PlaceHolderTextView *textView = [[PlaceHolderTextView alloc] init];
            [textFields addObject:textView];
        }
    }
    
    
    NSLog(@"Questionnaire array: %@", [questionnaire description]);
//
//    for (id object in questionnaire) {
//        if ([[object objectForKey:@"type"] isEqualToString:@"text"]) {
//            [textFields addObject:object];
//        }
//    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections according to number of questionnaire items.
    return (NSInteger)[questionnaire count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellContent = [questionnaire objectAtIndex:indexPath.section];
    NSLog(@"Section: %ld. Cell type %@", (long)indexPath.section, [cellContent objectForKey:@"type"]);
    
    
    NSString *type = [cellContent objectForKey:@"type"];
    
    static NSString *CellIdentifier = @"Cell";
    
    if ([type isEqualToString:@"text"]) {
//        NSLog(@"TextCell return");
        CellIdentifier = @"textCell";
        TextCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        PlaceHolderTextView *placeHolderTextView = (PlaceHolderTextView *) cell.textView;
        placeHolderTextView.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:@"UITextFieldTextDidChangeNotification" object:placeHolderTextView];
        
        // Add text if was already filled in
        if ([cellContent objectForKey:@"result"]) {
            [placeHolderTextView setText:[NSString stringWithString:[cellContent objectForKey:@"result"]]];
        } else {
            // Add placeholder text
            NSString *placeholder = [NSString stringWithString:[cellContent objectForKey:@"placeholder"]];
            if (placeholder) {
                [placeHolderTextView setPlaceholder:placeholder];
            } else {
                [placeHolderTextView setPlaceholder:@"Type here…"];
            }
        }
        if ([textFields count]>indexPath.section) {
            [textFields replaceObjectAtIndex:indexPath.section withObject:placeHolderTextView];
        } else {
            [textFields addObject:placeHolderTextView];
        }
        self.keyboardControls.fields = textFields;
        
        cell.required = [[cellContent objectForKey:@"required"] boolValue];
        
        // Cell Rendering Performance
        // plus: in IB, all views are set to opaque
        cell.layer.shouldRasterize = YES;
        cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        return cell;

        
    } else if ([type isEqualToString:@"bool"]) {
//        NSLog(@"BoolCell return");
        
        CellIdentifier = @"boolCell";
        BoolCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        cell.segmentedControl = [[UISegmentedControl alloc] initWithItems:[cellContent objectForKey:@"values"]];
        cell.required = [[cellContent objectForKey:@"required"] boolValue];
        
        if ([cellContent objectForKey:@"result"]) {
            NSInteger value = [[cellContent objectForKey:@"result"] integerValue];
            cell.selectedValue = [NSNumber numberWithInt:value];
        }
        
        cell = [cell init];
        // Cell Rendering Performance
        // plus: in IB, all views are set to opaque
        cell.layer.shouldRasterize = YES;
        cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        return cell;

    } else if(([type isEqualToString:@"picker"])) {
        CellIdentifier = @"pickerCell";
        PickerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.values = [cellContent objectForKey:@"values"];
        cell.required = [[cellContent objectForKey:@"required"] boolValue];
        cell = [cell init];
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        return cell;
    }
    
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = [NSString stringWithFormat:@"%@ (%@)", [[questionnaire objectAtIndex:section] objectForKey:@"title"], [[[questionnaire objectAtIndex:section] objectForKey:@"required"] boolValue] ? @"required":@"optional"];
    return sectionName;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if([view isKindOfClass:[UITableViewHeaderFooterView class]]){
        UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeaderFooterView *) view;
        tableViewHeaderFooterView.textLabel.text = [tableViewHeaderFooterView.textLabel.text capitalizedString];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[[questionnaire objectAtIndex:indexPath.section] objectForKey:@"type"]  isEqual: @"picker"]) {
        NSLog(@"is picker");
        return 162.0f;
    }

    
    return 70.0f;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        //end of loading        
        [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:textFields]];
        [self.keyboardControls setDelegate:self];
    }
}

#pragma mark – BSKeyboardControl delegate methods

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [keyboardControls.activeField resignFirstResponder];
}

- (void)keyboardControls:(BSKeyboardControls *)keyboardControls selectedField:(UIView *)field inDirection:(BSKeyboardControlsDirection)direction
{
//    UIView *view = keyboardControls.activeField.superview.superview;
//    [self.questionnaireTableView scrollRectToVisible:view.frame animated:YES];
    [self.tableView scrollRectToVisible:((UIView *)field).superview.superview.frame animated:YES];
    [field becomeFirstResponder];
    
    if ([field isKindOfClass:[TextCell class]]) {
        
        TextCell *textField = (TextCell *)field;
        NSInteger sectionIndex = textField.path.section;
        
        if (direction == BSKeyboardControlsDirectionPrevious) {
            if (sectionIndex != 0) {
                NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:textField.path.section];
            }
        } else {

        }
        
//        [self.questionnaireTableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.keyboardControls setActiveField:textField];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.keyboardControls setActiveField:textView];
}

-(void)textFieldDidChange:(id)sender {
    NSLog(@"A textfield did change");
}

#pragma mark – save values and submit

- (IBAction)continueButtonTapped:(id)sender {
    
    BOOL validationSuccess = [self validateData];
    if (validationSuccess) {
        NSLog(@"validation passed");
        // get data
        NSMutableArray *questionnaireResults = [[NSMutableArray alloc] initWithCapacity:[self.tableView numberOfSections]];
        for (int section = 0; section < [self.tableView numberOfSections]; section++) {
            for (int row = 0; row < [self.tableView numberOfRowsInSection:section]; row++) {
                NSIndexPath* cellPath = [NSIndexPath indexPathForRow:row inSection:section];
                UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:cellPath];
                if ([cell isKindOfClass:[TextCell class]]) {
                    TextCell *textCell = (TextCell *)cell;
                    NSMutableDictionary *oneQuestion = [[NSMutableDictionary alloc] initWithDictionary:[questionnaire objectAtIndex:section]];
                    [oneQuestion setObject:textCell.textView.text forKey:@"result"];
                    [questionnaireResults addObject:oneQuestion];
                }
                if ([cell isKindOfClass:[BoolCell class]]) {
                    BoolCell *boolCell = (BoolCell *)cell;
                    NSMutableDictionary *oneQuestion = [[NSMutableDictionary alloc] initWithDictionary:[questionnaire objectAtIndex:section]];
                    [oneQuestion setObject:[NSString stringWithFormat:@"%ld", (long)[boolCell.selectedValue integerValue]] forKey:@"result"];
                    [questionnaireResults addObject:oneQuestion];
                }
            }
        }
        NSLog(@"Questionnaire Results: %@", [questionnaireResults description]);
        // TBD send results
        [self.experimentDetail setObject:questionnaireResults forKey:@"questionnaire"];
        [self uploadExperimentData:self.experimentDetail];
        
    } else {
        NSLog(@"validation failed");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Required Fields Missing!" message:@"Please fill in all required data." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

-(void) uploadExperimentData:(NSMutableDictionary *)data {
    NSLog(@"JSON DATA: %@", [data description]);
    UploadExperimentData *uploadTask = [[UploadExperimentData alloc] initWithData:data andURL:[NSURL URLWithString:kIMPuploadURL]];
    uploadTask.delegate = self;
    [uploadTask upload];
}



- (BOOL) validateData {
    BOOL flag = YES;
    for (int section = 0; section < [self.tableView numberOfSections]; section++) {
        for (int row = 0; row < [self.tableView numberOfRowsInSection:section]; row++) {
            NSIndexPath* cellPath = [NSIndexPath indexPathForRow:row inSection:section];
            UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:cellPath];
            //do stuff with 'cell'
            if ([cell isKindOfClass:[TextCell class]]) {
                NSLog(@"Validation: Cell is text cell");
                TextCell *textCell = (TextCell *)cell;
                if (textCell.required && [textCell.textView.text isEqualToString:@""]) {
                    flag=NO;
                }
            }
            if ([cell isKindOfClass:[BoolCell class]]) {
                NSLog(@"Validation: Cell is bool cell");
                BoolCell *boolCell = (BoolCell *)cell;
                if (boolCell.required && (!boolCell.selectedValue)) {
                    flag = NO;
                }
            }
        }
    }
    return flag;
}

-(void) hasUploadedData:(UploadExperimentData *)sender withStatus:(BOOL)success {
    NSLog(@"Upload finished. Status: %hhd", success);
    [self performSegueWithIdentifier:@"fromQuestionnaireToThankYouSegue" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"fromQuestionnaireToThankYouSegue"]) {
        
        ThankYouViewController *thankYou = (ThankYouViewController *)segue.destinationViewController;
        
        thankYou.textMessage = [self.experimentDetail objectForKey:@"thankyoutext"];
        thankYou.imageViewURL = [self.experimentDetail objectForKey:@"thankyouimage"];

    }

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
    
    [actionSheet showInView:self.view];
}

#pragma mark – Action Sheet Delegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:@"Cancel Experiment"]) {
        
        [self performSegueWithIdentifier:@"experimentCancelledFromQuestionnaire" sender:self];
        
    }
    
    if  ([buttonTitle isEqualToString:@"Continue"]) {
        
        
    }
    
}

@end
