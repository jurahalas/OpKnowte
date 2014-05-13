//
//  UCSettingselectProcedureViewController.m
//  MZUroCapture
//
//  Created by Jawad ali on 4/27/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSettingselectProcedureViewController.h"
#import "UCSelectProcedureViewController.h"
#import "CONSTANTS.h"

@interface UCSettingselectProcedureViewController ()

@end

@implementation UCSettingselectProcedureViewController
@synthesize l_Header , no_of_setting;
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
    UCSelectProcedureViewController *selectProcedure = nil;
    if(IS_IPHONE_5) {
        selectProcedure = [[UCSelectProcedureViewController alloc] initWithNibName:@"UCSelectProcedureViewController" bundle:nil];
    }
    else {
        selectProcedure = [[UCSelectProcedureViewController alloc] initWithNibName:@"UCSelectProcedureViewController_iPhone" bundle:nil];
    }
    
    selectProcedure.no_of_setting=no_of_setting;
    selectProcedure.fromSettings=TRUE;
    
    [self.navigationController pushViewController:selectProcedure animated:YES];
    selectProcedure = nil;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    switch (no_of_setting) {
        case 1:
            l_Header.text=@"DATA SHARING";
            
            
            break;
        case 2:
            l_Header.text=@"REMINDER SETTINGS";
            
            
            break;
        case 3:
            l_Header.text=@"ACCESS SETTINGS";
            NSLog(@"********* after setting header label");
            
            break;
        case 4:
            l_Header.text=@"CONTACTS";
            
            
            break;
        case 5:
            l_Header.text=@"INSTITUTION";
            
            
            break;
            
            
            
            
        default:
            break;
    }
    if(IS_IPHONE_5)
    {
        l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];

}
-(void)viewWillAppear:(BOOL)animated
{
     //[l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:23]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
