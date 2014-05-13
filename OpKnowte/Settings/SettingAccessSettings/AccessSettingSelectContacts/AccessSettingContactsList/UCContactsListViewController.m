//
//  UCContactsListViewController.m
//  MZUroCapture
//
//  Created by Omer on 5/3/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCContactsListViewController.h"
#import "UCSettingsViewController.h"
#import "CONSTANTS.h"
#import "UCSelectContactsViewController.h"
#import "UCLRPNPageThreeViewController.h"
#import "UCLRPNSevenViewController.h"
#import "UCAppDelegate.h"
#import "UCAddNewInstitutionViewController.h"

@interface UCContactsListViewController ()

@end

@implementation UCContactsListViewController

@synthesize selectedCat;
@synthesize assistants;
@synthesize parent;
@synthesize accessParent;
@synthesize selectedList;
@synthesize reminderParent;

UCAppDelegate *appDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.selectedList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(IS_IPHONE_5) {
        headerLbl_.frame=CGRectMake(headerLbl_.frame.origin.x, headerLbl_.frame.origin.y+5, headerLbl_.frame.size.width, headerLbl_.frame.size.height);
    }
    [headerLbl_ setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
}

-(void)viewWillAppear:(BOOL)animated{
    
    if (self.selectedCat == 5) {
        [UCUtility showBlockView];
        [UCWebServerHandler doContactRequestWithRoleID:ROLE_ANESTHESIOLOGIST_ID withDelegate:self];
        
    }
    else if(self.selectedCat == 1)
    {
        [UCUtility showBlockView];
        [UCWebServerHandler doContactRequestWithRoleID:ROLE_SURGEON_ID withDelegate:self];
        
    }
    else if (self.selectedCat == 2){
        
        [UCUtility showBlockView];
        [UCWebServerHandler doContactRequestWithRoleID:ROLE_ASSISTANT_ID withDelegate:self];
        
    }
    else if(self.selectedCat == 8 || self.selectedCat == 20){
        
        [UCUtility showBlockView];
        [UCWebServerHandler doContactRequestWithRoleID:ROLE_OTHERS_ID withDelegate:self];
        
    }else if (self.selectedCat == 10){
        
        [UCUtility showBlockView];
        [UCWebServerHandler doContactRequestWithRoleID:ROLE_PHYSICIAN_ID withDelegate:self];
        
    }else if (self.selectedCat == 15){
        
        [UCUtility showBlockView];
        [UCWebServerHandler doContactRequestWithRoleID:ROLE_INSTITUTIONS_ID withDelegate:self];
        
    }else if (self.selectedCat == 21){
        
        [UCUtility showBlockView];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [UCWebServerHandler getOtherContacts:[defaults objectForKey:UD_USERID] withDelegate:self];
        
    }
    
}


- (void)ContactSuccessHandler:(ASIHTTPRequest *)request {
    [UCUtility hideBlockView];
    NSString *response = [request responseString];
    NSLog(@"%@",response);
   
    id result = [UCUtility getContactInfoList:response];
    if ((result) && ([result count] > 0)) {
        
        if (self.assistants == nil) {
            self.assistants = [[NSMutableArray alloc] init];
        }
        [self.assistants removeAllObjects];
        self.assistants = [result mutableCopy];
        [tableview reloadData];
    }
    else {
        
        [self.assistants removeAllObjects];
        [tableview reloadData];
    }
    
    result = nil;
    response = nil;
}

