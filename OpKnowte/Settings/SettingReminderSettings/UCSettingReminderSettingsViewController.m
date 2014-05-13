//
//  UCSettingReminderSettingsViewController.m
//  MZUroCapture
//
//  Created by Omer on 4/30/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSettingReminderSettingsViewController.h"
#import "UCSettingsViewController.h"
#import "UCSettingReminderToViewController.h"

#import "OKReminderManager.h"
#import "OKProceduresManager.h"

@interface UCSettingReminderSettingsViewController ()

@end

@implementation UCSettingReminderSettingsViewController

@synthesize reminderContacts, patientID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.reminderContacts = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    daysAray = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
    
    if(IS_IPHONE_5)
    {
        headerLbl_.frame=CGRectMake(headerLbl_.frame.origin.x, headerLbl_.frame.origin.y+5, headerLbl_.frame.size.width, headerLbl_.frame.size.height);
    }
    [headerLbl_ setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    
    
    [UCUtility showBlockView];
    [OKReminderManager getReminderSettings:[OKProceduresManager instance].selectedProcedure.procedureID handler:^(NSString *errorMsg, id responseJSON) {
        [UCUtility hideBlockView];
        
        if(!errorMsg)
            [self reminderSettingsSucceded:responseJSON];
        else
            [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
    }];
    
}


- (void)reminderSettingsSucceded:(id)result {

    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
        
        NSLog(@"%@",[result objectForKey:@"noOfDays"]);
        
        if ([[self getAge:[result objectForKey:@"noOfDays"]] intValue] > 0) {
            daysLbl_.hidden=YES;
            dayTxt_.text=[NSString stringWithFormat:@"    %@",[self getAge:[result objectForKey:@"noOfDays"]]];
        }
        
        if (self.reminderContacts == nil) {
            self.reminderContacts = [[NSMutableArray alloc] init];
        }
        [self.reminderContacts removeAllObjects];
        
        NSArray *arr = [result objectForKey:@"contacts"];
        
        for (NSDictionary *dict in arr) {
            UCContactInfoModel *contactInfo = [[UCContactInfoModel alloc]init];
            contactInfo.contactID = [dict objectForKey:@"contactID"];
            contactInfo.contactName = [dict objectForKey:@"name"];
            contactInfo.contactEmail = [dict objectForKey:@"emailAddress"];
            contactInfo.contactNumber = [dict objectForKey:@"ContactNo"];
            contactInfo.contactStreetAddress = [dict objectForKey:@"streetAddress"];
            contactInfo.contactCity = [dict objectForKey:@"city"];
            contactInfo.contactState = [dict objectForKey:@"state"];
            contactInfo.contactZip = [dict objectForKey:@"zip"];
            contactInfo.contactCountry = [dict objectForKey:@"country"];
            contactInfo.contactFax = [dict objectForKey:@"fax"];
            contactInfo.contactRoleID = [dict objectForKey:@"roleID"];
            
            [self.reminderContacts addObject:contactInfo];
        }
        
        
    }else{
        
    }
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


- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)reminderToButtonPressed:(id)sender
{
    picker_.hidden = YES;
     UCSettingReminderToViewController *reminder = [[UCSettingReminderToViewController alloc] initWithNibName:@"UCSettingReminderToViewController" bundle:nil];
    reminder.reminderParent = self;
    [self.navigationController pushViewController:reminder animated:YES];
    
}

- (IBAction)daysButtonPressed:(id)sender
{
    picker_.hidden = NO;
    t_toolbar.hidden= NO;
    daysLbl_.hidden=YES;
   // picker_.tag=22;
    [picker_ reloadAllComponents];
    if(dayTxt_.text.length==0)
    {
        dayTxt_.text =[NSString stringWithFormat:@"    %@",[daysAray objectAtIndex:0]];
    }else{
        [picker_ selectRow:[dayTxt_.text intValue]-1 inComponent:0 animated:NO];
    }
    
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    daysLbl_.hidden = YES;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return  CGRectMake(20, 91, 301, 49);
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.text.length < 1)
    {
        daysLbl_.hidden = NO;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [daysAray count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSLog(@"tagg:%i",picker_.tag);

        return   [daysAray objectAtIndex:row];

}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

- (IBAction)donePressed:(id)sender {
    
    picker_.hidden = YES;
    t_toolbar.hidden= YES;
    
    int row = [picker_ selectedRowInComponent:0];
    dayTxt_.text=[NSString stringWithFormat:@"    %@",[daysAray objectAtIndex:row]];
}


-(IBAction)updateSetting:(id)sender{
    
    if (dayTxt_.text.length == 0) {
        [UCUtility showInfoAlertView:@"Error" withMessage:@"Please select days to remind"];
    }else if (self.reminderContacts.count == 0){
        [UCUtility showInfoAlertView:@"Error" withMessage:@"Please select contacts to remind"];
    }else{
        
        [UCUtility showBlockView];
        
        NSString *list = [[NSString alloc] init];
        
        for (int i = 0; i<self.reminderContacts.count; i++) {
            
            UCContactInfoModel *model = [self.reminderContacts objectAtIndex:i];
            list = [list stringByAppendingFormat:@"%@",model.contactID];
            
            if (i != self.reminderContacts.count-1) {
                list = [list stringByAppendingString:@","];
            }
        }
        NSLog(@"%@",list);
        NSLog(@"%@",self.patientID);
        
        [OKReminderManager updateReminderSettingsWithProcedure:[OKProceduresManager instance].selectedProcedure.procedureID withPatientID:self.patientID days:dayTxt_.text withList:list handler:^(NSString *errorMsg, id responseJSON) {

            [UCUtility hideBlockView];
            
            if(!errorMsg)
                [UCUtility showInfoAlertView:@"" withMessage:[responseJSON objectForKey:@"msg"]];
            else
                [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
        }];
    }
}

@end
