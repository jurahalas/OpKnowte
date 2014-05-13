//
//  UCSurgeonPerformanceViewController.m
//  MZUroCapture
//
//  Created by Omer on 6/28/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSurgeonPerformanceViewController.h"
#import "UCSurgeonPerformanceFilter.h"
#import "UCSurgeonPerformanceCaseList.h"
#import "UCSettingsViewController.h"
#import "UCHomeScreenViewController.h"
@interface UCSurgeonPerformanceViewController ()

@end

@implementation UCSurgeonPerformanceViewController

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
    
    if (IS_IPHONE_5) {
        l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }else{
        float y = immediatePostOp.frame.origin.y - 10;
        [immediatePostOp setFrame:CGRectMake(immediatePostOp.frame.origin.x, y, immediatePostOp.frame.size.width, immediatePostOp.frame.size.height)];
        
        y = immediatePostOpLbl.frame.origin.y - 10;
        [immediatePostOpLbl setFrame:CGRectMake(immediatePostOpLbl.frame.origin.x, y, immediatePostOpLbl.frame.size.width, immediatePostOpLbl.frame.size.height)];
        
        y = outcomeData.frame.origin.y - 10;
        [outcomeData setFrame:CGRectMake(outcomeData.frame.origin.x, y, outcomeData.frame.size.width, outcomeData.frame.size.height)];
        
        y = outcomeDataLbl.frame.origin.y - 10;
        [outcomeDataLbl setFrame:CGRectMake(outcomeDataLbl.frame.origin.x, y, outcomeDataLbl.frame.size.width, outcomeDataLbl.frame.size.height)];
        
    }
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)PostOpData:(id)sender{
    
    UCSurgeonPerformanceCaseList *controller = [[UCSurgeonPerformanceCaseList alloc] initWithNibName:@"UCSurgeonPerformanceCaseList" bundle:nil];
    controller.parent = @"SurgeonPostOpData";
    [self.navigationController pushViewController:controller animated:YES];
//    UCSurgeonPerformanceFilter *controller = [[UCSurgeonPerformanceFilter alloc] initWithNibName:@"UCSurgeonPerformanceFilter" bundle:nil];
//    controller.parent = @"SurgeonPostOpData";
//    [self.navigationController pushViewController:controller animated:YES];

}

-(IBAction)OutcomeDataSearch:(id)sender{
    
    UCSurgeonPerformanceCaseList *controller = [[UCSurgeonPerformanceCaseList alloc] initWithNibName:@"UCSurgeonPerformanceCaseList" bundle:nil];
    controller.parent = @"SurgeonPerformance";
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
