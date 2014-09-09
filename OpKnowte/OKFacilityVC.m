//
//  OKFacilityVC.m
//  OpKnowte
//
//  Created by Apple on 29.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKFacilityVC.h"
#import "OKFacilityTableViewCell.h"
#import "OKInstituteVC.h"
#import "OKProcedureTemplateVariablesModel.h"
#import "OKContactModel.h"
#import "OKProceduresManager.h"
#import "OKPDFGenerator.h"


@interface OKFacilityVC ()<OKFacilityTableViewCellDelegate>

@property (strong, nonatomic) IBOutlet UITableView *facilityTableView;
@property (strong, nonatomic) IBOutlet UIView *faxAndEmailView;
@property (strong, nonatomic) NSMutableArray *contactsArray;
@property (strong, nonatomic) NSMutableArray *contactsSendTo;
@property (nonatomic) BOOL plusButtonIsPressed;

@end

@implementation OKFacilityVC


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"addNewInstitution"]){
        OKInstituteVC *instVC = (OKInstituteVC*)segue.destinationViewController;
        instVC.contactID = sender;
        instVC.cameFromVC = @"FacilityVC";
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _plusButtonIsPressed = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    _facilityTableView.backgroundColor = [UIColor clearColor];
    self.facilityTableView.dataSource = self;
    self.facilityTableView.delegate = self;
    _contactsSendTo = [[NSMutableArray alloc] init];
    if (IS_IOS7) {
    _facilityTableView.frame = CGRectMake(_facilityTableView.frame.origin.x, _facilityTableView.frame.origin.y, _facilityTableView.frame.size.width, (_facilityTableView.frame.size.height+25));
    }else{
        _facilityTableView.frame = CGRectMake(_facilityTableView.frame.origin.x, _facilityTableView.frame.origin.y, _facilityTableView.frame.size.width, (_facilityTableView.frame.size.height+20));
    }
    [self addBottomTabBar];
   
    [self addRightButtonToNavbar];
    if (![_cameFromVC isEqualToString:@"createProcedureVC"]){
        _roleID = @"4";
        _facilityTableView.allowsSelection = YES;
    } else {
        _faxAndEmailView.hidden = YES;
        if ([_roleID isEqualToString:@"7"]) {
            self.navigationItem.rightBarButtonItem = nil;
        }
        
    }
    if ([_roleID isEqualToString:@"1"]) {
       self.navigationItem.title =@"Select Surgeon";
    }else if ([_roleID isEqualToString:@"2"]){
        self.navigationItem.title =@"Select Assistant";
    }else if ([_roleID isEqualToString:@"3"]){
        self.navigationItem.title =@"Select Anesthesiologist";
    }else if ([_roleID isEqualToString:@"5"]){
        self.navigationItem.title =@"Select Physician";
    }else if([_roleID isEqualToString:@"6"]){
        self.navigationItem.title =@"Other";
    } else if([_roleID isEqualToString:@"7"]){
        self.navigationItem.title =@"Select CC";
    }
    if (IS_IOS6) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
    
}
    
-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width+27, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    OKContactManager *contactManager = [OKContactManager instance];
    if ([_roleID isEqualToString:@"7"]) {
        [[OKLoadingViewController instance] showWithText:@"Loading..."];

        [contactManager getOtherContactsByUserID:[OKUserManager instance].currentUser.identifier handler:^(NSString *errorMsg, NSMutableArray *contactsArray) {
            
            if (!errorMsg) {
                self.contactsArray = contactsArray;
                [self.facilityTableView reloadData];
            }
            NSLog(@"Error - %@", errorMsg);
            [[OKLoadingViewController instance] hide];
        }];
    } else {
        [[OKLoadingViewController instance] showWithText:@"Loading..."];

        [contactManager getContactsByUserID:[OKUserManager instance].currentUser.identifier roleID:_roleID handler: ^(NSString* error, NSMutableArray* array){
            [[OKLoadingViewController instance] hide];
            
            if (!error) {
                self.contactsArray = array;
                [self.facilityTableView reloadData];
            }
            NSLog(@"Error - %@", error);
            [[OKLoadingViewController instance] hide];
        }];
    }
}


-(void) addContactToSendToList:(OKContactModel *)contact
{
    [_contactsSendTo addObject:contact];
}


