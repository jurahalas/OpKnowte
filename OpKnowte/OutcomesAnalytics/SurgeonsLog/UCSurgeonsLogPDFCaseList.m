//
//  UCSurgeonsLogPDFCaseList.m
//  MZUroCapture
//
//  Created by Atif Joyia on 25/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSurgeonsLogPDFCaseList.h"
#import "GentatePDFFile.h"
#import "UCSettingsViewController.h"
#import "UCHomeScreenViewController.h"
@interface UCSurgeonsLogPDFCaseList ()

@end

@implementation UCSurgeonsLogPDFCaseList

@synthesize procedureLbl, fromCaseNumLbl, fromDateLbl, toCaseNumLbl, toDateLbl;
@synthesize procedureName, fromCase, fromDate, toCase, toDate, selectedCases;
@synthesize templateModel, templateVariables, caseDataArray, indicationTxt, procedureTxt, caseSelected;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.templateVariables = [[NSMutableArray alloc] init];
        self.selectedCases = [[NSMutableArray alloc] init];
        self.caseDataArray = [[NSMutableArray alloc] init];
        self.caseSelected = [[NSMutableDictionary alloc] init];
        
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
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (IS_IPHONE_5) {
        l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    
    [self.procedureLbl setTextColor:[UIColor orangeColor]];
    [self.fromDateLbl setTextColor:[UIColor orangeColor]];
    [self.toDateLbl setTextColor:[UIColor orangeColor]];
    [self.fromCaseNumLbl setTextColor:[UIColor orangeColor]];
    [self.toCaseNumLbl setTextColor:[UIColor orangeColor]];
    
    [self.procedureLbl setText:self.procedureName];
    [self.fromDateLbl setText:self.fromDate];
    [self.toDateLbl setText:self.toDate];
    [self.fromCaseNumLbl setText:self.fromCase];
    [self.toCaseNumLbl setText:self.toCase];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"UCSelectProcedureCell";
    cellIdentifier = [cellIdentifier stringByAppendingFormat:@"%i",indexPath.row];
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setText:self.procedureName];
        [cell.textLabel setTextColor:[UIColor darkGrayColor]];
        
        [cell.detailTextLabel setBackgroundColor:[UIColor clearColor]];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@ to %@",self.fromDate, self.toDate]];
        [cell.detailTextLabel setTextColor:[UIColor colorWithRed:227.0/255.0 green:92.0/255.0 blue:23.0/255.0 alpha:1.0]];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



-(IBAction)print:(id)sender{
    //[self.selectedCases removeAllObjects];
    //[self.casesTable reloadData];
}

-(IBAction)createPDFs:(id)sender{
    
    //[UCUtility showBlockView];
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[UCWebServerHandler getTemplate:[defaults objectForKey:UD_USERID] withProcedureID:[UCAppDelegate sharedObject].selectedProcedure.procedureID withDelegate:self];
    
    NSString *body = @"";
    
    for (int i = 0; i < [self.selectedCases count]; i++) {
        //UCLRPNModel *parentModel = [UCUtility getCaseMode:[self.selectedCases objectAtIndex:i]];
        
        NSDictionary *caseData = [self.selectedCases objectAtIndex:i];
        //NSLog(@"%@",caseData);
        
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd"];
        NSDate *d1 = [formater dateFromString:[caseData objectForKey:@"DateOfService"]];
        [formater setDateFormat:@"MM-dd-yyyy"];
        NSString *str = [formater stringFromDate:d1];
        
        body = [body stringByAppendingFormat:@"%i:\nPatient Name: %@\nProcedure Name: %@\nDate Of Service: %@\nMedical record No. %@\nComplations: %@",i+1,[caseData objectForKey:@"Patient_Name"],[caseData objectForKey:@"PROCEDURE_ID"],str,[caseData objectForKey:@"MRNumber"],[caseData objectForKey:@"Complations"]];
       
        if (i != [self.selectedCases count]-1) {
            body = [body stringByAppendingFormat:@"\n\n"];
        }
        
    }
    
    // NSLog(@"%@",body);
    
    GentatePDFFile *pdfController = [[GentatePDFFile alloc] init];
    [pdfController genratePdfFile:body withPath:[NSString stringWithFormat:@"report.pdf"] size:[self.selectedCases count]];
    
    [self sendEmail:body];
    
}


#pragma mark - Operative note response

