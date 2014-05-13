//
//  UCSelectContactsViewController.m
//  MZUroCapture
//
//  Created by Omer on 5/3/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSelectContactsViewController.h"
#import "UCSettingsViewController.h"
#import "UCContactsListViewController.h"
#import "UCAccessSettingViewController.h"
#import "UCSettingContactsViewController.h"
#import "UCAppDelegate.h"
#import "CONSTANTS.h"

@interface UCSelectContactsViewController ()

@end

@implementation UCSelectContactsViewController

@synthesize selectedVal, selectedCat, prevPage, selectedContacts;
@synthesize settingsBtn, homeBtn, updateAccessBtn;

UCAppDelegate *appDelegate;
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
    selectedContacts = [[NSMutableArray alloc]init];
    
    if(IS_IPHONE_5)
    {
        headerLbl_.frame=CGRectMake(headerLbl_.frame.origin.x, headerLbl_.frame.origin.y+5, headerLbl_.frame.size.width, headerLbl_.frame.size.height);
    }
    [headerLbl_ setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    
    if (self.prevPage == 1) {
        
        NSLog(@"Access Settings");
        [self.settingsBtn setHidden:YES];
        [self.homeBtn setHidden:YES];
        [self.updateAccessBtn setHidden:NO];
        
        [UCUtility showBlockView];
        [UCWebServerHandler getAccessSettings:[UCAppDelegate sharedObject].selectedProcedure.procedureID withDelegate:self];
        
    }else if(self.prevPage == 2)
    {
        headerLbl_.text = @"CONTACTS";
        othersLbl.text = @"Referring Physicians";
        
        [self.settingsBtn setHidden:YES];
        [self.homeBtn setHidden:YES];
        [self.updateAccessBtn setHidden:NO];
        
        [UCUtility showBlockView];
        [UCWebServerHandler getContactSettingsWithDelegate:self];
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    if(self.isSelected)
    {
        if(self.selectedCat == 1)
        {
            surgeonsTxt.text = [NSString stringWithFormat:@"    %@",selectedVal];
            surgeonsLbl.text =@"";
            assistantsTxt.text = @"";
            assistantsLbl.text = @"Assistants";
            if(prevPage == 2)
            {
                 othersLbl.text = @"Referring Physicians";  
            }
            else
            {
                 othersLbl.text = @"Others";
            }
            othersTxt.text = @"";
           
        }
        else if(self.selectedCat == 2)
        {
            assistantsTxt.text = [NSString stringWithFormat:@"    %@",selectedVal];
            assistantsLbl.text = @"";
            surgeonsTxt.text = @"";
            surgeonsLbl.text =@"Surgeons";
            if(prevPage == 2)
            {
                othersLbl.text = @"Referring Physicians";
            }
            else
            {
                othersLbl.text = @"Others";
            }
             othersTxt.text = @"";
        }
        else
        {
            othersTxt.text = [NSString stringWithFormat:@"    %@",selectedVal];
            othersLbl.text = @"";
            assistantsTxt.text = @"";
            assistantsLbl.text = @"Assistants";
            surgeonsTxt.text = @"";
            surgeonsLbl.text =@"Surgeons";
        }
        
    }
    
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

- (IBAction)homeButtonPressed:(id)sender {
    if ([UCAppDelegate sharedObject].isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}
- (IBAction)backButtonPressed:(id)sender {
    
    if(self.isSelected)
    {
        int count = [self.navigationController.viewControllers count];
        if(prevPage == 2)
        {
            UCSettingContactsViewController *cont = (UCSettingContactsViewController *) [self.navigationController.viewControllers objectAtIndex:count-2];
            cont.selectedVal = self.selectedVal;
            cont.isSelected = YES;
            //[self.navigationController pushViewController:cont animated:YES];
            [self.navigationController popToViewController:cont animated:YES];
        }
        else if(prevPage == 1)
        {
            UCAccessSettingViewController *cont = (UCAccessSettingViewController *) [self.navigationController.viewControllers objectAtIndex:count-2];
            cont.selectedVal = self.selectedVal;
            cont.isSelected = YES;
            //[self.navigationController pushViewController:cont animated:YES];
            [self.navigationController popToViewController:cont animated:YES];
        }
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (IBAction)surgeonsButtonPressed:(id)sender
{
    UCContactsListViewController * setting =nil;
    if(IS_IPHONE_5) {
        setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController" bundle:nil];
    }
    else {
        setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController_iPhone" bundle:nil];
    }

    setting.selectedCat = 1;
    setting.accessParent = self;
    setting.selectedList = [self.selectedContacts mutableCopy];
    //setting.prevPage = prevPage;
    [self.navigationController pushViewController:setting animated:YES];
   
}
- (IBAction)assistantsButtonPressed:(id)sender
{
    UCContactsListViewController * setting =nil;
    if(IS_IPHONE_5) {
        setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController" bundle:nil];
    }
    else {
        setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController_iPhone" bundle:nil];
    }
    setting.selectedCat = 2;
    setting.accessParent = self;
    setting.selectedList = [self.selectedContacts mutableCopy];
    //setting.prevPage = prevPage;
    [self.navigationController pushViewController:setting animated:YES];
   

}
- (IBAction)othersButtonPressed:(id)sender
{
    UCContactsListViewController * setting =nil;
    if(IS_IPHONE_5) {
        setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController" bundle:nil];
    }
    else {
        setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController_iPhone" bundle:nil];
    }

    if (self.prevPage == 2) {
        setting.selectedCat = 10;
    }else if (self.prevPage == 1){
        setting.selectedCat = 20;
    }
    
    setting.accessParent = self;
    setting.selectedList = [self.selectedContacts mutableCopy];
    //setting.prevPage = prevPage;
    [self.navigationController pushViewController:setting animated:YES];
}



-(IBAction)updateAccessSettings:(id)sender{
    
    [UCUtility showBlockView];
    
    if (self.prevPage == 1) {
        
        NSString *list = [[NSString alloc] init];
        
        for (int i = 0; i<self.selectedContacts.count; i++) {
            
            UCContactInfoModel *model = [self.selectedContacts objectAtIndex:i];
            list = [list stringByAppendingFormat:@"%@",model.contactEmail];
            
            if (i != self.selectedContacts.count-1) {
                list = [list stringByAppendingString:@","];
            }
        }
        
        NSLog(@"%@",list);
        
        [UCWebServerHandler updateAccessSettings:[UCAppDelegate sharedObject].selectedProcedure.procedureID withList:list withDelegate:self];
        
    }else if (self.prevPage == 2){
        
        NSString *list = [[NSString alloc] init];
        
        for (int i = 0; i<self.selectedContacts.count; i++) {
            
            UCContactInfoModel *model = [self.selectedContacts objectAtIndex:i];
            list = [list stringByAppendingFormat:@"%@",model.contactID];
            
            if (i != self.selectedContacts.count-1) {
                list = [list stringByAppendingString:@","];
            }
        }
        
        NSLog(@"%@",list);
        
        [UCWebServerHandler updateContactSettingsWithList:list withDelegate:self];
        
    }
    
    
}

- (void)UpdateAccessSettingsSuccessHandler:(ASIHTTPRequest *)request {
    [UCUtility hideBlockView];
    
    NSString *response = [request responseString];
    NSLog(@"%@",response);
    
    id result = [response JSONValue];
    
    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
        
        [UCUtility showInfoAlertView:@"" withMessage:[result objectForKey:@"msg"]];
    }
    else {
        [UCUtility showInfoAlertView:@"Error" withMessage:[result objectForKey:@"msg"]];
    }
    
    result = nil;
    response = nil;
}

- (void)UpdateAccessSettingsErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)AccessSettingsSuccessHandler:(ASIHTTPRequest *)request {
    [UCUtility hideBlockView];
    NSString *response = [request responseString];
    NSLog(@"%@",response);
    id result = [UCUtility getContactInfoList:response];
    if (result && [result count] > 0) {
        
        if (self.selectedContacts == nil) {
            self.selectedContacts = [[NSMutableArray alloc] init];
        }
        [self.selectedContacts removeAllObjects];
        
        self.selectedContacts = [result mutableCopy];
        
    }else{
        
    }
    
    response = nil;
}

- (void)AccessSettingsErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}


@end
