//
//  UCSettingDataSharingViewController.m
//  MZUroCapture
//
//  Created by Jawad ali on 4/27/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSettingDataSharingViewController.h"
#import "UCSettingsViewController.h"
#import "CONSTANTS.h"
#import "NSString+MD5.h"

#import "OKWebServerManager.h"
#import "OKProceduresManager.h"

@interface UCSettingDataSharingViewController ()

@end

@implementation UCSettingDataSharingViewController

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
        DataShareSwitch = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(230, 110,63 , 26)];
    }else{
        DataShareSwitch = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(230, 90,63 , 26)];
    }
    
    [self.view addSubview:DataShareSwitch];
    
    [UCUtility showBlockView];
    [OKWebServerManager getDataSharingSettings:[OKProceduresManager instance].selectedProcedure.procedureID handler:^(NSString *errorMsg, id responseJSON) {
        [UCUtility hideBlockView];
        if(!errorMsg)
            [self dataSharingSettingsSuccessHandler:responseJSON];
        else{
            [DataShareSwitch addTarget: self action: @selector(flipDataShare:) forControlEvents:UIControlEventValueChanged];
            [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
        }
    }];
}


- (void)dataSharingSettingsSuccessHandler:(id)response
{
    if ((response) && ([[response objectForKey:@"status"] isEqualToString:@"true"])) {
        
        if ([[response objectForKey:@"isDataShared"] isEqualToString:@"no"]) {
            [DataShareSwitch setOn:NO];
        }else{
            [DataShareSwitch setOn:YES];
        }
    }
    
    [DataShareSwitch addTarget: self action: @selector(flipDataShare:) forControlEvents:UIControlEventValueChanged];
}


-(void)flipDataShare:(UISwitch *)value
{
    shareDataPopup.frame=self.view.frame;
    [self.view addSubview:shareDataPopup];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (!IS_IPHONE_5) {
        [self animateTextField:textField up:NO];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (!IS_IPHONE_5) {
        [self animateTextField:textField up:YES];
    }
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    if (IS_IPHONE_5) {
        
        
    }else{
        
        const int movementDistance = 50; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        int movement = (up ? -movementDistance : movementDistance);
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
        
    }
}

-(IBAction)ShareButtonPress:(id)sender
{
    if(t_password.text.length<=0)
    {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter Your password First" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if ([[t_password.text MD5String] isEqualToString:[[defaults objectForKey:UD_PASSWORD] lowercaseString]]) {
            
            [UCUtility showBlockView];
            
            NSString *isSharing = DataShareSwitch.on?@"yes":@"no";
            
            [OKWebServerManager updateDataSharingSettings:[OKProceduresManager instance].selectedProcedure.procedureID isSharing:isSharing handler:^(NSString *errorMsg, id responseJSON) {
                [UCUtility hideBlockView];
                if(!errorMsg)
                   [self updateDataSharingSucceded:responseJSON];
                else{
                    t_password.text = @"";
                    [shareDataPopup removeFromSuperview];
                    [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
                }
            }];
            
        }else{
            [UCUtility showInfoAlertView:@"" withMessage:@"Incorrect password"];
        }
        //[UCUtility showBlockView];
        //[UCWebServerHandler confirmPasword:t_password.text withDelegate:self];
        
    }
}


- (IBAction)homeButtonPressed:(id)sender
{
    if (DELEGATE.isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}


- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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


- (void)ConfirmPaswordSuccessHandler:(id)response
{
    id result = response;
    
    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
        
        NSString *isSharing = DataShareSwitch.on?@"yes":@"no";

        [OKWebServerManager updateDataSharingSettings:[OKProceduresManager instance].selectedProcedure.procedureID isSharing:isSharing handler:^(NSString *errorMsg, id responseJSON) {
            
            [UCUtility hideBlockView];
            if(!errorMsg)
                [self updateDataSharingSucceded:responseJSON];
            else{
                t_password.text = @"";
                [shareDataPopup removeFromSuperview];
                [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
            }
        }];
    }
    else {
        [UCUtility hideBlockView];
        
        [UCUtility showInfoAlertView:@"Error" withMessage:[result objectForKey:@"msg"]];
        
        if (DataShareSwitch.on) {
            [DataShareSwitch setOn:NO];
        }else{
            [DataShareSwitch setOn:YES];
        }
        
        [shareDataPopup removeFromSuperview];
        
    }
    
    result = nil;
    response = nil;
}

//- (void)ConfirmPaswordErrorHandler:(ASIHTTPRequest *)request {
//    NSError *error = [request error];
//    [UCUtility hideBlockView];
//    [shareDataPopup removeFromSuperview];
//    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
//}


- (void)updateDataSharingSucceded:(id)response
{
    [shareDataPopup removeFromSuperview];

    if ([[response objectForKey:@"status"] isEqualToString:@"true"]) {
        
        [UCUtility showInfoAlertView:@"" withMessage:@"Data Sharing settings updated succefully"];
    }
    else {
        [UCUtility showInfoAlertView:@"Error" withMessage:[response objectForKey:@"msg"]];
    }
    
    t_password.text = @"";
}

@end
