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
        _facilityTableView.frame = CGRectMake(_facilityTableView.frame.origin.x, _facilityTableView.frame.origin.y, _facilityTableView.frame.size.width, (_facilityTableView.frame.size.height-57));
    }
    [self addBottomTabBar];
   
    [self addRightButtonToNavbar];
    if (![_cameFromVC isEqualToString:@"createProcedureVC"]){
        _roleID = @"4";
        _facilityTableView.allowsSelection = NO;
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
    if (faxNumbersList.length) {

        [self sendFaxTo:faxNumbersList];
    }else {
        UIAlertView *alertNoContacts = [[UIAlertView alloc] initWithTitle:@""
                                                                  message:@"Please select atleast one institute with fax number."
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil];
        [alertNoContacts show];
    }
}


-(void) sendFaxTo:(NSString*)faxNumberList
{
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    NSString *faxBody = [self getEmailBodyForProcedure];
    OKSendFaxManager *sendFaxManager = [OKSendFaxManager instance];
    [sendFaxManager sendFaxWithUserID:[OKUserManager instance].currentUser.identifier Message:faxBody AndFaxNumbers:faxNumberList handler:^(NSString *errorMsg, NSDictionary *json) {
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
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
            mailer.mailComposeDelegate = self;
            [mailer setSubject:@"Operative Note"];
            [mailer setToRecipients:[self getEmailAddress:_contactsSendTo]];
            [mailer setMessageBody:[self getEmailBodyForProcedure] isHTML:NO];
            [self presentViewController:mailer animated:YES completion:^{
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            }];
            
            mailer = nil;
        }
        else
        {
            UIAlertView *alertFailure = [[UIAlertView alloc] initWithTitle:@"No Email Account"
                                                            message:@"There are no Email accounts configured. You can add or create Email account in Settings."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alertFailure show];
        }
    }else {
        UIAlertView *alertNoContacts = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please select atleast one institute."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alertNoContacts show];
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
    OKFacilityTableViewCell *cell = (OKFacilityTableViewCell *)[_facilityTableView cellForRowAtIndexPath:indexPath];

    if ([_cameFromVC isEqualToString:@"createProcedureVC"]){
        [self.navigationController popViewControllerAnimated:YES];
        
        NSMutableArray *contactsArray = [[NSMutableArray alloc] init];
        [contactsArray addObject:cell.contact];
        [self.delegate setContactFieldWithContactArray:contactsArray];
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
        }
    }
    
    listFaxNumbers = [faxesArray componentsJoinedByString:@","];
    
    NSLog(@"%@",listFaxNumbers);
    return listFaxNumbers;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(NSString *)getEmailBodyForProcedure{
    NSString *body = [[NSString alloc] init];
    
    body = [body stringByAppendingString:@"\n\n"];
    
    for (OKProcedureTemplateVariablesModel *caseDataModel in [_templateDictionary objectForKey:@"caseData"]) {
        
        body = [body stringByAppendingFormat:@"%@: %@\n",caseDataModel.key, caseDataModel.value ];

    }
    
    body = [body stringByAppendingFormat:@"\nIndications: %@ \n\n Procedures: %@", [_templateDictionary objectForKey:@"indicationText"], [_templateDictionary objectForKey:@"procedureText"]];
    
    body = [body stringByReplacingOccurrencesOfString:@"(" withString:@""];
    body = [body stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    return body;
}




@end
