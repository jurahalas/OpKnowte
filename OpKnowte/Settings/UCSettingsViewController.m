//
//  UCSettingsViewController.m
//  MZUroCapture
//
//  Created by Jawad ali on 4/26/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSettingsViewController.h"
#import "UCSettingselectProcedureViewController.h"
#import "UCSelectProcedureViewController.h"
#import "UCSelectContactsViewController.h"
#import "UCChangePaswordViewController.h"
#import "UCSettingInstitutionListViewController.h"

@interface UCSettingsViewController ()

@end

@implementation UCSettingsViewController

@synthesize scroller;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

-(IBAction)buttonPressed:(UIButton *)sender
{
    NSLog(@" ************** TAG :: %i",sender.tag);
    if(sender.tag == 4)
    {
        UCSelectContactsViewController * obj =[[UCSelectContactsViewController alloc]init];
        obj.prevPage = 2;
        [self.navigationController pushViewController:obj animated:YES];
        //        UCSettingContactsViewController *obj = [[UCSettingContactsViewController alloc] init];
//        [self.navigationController pushViewController:obj animated:YES];
        
    }else if (sender.tag == 7){
        
        UCChangePaswordViewController *controller = [[UCChangePaswordViewController alloc] initWithNibName:@"UCChangePaswordViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
        
    }else if (sender.tag == 5){
        
        UCSettingInstitutionsViewController *obj = [[UCSettingInstitutionsViewController alloc] init];
        [self.navigationController pushViewController:obj animated:YES];
        
    }else{
        
        UCSettingselectProcedureViewController * obj =[[UCSettingselectProcedureViewController alloc]init];
        obj.no_of_setting=sender.tag;
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    
    /*
     
     
     
     else if (sender.tag == 5){
     
     UCSettingInstitutionListViewController * obj =nil;
     if(IS_IPHONE_5) {
     obj = [[UCSettingInstitutionListViewController alloc] initWithNibName:@"UCSettingInstitutionListViewController" bundle:nil];
     }
     else {
     obj = [[UCSettingInstitutionListViewController alloc] initWithNibName:@"UCSettingInstitutionListViewController_iPhone" bundle:nil];
     }
     
     [self.navigationController pushViewController:obj animated:YES];
     
     }
     
     */
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.scroller setContentSize:CGSizeMake(320, 400)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
