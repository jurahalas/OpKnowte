//
//  UCSettingReminderToViewController.m
//  MZUroCapture
//
//  Created by Omer on 5/2/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSettingReminderToViewController.h"
#import "CONSTANTS.h"
#import "UCSettingsViewController.h"
#import "UCContactsListViewController.h"

@interface UCSettingReminderToViewController ()

@end

@implementation UCSettingReminderToViewController

@synthesize reminderParent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(IS_IPHONE_5)
    {
        headerLbl_.frame=CGRectMake(headerLbl_.frame.origin.x, headerLbl_.frame.origin.y+5, headerLbl_.frame.size.width, headerLbl_.frame.size.height);
    }
    [headerLbl_ setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
}

-(IBAction)selectSurgeons:(id)sender{
    
    UCContactsListViewController * setting =nil;
    if(IS_IPHONE_5) {
        setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController" bundle:nil];
    }
    else {
        setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController_iPhone" bundle:nil];
    }
    
    setting.selectedCat = 1;
    setting.reminderParent = self.reminderParent;
    setting.selectedList = self.reminderParent.reminderContacts;
    
    [self.navigationController pushViewController:setting animated:YES];
    
}

-(IBAction)selectOthers:(id)sender{
    
    UCContactsListViewController * setting =nil;
    if(IS_IPHONE_5) {
        setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController" bundle:nil];
    }
    else {
        setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController_iPhone" bundle:nil];
    }
    
    setting.selectedCat = 20;
    setting.reminderParent = self.reminderParent;
    setting.selectedList = self.reminderParent.reminderContacts;
    
    [self.navigationController pushViewController:setting animated:YES];
    
}

@end
