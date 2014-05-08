//
//  OKDataSharingViewController.m
//  OpKnowte
//
//  Created by Olegek on 02.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKDataSharingViewController.h"

@interface OKDataSharingViewController ()
@property (strong, nonatomic) IBOutlet UISwitch *dataShareSwitch;

@end

@implementation OKDataSharingViewController
@synthesize dataShareSwitch;

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
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    
    //[self.dataShareSwitch setOn:YES];
}
- (IBAction)swithButton:(id)sender {
    
    if (dataShareSwitch.on){
        UIAlertView *customAlertView = [[UIAlertView alloc] initWithTitle:@"Confirm"
                                                              message:@"Please confirm that you want to share your anonymous data."
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                                    otherButtonTitles:@"Share Data", nil];
    
        customAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [customAlertView textFieldAtIndex:0].placeholder = @"Password";
        [customAlertView show];
   }
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
