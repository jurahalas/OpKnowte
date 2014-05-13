//
//  UCSettingInstitutionListViewController.m
//  MZUroCapture
//
//  Created by Omer on 5/8/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSettingInstitutionListViewController.h"
#import "UCSettingsViewController.h"
#import "UCSettingInstitutionsViewController.h"
#import "UCAddNewInstitutionViewController.h"
#import "CONSTANTS.h"

#import "UCAssistantModel.h"

#import "OKContactManager.h"
#import "OKInstitutionManager.h"

@implementation UCSettingInstitutionListViewController

@synthesize isOpNote;
@synthesize backButton;
@synthesize settingButton;
@synthesize homeButton;
@synthesize fwdButton;
@synthesize parent;
@synthesize selectedInstitutes;
@synthesize listName;
@synthesize institutions;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.selectedInstitutes = [[NSMutableArray alloc] init];
        self.institutions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.institutions = [[NSMutableArray alloc] init];
    
    if(IS_IPHONE_5)
    {
        headerLbl_.frame=CGRectMake(headerLbl_.frame.origin.x, headerLbl_.frame.origin.y+5, headerLbl_.frame.size.width, headerLbl_.frame.size.height);
    }
    [headerLbl_ setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    
    
    if (isOpNote) {
        [self.fwdButton setHidden:NO];
        if(IS_IPHONE_5)
        {
            [self.backButton setFrame:CGRectMake(0, 500, 50, 44)];
            [self.settingButton setFrame:CGRectMake(90, 500, 50, 44)];
            [self.homeButton setFrame:CGRectMake(180, 500, 50, 44)];
            [self.fwdButton setFrame:CGRectMake(270, 500, 50, 44)];
            
        }else{
            
            [self.backButton setFrame:CGRectMake(0, 414, 50, 44)];
            [self.settingButton setFrame:CGRectMake(90, 414, 50, 44)];
            [self.homeButton setFrame:CGRectMake(180, 414, 50, 44)];
            [self.fwdButton setFrame:CGRectMake(270, 414, 50, 44)];
            
        }
    }else{
        [self.fwdButton setHidden:YES];
        if(IS_IPHONE_5)
        {
            [self.backButton setFrame:CGRectMake(0, 500, 50, 44)];
            [self.settingButton setFrame:CGRectMake(135, 500, 50, 44)];
            [self.homeButton setFrame:CGRectMake(260, 500, 50, 44)];
            [self.fwdButton setFrame:CGRectMake(0, 500, 50, 44)];
            
        }else{
            
            //[self.backButton setFrame:CGRectMake(0, 414, 50, 44)];
            //[self.settingButton setFrame:CGRectMake(135, 414, 50, 44)];
            //[self.homeButton setFrame:CGRectMake(260, 414, 50, 44)];
            //[self.fwdButton setFrame:CGRectMake(0, 414, 50, 44)];
            
        }
    }
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UCUtility showBlockView];
    [OKContactManager doContactRequestWithRoleID:ROLE_INSTITUTIONS_ID handler:^(NSString *errorMsg, id responseJSON) {
        if(!errorMsg)
            [self contactRequestSucceded:responseJSON];
        else{
            [UCUtility hideBlockView];
            [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
        }
    }];
    
    //[UCWebServerHandler getOtherContacts:[NSString stringWithFormat:@"0"] withDelegate:self];
}


