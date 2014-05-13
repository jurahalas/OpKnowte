//
//  UCEditProcedureTemplateViewController.m
//  MZUroCapture
//
//  Created by Omer on 5/8/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCEditProcedureTemplateViewController.h"
#import "UCSettingsViewController.h"
#import "UCEditIndicationsViewController.h"
#import "UCEditProceduresViewController.h"
#import "UCEditCaseDataViewController.h"

@interface UCEditProcedureTemplateViewController ()

@end

@implementation UCEditProcedureTemplateViewController

@synthesize templateModel, templateVariables;

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

-(void)viewWillAppear:(BOOL)animated{

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
    
    [UCUtility showBlockView];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [UCWebServerHandler getTemplate:[defaults objectForKey:UD_USERID] withProcedureID:[UCAppDelegate sharedObject].selectedProcedure.procedureID withDelegate:self];
    
    [UCWebServerHandler getTemplateVariables:[[UCAppDelegate sharedObject].selectedProcedure procedureID] WithDelagate:self];
}


- (void)TemplateSuccessHandler:(ASIHTTPRequest *)request {
    [UCUtility hideBlockView];
    NSString *response = [request responseString];
    //NSLog(@"%@",response);
    self.templateModel = [UCUtility getTemplateDetail:response];
    if ([[self.templateModel status] isEqualToString:@"true"]) {
        
    }else {
        
    }
    
    response = nil;
}

- (void)TemplateErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    //[UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}

- (void)TemplateVariablesSuccessHandler:(ASIHTTPRequest *)request {
    //[UCUtility hideBlockView];
    NSString *response = [request responseString];
    self.templateVariables = [UCUtility getTemplateDetailVariables:response];
}

- (void)TemplateVariablesErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    //[UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
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

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)caseDataButtonPressed:(id)sender{
    NSLog(@"CASEDATA BUTTON: ");
        
    if ([[self.templateModel status] isEqualToString:@"true"]) {
        
        NSString *str = [self.templateModel caseData];
        str = [str stringByReplacingOccurrencesOfString:@"(" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@")" withString:@""];
        NSArray* tokens = [str componentsSeparatedByString: @","];
        
        UCEditCaseDataViewController *controller = [[UCEditCaseDataViewController alloc] initWithNibName:@"UCEditCaseDataViewController" bundle:nil];
        controller.parent = self;
        controller.caseDataArray = [tokens mutableCopy];
        [self.navigationController pushViewController:controller animated:YES];
        controller = nil;
        tokens = nil;
        str = nil;
    }
}

- (IBAction)indicationsButtonPressed:(id)sender{
    NSLog(@"INDICATION BUTTON: ");
    
    if ([[self.templateModel status] isEqualToString:@"true"]) {
        
        UCEditIndicationsViewController *controller = [[UCEditIndicationsViewController alloc] initWithNibName:@"UCEditIndicationsViewController" bundle:nil];
        controller.parent = self;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

- (IBAction)procedureButtonPressed:(id)sender{
    NSLog(@"PRCEDURES BUTTON: ");
    
    if ([[self.templateModel status] isEqualToString:@"true"]) {
        
        UCEditProceduresViewController *controller = [[UCEditProceduresViewController alloc] initWithNibName:@"UCEditProceduresViewController" bundle:nil];
        controller.parent = self;
        [self.navigationController pushViewController:controller animated:YES];
    }
}


- (IBAction)saveTemplate:(id)sender {
    [UCUtility showBlockView];
    [UCWebServerHandler updateTemplate:self.templateModel withDelegate:self];
}


- (void)UpdateTemplateSuccessHandler:(ASIHTTPRequest *)request {
    [UCUtility hideBlockView];
    NSString *response = [request responseString];
    NSLog(@"%@",response);
    id result = [response JSONValue];
    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
        
        [UCUtility showInfoAlertView:@"" withMessage:[result objectForKey:@"msg"]];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else {
        
    }
    
    result = nil;
    response = nil;
}

- (void)UpdateTemplateErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}


@end