- (void)ContactErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)SettingsView:(id)sender
{
    UCSettingsViewController *setting = nil;
    
    setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController" bundle:nil];
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
    
    int count = [self.navigationController.viewControllers count];
    NSString *controller = [NSString stringWithFormat:@"%@",[[self.navigationController.viewControllers objectAtIndex:count-2] class]];
    
    NSLog(@"%@",controller);
    
    if([controller isEqualToString:@"UCSettingReminderToViewController"]){
        
        
    }else if (self.accessParent) {
        
        [self.accessParent.selectedContacts removeAllObjects];
        
        NSLog(@"%i",self.selectedList.count);
        
        if (self.accessParent.selectedContacts == nil) {
            self.accessParent.selectedContacts = [[NSMutableArray alloc] init];
        }
        
        self.accessParent.selectedContacts = [self.selectedList mutableCopy];
         NSLog(@"%i",self.accessParent.selectedContacts.count);
        
    }else if(self.selectedCat == 21){
        int count = [self.navigationController.viewControllers count];
        UCLRPNSevenViewController *vcontroller = (UCLRPNSevenViewController *)[self.navigationController.viewControllers objectAtIndex:count-2];
        [vcontroller.selectedContacts removeAllObjects];
        if(vcontroller.selectedContacts == nil)
        {
            vcontroller.selectedContacts = [[NSMutableArray alloc] init];
        }
        vcontroller.selectedContacts = [self.selectedList mutableCopy];
        NSLog(@"%i",self.selectedList.count);
        if(self.selectedList.count > 0)
        {
            NSMutableString *str = [[NSMutableString alloc] init];
            for(int i=0;i<self.selectedList.count;i++)
            {
                UCContactInfoModel *model = (UCContactInfoModel *)[self.selectedList objectAtIndex:i];
                [str appendString:model.contactName];
                if(i != self.selectedList.count-1)
                {
                    [str appendFormat:@","];
                }
                NSLog(@" ^^^^^ CONTACT EMAIL :: %@",model.contactEmail);
            }
            [vcontroller.ccTxt_ setText:str];
            [vcontroller.ccLbl_ setHidden:YES];
        }else{
            [vcontroller.ccTxt_ setText:@""];
            [vcontroller.ccLbl_ setHidden:NO];
        }
    }
        
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)removeButtonPressed:(id)sender
{
    
    NSLog(@"%i",self.selectedCat);
    
    if (self.selectedCat != 8) {
        
        if([tableview isEditing])
        {
            [tableview setEditing:NO animated:YES];
        }
        else
        {
            [tableview setEditing:YES animated:YES];
        }
        
    }
    
    
}