- (void)contactRequestSucceded:(id)response {
//    [UCUtility hideBlockView];
    NSLog(@"CSH  ::   %@",response);
    id result = [UCUtility getContactInfoList:response];
    
    if ((result) && ([result count] > 0)) {
        self.institutions = [result mutableCopy];
        //[tableview reloadData];
        
        //[UCUtility showBlockView];
        [OKInstitutionManager getInstitutionSettings:@"" handler:^(NSString *errorMsg, id responseJSON) {
            if(!errorMsg)
               [self institutionsSettingsSucceded:responseJSON];
            else{
                [UCUtility hideBlockView];
                [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
            }
        }];
    }
    else {
        [UCUtility hideBlockView];
        [self.institutions removeAllObjects];
        [tableview reloadData];
    }
    
}


- (void)institutionsSettingsSucceded:(id)response {
    [UCUtility hideBlockView];
    //NSLog(@"%@",response);
    
    if (self.selectedInstitutes == nil) {
        self.selectedInstitutes = [[NSMutableArray alloc] init];
    }
    [self.selectedInstitutes removeAllObjects];
    
    self.selectedInstitutes = [UCUtility getContactInfoList:response];
    
    [tableview reloadData];
    
    response = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (DELEGATE.isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)fwdButtonPressed:(id)sender{
    
}


- (IBAction)removeButtonPressed:(id)sender
{
    if([tableview isEditing])
    {
        [tableview setEditing:NO animated:YES];
    }
    else
    {
        [tableview setEditing:YES animated:YES];
    }
    
}

- (IBAction)addButtonPressed:(id)sender
{
    UCAddNewInstitutionViewController *controller;
    if(IS_IPHONE_5)
    {
       controller = [[UCAddNewInstitutionViewController alloc] initWithNibName:@"UCAddNewInstitutionViewController_iPhone5" bundle:nil];
    }
    else
    {
        controller = [[UCAddNewInstitutionViewController alloc] initWithNibName:@"UCAddNewInstitutionViewController" bundle:nil];
    }
    controller.contactRoleID = ROLE_INSTITUTIONS_ID;
    controller.titleText = @"INSTITUTE";
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

-(void)cancelButtonPressed:(id)sender
{
   // [alertView dismissWithClickedButtonIndex:-1 animated:YES];
    [tableview setEditing:NO];
}

-(void)saveButtonPressed:(id)sender
{
    if([tableview isEditing])
    {
        //        [tableview beginUpdates];
        //[tableview insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:assistants.count inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];        [tableview endUpdates];
        [self.institutions addObject:nameField.text];
        [tableview reloadData];
        [tableview setEditing:NO];
        //[alertView dismissWithClickedButtonIndex:-1 animated:YES];
        
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
    //[alertView setFrame:CGRectMake(25, 100, 270, 200)];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
    if (alertView.tag == 102) {
        if (buttonIndex == 0) {
            
            [tableview setEditing:NO];
            
        }else if (buttonIndex == 1){
            
            UCAssistantModel *model = [[UCAssistantModel alloc] init];
            
            if([tableview isEditing])
            {
                for (UIView *tf in alertView.subviews) {
                    
                    NSString *str = [NSString stringWithFormat:@"%@",[tf class]];
                    if ([str isEqualToString:@"UITextField"]) {
                        [((UITextField *)tf) text];
                        
                        if ([((UITextField *)tf) tag] == 10) {
                            model.name = [((UITextField *)tf) text];
                        }
                        else if ([((UITextField *)tf) tag] == 11){
                            model.email = [((UITextField *)tf) text];
                        }
                        
                        
                    }
                }
            }
            
            
            NSLog(@"Name: %@ and Email: %@",model.name, model.email);
                [UCUtility showBlockView];
            [[OKContactManager instance]addContactWithName:model.name roleID:ROLE_INSTITUTIONS_ID email:model.email steetAddress:@"" city:@"" state:@"" zip:@"" country:@"" fax:@"" updatedBy:@"" handler:^(NSString *errorMsg,  id responseJSON) {
                
                [UCUtility hideBlockView];
                if(!errorMsg)
                   [self addContactSucceded:responseJSON];
                else
                    [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
            }];
        }
    }
}


-(IBAction)checkButtonPressed:(UIButton *)sender{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    UITableViewCell *cell = [tableview cellForRowAtIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        
        NSString *viewClass = [NSString stringWithFormat:@"%@",view.class];
        if ([viewClass isEqualToString:@"UIImageView"]) {
            UIImageView *imageView = (UIImageView *)view;
            if ([imageView.accessibilityIdentifier isEqualToString:@"proceduresUnCheck.png"]) {
                
                [imageView setImage:[UIImage imageNamed:@"proceduresCheck.png"]];
                [imageView setAccessibilityIdentifier:@"proceduresCheck.png"];
                [self.selectedInstitutes addObject:[self.institutions objectAtIndex:indexPath.row]];
                
            }else{
                
                [imageView setImage:[UIImage imageNamed:@"proceduresUnCheck.png"]];
                [imageView setAccessibilityIdentifier:@"proceduresUnCheck.png"];
                
                NSString *temp = [[self.institutions objectAtIndex:indexPath.row] contactID];
                
                for (int i = 0; i < self.selectedInstitutes.count; i++) {
                    UCContactInfoModel *model = [self.selectedInstitutes objectAtIndex:i];
                    
                    if ([temp isEqualToString:model.contactID]) {
                        [self.selectedInstitutes removeObjectAtIndex:i];
                        break;
                    }
                }
            }
            
            break;
        }
        
    }
}


-(IBAction)saveList:(id)sender{
    
    if (self.selectedInstitutes.count == 0) {
        
        [UCUtility showInfoAlertView:@"" withMessage:@"Please select atleast one institute to save."];
        
    }else{
        
        NSString *listID = [[NSString alloc] init];
        self.listName = @"";
        for (int i = 0; i < self.selectedInstitutes.count; i++) {
            
            UCContactInfoModel *model = [self.selectedInstitutes objectAtIndex:i];
            listID = [listID stringByAppendingFormat:@"%@",model.contactID];
            self.listName = [self.listName stringByAppendingFormat:@"%@",model.contactName];
            if (i != self.selectedInstitutes.count - 1) {
                listID = [listID stringByAppendingString:@","];
                self.listName = [self.listName stringByAppendingString:@", "];
            }
        }
        
        [UCUtility showBlockView];
        [OKInstitutionManager updateInstitutionList:self.parent.selectedProcedureID withInstitionsList:listID handler:^(NSString *errorMsg, id responseJSON) {
            [UCUtility hideBlockView];
            if(!errorMsg)
                [self UpdateInstituteSucceded:responseJSON];
            else
                [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
        }];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.institutions count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"UCSelectProcedureCell";
    cellIdentifier = [cellIdentifier stringByAppendingFormat:@"%i",indexPath.row];
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        UIImageView *checkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 14, 15)];
        
        [checkImageView setImage:[UIImage imageNamed:@"proceduresUnCheck.png"]];
        [checkImageView setAccessibilityIdentifier:@"proceduresUnCheck.png"];
        
        for (UCContactInfoModel *model in self.selectedInstitutes) {
            if ([model.contactID isEqualToString:[[self.institutions objectAtIndex:indexPath.row] contactID]]) {
                
                [checkImageView setImage:[UIImage imageNamed:@"proceduresCheck.png"]];
                [checkImageView setAccessibilityIdentifier:@"proceduresCheck.png"];
                break;
            }
        }
        
        [cell.contentView addSubview:checkImageView];
        
        UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkButton setFrame:CGRectMake(5, 7, 30, 30)];
        [checkButton setBackgroundColor:[UIColor clearColor]];
        [checkButton setTag:indexPath.row];
        [checkButton addTarget:self action:@selector(checkButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:checkButton];
        
        UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 2, 250, 20)];
        [nameLbl setBackgroundColor:[UIColor clearColor]];
        [nameLbl setText:[[self.institutions objectAtIndex:indexPath.row] contactName]];
        [nameLbl setTextColor:[UIColor darkGrayColor]];
        [cell.contentView addSubview:nameLbl];
        
        UILabel *emailLbl = [[UILabel alloc] initWithFrame:CGRectMake(42, 22, 248, 20)];
        [emailLbl setBackgroundColor:[UIColor clearColor]];
        [emailLbl setText:[[self.institutions objectAtIndex:indexPath.row] contactEmail]];
        [emailLbl setTextColor:[UIColor colorWithRed:227.0/255.0 green:92.0/255.0 blue:23.0/255.0 alpha:1.0]];
        [cell.contentView addSubview:emailLbl];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //UCAddNewInstitutionViewController
    UCAddNewInstitutionViewController *controller;
    if(IS_IPHONE_5)
    {
        controller = [[UCAddNewInstitutionViewController alloc] initWithNibName:@"UCAddNewInstitutionViewController_iPhone5" bundle:nil];
    }
    else
    {
        controller = [[UCAddNewInstitutionViewController alloc] initWithNibName:@"UCAddNewInstitutionViewController" bundle:nil];
    }
    controller.contactInfo = [self.institutions objectAtIndex:indexPath.row];
    controller.contactRoleID = ROLE_INSTITUTIONS_ID;
    controller.titleText = @"INSTITUTE";
    [self.navigationController pushViewController:controller animated:YES];
    
    /*
    int count = [self.navigationController.viewControllers count];
    UCSettingInstitutionsViewController *cont = (UCSettingInstitutionsViewController *) [self.navigationController.viewControllers objectAtIndex:count-2];
    cont.selectedVal = [[institutions objectAtIndex:indexPath.row] contactName];
    cont.isSelected = YES;
    //[self.navigationController pushViewController:cont animated:YES];
    [self.navigationController popToViewController:cont animated:YES];
     */
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [UCUtility showBlockView];
        [[OKContactManager instance] deleteContactWithContactID:[[self.institutions objectAtIndex:indexPath.row] contactID] handler:^(NSString *errorMsg, id responseJSON) {
            
            [UCUtility hideBlockView];
            if(!errorMsg)
                [self deleteContactSucceded:responseJSON];
            else
                [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
        }];
    }
}


- (void)addContactSucceded:(id)response {
    id result = response;
    //NSLog(@"%@",result);
    
    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
        [UCUtility showBlockView];
        
        if([tableview isEditing])
        {
            [tableview setEditing:NO animated:YES];
        }
        [OKContactManager doContactRequestWithRoleID:ROLE_INSTITUTIONS_ID handler:^(NSString *errorMsg, id responseJSON) {
            if(!errorMsg)
               [self contactRequestSucceded:responseJSON];
            else
                [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
        }];
        
       // [UCWebServerHandler getOtherContacts:[NSString stringWithFormat:@"0"] withDelegate:self];
    }
    else {
        [UCUtility showInfoAlertView:@"Error" withMessage:@"Not Saved, Try Again."];
    }
}


- (void)deleteContactSucceded:(id)response {

    id result = response;
    //NSLog(@"%@",result);
    
    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
        [UCUtility showBlockView];
        [tableview setEditing:NO animated:YES];
        [OKContactManager doContactRequestWithRoleID:ROLE_INSTITUTIONS_ID handler:^(NSString *errorMsg, id responseJSON) {
            if(!errorMsg)
                [self contactRequestSucceded:responseJSON];
            else
                [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
        }];
        //[UCWebServerHandler getOtherContacts:[NSString stringWithFormat:@"0"] withDelegate:self];
    }
    else {
        [UCUtility showInfoAlertView:@"Error" withMessage:@"Not removed, Try Again."];
    }
}


- (void)UpdateInstituteSucceded:(id)response {
    
    id result = response;
    
    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
        
        [UCUtility showInfoAlertView:@"" withMessage:[result objectForKey:@"msg"]];
        //self.parent.selectedInstituteTxt.text = [NSString stringWithFormat:@"    %@",listName];
        //self.parent.selectedInstituteLbl.text = @"";
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else {
        [UCUtility showInfoAlertView:@"Error" withMessage:[result objectForKey:@"msg"]];
    }
}

@end
