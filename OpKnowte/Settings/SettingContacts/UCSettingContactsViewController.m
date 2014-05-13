//
//  UCSettingContactsViewController.m
//  MZUroCapture
//
//  Created by Omer on 5/7/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSettingContactsViewController.h"
#import "UCSettingsViewController.h"
#import "UCSelectContactsViewController.h"
#import "CONSTANTS.h"
@interface UCSettingContactsViewController ()

@end

@implementation UCSettingContactsViewController

@synthesize selectedVal, isSelected;

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
    // Do any additional setup after loading the view from its nib.
    if(IS_IPHONE_5)
    {
        headerLbl_.frame=CGRectMake(headerLbl_.frame.origin.x, headerLbl_.frame.origin.y+5, headerLbl_.frame.size.width, headerLbl_.frame.size.height);
    }
    [headerLbl_ setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if(self.isSelected)
    {
        //selectedContactTxt.text = [NSString stringWithFormat:@"    %@",selectedVal];
       // selectedContactLbl.text = @"";
    }
    
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

- (IBAction)selectContactsButtonPressed:(id)sender
{
    UCSelectContactsViewController * obj =[[UCSelectContactsViewController alloc]init];
    obj.prevPage = 2;
    [self.navigationController pushViewController:obj animated:YES];
}

- (IBAction)homeButtonPressed:(id)sender {
    if (DELEGATE.isComingFromSignUp) {
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

@end