- (IBAction)addButtonPressed:(id)sender
{
    NSLog(@"%i",self.selectedCat);
    if (self.selectedCat != 21) {
    
        UCAddNewInstitutionViewController *controller;
        if(IS_IPHONE_5)
        {
            controller = [[UCAddNewInstitutionViewController alloc] initWithNibName:@"UCAddNewInstitutionViewController_iPhone5" bundle:nil];
        }
        else
        {
            controller = [[UCAddNewInstitutionViewController alloc] initWithNibName:@"UCAddNewInstitutionViewController" bundle:nil];
        }
        
        
        
        if (self.selectedCat == 2)
        {
            controller.contactRoleID = ROLE_ASSISTANT_ID;
            controller.titleText = @"ASSISTANT";
        }
        else if(self.selectedCat == 1)
        {
            controller.contactRoleID = ROLE_SURGEON_ID;
            controller.titleText = @"SURGEON";
        }
        else if (self.selectedCat == 5){
            
            controller.contactRoleID = ROLE_ANESTHESIOLOGIST_ID;
            controller.titleText = @"ANESTHESIOLOGIST";
            
        }else if (self.selectedCat == 10){
            
            controller.contactRoleID = ROLE_PHYSICIAN_ID;
            controller.titleText = @"PHYSICIAN";
            
        }else if (self.selectedCat == 15){
            
            controller.contactRoleID = ROLE_INSTITUTIONS_ID;
            controller.titleText = @"INSTITUTION";
            
        }else if(self.selectedCat == 8 || self.selectedCat == 20){
            
            controller.contactRoleID = ROLE_OTHERS_ID;
            controller.titleText = @"OTHERS";
            
        }
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
    
    /*
    if (self.selectedCat != 21) {
     
        [tableview setEditing:YES animated:YES];
     
        UIAlertView *alertNew = [[UIAlertView alloc] initWithTitle:@"Insert Values" message:@"\n \n \n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
        [alertNew setTag:102];
        // Insert a username text field
        UITextField *nameTF= [[UITextField alloc] initWithFrame:CGRectMake(12, 50, 260, 30)];
        nameTF.placeholder = @"Name";
        nameTF.tag = 10;
        [nameTF setBackgroundColor:[UIColor whiteColor]];
        [nameTF setKeyboardType:UIKeyboardTypeDefault];
        
        // insert a password text field
        UITextField *emailTF = [[UITextField alloc] initWithFrame:CGRectMake(12, 85, 260, 30)];
        emailTF.placeholder = @"Email";
        emailTF.tag=11;
        [emailTF setBackgroundColor:[UIColor whiteColor]];
        [emailTF setKeyboardType:UIKeyboardTypeDefault];
        
        [alertNew addSubview:nameTF];
        [alertNew addSubview:emailTF];
        
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 0);
        [alertNew setTransform:transform];
        
        [alertNew show];
     
    }
    */
}

-(void)cancelButtonPressed:(id)sender
{
    //[alertView dismissWithClickedButtonIndex:-1 animated:YES];
    [tableview setEditing:NO];
}

-(void)saveButtonPressed:(id)sender
{
    if([tableview isEditing]) {
        [assistants addObject:nameField.text];
        [emails addObject:emailField.text];
        [tableview reloadData];
        //[tableview setEditing:NO];
    }
}

-(BOOL)containsContactObject:(NSMutableArray *)contactsArray andContact:(UCContactInfoModel *)obj
{
    for(int i=0;i<contactsArray.count;i++)
    {
        UCContactInfoModel *temp = (UCContactInfoModel *)[contactsArray objectAtIndex:i];
        if([temp.contactEmail isEqualToString:[obj contactEmail]])
        {
            return TRUE;
        }
    }
    return FALSE;
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
    //[alertView setFrame:CGRectMake(10, 100, 270, 250)];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.assistants count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"UCSelectProcedureCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [tableView setBackgroundView:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    
    cell.textLabel.text = [[self.assistants objectAtIndex:indexPath.row] contactName];
    cell.detailTextLabel.text = [[self.assistants objectAtIndex:indexPath.row] contactEmail];
    
    NSLog(@"%i",self.selectedList.count);
    
    if([self containsContactObject:self.selectedList andContact:[self.assistants objectAtIndex:indexPath.row]])
    {
         cell.accessoryType  = UITableViewCellAccessoryCheckmark;
    }
    else
    {
         cell.accessoryType  = UITableViewCellAccessoryNone;
    }
    
    if (selectedCat == 15) {
        
        NSString *tempStr = [[self.assistants objectAtIndex:indexPath.row] contactEmail];
        if ([self.parent.emailsArray containsObject:tempStr]) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (selectedCat == 15) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        NSString *tempStr = [[self.assistants objectAtIndex:indexPath.row] contactEmail];
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            /*
            for (int i = 0; i < [self.parent.contactsArray count]; i++) {
                
                UCContactInfoModel *model = [self.parent.contactsArray objectAtIndex:i];
                NSString *modelEmail = [model contactEmail];
                
                if ([modelEmail isEqualToString:tempStr]) {
                    [self.parent.contactsArray removeObjectAtIndex:i];
                    break;
                }
            }*/
            
            [self.parent.emailsArray removeObject:tempStr];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            
        }else{
            
            UCContactInfoModel *model = [self.assistants objectAtIndex:indexPath.row];
            if (self.parent.contactsArray == nil) {
                self.parent.contactsArray = [[NSMutableArray alloc] init];
            }
            
            if (self.parent.emailsArray == nil) {
                self.parent.emailsArray = [[NSMutableArray alloc] init];
            }
            [self.parent.contactsArray addObject:model];
            
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            
            [self.parent.emailsArray addObject:tempStr];
            
        }
        
    }else{
        
        int count = [self.navigationController.viewControllers count];
        
        NSString *controller = [NSString stringWithFormat:@"%@",[[self.navigationController.viewControllers objectAtIndex:count-2] class]];
        
        //NSLog(@"%@",controller);
        
        if ([controller isEqualToString:@"UCLRPNPageThreeViewController"]) {
            
            UCLRPNPageThreeViewController *cont = (UCLRPNPageThreeViewController *) [self.navigationController.viewControllers objectAtIndex:count-2];
            
            //NSLog(@"%@",[self.assistants objectAtIndex:indexPath.row]);
            
            if (self.selectedCat == 2) {
                
                cont.isAssistantSelection = YES;
                cont.assisantSelected = (UCContactInfoModel *)[self.assistants objectAtIndex:indexPath.row];
                cont.isAnesthesiologistSelection = NO;
                
            } else if (self.selectedCat == 5){
                
                cont.isAssistantSelection = NO;
                cont.anesthesiologistSelected = (UCContactInfoModel *)[self.assistants objectAtIndex:indexPath.row];
                cont.isAnesthesiologistSelection = YES;
                
            } else if (self.selectedCat == 10){
                
                cont.isAssistantSelection = NO;
                cont.anesthesiologistSelected = (UCContactInfoModel *)[self.assistants objectAtIndex:indexPath.row];
                cont.isAnesthesiologistSelection = YES;
                
            }
            
            [self.navigationController popToViewController:cont animated:YES];
            
        }else if ([controller isEqualToString:@"UCSelectContactsViewController"] || [controller isEqualToString:@"UCLRPNSevenViewController"]){

            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if(cell.accessoryType == UITableViewCellAccessoryCheckmark)
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
                for(int k=0;k<self.selectedList.count;k++)
                {
                    UCContactInfoModel *temp = [self.selectedList objectAtIndex:k];
                    if([temp.contactEmail isEqualToString:[[self.assistants objectAtIndex:indexPath.row] contactEmail]])
                    {
                        [self.selectedList removeObjectAtIndex:k];
                    }
                }
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                //UCContactInfoModel *cModel = [[UCContactInfoModel alloc]init];
                UCContactInfoModel *cModel = [self.assistants objectAtIndex:indexPath.row];
                if (self.selectedList == nil) {
                    self.selectedList = [[NSMutableArray alloc] init];
                }
                [self.selectedList addObject:cModel];
                
                NSLog(@"%i",self.selectedList.count);
            }
            
        }
        else if ([controller isEqualToString:@"UCSettingReminderToViewController"]){
            
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if(cell.accessoryType == UITableViewCellAccessoryCheckmark)
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
                for(int k=0;k<self.reminderParent.reminderContacts.count;k++)
                {
                    UCContactInfoModel *temp = [self.reminderParent.reminderContacts objectAtIndex:k];
                    if([temp.contactEmail isEqualToString:[[self.assistants objectAtIndex:indexPath.row] contactEmail]])
                    {
                        [self.reminderParent.reminderContacts removeObjectAtIndex:k];
                    }
                }
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                UCContactInfoModel *cModel  = [self.assistants objectAtIndex:indexPath.row];
                if (self.reminderParent.reminderContacts == nil) {
                    self.reminderParent.reminderContacts = [[NSMutableArray alloc] init];
                }
                [self.reminderParent.reminderContacts addObject:cModel];
                
                NSLog(@"%i",self.reminderParent.reminderContacts.count);
            }
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //return NO;
        }
    }
    return YES;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get the managedObjectContext from the AppDelegate (for use in CoreData Applications)
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [UCUtility showBlockView];
        [UCWebServerHandler deleteContact:[[self.assistants objectAtIndex:indexPath.row] contactID] withDelegate:self];
        
    }

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
                    NSLog(@"%@",[tf class]);
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
            
            if (self.selectedCat == 2) {
                
                [UCUtility showBlockView];
                [UCWebServerHandler addContactWithRoleID:ROLE_ASSISTANT_ID withName:model.name withEmail:model.email withSteetAddress:@"" withCity:@"" withState:@"" withZip:@"" withCountry:@"" withFax:@"" withContactID:@"" withDelegate:self];
                
            }
            else if(self.selectedCat == 1)
            {
                [UCUtility showBlockView];
                [UCWebServerHandler addContactWithRoleID:ROLE_SURGEON_ID withName:model.name withEmail:model.email withSteetAddress:@"" withCity:@"" withState:@"" withZip:@"" withCountry:@"" withFax:@"" withContactID:@"" withDelegate:self];
            }
            else if (self.selectedCat == 5){
                
                [UCUtility showBlockView];
                [UCWebServerHandler addContactWithRoleID:ROLE_ANESTHESIOLOGIST_ID withName:model.name withEmail:model.email withSteetAddress:@"" withCity:@"" withState:@"" withZip:@"" withCountry:@"" withFax:@"" withContactID:@"" withDelegate:self];
                
            }else if (self.selectedCat == 10){
                
                [UCUtility showBlockView];
                [UCWebServerHandler addContactWithRoleID:ROLE_PHYSICIAN_ID withName:model.name withEmail:model.email withSteetAddress:@"" withCity:@"" withState:@"" withZip:@"" withCountry:@"" withFax:@"" withContactID:@"" withDelegate:self];
                
            }else if (self.selectedCat == 15){
                
                [UCUtility showBlockView];
                [UCWebServerHandler addContactWithRoleID:ROLE_INSTITUTIONS_ID withName:model.name withEmail:model.email withSteetAddress:@"" withCity:@"" withState:@"" withZip:@"" withCountry:@"" withFax:@"" withContactID:@"" withDelegate:self];
                
            }else if(self.selectedCat == 8 || self.selectedCat == 20){
                
                [UCUtility showBlockView];
                [UCWebServerHandler addContactWithRoleID:ROLE_OTHERS_ID withName:model.name withEmail:model.email withSteetAddress:@"" withCity:@"" withState:@"" withZip:@"" withCountry:@"" withFax:@"" withContactID:@"" withDelegate:self];
                
            }
            
        }
    }
}

