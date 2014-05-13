//
//  UCHomeScreenViewController.m
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/5/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCHomeScreenViewController.h"
#import "UCDataCaptureViewController.h"
#import "CONSTANTS.h"
#import "BusinessClass.h"
#import "UCSettingsViewController.h"
#import "UCSelectProcedureViewController.h"
#import "UCOutcomeAnalyticsViewController.h"

@interface UCHomeScreenViewController ()

@end

@implementation UCHomeScreenViewController

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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL check = [defaults boolForKey:UD_INTRO_KEY];
    if (!check) {
        [self displayIntroductionScreen:NO];
    }
    else {
        [self displayIntroductionScreen:[defaults boolForKey:UD_INTRO_KEY]];
    }
}

- (void)didReceiveMemoryWarning
{
    introView_ = nil;
    homeView = nil;
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayIntroductionScreen:(BOOL)isIntroScreenShown {
    
    if(isIntroScreenShown) {
        homeView.hidden = FALSE;
        introView_.hidden = TRUE;
    }
    else {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:UD_INTRO_KEY];
        [defaults synchronize];
        
        homeView.hidden = TRUE;
        introView_.hidden = FALSE;
    }
}

- (IBAction)introductionButtonPressed:(id)sender {
    [self displayIntroductionScreen:NO];
}

- (IBAction)dataCollectionButtonPressed:(id)sender {
    UCDataCaptureViewController *selectProcedure;
    if(IS_IPHONE_5) {
        selectProcedure = [[UCDataCaptureViewController alloc] initWithNibName:@"UCDataCaptureViewController_iphone5" bundle:nil];
    }
    else {
        selectProcedure = [[UCDataCaptureViewController alloc] initWithNibName:@"UCDataCaptureViewController" bundle:nil];
    }
    
    [self.navigationController pushViewController:selectProcedure animated:NO];
    selectProcedure = nil;
}

- (IBAction)analyticsButtonPressed:(id)sender {
    NSLog(@"Analytics Button :p");
    
    UCOutcomeAnalyticsViewController *controller = [[UCOutcomeAnalyticsViewController alloc] initWithNibName:@"UCOutcomeAnalyticsViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)onGoingClinical:(id)sender {
    NSLog(@"On Going Clinical Button :p");
    
    UCSelectProcedureViewController *selectProcedure = nil;
    
    if(IS_IPHONE_5) {
        selectProcedure = [[UCSelectProcedureViewController alloc] initWithNibName:@"UCSelectProcedureViewController" bundle:nil];
    }
    else {
        selectProcedure = [[UCSelectProcedureViewController alloc] initWithNibName:@"UCSelectProcedureViewController_iPhone" bundle:nil];
    }
    
    //selectProcedure.home = self;
    selectProcedure.fromOngoingClinical = YES;
    [self.navigationController pushViewController:selectProcedure animated:NO];
    selectProcedure = nil;
    
}


- (IBAction)settingsButtonPressed:(id)sender {
}  

- (IBAction)skipIntroPressed:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:UD_INTRO_KEY];
    [defaults synchronize];
    introView_.hidden = TRUE;
    homeView.hidden = FALSE;
}

- (IBAction)logOff:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
}

-(IBAction)SettingsView:(id)sender {
    UCSettingsViewController *setting = nil;
    //if(IS_IPHONE_5) {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController" bundle:nil];
    //}
    //else {
      //  setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController_iphone" bundle:nil];
    //}
    
    [self.navigationController pushViewController:setting animated:YES];
    setting = nil;
}

@end

