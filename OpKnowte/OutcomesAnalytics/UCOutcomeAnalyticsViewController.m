//
//  UCOutcomeAnalyticsViewController.m
//  MZUroCapture
//
//  Created by Atif Joyia on 17/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCOutcomeAnalyticsViewController.h"
#import "UCSurgeonPerformanceFilter.h"
#import "UCSurgeonPerformanceViewController.h"
#import "UCSurgeonPerformanceCaseList.h"
#import "UCNationalPerformanceCaseList.h"
#import "UCSettingsViewController.h"
#import "UCHomeScreenViewController.h"
@interface UCOutcomeAnalyticsViewController ()

@end

@implementation UCOutcomeAnalyticsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (IS_IPHONE_5) {
        l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }else{
        float y = surgeonPerformance.frame.origin.y - 10;
        [surgeonPerformance setFrame:CGRectMake(surgeonPerformance.frame.origin.x, y, surgeonPerformance.frame.size.width, surgeonPerformance.frame.size.height)];
        
        y = surgeonPerformanceLbl.frame.origin.y - 10;
        [surgeonPerformanceLbl setFrame:CGRectMake(surgeonPerformanceLbl.frame.origin.x, y, surgeonPerformanceLbl.frame.size.width, surgeonPerformanceLbl.frame.size.height)];
        
        y = nationalPerformance.frame.origin.y - 10;
        [nationalPerformance setFrame:CGRectMake(nationalPerformance.frame.origin.x, y, nationalPerformance.frame.size.width, nationalPerformance.frame.size.height)];
        
        y = nationalPerformanceLbl.frame.origin.y - 10;
        [nationalPerformanceLbl setFrame:CGRectMake(nationalPerformanceLbl.frame.origin.x, y, nationalPerformanceLbl.frame.size.width, nationalPerformanceLbl.frame.size.height)];
        
        y = surgeonData.frame.origin.y - 10;
        [surgeonData setFrame:CGRectMake(surgeonData.frame.origin.x, y, surgeonData.frame.size.width, surgeonData.frame.size.height)];
        
        y = surgeonDataLbl.frame.origin.y - 10;
        [surgeonDataLbl setFrame:CGRectMake(surgeonDataLbl.frame.origin.x, y, surgeonDataLbl.frame.size.width, surgeonDataLbl.frame.size.height)];
        
    }
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
}


-(IBAction)SurgeonPerformanceData:(id)sender{
    
    UCSurgeonPerformanceViewController *controller = [[UCSurgeonPerformanceViewController alloc] initWithNibName:@"UCSurgeonPerformanceViewController" bundle:nil];
    //controller.parent = @"SurgeonPerformance";
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(IBAction)NationalDataComparison:(id)sender{
    
    UCNationalPerformanceCaseList *controller = [[UCNationalPerformanceCaseList alloc] initWithNibName:@"UCNationalPerformanceCaseList" bundle:nil];
    //controller.parent = @"NationalDataComparison";
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(IBAction)SurgeonLog:(id)sender{
    
    UCSurgeonPerformanceCaseList *controller = [[UCSurgeonPerformanceCaseList alloc] initWithNibName:@"UCSurgeonPerformanceCaseList" bundle:nil];
    controller.parent = @"SurgeonLog";
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)SettingsView:(id)sender {
    UCSettingsViewController *setting = nil;
    if(IS_IPHONE_5) {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController" bundle:nil];
    }
    else {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController_iphone" bundle:nil];
    }
    //UCSettingsViewController * setting =[[UCSettingsViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}

-(IBAction)home:(id)sender{
    if ([UCAppDelegate sharedObject].isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}

@end