- (void)AddContactSuccessHandler:(ASIHTTPRequest *)request {
    
    [UCUtility hideBlockView];
    NSString *response = [request responseString];
    NSLog(@"%@",response);
    id result = [response JSONValue];
    
    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
        [UCUtility showBlockView];
        
        if([tableview isEditing])
        {
            [tableview setEditing:NO animated:YES];
        }
        
        if (self.selectedCat == 2) {
            [UCWebServerHandler doContactRequestWithRoleID:ROLE_ASSISTANT_ID withDelegate:self];
        }
        else if(self.selectedCat == 1)
        {
            [UCWebServerHandler doContactRequestWithRoleID:ROLE_SURGEON_ID withDelegate:self];
        }
        else if (self.selectedCat == 5){
            [UCWebServerHandler doContactRequestWithRoleID:ROLE_ANESTHESIOLOGIST_ID withDelegate:self];
        }else if (self.selectedCat == 10){
            [UCWebServerHandler doContactRequestWithRoleID:ROLE_PHYSICIAN_ID withDelegate:self];
        }else if (self.selectedCat == 15){
            [UCWebServerHandler doContactRequestWithRoleID:ROLE_INSTITUTIONS_ID withDelegate:self];
        }else if (self.selectedCat == 8 || self.selectedCat == 20){
            [UCWebServerHandler doContactRequestWithRoleID:ROLE_OTHERS_ID withDelegate:self];
        }
        
    }
    else {
        [UCUtility showInfoAlertView:@"Error" withMessage:[result objectForKey:@"msg"]];
    }
    
    result = nil;
    response = nil;
}

