//
//  UCSelectCaseListViewController.m
//  MZUroCapture
//
//  Created by Omer on 5/9/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSelectCaseListViewController.h"
#import "UCSettingsViewController.h"
#import "CONSTANTS.h"
#import "UCSelectTimePointViewController.h"
#import "UCSettingReminderSettingsViewController.h"

@interface UCSelectCaseListViewController ()

@end

@implementation UCSelectCaseListViewController

@synthesize fromSettings, cases, isReminderSetting;
int counter=0;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.cases = [[NSMutableArray alloc] init];
        self.isReminderSetting = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [UCUtility showBlockView];
    
    if (self.fromSettings == YES) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [UCWebServerHandler getTemplate:[defaults objectForKey:UD_USERID] withProcedureID:[UCAppDelegate sharedObject].selectedProcedure.procedureID withDelegate:self];
        
    }else if (self.isReminderSetting){
        
        [UCWebServerHandler getCasesList:[UCAppDelegate sharedObject].selectedProcedure.procedureID withSergeonID:[defaults objectForKey:UD_USERID] withDelegate:self];
        
    }else{
        if([UCAppDelegate sharedObject].selectedUser!=nil)
        {
            [UCWebServerHandler getCasesList:[UCAppDelegate sharedObject].selectedProcedure.procedureID withSergeonID:[UCAppDelegate sharedObject].selectedUser.userID withDelegate:self];
        }
        else
        {
            [UCWebServerHandler getCasesList:[UCAppDelegate sharedObject].selectedProcedure.procedureID withSergeonID:[defaults objectForKey:UD_USERID] withDelegate:self];
        }
        
        
    }
    
    
    if(IS_IPHONE_5)
    {
        headerLbl_.frame=CGRectMake(headerLbl_.frame.origin.x, headerLbl_.frame.origin.y+5, headerLbl_.frame.size.width, headerLbl_.frame.size.height);
    }
    [headerLbl_ setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
}

- (void)CaseListSuccessHandler:(ASIHTTPRequest *)request {
    [UCUtility hideBlockView];
    NSString *response = [request responseString];
    NSLog(@"%@",response);
    
    NSArray *result = [response JSONValue];
    if ([result count] >0) {
        if (self.cases == nil) {
            self.cases = [[NSMutableArray alloc] init];
        }
        [self.cases removeAllObjects];
        self.cases = [result mutableCopy];
        [self sortCasesAccordingToDate];
        NSLog(@"%@",self.cases);
        counter = self.cases.count;
        [tableview reloadData];
    }
    else {
        
    }
    
    result = nil;
    response = nil;
}

-(void)sortCasesAccordingToDate{
    NSArray *newArray = [self.cases sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *c1, NSDictionary *c2)
    {
        NSString *date1 = [c1 objectForKey:@"DateOfService"];
        NSString *date2 = [c2 objectForKey:@"DateOfService"];
        NSDate *d1;
        NSDate *d2;
        NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
        [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
        d1 = [dateFormat1 dateFromString:date1];
        d2 = [dateFormat1 dateFromString:date2];
        return [d2 compare:d1];
    } ];
    
    self.cases = [newArray mutableCopy];
}

- (void)CaseListErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}




- (void)TemplateSuccessHandler:(ASIHTTPRequest *)request {
    [UCUtility hideBlockView];
    NSString *response = [request responseString];
    id result = [UCUtility getTemplateDetail:response];
    NSLog(@"%@",result);
    if (result) {
        NSDictionary *dic = [result objectAtIndex:0];
        //NSLog(@"%@",dic);
        if ([[dic objectForKey:@"success"] isEqualToString:@"true"]) {
            
        }
        else {
            [UCUtility showInfoAlertView:@"Error" withMessage:[result message]];
        }
    }else {
        
    }
    
    result = nil;
    response = nil;
}

- (void)TemplateErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)SettingsView:(id)sender
{
    UCSettingsViewController *setting = nil;
    //if(IS_IPHONE_5) {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController" bundle:nil];
    /*}
    else {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController_iphone" bundle:nil];
    }*/
    //UCSettingsViewController * setting =[[UCSettingsViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}

- (IBAction)homeButtonPressed:(id)sender {
    if ([UCAppDelegate sharedObject].isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cases count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"UCSelectCaseCell";
    cellIdentifier = [NSString stringWithFormat:@"%i",indexPath.row];
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
        if ([self.cases count] > 0) {
            if(indexPath.row == 0)
                counter = cases.count;
            NSDictionary *caseDic = [self.cases objectAtIndex:indexPath.row];
            if(fromSettings == YES)
            {
                cell.textLabel.text =[caseDic objectForKey:@"Patient_Name"];
            }
            else
            {
                cell.textLabel.text =[NSString stringWithFormat:@"%i. %@",counter,[caseDic objectForKey:@"Patient_Name"]];// [caseDic objectForKey:@"Patient_Name"];
            }
            
            cell.textLabel.textColor = [UIColor darkGrayColor];
            
            NSDateFormatter *formater = [[NSDateFormatter alloc] init];
            [formater setDateFormat:@"yyyy-MM-dd"];
            NSDate *d1 = [formater dateFromString:[[self.cases objectAtIndex:indexPath.row] objectForKey:@"DateOfService"]];
            [formater setDateFormat:@"MM-dd-yyyy"];
            NSString *str = [formater stringFromDate:d1];

            cell.detailTextLabel.text = str;
            cell.detailTextLabel.textColor = [UIColor orangeColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            counter--;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    int count = [self.navigationController.viewControllers count];
//    UCSettingInstitutionsViewController *cont = (UCSettingInstitutionsViewController *) [self.navigationController.viewControllers objectAtIndex:count-2];
//    cont.selectedVal = [cases objectAtIndex:indexPath.row];
//    cont.isSelected = YES;
    //[self.navigationController pushViewController:cont animated:YES];
//    [self.navigationController popToViewController:cont animated:YES];
    
    if (self.isReminderSetting) {
        UCSettingReminderSettingsViewController *obj = [[UCSettingReminderSettingsViewController alloc] initWithNibName:@"UCSettingReminderSettingsViewController" bundle:nil];
        obj.patientID = [[self.cases objectAtIndex:indexPath.row] objectForKey:@"DetailID"];
        NSLog(@"%@",[self.cases objectAtIndex:indexPath.row]);
        NSLog(@"%@",obj.patientID);
        [self.navigationController pushViewController:obj animated:YES];
    }else{
        
        UCSelectTimePointViewController *controller = [[UCSelectTimePointViewController alloc] initWithNibName:@"UCSelectTimePointViewController" bundle:nil];
        controller.caseData = [[self.cases objectAtIndex:indexPath.row] mutableCopy];
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
}




@end
