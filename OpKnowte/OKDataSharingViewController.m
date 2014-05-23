//
//  OKDataSharingViewController.m
//  OpKnowte
//
//  Created by Olegek on 02.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKDataSharingViewController.h"
#import "OKSelectProcedureViewController.h"

@interface OKDataSharingViewController ()

@property (strong, nonatomic) IBOutlet UISwitch *dataShareSwitch;
@property(strong,  nonatomic) NSString* isShare;

@end

@implementation OKDataSharingViewController
@synthesize dataShareSwitch;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    OKUserManager *usermanager = [OKUserManager instance];
    
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    
   [usermanager getDataSharingSettingsWithUserID:usermanager.currentUser.identifier andProcID:self.procID handler:^(NSString* error, id json){
       if ([[json objectForKey:@"isDataShared"] isEqualToString:@"yes"]) {
           [self.dataShareSwitch setOn:YES];
       }else if ([[json objectForKey:@"isDataShared"] isEqualToString:@"no"]){
           [self.dataShareSwitch setOn:NO];
       }else{
           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                             message:@"Please, try again"
                                                                            delegate:self
                                                                   cancelButtonTitle:@"OK"
                                                                   otherButtonTitles:nil, nil];
           [alertView show];
       }
       [[OKLoadingViewController instance] hide];
   }];
}


- (IBAction)swithButton:(id)sender
{
    UIAlertView *customAlertView = [[UIAlertView alloc] initWithTitle:@"Confirm"
                                                              message:@"Please confirm that you want to share your anonymous data."
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                                    otherButtonTitles:@"Share Data", nil];
    
    customAlertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [customAlertView textFieldAtIndex:0].placeholder = @"Password";
    [customAlertView show];

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[OKLoadingViewController instance] showWithText:@"Loading..."];

        OKUserManager *usermanager = [OKUserManager instance];
        if ([usermanager.currentUser.password isEqualToString:[alertView textFieldAtIndex:0].text]) {
            if (dataShareSwitch.on) {
                _isShare = @"yes";
            }else{
                _isShare = @"no";
            }
            [usermanager updateDataSharingSettingsWithProcID:self.procID userID:[OKUserManager instance].currentUser.identifier isSharing:_isShare handler:^(NSString* error){}];
            }else{
            [self.dataShareSwitch setOn:!dataShareSwitch.on];
            UIAlertView *loginFormErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Data Sharing Error"
                                                                              message:@"Password is invalid"
                                                                             delegate:self
                                                                    cancelButtonTitle:@"OK"
                                                                    otherButtonTitles:nil, nil];
            [loginFormErrorAlertView show];
            [self.dataShareSwitch setOn:!dataShareSwitch.on];
            [[OKLoadingViewController instance] hide];
        }
    }else{
        [self.dataShareSwitch setOn:!dataShareSwitch.on];
    }
}



- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