- (void)AddContactErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}


- (void)deleteContactSuccessHandler:(ASIHTTPRequest *)request {
    [UCUtility hideBlockView];
    NSString *response = [request responseString];
    NSLog(@"%@",response);
    id result = [response JSONValue];
    //NSLog(@"%@",result);
    
    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
        [UCUtility showBlockView];
        [tableview setEditing:NO animated:YES];
        
        if (self.selectedCat == 2) {
            [UCWebServerHandler doContactRequestWithRoleID:ROLE_ASSISTANT_ID withDelegate:self];
        }
        else if(self.selectedCat == 1)
        {
            [UCWebServerHandler doContactRequestWithRoleID:ROLE_SURGEON_ID withDelegate:self];
        }
        else if (self.selectedCat == 5){
            [UCWebServerHandler doContactRequestWithRoleID:ROLE_ANESTHESIOLOGIST_ID withDelegate:self];
        }else if (self.selectedCat == 10){
            [UCWebServerHandler doContactRequestWithRoleID:ROLE_PHYSICIAN_ID withDelegate:self];
        }else if (self.selectedCat == 15){
            [UCWebServerHandler doContactRequestWithRoleID:ROLE_INSTITUTIONS_ID withDelegate:self];
        }else if (self.selectedCat == 8 || self.selectedCat == 20){
            [UCWebServerHandler doContactRequestWithRoleID:ROLE_OTHERS_ID withDelegate:self];
        }
        
    }
    else {
        [UCUtility showInfoAlertView:@"Error" withMessage:@"Not removed, Try Again."];
    }
    
    result = nil;
    response = nil;
}

- (void)deleteContactErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}



@end
