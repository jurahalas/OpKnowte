//
//  UCDataCaptureViewController.m
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/13/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCDataCaptureViewController.h"
#import "UCSettingsViewController.h"
#import "UCSelectProcedureViewController.h"
#import "CONSTANTS.h"

@interface UCDataCaptureViewController ()

@end

@implementation UCDataCaptureViewController

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeButtonPressed:(id)sender {
    if (DELEGATE.isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}


- (IBAction)ongoingClinicalPressed:(id)sender {
    UCSelectProcedureViewController *selectProcedure = nil;
    
    if(IS_IPHONE_5) {
        selectProcedure = [[UCSelectProcedureViewController alloc] initWithNibName:@"UCSelectProcedureViewController" bundle:nil];
    }
    else {
        selectProcedure = [[UCSelectProcedureViewController alloc] initWithNibName:@"UCSelectProcedureViewController_iPhone" bundle:nil];
    }
    
    selectProcedure.home = self;
    selectProcedure.fromOngoingClinical = YES;
    [self.navigationController pushViewController:selectProcedure animated:NO];
    selectProcedure = nil;

}

- (IBAction)immediateBtnPressed:(id)sender {
    UCSelectProcedureViewController *selectProcedure = nil;
    if(IS_IPHONE_5)
    {
        selectProcedure = [[UCSelectProcedureViewController alloc] initWithNibName:@"UCSelectProcedureViewController" bundle:nil];
    }
    else
    {
        selectProcedure = [[UCSelectProcedureViewController alloc] initWithNibName:@"UCSelectProcedureViewController_iPhone" bundle:nil];
        
    }
    selectProcedure.home = self;
    [self.navigationController pushViewController:selectProcedure animated:NO];
    selectProcedure = nil;
    
}

- (IBAction)backBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
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
@end