-(void) deleteContactFromSendToList:(OKContactModel *)contact{
    for (int i = 0; i<_contactsSendTo.count; i++) {
        OKContactModel *searchedContact = _contactsSendTo[i];
        if ([searchedContact.identifier isEqualToString:contact.identifier]) {
            [_contactsSendTo removeObjectAtIndex:i];
            break;
        }
    }
}


-(void) addRightButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    if (IS_IOS7) {
        right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width, [UIImage imageNamed:@"back"].size.height );
    } else {
        right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width +27, [UIImage imageNamed:@"back"].size.height );}
    [right setImage:[UIImage imageNamed:@"plusWhiteIcon"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(rightButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = anotherButton;
}


-(void) rightButtonTapped
{
      [self performSegueWithIdentifier:@"addNewInstitution" sender:_roleID];
}


#pragma mark IBAction metods
- (IBAction)faxButtonTapped:(id)sender {
    NSString *faxNumbersList = [self getFaxNumbersFromContactsArray:_contactsSendTo];
    NSString *address = [self getAddressFromContactsArray:_contactsSendTo];
    NSString *institutionNames = [self getNameFromContactsArray:_contactsSendTo];
    NSString *faxNumbersList2 = [self getFaxNumbersFromContactsArray2:_contactsSendTo];
    if (faxNumbersList.length) {
        [self sendFaxTo:faxNumbersList addressList:address andNames:institutionNames institutionFax: faxNumbersList2];
    }else {
        UIAlertView *alertNoContacts = [[UIAlertView alloc] initWithTitle:@""
                                                                  message:@"Please select atleast one institute with fax number."
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil];
        [alertNoContacts show];
    }
}


-(void) sendFaxTo:(NSString*)faxNumberList addressList:(NSString*)addressList andNames:(NSString*)namesList institutionFax:(NSString*)faxNumberList2
{
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    NSString *faxBody = [self getFaxBodyForProcedure];
    OKSendFaxManager *sendFaxManager = [OKSendFaxManager instance];

    [sendFaxManager sendFaxWithUserID:[OKUserManager instance].currentUser.identifier Message:faxBody AndFaxNumbers:faxNumberList AndFaxNumbers2:faxNumberList2 addressList:addressList andNames:namesList     handler:^(NSString *errorMsg, NSDictionary *json) {
        [[OKLoadingViewController instance] hide];
        if (!errorMsg) {
            UIAlertView *alertSuccess = [[UIAlertView alloc] initWithTitle:@""
                                                                   message:[json objectForKey:@"msg"]
                                                                  delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles: nil];
            [alertSuccess show];
        } else {
            NSLog(@"Error - %@", errorMsg);
            UIAlertView *alertFailure = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                   message:[json objectForKey:@"msg"]
                                                                  delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles: nil];
            [alertFailure show];
        }
    }];
    
    
     

}
     
     
- (IBAction)emailButtonTapped:(id)sender
{
    if (_contactsSendTo.count) {
        UIAlertView *alertFailure = [[UIAlertView alloc] initWithTitle:@""
                                                               message:@"This method of delivery is not HIPPA compliant."
                                                              delegate:self
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles: nil];
        [alertFailure show];
    }else {
        UIAlertView *alertNoContacts = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please select atleast one institute."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alertNoContacts show];
    }
}


-(void) sendEmailIfPossible{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"Operative Note"];
        [mailer setToRecipients:[self getEmailAddress:_contactsSendTo]];
        [mailer setMessageBody:[self getEmailBodyForProcedure] isHTML:YES];
        [self presentViewController:mailer animated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }];
        mailer = nil;
        
    }else{
        UIAlertView *alertFailure = [[UIAlertView alloc] initWithTitle:@"No Email Account"
                                                               message:@"There are no Email accounts configured. You can add or create Email account in Settings."
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles: nil];
        [alertFailure show];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([alertView.message isEqualToString:@"This method of delivery is not HIPPA compliant."]) {
            
            [self sendEmailIfPossible];
            
        }
    }

}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:{
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        }
        case MFMailComposeResultSaved:{
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            UIAlertView *alertSave = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"Email saved in Drafts"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alertSave show];
            break;
        }
        case MFMailComposeResultSent:{
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            UIAlertView *alertSent = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"Email Sent"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alertSent show];
            break;
        }
            
        case MFMailComposeResultFailed:{
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        }
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
}


- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];

    if ([_cameFromVC isEqualToString:@"createProcedureVC"]){
        [self.delegate setContactFieldWithContactArray:_contactsSendTo];
    }
}


#pragma mark Table View methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contactsArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"facilityCell";
    OKFacilityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKFacilityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    OKContactModel *contact = (OKContactModel*)self.contactsArray[indexPath.row];
    cell.contact = contact;
    cell.delegate = self;
    cell.facilityNameLabel.text = contact.name;
    cell.emailLabel.text = contact.contactEmail;
    [cell setCellBGImageLight:indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![_roleID isEqualToString:@"4"]) {
        OKFacilityTableViewCell *cell = (OKFacilityTableViewCell *)[_facilityTableView cellForRowAtIndexPath:indexPath];

        if ([_cameFromVC isEqualToString:@"createProcedureVC"]){
            [self.navigationController popViewControllerAnimated:YES];
        
            NSMutableArray *contactsArray = [[NSMutableArray alloc] init];
            [contactsArray addObject:cell.contact];
            [self.delegate setContactFieldWithContactArray:contactsArray];
        }
    }else{
        
        OKFacilityTableViewCell * cell = (OKFacilityTableViewCell *)[_facilityTableView cellForRowAtIndexPath:indexPath];
        [cell facilityButton:cell.contact];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_roleID isEqualToString:@"4"]) {
        if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[OKFacilityTableViewCell class]]) {
            OKFacilityTableViewCell *cell = (OKFacilityTableViewCell *)[_facilityTableView cellForRowAtIndexPath:indexPath];
            [cell facilityButton:cell.contact];
        }
    }
}

-(NSMutableArray *)getEmailAddress:(NSMutableArray *)contacts
{
    NSMutableArray *emailsArray = [[NSMutableArray alloc]init];
    for (OKContactModel *contact in contacts) {
        [emailsArray addObject:contact.contactEmail];
    }
    return emailsArray;
}


-(NSString *) getFaxNumbersFromContactsArray:(NSMutableArray*)contacts{
    NSString *listFaxNumbers = [[NSString alloc] init];
    NSMutableArray *faxesArray = [[NSMutableArray alloc]init];
    for(OKContactModel *contact in contacts) {
        if (contact.contactFax) {
            [faxesArray addObject:[NSString stringWithFormat:@"%@@smartfax.com",contact.contactFax]];
            //[faxesArray addObject:[NSString stringWithFormat:@"%@",contact.contactFax]];
        }
    }
    
    listFaxNumbers = [faxesArray componentsJoinedByString:@","];
    
    NSLog(@"%@",listFaxNumbers);
    return listFaxNumbers;
    
}

-(NSString *) getFaxNumbersFromContactsArray2:(NSMutableArray*)contacts{
    NSString *listFaxNumbers = [[NSString alloc] init];
    NSMutableArray *faxesArray = [[NSMutableArray alloc]init];
    for(OKContactModel *contact in contacts) {
        if (contact.contactFax) {
            //[faxesArray addObject:[NSString stringWithFormat:@"%@@smartfax.com",contact.contactFax]];
            [faxesArray addObject:[NSString stringWithFormat:@"%@",contact.contactFax]];
        }
    }
    
    listFaxNumbers = [faxesArray componentsJoinedByString:@","];
    
    NSLog(@"%@",listFaxNumbers);
    return listFaxNumbers;
    
}

-(NSString *) getAddressFromContactsArray:(NSMutableArray*)contacts{
    NSString *listOfAddress = [[NSString alloc] init];
    NSMutableArray *addressArray = [[NSMutableArray alloc]init];
    for(OKContactModel *contact in contacts) {
        NSString *fullAddress = @"";
        if (contact.contactStreetAddress) {
            fullAddress = [fullAddress stringByAppendingString:[NSString stringWithFormat:@"\n%@, ",contact.contactStreetAddress]];
        } else {
            fullAddress = [fullAddress stringByAppendingString:@"\nNo Address, "];
        }

        if (contact.contactCity) {
            fullAddress = [fullAddress stringByAppendingString:[NSString stringWithFormat:@"%@, ",contact.contactCity]];
        } else {
            fullAddress = [fullAddress stringByAppendingString:@"No City, "];
        }
        
        if (contact.contactState) {
            fullAddress = [fullAddress stringByAppendingString:[NSString stringWithFormat:@"%@, ",contact.contactState]];
        } else {
            fullAddress = [fullAddress stringByAppendingString:@"No State, "];
        }
        if (contact.contactZip) {
            fullAddress = [fullAddress stringByAppendingString:[NSString stringWithFormat:@"%@",contact.contactZip]];
        } else {
            fullAddress = [fullAddress stringByAppendingString:@"No Zip"];
        }
        
        [addressArray addObject:[NSString stringWithFormat:@"%@",fullAddress]];
    }
    
    listOfAddress = [addressArray componentsJoinedByString:@";"];
    
    NSLog(@"%@",listOfAddress);
    return listOfAddress;
    
}

