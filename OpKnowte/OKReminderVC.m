//
//  OKReminderVC.m
//  OpKnowte
//
//  Created by Apple on 12.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKReminderVC.h"
#import "OKSelectContactTypeVC.h"
#import "OKCaseManager.h"
@interface OKReminderVC ()<OKSelectContactTypeVCDelegate>

- (IBAction)updateButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *daysPicker;
@property (strong, nonatomic) IBOutlet OKCustomTextField *daysPickerTextField;
@property (strong, nonatomic) IBOutlet UIButton *updateSettings;
@property (strong, nonatomic) IBOutlet UIButton *sendReminderTo;
- (IBAction)sendReminderTapped:(id)sender;
@property (strong, nonatomic) NSArray *pickerData;
@property(strong, nonatomic) NSString *noOfDays;
@property (strong, nonatomic) NSMutableArray *choosedContacts;
@property (strong, nonatomic) IBOutlet UILabel *explanationTextLabel;

@end

@implementation OKReminderVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self design];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    _pickerData = [[NSArray alloc]init];
    _daysPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    _daysPicker.dataSource = self;
    _daysPicker.delegate = self;
    _daysPicker.hidden=NO;
    self.daysPickerTextField.inputView = _daysPicker;
    self.pickerData = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30"];
    [self getReminderSettings];
    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
}


-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width + 27, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
}

-(void)getReminderSettings
{
    [[OKLoadingViewController instance] showWithText:@"Loading..."];

    OKProceduresManager *procManager = [OKProceduresManager instance];
    [procManager getReminderSettingsWithUserID:[OKUserManager instance].currentUser.identifier andProcedureID:_procID handler:^(NSString *errorMsg, NSMutableArray *reminderSettings) {
        
        _noOfDays = [reminderSettings valueForKey:@"noOfDays"];
        if ([[self getAge:[reminderSettings valueForKey:@"noOfDays"]] intValue] > 0) {
            _daysPickerTextField.text=[NSString stringWithFormat:@"%@",[self getAge:[reminderSettings valueForKey:@"noOfDays"]]];
            _explanationTextLabel.text = [NSString stringWithFormat: @" An email will be sent to user or team member at %@ days after time point is reached", [self getAge:[reminderSettings valueForKey:@"noOfDays"]]];
           
        }else{
            _explanationTextLabel.text = [NSString stringWithFormat: @" An email will be sent to user or team member at x days after time point is reached"];
        }

        [[OKLoadingViewController instance] hide];

    }];
}

- (id)getAge:(NSString *)DOB{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSDate *start = [dateFormatter dateFromString:DOB];
    NSString *endStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *end = [dateFormatter dateFromString:endStr];
    
    NSDateComponents *diff = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:end toDate:start options:0];
    dateFormatter = nil;
    
    return [NSString stringWithFormat:@"%i",[diff day]];
}

#pragma mark - Text Fields methods


-(void)design
{
    [_daysPickerTextField setBackgroundColor:[UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:.10]];
    _daysPickerTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Days" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    _updateSettings.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    [_updateSettings setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    _updateSettings.layer.cornerRadius = 14;
    _sendReminderTo.layer.borderColor =[UIColor whiteColor].CGColor;
    _sendReminderTo.layer.borderWidth = 1.f;
    _sendReminderTo.layer.cornerRadius = 14;
    
}

#pragma mark - Picker View

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}


-(NSAttributedString*) pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSAttributedString *pickerAttributedString = [[NSAttributedString alloc] init];
    NSString *pickerString = [NSString stringWithFormat:@"%@", [_pickerData objectAtIndex:row]];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
            pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    }else{
        pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
            _daysPicker.backgroundColor = [[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]] colorWithAlphaComponent:0.9];
    }

    return pickerAttributedString;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.daysPickerTextField.text = self.pickerData[row];
    [self.daysPickerTextField resignFirstResponder];
}

#pragma mark - IBAction

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)updateButton:(id)sender
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *contactIDs = [[NSString alloc] init];
    
    for (int i=0; i<_choosedContacts.count; i++) {
        OKContactModel *cont = (OKContactModel*)_choosedContacts[i];
        [array addObject:cont.identifier];
        contactIDs = [array componentsJoinedByString:@","];
    }
    _noOfDays = self.daysPickerTextField.text;
    
    
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    if ([_noOfDays isEqualToString:@""]) {
        UIAlertView *loginFormErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Update Setting Error"
                                                                          message:@"Please, set number of days"
                                                                         delegate:self
                                                                cancelButtonTitle:@"OK"
                                                                otherButtonTitles:nil, nil];
        [loginFormErrorAlertView show];
        [[OKLoadingViewController instance] hide];
    }else if ([contactIDs isEqualToString:@""]){
        UIAlertView *loginFormErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Update Setting Error"
                                                                          message:@"Please, choose at least one contact"
                                                                         delegate:self
                                                                cancelButtonTitle:@"OK"
                                                                otherButtonTitles:nil, nil];
        [loginFormErrorAlertView show];
        [[OKLoadingViewController instance] hide];
    }else{
        OKProceduresManager *procManager = [OKProceduresManager instance];
        [procManager updateReminderSettingsWithProcedureID:_procID patientID:@"1" userID:[OKUserManager instance].currentUser.identifier days:_noOfDays andList:contactIDs handler:^(NSString *errorMsg, NSDictionary *json) {
            if (errorMsg) {
                UIAlertView *loginFormErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Update Setting Error"
                                                                                  message:errorMsg
                                                                                 delegate:self
                                                                        cancelButtonTitle:@"OK"
                                                                        otherButtonTitles:nil, nil];
                [loginFormErrorAlertView show];
                [[OKLoadingViewController instance] hide];
            }else{
                UIAlertView *loginFormErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Update Setting Success"
                                                                                  message:[json valueForKey:@"msg"]
                                                                                 delegate:self
                                                                        cancelButtonTitle:@"OK"
                                                                        otherButtonTitles:nil];
                [loginFormErrorAlertView show];
                [[OKLoadingViewController instance] hide];
            }
        }];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)setChoosedContactsArray:(NSMutableArray *)contactsArray{
    _choosedContacts = contactsArray;
}

- (IBAction)sendReminderTapped:(id)sender
{
    [self performSegueWithIdentifier:@"fromReminderToSelectType" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fromReminderToSelectType"]){
        OKSelectContactTypeVC *instVC = (OKSelectContactTypeVC*)segue.destinationViewController;
        instVC.delegate = self;
    }
    
}

@end