- (void)TemplateSuccessHandler:(ASIHTTPRequest *)request {
    
    NSString *response = [request responseString];
    // NSLog(@"%@",response);
    self.templateModel = [UCUtility getTemplateDetail:response];
    
    if ([[self.templateModel status] isEqualToString:@"true"]) {
        
        [UCWebServerHandler getTemplateVariables:[[UCAppDelegate sharedObject].selectedProcedure procedureID] WithDelagate:self];
    }
    else {
        
    }
    
    response = nil;
}

- (void)TemplateErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}


- (void)TemplateVariablesSuccessHandler:(ASIHTTPRequest *)request {
    [UCUtility hideBlockView];
    NSString *response = [request responseString];
    //NSLog(@"%@",response);
    self.templateVariables = [UCUtility getTemplateDetailVariables:response];
    
    if ([self.templateVariables count] > 0) {
        for (int i = 0; i < [self.selectedCases count]; i++) {
            [self.caseSelected removeAllObjects];
            
            UCLRPNModel *parentModel = [UCUtility getCaseMode:[self.selectedCases objectAtIndex:i]];
            
            [self loadCaseData:parentModel];
            [self dispLayIndicationsTextOnWebView:[self.templateModel indicationText] :parentModel];
            [self dispLayProcedureTextOnWebView:[self.templateModel procedureText] :parentModel];
            [self getEmailBody:parentModel];
        }
        
        //[self sendEmail];
        
    }
}

- (void)TemplateVariablesErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}


-(void)sendEmail:(NSString *)body{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"Operative Note"];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"report.pdf"]];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        [mailer addAttachmentData:data mimeType:@"application/pdf" fileName: [NSString stringWithFormat:@"Patients Log"]];
        
        [mailer setMessageBody:body isHTML:NO];
        
        [self presentModalViewController:mailer animated:YES];
        
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
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"report.pdf"]];
    [UCUtility deletePDF:filePath withDelay:120];

    [self dismissModalViewControllerAnimated:YES];
}