-(NSString *) getNameFromContactsArray:(NSMutableArray*)contacts{
    NSString *listOfNames = [[NSString alloc] init];
    NSMutableArray *namesArray = [[NSMutableArray alloc]init];
    for(OKContactModel *contact in contacts) {
        if (contact.name) {
            [namesArray addObject:[NSString stringWithFormat:@"%@",contact.name]];
        }
    }
    
    listOfNames = [namesArray componentsJoinedByString:@";"];
    
    NSLog(@"%@",listOfNames);
    return listOfNames;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) generatePDF {
    OKPDFGenerator *pdfController = [[OKPDFGenerator alloc] init];
    [pdfController genratePdfFile2:[self getEmailBodyForProcedure] withPath:[NSString stringWithFormat:@"report.pdf"] size:10000];
    
}

-(NSString *)getEmailBodyForProcedure{
    NSString *body = [[NSString alloc] init];
    NSString *procID = [[NSString alloc] initWithFormat:@"%@", [OKProceduresManager instance].selectedProcedure.identifier];
//    NSString *perProcedure  = [[NSString alloc] init];
//    NSString *perProcedure2 = @"";
    
    body = [body stringByAppendingString:@"<br><br>"];
    
//    if ([[[[_templateDictionary objectForKey:@"caseData"] objectAtIndex:4] valueForKey:@"value"] isEqualToString:@"Right renal mass"]) {
//        perProcedure = [NSString stringWithFormat:@"right"];
//    }else{
//        perProcedure = [NSString stringWithFormat:@"left"];
//    }
    NSMutableDictionary * caseDataOrderChange = [[NSMutableDictionary alloc] init];
    for (OKProcedureTemplateVariablesModel *caseDataModel in [_templateDictionary objectForKey:@"caseData"]) {
        [caseDataOrderChange setValue:caseDataModel forKey:caseDataModel.key];
    }
    
    
    NSMutableArray *caseDataChangeOrderArray = [[NSMutableArray alloc] init];
    if ([procID isEqualToString:@"1"]) {
        for (int i = 0; i<11; i++) {
            if (i == 0) {
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Patient Name"]];
            }
            else if (i == 1){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Patient DOB"]];
            }
            else if (i == 2){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Medical Record Number"]];
            }
            else if (i == 3){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Date Of Service"]];
            }
            else if (i == 4){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Pre-operative Diagnosis"]];
            }
            else if (i == 5){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Post-operative Diagnosis"]];
            }
            else if (i == 6){
                NSString *nerveSparring = [self.model valueForKey:@"var_nervesparing"];
                OKProcedureTemplateVariablesModel *caseDataModel = [caseDataOrderChange objectForKey:@"Procedure"];
                caseDataModel.value =[NSString stringWithFormat:@"%@ with %@",caseDataModel.value, nerveSparring];
                [caseDataChangeOrderArray addObject:caseDataModel];
            }
            else if (i == 7){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Surgeon";
                caseDataModel.value = [NSString stringWithFormat:@"%@ %@, %@", [OKUserManager instance].currentUser.firstName, [OKUserManager instance].currentUser.lastName , [OKUserManager instance].currentUser.title];
                [caseDataChangeOrderArray addObject:caseDataModel];
            }
            else if (i == 8){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Assistant"]];
            }
            else if (i == 9){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Anesthesia"]];
            }
            else if (i == 10){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Anesthesiologist";
                caseDataModel.value = [self.model valueForKey:@"var_anesthesiologist"];
                [caseDataChangeOrderArray addObject:caseDataModel];
            }
            
        }
    } else if ([procID isEqualToString:@"2"]) {
        for (int i = 0; i<10; i++) {
            if (i == 0) {
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Patient Name"]];
            } else if (i == 1){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Patient DOB"]];
                
            }else if (i == 2){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Medical Record Number"]];
                
            }else if (i == 3){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Date of Service"]];
                
            }else if (i == 4){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Pre-operative Diagnosis"]];
                
            }else if (i == 5){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Post-operative Diagnosis"]];
                
            }else if (i == 6){
                OKProcedureTemplateVariablesModel *caseDataModel = [caseDataOrderChange objectForKey:@"Procedure"];
                
                if ([[self.model valueForKey:@"var_cysto"] isEqualToString:@"YES"]) {
                    caseDataModel.value = [NSString stringWithFormat:@"%@ with cysto and right stent placement",caseDataModel.value];
                }
                NSString *right = [self.model valueForKey:@"var_preOp"];
                if ([right isEqualToString:@"Right renal mass"]) {
                    right = @"Right";
                    caseDataModel.value = [NSString stringWithFormat:@"%@ %@",right,caseDataModel.value];
                } else {
                    right = @"Left";
                    caseDataModel.value = [NSString stringWithFormat:@"%@ %@",right,caseDataModel.value];
                }
               
                [caseDataChangeOrderArray addObject:caseDataModel];
                
            }else if (i == 7){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Surgeon";
                caseDataModel.value = [NSString stringWithFormat:@"%@ %@, %@", [OKUserManager instance].currentUser.firstName, [OKUserManager instance].currentUser.lastName , [OKUserManager instance].currentUser.title];
                [caseDataChangeOrderArray addObject:caseDataModel];
                
            }else if (i == 8){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Assistant"]];
                
            }
//            else if (i == 9){
//                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Anesthesia"]];
//                
//            }
            else if (i == 9){
                //_var_anesthesiologist
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Anesthesiologist";
                caseDataModel.value = [self.model valueForKey:@"var_anesthesiologist"];
                [caseDataChangeOrderArray addObject:caseDataModel];
                
            }
            
        }
 
    } else if ([procID isEqualToString:@"9"]) {
        for (int i = 0; i<9; i++) {
            if (i == 0) {
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Patient Name"]];
            } else if (i == 1){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Patient DOB"]];
                
            }else if (i == 2){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Medical Record Number"]];
                
            }else if (i == 3){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Date Of Service"]];
                
            }else if (i == 4){
                //var_diagnosis
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Pre-operative Diagnosis";
                caseDataModel.value = [self.model valueForKey:@"var_diagnosis"];
                [caseDataChangeOrderArray addObject:caseDataModel];
                //[caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Pre-operative Diagnosis"]];
                
            }else if (i == 5){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Post-operative Diagnosis";
                caseDataModel.value = @"Same";
                [caseDataChangeOrderArray addObject:caseDataModel];
                //[caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Post-operative Diagnosis"]];
                
            }else if (i == 6){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Procedure"]];
                
            }else if (i == 7){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Surgeon";
                caseDataModel.value = [NSString stringWithFormat:@"%@ %@, %@", [OKUserManager instance].currentUser.firstName, [OKUserManager instance].currentUser.lastName , [OKUserManager instance].currentUser.title];
                [caseDataChangeOrderArray addObject:caseDataModel];

            }
//            else if (i == 8){
//                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Assistant"]];
//                
//            }
            else if (i == 8){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Anesthesia performed"]];
                
            }
//            else if (i == 10){
//                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Anesthesiologist"]];
//                
//            }
            
        }

    } else if ([procID isEqualToString:@"10"]) {
        for (int i = 0; i<9; i++) {
            if (i == 0) {
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Patient Name"]];
            }
            else if (i == 1){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Patient DOB"]];
                
            }
            else if (i == 2){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Medical Record Number"]];
                
            }
            else if (i == 3){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Date Of Service"]];
                
            }
            else if (i == 4){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Pre-operative Diagnosis";
                caseDataModel.value = [self.model valueForKey:@"var_anesthesiaLocation"];
                if ([[[self.model valueForKey:@"var_stonesLocations"] objectAtIndex:0] isEqualToString:@"Upper pole, renal"] || [[[self.model valueForKey:@"var_stonesLocations"] objectAtIndex:0] isEqualToString:@"Mid-renal"] || [[[self.model valueForKey:@"var_stonesLocations"] objectAtIndex:0] isEqualToString:@"Lower pole, renal"] || [[[self.model valueForKey:@"var_stonesLocations"] objectAtIndex:0] isEqualToString:@"Renal pelvis"]) {
                    
                   caseDataModel.value = [NSString stringWithFormat:@"%@ Renal",caseDataModel.value ];
                } else {
                    caseDataModel.value = [NSString stringWithFormat:@"%@ Uretral",caseDataModel.value ];
                }
                
                if ([[self.model valueForKey:@"var_stonesCount"] isEqualToString:@"1"]) {
                    caseDataModel.value = [NSString stringWithFormat:@"%@ calculus",caseDataModel.value ];
                } else {
                    caseDataModel.value = [NSString stringWithFormat:@"%@ calculi",caseDataModel.value ];
                }
                
                [caseDataChangeOrderArray addObject:caseDataModel];
                
            }
            else if (i == 5){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Post-operative Diagnosis";
                caseDataModel.value = @"Same";
                [caseDataChangeOrderArray addObject:caseDataModel];
                
            }
            else if (i == 6){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Procedure"]];
                
            }
            else if (i == 7){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Surgeon";
                caseDataModel.value = [NSString stringWithFormat:@"%@ %@, %@", [OKUserManager instance].currentUser.firstName, [OKUserManager instance].currentUser.lastName , [OKUserManager instance].currentUser.title];
                [caseDataChangeOrderArray addObject:caseDataModel];
            }
//            else if (i == 8){
//                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Assistant"]];
//                
//            }
            else if (i == 8){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Anesthesia";
                caseDataModel.value = [self.model valueForKey:@"var_anesthesiaPerformed"];
                [caseDataChangeOrderArray addObject:caseDataModel];
            }
//            else if (i == 10){
//                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Anesthesiologist"]];
//                
//            }
            
        }

    }

    
    
    
    
    for (OKProcedureTemplateVariablesModel *caseDataModel in caseDataChangeOrderArray) {
        
        if ([procID isEqualToString:@"1"]) {
            body = [body stringByAppendingFormat:@"<b>%@:</b> %@<br>",[caseDataModel.key uppercaseString], caseDataModel.value ];
        }else if ([procID isEqualToString:@"2"]){
            body = [body stringByAppendingFormat:@"<b>%@:</b> %@<br>",[caseDataModel.key uppercaseString], caseDataModel.value ];
        }else{
            body = [body stringByAppendingFormat:@"<b>%@:</b> %@<br>",[caseDataModel.key uppercaseString], caseDataModel.value ];
        }
    }
    
    
    body = [body stringByAppendingFormat:@"<br><b>INDICATIONS:</b> %@ <br><br> <b>PROCEDURES:</b> %@", [_templateDictionary objectForKey:@"indicationText"], [_templateDictionary objectForKey:@"procedureText"]];
    
    body = [body stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
    
    return body;
    
}


-(NSString *)getFaxBodyForProcedure{
    NSString *body = [[NSString alloc] init];
    NSString *procID = [[NSString alloc] initWithFormat:@"%@", [OKProceduresManager instance].selectedProcedure.identifier];
    //    NSString *perProcedure  = [[NSString alloc] init];
    //    NSString *perProcedure2 = @"";
    
    body = [body stringByAppendingString:@"\n\n"];
    
    //    if ([[[[_templateDictionary objectForKey:@"caseData"] objectAtIndex:4] valueForKey:@"value"] isEqualToString:@"Right renal mass"]) {
    //        perProcedure = [NSString stringWithFormat:@"right"];
    //    }else{
    //        perProcedure = [NSString stringWithFormat:@"left"];
    //    }
    NSMutableDictionary * caseDataOrderChange = [[NSMutableDictionary alloc] init];
    for (OKProcedureTemplateVariablesModel *caseDataModel in [_templateDictionary objectForKey:@"caseData"]) {
        [caseDataOrderChange setValue:caseDataModel forKey:caseDataModel.key];
    }
    
    
    NSMutableArray *caseDataChangeOrderArray = [[NSMutableArray alloc] init];
    if ([procID isEqualToString:@"1"]) {
        for (int i = 0; i<11; i++) {
            if (i == 0) {
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Patient Name"]];
            }
            else if (i == 1){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Patient DOB"]];
            }
            else if (i == 2){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Medical Record Number"]];
            }
            else if (i == 3){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Date Of Service"]];
            }
            else if (i == 4){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Pre-operative Diagnosis"]];
            }
            else if (i == 5){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Post-operative Diagnosis"]];
            }
            else if (i == 6){
                NSString *nerveSparring = [self.model valueForKey:@"var_nervesparing"];
                OKProcedureTemplateVariablesModel *caseDataModel = [caseDataOrderChange objectForKey:@"Procedure"];
                caseDataModel.value =[NSString stringWithFormat:@"%@ with %@",caseDataModel.value, nerveSparring];
                [caseDataChangeOrderArray addObject:caseDataModel];
            }
            else if (i == 7){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Surgeon";
                caseDataModel.value = [NSString stringWithFormat:@"%@ %@, %@", [OKUserManager instance].currentUser.firstName, [OKUserManager instance].currentUser.lastName , [OKUserManager instance].currentUser.title];
                [caseDataChangeOrderArray addObject:caseDataModel];
            }
            else if (i == 8){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Assistant"]];
            }
            else if (i == 9){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Anesthesia"]];
            }
            else if (i == 10){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Anesthesiologist";
                caseDataModel.value = [self.model valueForKey:@"var_anesthesiologist"];
                [caseDataChangeOrderArray addObject:caseDataModel];
            }
            
        }
    } else if ([procID isEqualToString:@"2"]) {
        for (int i = 0; i<10; i++) {
            if (i == 0) {
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Patient Name"]];
            } else if (i == 1){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Patient DOB"]];
                
            }else if (i == 2){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Medical Record Number"]];
                
            }else if (i == 3){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Date of Service"]];
                
            }else if (i == 4){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Pre-operative Diagnosis"]];
                
            }else if (i == 5){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Post-operative Diagnosis"]];
                
            }else if (i == 6){
                OKProcedureTemplateVariablesModel *caseDataModel = [caseDataOrderChange objectForKey:@"Procedure"];
                
                if ([[self.model valueForKey:@"var_cysto"] isEqualToString:@"YES"]) {
                    caseDataModel.value = [NSString stringWithFormat:@"%@ with cysto and right stent placement",caseDataModel.value];
                }
                NSString *right = [self.model valueForKey:@"var_preOp"];
                if ([right isEqualToString:@"Right renal mass"]) {
                    right = @"Right";
                    caseDataModel.value = [NSString stringWithFormat:@"%@ %@",right,caseDataModel.value];
                } else {
                    right = @"Left";
                    caseDataModel.value = [NSString stringWithFormat:@"%@ %@",right,caseDataModel.value];
                }
                
                [caseDataChangeOrderArray addObject:caseDataModel];
                
            }else if (i == 7){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Surgeon";
                caseDataModel.value = [NSString stringWithFormat:@"%@ %@, %@", [OKUserManager instance].currentUser.firstName, [OKUserManager instance].currentUser.lastName , [OKUserManager instance].currentUser.title];
                [caseDataChangeOrderArray addObject:caseDataModel];
                
            }else if (i == 8){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Assistant"]];
                
            }
            //            else if (i == 9){
            //                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Anesthesia"]];
            //
            //            }
            else if (i == 9){
                //_var_anesthesiologist
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Anesthesiologist";
                caseDataModel.value = [self.model valueForKey:@"var_anesthesiologist"];
                [caseDataChangeOrderArray addObject:caseDataModel];
                
            }
            
        }
        
    } else if ([procID isEqualToString:@"9"]) {
        for (int i = 0; i<9; i++) {
            if (i == 0) {
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Patient Name"]];
            } else if (i == 1){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Patient DOB"]];
                
            }else if (i == 2){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Medical Record Number"]];
                
            }else if (i == 3){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Date Of Service"]];
                
            }else if (i == 4){
                //var_diagnosis
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Pre-operative Diagnosis";
                caseDataModel.value = [self.model valueForKey:@"var_diagnosis"];
                [caseDataChangeOrderArray addObject:caseDataModel];
                //[caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Pre-operative Diagnosis"]];
                
            }else if (i == 5){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Post-operative Diagnosis";
                caseDataModel.value = @"Same";
                [caseDataChangeOrderArray addObject:caseDataModel];
                //[caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Post-operative Diagnosis"]];
                
            }else if (i == 6){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Procedure"]];
                
            }else if (i == 7){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Surgeon";
                caseDataModel.value = [NSString stringWithFormat:@"%@ %@, %@", [OKUserManager instance].currentUser.firstName, [OKUserManager instance].currentUser.lastName , [OKUserManager instance].currentUser.title];
                [caseDataChangeOrderArray addObject:caseDataModel];
                
            }
            //            else if (i == 8){
            //                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Assistant"]];
            //
            //            }
            else if (i == 8){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Anesthesia performed"]];
                
            }
            //            else if (i == 10){
            //                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Anesthesiologist"]];
            //
            //            }
            
        }
        
    } else if ([procID isEqualToString:@"10"]) {
        for (int i = 0; i<9; i++) {
            if (i == 0) {
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Patient Name"]];
            }
            else if (i == 1){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Patient DOB"]];
                
            }
            else if (i == 2){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Medical Record Number"]];
                
            }
            else if (i == 3){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Date Of Service"]];
                
            }
            else if (i == 4){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Pre-operative Diagnosis";
                caseDataModel.value = [self.model valueForKey:@"var_anesthesiaLocation"];
                if ([[[self.model valueForKey:@"var_stonesLocations"] objectAtIndex:0] isEqualToString:@"Upper pole, renal"] || [[[self.model valueForKey:@"var_stonesLocations"] objectAtIndex:0] isEqualToString:@"Mid-renal"] || [[[self.model valueForKey:@"var_stonesLocations"] objectAtIndex:0] isEqualToString:@"Lower pole, renal"] || [[[self.model valueForKey:@"var_stonesLocations"] objectAtIndex:0] isEqualToString:@"Renal pelvis"]) {
                    
                    caseDataModel.value = [NSString stringWithFormat:@"%@ Renal",caseDataModel.value ];
                } else {
                    caseDataModel.value = [NSString stringWithFormat:@"%@ Uretral",caseDataModel.value ];
                }
                
                if ([[self.model valueForKey:@"var_stonesCount"] isEqualToString:@"1"]) {
                    caseDataModel.value = [NSString stringWithFormat:@"%@ calculus",caseDataModel.value ];
                } else {
                    caseDataModel.value = [NSString stringWithFormat:@"%@ calculi",caseDataModel.value ];
                }
                
                [caseDataChangeOrderArray addObject:caseDataModel];
                
            }
            else if (i == 5){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Post-operative Diagnosis";
                caseDataModel.value = @"Same";
                [caseDataChangeOrderArray addObject:caseDataModel];
                
            }
            else if (i == 6){
                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Procedure"]];
                
            }
            else if (i == 7){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Surgeon";
                caseDataModel.value = [NSString stringWithFormat:@"%@ %@, %@", [OKUserManager instance].currentUser.firstName, [OKUserManager instance].currentUser.lastName , [OKUserManager instance].currentUser.title];
                [caseDataChangeOrderArray addObject:caseDataModel];
            }
            //            else if (i == 8){
            //                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Assistant"]];
            //
            //            }
            else if (i == 8){
                OKProcedureTemplateVariablesModel *caseDataModel = [[OKProcedureTemplateVariablesModel alloc] init];
                caseDataModel.key = @"Anesthesia";
                caseDataModel.value = [self.model valueForKey:@"var_anesthesiaPerformed"];
                [caseDataChangeOrderArray addObject:caseDataModel];
            }
            //            else if (i == 10){
            //                [caseDataChangeOrderArray addObject:[caseDataOrderChange objectForKey:@"Anesthesiologist"]];
            //                
            //            }
            
        }
        
    }

    
    
    for (OKProcedureTemplateVariablesModel *caseDataModel in caseDataChangeOrderArray) {
        if ([procID isEqualToString:@"1"]) {

            body = [body stringByAppendingFormat:@"%@: %@\n",[caseDataModel.key uppercaseString], caseDataModel.value ];
            
        }else if ([procID isEqualToString:@"2"]){
            body = [body stringByAppendingFormat:@"%@: %@\n",[caseDataModel.key uppercaseString], caseDataModel.value ];
        }else{
            body = [body stringByAppendingFormat:@"%@: %@\n",[caseDataModel.key uppercaseString], caseDataModel.value ];
        }
    }
    
    
    body = [body stringByAppendingFormat:@"\nINDICATIONS: %@ \n\n PROCEDURES: %@", [_templateDictionary objectForKey:@"indicationText"], [_templateDictionary objectForKey:@"procedureText"]];
    
    return body;
}


@end
