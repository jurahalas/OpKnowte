//
//  UCSendEmailToIstitutions.m
//  MZUroCapture
//
//  Created by Atif Joyia on 24/05/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSendEmailToIstitutions.h"
#import "UCContactsListViewController.h"
#import "UCHomeScreenViewController.h"
#import "UCAddNewInstitutionViewController.h"

#import "OKContactManager.h"
#import "OKProceduresManager.h"
#import "OKWebServerManager.h"

@interface UCSendEmailToIstitutions ()

@end

@implementation UCSendEmailToIstitutions

@synthesize headerLbl;
@synthesize institutionTable;
@synthesize sendBtn;
@synthesize parent;
@synthesize faxArray;
@synthesize contactsArray;
@synthesize emailsArray;
@synthesize caseDataArray;
@synthesize indicationText;
@synthesize procedureText;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.faxArray = [[NSMutableArray alloc] init];
        self.emailsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated {
    if (emailSent == YES) {
        emailSent = NO;
        
        if (DELEGATE.isComingFromSignUp) {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
        }else{
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        }
    }else{
        
        [UCUtility showBlockView];
        [OKContactManager doContactRequestWithRoleID:ROLE_INSTITUTIONS_ID handler:^(NSString *errorMsg, id responseJSON) {
            [UCUtility hideBlockView];
            if(!errorMsg)
                [self contactRequestSucceded:responseJSON];
            else
                [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
        }];
        
        [OKContactManager getContactSettingsWithHandler:^(NSString *errorMsg, id responseJSON) {
            [UCUtility hideBlockView];
            if(!errorMsg)
                [self accessSettingsSucceded:responseJSON];
            else
               [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
        }];
        
    }
    [self.institutionTable reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    emailSent = NO;
    if(IS_IPHONE_5) 
    {
        self.headerLbl.frame=CGRectMake(self.headerLbl.frame.origin.x, self.headerLbl.frame.origin.y+5, self.headerLbl.frame.size.width, self.headerLbl.frame.size.height);
    }
    [self.headerLbl setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    [self.headerLbl setText:@"SELECT FACILITY"];
    
    [self.sendBtn.titleLabel setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    [self.sendBtn.titleLabel setText:@"Send Email"];
    
}


- (void)contactRequestSucceded:(id)response {

    id result = [UCUtility getContactInfoList:response];
    
    if ((result) && ([result count] > 0)) {
        
        if (self.contactsArray == nil) {
            self.contactsArray = [[NSMutableArray alloc] init];
        }
        [self.contactsArray removeAllObjects];
        self.contactsArray = [result mutableCopy];
        
    }
    else {
        
        [self.contactsArray removeAllObjects];
    }
    
    [self.institutionTable reloadData];
    //[UCWebServerHandler getInstitutionSettings:[UCAppDelegate sharedObject].selectedProcedure.procedureID withDelegate:self];
}


- (void)InstitutionsSettingsSuccessHandler:(id)response {
    [UCUtility hideBlockView];

    id result = [UCUtility getContactInfoList:response];
    
    if (self.emailsArray == nil) {
        self.emailsArray = [[NSMutableArray alloc] init];
    }
    [self.emailsArray removeAllObjects];
    
    if ((result) && ([result count] > 0)) {
        
        NSMutableArray *tempArray = [result mutableCopy];
        
        for (int i = 0; i < tempArray.count; i++) {
            [self.emailsArray addObject:[[tempArray objectAtIndex:i] contactEmail]];
        }
        
    }
    [self.institutionTable reloadData];
    response = nil;
}


- (void)accessSettingsSucceded:(id)response
{
    //[UCUtility hideBlockView];
    id result = [UCUtility getContactInfoList:response];
    if (result && [result count] > 0) {
        
        if (self.CCArray == nil) {
            self.CCArray = [[NSMutableArray alloc] init];
        }
        [self.CCArray removeAllObjects];
        self.CCArray = [[self getemailAddress:result] mutableCopy];
        NSArray *aray = self.parent.parentModel.var_cc;
        for(int i=0;i<aray.count;i++){
            if(![self containsString:self.CCArray object:[aray objectAtIndex:i]])
            {
                [self.CCArray addObject:[aray objectAtIndex:i]];
            }
        }
        
    }else{
        
    }
    
    if (self.CCArray == nil) {
        self.CCArray = [[NSMutableArray alloc] init];
    }
    
    NSArray *aray = self.parent.parentModel.var_cc;
    for(int i=0;i<aray.count;i++){
        if(![self containsString:self.CCArray object:[aray objectAtIndex:i]])
        {
            [self.CCArray addObject:[aray objectAtIndex:i]];
        }
    }
    
}


- (BOOL) containsString:(NSArray *)arrayOfStrings object:(NSString *)str{
    for(int i=0;i<arrayOfStrings.count;i++){
        if([str isEqualToString:[arrayOfStrings objectAtIndex:i]]){
            NSLog(@" ^^^^ EMAIL ALREADY THERE  ::  %@",str);
            return YES;
        }
    }
    return NO;
}


-(NSMutableArray *)getemailAddress:(NSMutableArray *)contacts{
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (int i = 0; i < [contacts count]; i++) {
        UCContactInfoModel *model = [contacts objectAtIndex:i];
        [temp addObject:[model contactEmail]];
    }
    return temp;
}


-(IBAction)findFacility:(id)sender{
    
    UCContactsListViewController * setting =nil;
    if(!IS_IPHONE_5) {
        setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController" bundle:nil];
    }
    else {
        setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController_iPhone" bundle:nil];
    }
    setting.selectedCat = 15;
    setting.parent = self;
    [self.navigationController pushViewController:setting animated:YES];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contactsArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"UCSelectProcedureCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [tableView setBackgroundView:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.textLabel.text = [[self.contactsArray objectAtIndex:indexPath.row] contactName];
    cell.detailTextLabel.text = [[self.contactsArray objectAtIndex:indexPath.row] contactEmail];
    
    NSString *contactEmail = [[self.contactsArray objectAtIndex:indexPath.row] contactEmail];
    if ([self.emailsArray containsObject:contactEmail]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        NSString *contactEmail = [[self.contactsArray objectAtIndex:indexPath.row] contactEmail];
        NSString *contactFax = [[self.contactsArray objectAtIndex:indexPath.row] contactFax];
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            
            [self.faxArray removeObject:contactFax];
            [self.emailsArray removeObject:contactEmail];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            
        }else{
            
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            [self.emailsArray addObject:contactEmail];
            [self.faxArray addObject:contactFax];
            
        }
}

-(NSString *)getEmailBodyForProcedureTwo{
    NSString *body = [[NSString alloc] init];
    
    body = [body stringByAppendingString:@"\n\n"];
    
    for (int i = 0; i < [self.caseDataArray count]; i++) {
       //
        UCTemplateVariablesModel *tempModel = [self.caseDataArray objectAtIndex:i];
       
        NSString *name = [tempModel key];
        NSString *key = [tempModel value];
        NSLog(@"%@",key);
        
        NSString *temp;
        
        if ([key isEqualToString:@"var_assistant"] || [key isEqualToString:@"var_anesthesiologist"]) {
            UCContactInfoModel *contact = [self.parent.parentModel valueForKey:key];
            temp = contact.contactName;
        }else if ([key isEqualToString:@"var_preOp"]){
            
            temp = [NSString stringWithFormat:@"%@ Renal Mass",[self.parent.parentModel valueForKey:key]];
            
        }else if ([key isEqualToString:@"var_procedureName"]){
            
            if ([self.parent.parentModel.var_cysto isEqualToString:@"YES"]) {
                temp = [NSString stringWithFormat:@"%@ with cysto and %@ stent placement.",[self.parent.parentModel valueForKey:key],[self.parent.parentModel.var_preOp lowercaseString]];
            }else{
                temp = [NSString stringWithFormat:@"%@",[self.parent.parentModel valueForKey:key]];
            }
            
        }else if ([key isEqualToString:@"var_cc"]){
            NSArray *arr = [self.parent.parentModel valueForKey:key];
            for (int i = 0; i < [arr count]; i++) {
                temp = [arr objectAtIndex:i];
                if (i != arr.count-1) {
                    temp = [temp stringByAppendingString:@","];
                }
            }
            
        }else{
            temp = [self.parent.parentModel valueForKey:key];
        }
        
        if (temp.length > 0) {
            body = [body stringByAppendingFormat:@"%@: %@",name,temp];
        }
        
        if (i <= [self.caseDataArray count]-1) {
            body = [body stringByAppendingString:@"\n"];
        }
    }
    
    body = [body stringByAppendingString:@"\n\n"];
    
    body = [body stringByAppendingFormat:@"Indications: %@ \n\n Procedures:%@",self.indicationText, self.procedureText];
    
    body = [body stringByReplacingOccurrencesOfString:@"(" withString:@""];
    body = [body stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    return body;
}


-(NSString *)getEmailBodyforProcedureTen{
    NSString *body = [[NSString alloc] init];
    
    body = [body stringByAppendingString:@"\n\n"];
    
    for (int i = 0; i < [self.caseDataArray count]; i++) {
        //
        UCTemplateVariablesModel *tempModel = [self.caseDataArray objectAtIndex:i];
        
        NSString *name = [tempModel key];
        NSString *key = [tempModel value];
        
        NSString *temp;
        
        temp = [self.parent.ESWLparentModel valueForKey:key];
        
        if (temp.length > 0) {
            body = [body stringByAppendingFormat:@"%@: %@",name,temp];
        }
        
        if (i <= [self.caseDataArray count]-1) {
            body = [body stringByAppendingString:@"\n"];
        }
    }
    
    
    body = [body stringByAppendingString:@"\n\n"];
    
    body = [body stringByAppendingFormat:@"Indications for Procedure: %@ \n\n Procedure and Findings:%@",self.indicationText, self.procedureText];
    
    body = [body stringByReplacingOccurrencesOfString:@"(" withString:@""];
    body = [body stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    return body;
}

-(IBAction)emailBtnPressed:(id)sender{
    
    int procedure = [[OKProceduresManager instance].selectedProcedure.procedureID intValue];
    NSString *emailBody;
    if (procedure == 2) {
        emailBody = [self getEmailBodyForProcedureTwo];
    }else if (procedure == 10){
        emailBody = [self getEmailBodyforProcedureTen];
    }
    
    
    //Sending Emails via emailComposer
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"Operative Note"];
        [mailer setToRecipients:self.emailsArray];
        [mailer setCcRecipients:self.CCArray];
        [mailer setMessageBody:emailBody isHTML:NO];
        [self presentViewController:mailer animated:YES completion:nil];
        
        mailer = nil;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        alert = nil;
    }
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            emailSent = YES;
            [UCUtility showInfoAlertView:@"" withMessage:@"Email saved in Drafts"];
            break;
        case MFMailComposeResultSent:{
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            emailSent = YES;
            [UCUtility showInfoAlertView:@"" withMessage:@"Email Sent"];
            break;
        }
            
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(IBAction)sendFax:(id)sender{
    
    if (self.faxArray.count == 0) {
        [UCUtility showInfoAlertView:@"" withMessage:@"Please select atleast one institute with fax number in details."];
        
    }else{
        
        
        NSMutableString *listFaxNumbers = [[NSMutableString alloc] init];
        for(int i=0;i<self.faxArray.count;i++)
        {
            if ([[self.faxArray objectAtIndex:i] length] > 0) {
                [listFaxNumbers appendString:[NSString stringWithFormat:@"%@@smartfax.com",[self.faxArray objectAtIndex:i]]];
                if(i != self.faxArray.count-1)
                {
                    [listFaxNumbers appendFormat:@","];
                }
            }
            
        }
        
        NSLog(@"%@",listFaxNumbers);
        
        [self sendFaxTo:listFaxNumbers];
    }
    
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Do You want to add another fax number?" delegate:self cancelButtonTitle:@"No, Send" otherButtonTitles:@"Yes", nil];
//    alert.tag = 100;
//    [alert show];
    
}

- (void)sendFaxSucceded:(id)response {

    id result = response;
    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
        
        [UCUtility showInfoAlertView:@"" withMessage:[result objectForKey:@"msg"]];
    }
    else {
        [UCUtility showInfoAlertView:@"Error" withMessage:[result objectForKey:@"msg"]];
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            //t_toolbar.hidden = false;
            
            [self sendFaxTo:@""];
            
        }else if (buttonIndex == 1){
            
            UIAlertView *alertfax = [[UIAlertView alloc] initWithTitle:@"Insert Values" message:@"\n \n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send", nil];
            [alertfax setTag:102];
            // Insert a username text field
            UITextField *faxNumber = [[UITextField alloc] initWithFrame:CGRectMake(12, 50, 260, 30)];
            faxNumber.placeholder = @"Insert Fax No.";
            faxNumber.tag = 10;
            [faxNumber setBackgroundColor:[UIColor whiteColor]];
            [faxNumber setKeyboardType:UIKeyboardTypePhonePad];
            
            [alertfax addSubview:faxNumber];
            
            CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 0);
            [alertfax setTransform:transform];
            
            [alertfax show];
            
            
        }
    }else if (alertView.tag == 102){
        if (buttonIndex == 1){
            
            NSString *faxNumber = [[NSString alloc] init];
            
            for (UIView *tf in alertView.subviews) {
                
                NSString *str = [NSString stringWithFormat:@"%@",[tf class]];
                if ([str isEqualToString:@"UITextField"]) {
                    [((UITextField *)tf) text];
                    
                    if ([((UITextField *)tf) tag] == 10) {
                        faxNumber = [((UITextField *)tf) text];
                    }
                }
            }
            
            if (faxNumber.length > 0) {
                [self sendFaxTo:faxNumber];
            }else{
                //[self sendFaxTo:@""];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter a fax number." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                alert.tag = 105;
                [alert show];
            }
            
        }
    }else if (alertView.tag == 105){
        
        if (buttonIndex == 0) {
            
            UIAlertView *alertfax = [[UIAlertView alloc] initWithTitle:@"Insert Values" message:@"\n \n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send", nil];
            [alertfax setTag:102];
            // Insert a username text field
            UITextField *faxNumber = [[UITextField alloc] initWithFrame:CGRectMake(12, 50, 260, 30)];
            faxNumber.placeholder = @"Insert Fax No.";
            faxNumber.tag = 10;
            [faxNumber setBackgroundColor:[UIColor whiteColor]];
            [faxNumber setKeyboardType:UIKeyboardTypePhonePad];
            
            [alertfax addSubview:faxNumber];
            
            CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 0);
            [alertfax setTransform:transform];
            
            [alertfax show];
            
        }
        
    }
}


-(void)sendFaxTo:(NSString *)faxNumber{
    
    int procedure = [[OKProceduresManager instance].selectedProcedure.procedureID intValue];
    NSString *faxBody;
    if (procedure == 2) {
        faxBody = [self getEmailBodyForProcedureTwo];
    }else if (procedure == 10){
        faxBody = [self getEmailBodyforProcedureTen];
    }
    
    [UCUtility showBlockView];
    [OKWebServerManager sendFaxWithText:faxBody faxNumber:faxNumber handler:^(NSString *errorMsg, id responseJSON) {
        [UCUtility hideBlockView];
        if(!errorMsg)
            [self sendFaxSucceded:responseJSON];
        else
            [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
    }];
    
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



@end