- (void)loadCaseData:(UCLRPNModel *)model {
    
    if (![[self.templateModel caseData] isEqualToString:@""]) {
        
        if (self.caseDataArray == nil) {
            self.caseDataArray = [[NSMutableArray alloc] init];
        }
        [self.caseDataArray removeAllObjects];
        
        NSString *tempStr = [self.templateModel caseData];
        tempStr = [tempStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
        tempStr = [tempStr stringByReplacingOccurrencesOfString:@")" withString:@""];
        
        
        NSMutableArray *selectedCaseDataArray = [NSMutableArray arrayWithArray:[tempStr componentsSeparatedByString:@","]];
        
        for (NSString *str in selectedCaseDataArray) {
            
            for (UCTemplateVariablesModel *allKeys in self.templateVariables) {
                if ([str isEqualToString:[allKeys key]]) {
                    
                    UCTemplateVariablesModel *tempModel = [[UCTemplateVariablesModel alloc]init];
                    
                    tempModel.value = allKeys.value;
                    tempModel.key = allKeys.key;
                    
                    [self.caseDataArray addObject:tempModel];
                    tempModel = nil;
                    break;
                }
            }
        }
    }
    else {
        [UCUtility showInfoAlertView:@"Information" withMessage:@"No case data template value found"];
    }
    
    //NSLog(@"%@",self.caseDataArray);
}

- (void)dispLayIndicationsTextOnWebView:(NSString *)text :(UCLRPNModel *)parentModel{
    
    self.indicationTxt = text;
    
    for(int i=0;i<self.templateVariables.count;i++)
    {
        UCTemplateVariablesModel *model = [self.templateVariables objectAtIndex:i];
       // NSLog(@"%@",model.key);
        
        NSString *details;// = [[NSString alloc] init];
        
        if ([model.key isEqualToString:@"var_assistant"] || [model.key isEqualToString:@"var_anesthesiologist"]) {
            //UCContactInfoModel *contact = [parentModel valueForKey:model.key];
            //details = contact.contactName;
            details = @"Atif Joyia";
        }else{
            details = [parentModel valueForKey:model.key];
        }
        
        if (details.length > 0) {
            self.indicationTxt = [self.indicationTxt stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",[model key]] withString:[NSString stringWithFormat:@"%@",details]];
        }else{
            
        }
        //NSLog(@"%@",details);
        model = nil;
    }
    
    //NSLog(@"%@",self.indicationTxt);
}


- (void)dispLayProcedureTextOnWebView:(NSString *)text :(UCLRPNModel *)parentModel {
    
    self.procedureTxt = text;
    
   // NSLog(@"%@",self.procedureTxt);
    
    for(int i=0;i<self.templateVariables.count;i++)
    {
        UCTemplateVariablesModel *model = [self.templateVariables objectAtIndex:i];
        //NSLog(@"%@",model.key);
        
        NSString *details;// = [[NSString alloc] init];
        
        if ([model.key isEqualToString:@"var_assistant"] || [model.key isEqualToString:@"var_anesthesiologist"]) {
            //UCContactInfoModel *contact = [parentModel valueForKey:model.key];
            //details = contact.contactName;
            details = @"Atif Joyia";
        }
        else if([model.key isEqualToString:@"var_preOp"])
        {
            details = [parentModel valueForKey:model.key];
            if([details isEqualToString:@"Left"])
            {
                details = @"spleen";
            }
            else
            {
                details = @"liver";
            }
        }
        else if([model.key isEqualToString:@"var_adhesions"])
        {
            details = [parentModel valueForKey:model.key];
            if([details isEqualToString:@"Yes"])
            {
                details = [NSString stringWithFormat:@"Adhesiolysis was necessary and was performed with sharp scissor dissection the dissection took %@ than 30 minutes.",[parentModel valueForKey:@"var_adhTook"]];
            }
            else
            {
                details = @"";
            }
        }else{
            details = [parentModel valueForKey:model.key];
        }
        
        if (details.length > 0) {
            
            if ([details isEqualToString:@"No"]) {
                
                self.procedureTxt = [self.procedureTxt stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",[model key]] withString:[NSString stringWithFormat:@""]];
                
            }else{
                self.procedureTxt = [self.procedureTxt stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",[model key]] withString:[NSString stringWithFormat:@"%@",details]];
            }
            
        }else{
            
            self.procedureTxt = [self.procedureTxt stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",[model key]] withString:[NSString stringWithFormat:@""]];
            
        }
        //NSLog(@"%@",details);
        model = nil;
    }
    
     //NSLog(@"%@",self.procedureTxt);
}


-(void)getEmailBody:(UCLRPNModel *)parentModel{
    NSString *body = [[NSString alloc] init];
    
    body = [body stringByAppendingString:@"\n\n"];
    
    for (int i = 0; i < [self.caseDataArray count]; i++) {
        //
        UCTemplateVariablesModel *tempModel = [self.caseDataArray objectAtIndex:i];
        
        NSString *name = [tempModel value];
        NSString *key = [tempModel key];
       // NSLog(@"%@",key);
        
        NSString *temp;// = [[NSString alloc] init];
        
        if ([key isEqualToString:@"var_assistant"] || [key isEqualToString:@"var_anesthesiologist"]) {
            //UCContactInfoModel *contact = [parentModel valueForKey:key];
            //temp = contact.contactName;
            temp = @"Atif Joyia";
        }else if ([key isEqualToString:@"var_preOp"]){
            
            temp = [NSString stringWithFormat:@"%@ Renal Mass",[parentModel valueForKey:key]];
            
        }else if ([key isEqualToString:@"var_procedureName"]){
            
            if ([parentModel.var_cysto isEqualToString:@"YES"]) {
                temp = [NSString stringWithFormat:@"%@ with cysto and %@ stent placement.",[parentModel valueForKey:key],[parentModel.var_preOp lowercaseString]];
            }else{
                temp = [NSString stringWithFormat:@"%@",[parentModel valueForKey:key]];
            }
            
        }else{
            temp = [parentModel valueForKey:key];
        }
        
        if (temp.length > 0) {
            body = [body stringByAppendingFormat:@"%@: %@",name,temp];
        }
        
        
        if (i <= [self.caseDataArray count]-1) {
            body = [body stringByAppendingString:@"\n"];
        }
    }
    
    
    body = [body stringByAppendingString:@"\n\n"];
    
    
    body = [body stringByAppendingFormat:@"Indications: %@ \n\n Procedures:%@",self.indicationTxt, self.procedureTxt];
    
    body = [body stringByReplacingOccurrencesOfString:@"(" withString:@""];
    body = [body stringByReplacingOccurrencesOfString:@")" withString:@""];
    
   // NSLog(@"%@",body);
    
    //GentatePDFFile *pdfController = [[GentatePDFFile alloc] init];
    
    //[pdfController genratePdfFile:body withPath:[NSString stringWithFormat:@"%@%@.pdf",parentModel.var_patientName,parentModel.var_MRNumber]];
}

- (IBAction)SettingsView:(id)sender {
    UCSettingsViewController *setting = nil;
    if(IS_IPHONE_5) {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController" bundle:nil];
    }
    else {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController_iphone" bundle:nil];
    }
    //UCSettingsViewController * setting =[[UCSettingsViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}

-(IBAction)home:(id)sender{
    if ([UCAppDelegate sharedObject].isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}

@end
