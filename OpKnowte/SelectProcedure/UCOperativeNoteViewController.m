  //
//  UCOperativeNoteViewController.m
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/29/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCOperativeNoteViewController.h"
#import "CONSTANTS.h"
#import "UCSettingsViewController.h"
#import "UCSendOperativeNoteViewController.h"


@interface UCOperativeNoteViewController ()

@end

@implementation UCOperativeNoteViewController

@synthesize templateModel;
@synthesize opTable;
@synthesize parent, indicationWV;
@synthesize caseDataBtn, indicatonBTn, procedureBtn, bottomBar;
@synthesize prOneBtn, prThreeBtn, prTwoBtn, prFiveBtn, prFourBtn;
@synthesize fwdBtn;
@synthesize procedureTV, prTable;
@synthesize tableArray;
@synthesize templateVariables;
@synthesize caseDataArray;
@synthesize indicationTxt;
@synthesize procedureTxt;
@synthesize parentModel;
@synthesize CCContacts;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.CCContacts = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.bottomBar setHidden:YES];
    [self.prOneBtn setHidden:YES];
    [self.prTwoBtn setHidden:YES];
    [self.prThreeBtn setHidden:YES];
    [self.prFourBtn setHidden:YES];
    [self.prFiveBtn setHidden:YES];
    
    //[self.fwdBtn setEnabled:NO];
    
    //hiding the indication table and case study table
    [self.indicationWV setHidden:YES];
    [self.opTable setHidden:NO];
    [self.prTable setHidden:YES];
    [self.procedureTV setHidden:YES];
    
    
    if ([UCAppDelegate sharedObject].selectedUser != nil) {
        
         [UCUtility showBlockView];
        [UCWebServerHandler getTemplate:[UCAppDelegate sharedObject].selectedUser.userID withProcedureID:[UCAppDelegate sharedObject].selectedProcedure.procedureID withDelegate:self];
        
    }else{
        
        [UCUtility showBlockView];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [UCWebServerHandler getTemplate:[defaults objectForKey:UD_USERID] withProcedureID:[UCAppDelegate sharedObject].selectedProcedure.procedureID withDelegate:self];
    }
    
    
    
    
    //here
    varsArray_ = [[NSMutableArray alloc] initWithObjects:@"var_adhesiolysis",@"var_preOp",@"var_vascularAnomolies",@"var_renalUltrasound",@"var_deepMargin",@"var_renalCollection",@"var_clampTime",@"var_cogulant",@"var_bloodLoss",@"var_counselTime",@"var_roomTime",@"var_complation",@"var_transfusion",@"var_cc",@"var_age",@"var_sex",@"var_tumorSize",@"var_location",@"var_tumorChar",@"var_history",@"var_Bmi", nil];
    
    self.tableArray = [[NSMutableArray alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated{
    //[self loadNotesArrays];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)homeButtonPressed:(id)sender {
    if ([UCAppDelegate sharedObject].isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}


#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag == 10) {
        return [self.caseDataArray count];
    }else if (tableView.tag == 20){
        return 10;
    }else
        return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (tableView.tag == 10) {
        
        if ([[[UCAppDelegate sharedObject].selectedProcedure procedureID] intValue] == 2) {
            
            UCTemplateVariablesModel *model = [self.caseDataArray objectAtIndex:indexPath.row];
            
            NSLog(@"%@",model.key);
            [cell.textLabel setText:model.key];
            [cell.textLabel setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:15]];
            [cell.textLabel setTextColor:[UIColor darkGrayColor]];
            
            NSString *details;
            
            if ([model.value isEqualToString:@"var_assistant"] || [model.value isEqualToString:@"var_anesthesiologist"]) {
                UCContactInfoModel *contact = (UCContactInfoModel *)[self.parent.parentModel valueForKey:model.value];
                NSLog(@"%@",[self.parent.parentModel valueForKey:model.value]);
                details = contact.contactName;
                NSLog(@"%@",details);
                NSLog(@"%@",self.parent.parentModel.var_assistant);
                
            }else if ([model.value isEqualToString:@"var_procedureName"]) {
                
                details = [NSString stringWithFormat:@"%@ %@",self.parent.parentModel.var_preOp,[[UCAppDelegate sharedObject].selectedProcedure procedureText]];
                self.parent.parentModel.var_procedureName = [NSString stringWithFormat:@"%@",details];
                
            }else if ([model.value isEqualToString:@"var_preOp"]){
                
                details = [NSString stringWithFormat:@"%@ Renal Mass",self.parent.parentModel.var_preOp];
                
            }else if ([model.value isEqualToString:@"var_cc"] ){
                
                NSLog(@"%@",[self.parent.parentModel valueForKey:model.value]);
                details = [UCUtility getCommaSeparatedString:[self.parent.parentModel valueForKey:model.value]];
                
                NSLog(@"%@",details);
                
            }else if ([model.value isEqualToString:@"var_DOS"] ){
                
                
                details = [self.parent.parentModel valueForKey:model.value];
                NSDateFormatter *formater = [[NSDateFormatter alloc] init];
                [formater setDateFormat:@"yyyy-MM-dd"];
                NSDate *d1 = [formater dateFromString:details];
                [formater setDateFormat:@"MM-dd-yyyy"];
                details = [formater stringFromDate:d1];
                
            }else if ([model.value isEqualToString:@"var_DOS"]){
                
                details = [self.parent.parentModel valueForKey:model.value];
                
            }
            else{
                details = [self.parent.parentModel valueForKey:model.value];
            }
            
            
            if (details.length > 0) {
                [cell.detailTextLabel setText:details];
            }else{
                [cell.detailTextLabel setText:@""];
            }
            
            [cell.detailTextLabel setFont:[UIFont fontWithName:@"PTSans-Regular" size:15]];
            [cell.detailTextLabel setTextColor:[UIColor colorWithRed:0.4863f green:0.7294f blue:0.7333 alpha:1.0f]];
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;

            
        }else if ([[[UCAppDelegate sharedObject].selectedProcedure procedureID] intValue] == 10){
            UCTemplateVariablesModel *model = [self.caseDataArray objectAtIndex:indexPath.row];
            
            [cell.textLabel setText:model.key];
            [cell.textLabel setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:15]];
            [cell.textLabel setTextColor:[UIColor darkGrayColor]];
            
            NSString *details;
            
            if ([model.value isEqualToString:@"var_DOS"] ){
                
                
                details = [self.parent.ESWLparentModel valueForKey:model.value];
                NSDateFormatter *formater = [[NSDateFormatter alloc] init];
                [formater setDateFormat:@"yyyy-MM-dd"];
                NSDate *d1 = [formater dateFromString:details];
                [formater setDateFormat:@"MM-dd-yyyy"];
                details = [formater stringFromDate:d1];
                
            }
            else{
                details = [self.parent.ESWLparentModel valueForKey:model.value];
            }
            
            
            if (details.length > 0) {
                [cell.detailTextLabel setText:details];
            }else{
                [cell.detailTextLabel setText:@""];
            }
            
            [cell.detailTextLabel setFont:[UIFont fontWithName:@"PTSans-Regular" size:15]];
            [cell.detailTextLabel setTextColor:[UIColor colorWithRed:0.4863f green:0.7294f blue:0.7333 alpha:1.0f]];
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;

        }
        
                
    }else if (tableView.tag == 20){
        
        
        
    }
    return cell;
    
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Operative note response 

- (void)TemplateSuccessHandler:(ASIHTTPRequest *)request {
    
    NSString *response = [request responseString];
    NSLog(@"%@",response);
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
    NSLog(@"%@",response);
    self.templateVariables = [UCUtility getTemplateDetailVariables:response];
    
    [self loadCaseData];
    [self dispLayIndicationsTextOnWebView:[self.templateModel indicationText]];
    [self dispLayProcedureTextOnWebView:[self.templateModel procedureText]];
    
}

- (void)TemplateVariablesErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}



-(void)loadProcedureTableArrays {
    /*
     NSMutableArray *temp = [[NSMutableArray alloc] init];
     int i = 1;
     while(i<8){
     UCOperativeNoteModel *model = [[UCOperativeNoteModel alloc] init];
     switch (i) {
     case 1:
     model.key = @"Estimated Blood loss (ml)";
     model.value = parent.parentModel.estimatedBloodLoss_;
     break;
     
     case 2:
     model.key = @"Counsel Time ";
     model.value = parent.parentModel.counslTime_;
     break;
     
     case 3:
     model.key = @"Room time was";
     model.value = parent.parentModel.roomTime_;
     break;
     
     case 4:
     model.key = @"Complications";
     model.value = parent.parentModel.complution_;
     break;
     
     case 5:
     model.key = @"Transfusion";
     model.value = parent.parentModel.transfusion_;
     break;
     
     case 6:
     model.key = @"# of unit";
     if ([parent.parentModel.transfusion_ isEqualToString:@"YES"]) {
     model.value = parent.parentModel.transfusionDesc_;
     }
     else{
     model.value = @"X";
     }
     break;
     
     case 7:
     model.key = @"CC";
     model.value = parent.parentModel.cc_;
     break;
     
     default:
     break;
     }
     [temp addObject:model];
     i++;
     }
     
     self.tableArray = [temp mutableCopy];
     [self.prTable reloadData];
     */
}

- (IBAction)opNoteSegmentControl:(UIButton *)sender {
    
    if ([self.procedureTV isFirstResponder]) {
        [self.procedureTV resignFirstResponder];
    }
    
    if (sender.tag == 1) {
        
        
        
        [self.bottomBar setHidden:YES];
        [self.prOneBtn setHidden:YES];
        [self.prTwoBtn setHidden:YES];
        [self.prThreeBtn setHidden:YES];
        [self.prFourBtn setHidden:YES];
        [self.prFiveBtn setHidden:YES];
        
        [self.caseDataBtn setUserInteractionEnabled:NO];
        [self.indicatonBTn setUserInteractionEnabled:YES];
        [self.procedureBtn setUserInteractionEnabled:YES];
        
        [self.caseDataBtn setBackgroundImage:[UIImage imageNamed:@"case_data_btn_pressed.png"] forState:UIControlStateNormal];
        [self.indicatonBTn setBackgroundImage:[UIImage imageNamed:@"indication_btn_unpressed.png"] forState:UIControlStateNormal];
        [self.procedureBtn setBackgroundImage:[UIImage imageNamed:@"procedure_btn_unpressed.png"] forState:UIControlStateNormal];
        
        //hiding the indication table and case study table
        [self.indicationWV setHidden:YES];
        [self.opTable setHidden:NO];
        [self.prTable setHidden:YES];
        [self.procedureTV setHidden:YES];
        
    }else if (sender.tag == 2){
        
        [self.caseDataBtn setUserInteractionEnabled:YES];
        [self.indicatonBTn setUserInteractionEnabled:NO];
        [self.procedureBtn setUserInteractionEnabled:YES];
        
        [self.bottomBar setHidden:YES];
        [self.prOneBtn setHidden:YES];
        [self.prTwoBtn setHidden:YES];
        [self.prThreeBtn setHidden:YES];
        [self.prFourBtn setHidden:YES];
        [self.prFiveBtn setHidden:YES];
        
        [self.caseDataBtn setBackgroundImage:[UIImage imageNamed:@"core_data_btn_unpressed.png"] forState:UIControlStateNormal];
        [self.indicatonBTn setBackgroundImage:[UIImage imageNamed:@"indication_btn_pressed.png"] forState:UIControlStateNormal];
        [self.procedureBtn setBackgroundImage:[UIImage imageNamed:@"procedure_btn_unpressed.png"] forState:UIControlStateNormal];
        
        
        //hiding the indication table and case study table
        [self.indicationWV setHidden:YES];
        [self.opTable setHidden:YES];
        [self.prTable setHidden:YES];
        [self.procedureTV setHidden:NO];
        
        [self dispLayIndicationsTextOnWebView:[self.templateModel indicationText]];
        
    } else if (sender.tag == 3){
        
        //enable/disable segment buttons
        [self.caseDataBtn setUserInteractionEnabled:YES];
        [self.indicatonBTn setUserInteractionEnabled:YES];
        [self.procedureBtn setUserInteractionEnabled:NO];
        
        //enable/disable procedure bottom buttons
//        [self.bottomBar setHidden:NO];
//        [self.prOneBtn setHidden:NO];
//        [self.prTwoBtn setHidden:NO];
//        [self.prThreeBtn setHidden:NO];
//        [self.prFourBtn setHidden:NO];
//        [self.prFiveBtn setHidden:NO];
        
        //changing images of segment buttons
        [self.caseDataBtn setBackgroundImage:[UIImage imageNamed:@"core_data_btn_unpressed.png"] forState:UIControlStateNormal];
        [self.indicatonBTn setBackgroundImage:[UIImage imageNamed:@"indication_btn_unpressed.png"] forState:UIControlStateNormal];
        [self.procedureBtn setBackgroundImage:[UIImage imageNamed:@"procedure_btn_presses.png"] forState:UIControlStateNormal];
        
        //hiding the indication table and case study table
        [self.indicationWV setHidden:YES];
        [self.opTable setHidden:YES];
        [self.prTable setHidden:YES];
        [self.procedureTV setHidden:NO];
        
        
        //set tex in procedure text view...
        //here
        
        //enable/disable procedure bottom buttons
//        [self.prOneBtn setUserInteractionEnabled:NO];
//        [self.prTwoBtn setUserInteractionEnabled:YES];
//        [self.prThreeBtn setUserInteractionEnabled:NO];
//        [self.prFourBtn setUserInteractionEnabled:NO];
//        [self.prFiveBtn setUserInteractionEnabled:NO];
        
        //changing images of bottom bar images.
//        [self.prOneBtn setBackgroundImage:[UIImage imageNamed:@"pr_one_pressed.png"] forState:UIControlStateNormal];
//        [self.prTwoBtn setBackgroundImage:[UIImage imageNamed:@"pr_two_unpressed.png"] forState:UIControlStateNormal];
//        [self.prThreeBtn setBackgroundImage:[UIImage imageNamed:@"pr_three_unpressed.png"] forState:UIControlStateNormal];
//        [self.prFourBtn setBackgroundImage:[UIImage imageNamed:@"pr_four_unpressed.png"] forState:UIControlStateNormal];
//        [self.prFiveBtn setBackgroundImage:[UIImage imageNamed:@"pr_five_unpressed.png"] forState:UIControlStateNormal];
        
        
        
        //set tex in procedure text view...
        
       // NSString *tempStr = [NSString stringWithFormat:@"The patient was brought to the operating room. SCD’s were on and functioning at the time of induction of anesthesia. A 16 french foley catheter was placed without complication in the standard fashion. The patient was then positioned in the flank position and the table was flexed. An axilllary role was placed. When it was clear the patient was well padded and secure, the patient was prepped and draped in the usual sterile fashion."];
        
        //NSLog(@"%@",tempStr);
        [self dispLayProcedureTextOnWebView:[self.templateModel procedureText]];
        //[self.procedureTV setText:tempStr];
    }
}


- (void)loadCaseData {
    
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
                    
                    tempModel.key = allKeys.value;
                    tempModel.value = allKeys.key;
                    
                    [self.caseDataArray addObject:tempModel];
                    tempModel = nil;
                    break;
                }
            }
        }
        
        [opTable reloadData];
        
    }
    else {
        [UCUtility showInfoAlertView:@"Information" withMessage:@"No case data template value found"];
    }
}


- (void)dispLayIndicationsTextOnWebView:(NSString *)text {
    
    self.indicationTxt = text;
    
    if ([[[UCAppDelegate sharedObject].selectedProcedure procedureID] intValue] == 10) {
        
        for(int i=0;i<self.templateVariables.count;i++)
        {
            
            UCTemplateVariablesModel *model = [self.templateVariables objectAtIndex:i];
            
            NSLog(@"%@",model.key);
            NSString *details;
            
            if ([model.key isEqualToString:@"var_assistant"] || [model.key isEqualToString:@"var_anesthesiologist"]) {
                UCContactInfoModel *contact = [self.parent.ESWLparentModel valueForKey:model.key];
                details = contact.contactName;
            }else{
                details = [self.parent.ESWLparentModel valueForKey:model.key];
            }
            
            if (details.length > 0) {
                self.indicationTxt = [self.indicationTxt stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",[model key]] withString:[NSString stringWithFormat:@"%@",details]];
            }else{
                
            }
            NSLog(@"%@",details);
            model = nil;
        }

        
    }else if ([[[UCAppDelegate sharedObject].selectedProcedure procedureID] intValue] == 2){
        
        for(int i=0;i<self.templateVariables.count;i++)
        {
            //UCTemplateVariablesModel *model = [[UCTemplateVariablesModel alloc] init];
            UCTemplateVariablesModel *model = [self.templateVariables objectAtIndex:i];
            
            NSLog(@"%@",model.key);
            NSString *details;
            
            if ([model.key isEqualToString:@"var_assistant"] || [model.key isEqualToString:@"var_anesthesiologist"]) {
                UCContactInfoModel *contact = [self.parent.parentModel valueForKey:model.key];
                details = contact.contactName;
            }else if([model.key isEqualToString:@"var_cc"]){
                
                NSLog(@"%@",[self.parent.parentModel valueForKey:model.key]);
                details = [UCUtility getCommaSeparatedString:[self.parent.parentModel valueForKey:model.key]];
                
                NSLog(@"%@",details);
                
            }else{
                details = [self.parent.parentModel valueForKey:model.key];
            }
            
            if (details.length > 0) {
                self.indicationTxt = [self.indicationTxt stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",[model key]] withString:[NSString stringWithFormat:@"%@",details]];
            }else{
                
            }
            NSLog(@"%@",details);
            model = nil;
        }

    }
    
    [self.procedureTV setText:self.indicationTxt];

}


- (void)dispLayProcedureTextOnWebView:(NSString *)text {
    
    self.procedureTxt = text;
    
    if ([[[UCAppDelegate sharedObject].selectedProcedure procedureID] intValue] == 2){
        
        for(int i=0;i<self.templateVariables.count;i++)
        {
            
            UCTemplateVariablesModel *model = [self.templateVariables objectAtIndex:i];
            
            NSString *details;// = [[NSString alloc] init];
            
            if ([model.key isEqualToString:@"var_assistant"] || [model.key isEqualToString:@"var_anesthesiologist"]) {
                UCContactInfoModel *contact = [self.parent.parentModel valueForKey:model.key];
                details = contact.contactName;
            }
            else if([model.key isEqualToString:@"var_preOp"])
            {
                details = [self.parent.parentModel valueForKey:model.key];
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
                details = [self.parent.parentModel valueForKey:model.key];
                if([details isEqualToString:@"Yes"])
                {
                    details = [NSString stringWithFormat:@"Adhesiolysis was necessary and was performed with sharp scissor dissection the dissection took %@ than 30 minutes.",self.parent.parentModel.var_adhTook];
                }
                else
                {
                    details = @"";
                }
            }else if([model.key isEqualToString:@"var_cc"]){
                
                NSLog(@"%@",[self.parent.parentModel valueForKey:model.key]);
                //details = [UCUtility getCommaSeparatedString:[self.parent.parentModel valueForKey:model.key]];
                if(self.CCContacts.count > 0)
                {
                    NSMutableString *str = [[NSMutableString alloc] init];
                    for(int i=0;i<self.CCContacts.count;i++)
                    {
                        UCContactInfoModel *model = (UCContactInfoModel *)[self.CCContacts objectAtIndex:i];
                        [str appendString:[NSString stringWithFormat:@"\n%i-\nName: %@\nAddress: %@\nFax Number: %@",i+1,model.contactName, model.contactStreetAddress, model.contactFax]];
                        //if(i != self.CCContacts.count-1)
                        //{
                            [str appendFormat:@"\n"];
                        //}
                    }
                    
                    details = [NSString stringWithFormat:@"%@",str];
                }
                
            }else{
                details = [self.parent.parentModel valueForKey:model.key];
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
            NSLog(@"%@",details);
            model = nil;
        }
    
    }else if ([[[UCAppDelegate sharedObject].selectedProcedure procedureID] intValue] == 10){
        
        for(int i=0;i<self.templateVariables.count;i++)
        {
            
            UCTemplateVariablesModel *model = [self.templateVariables objectAtIndex:i];
            NSLog(@"%@",model.key);
            NSString *details;// = [[NSString alloc] init];
            
            if ([model.key isEqualToString:@"var_assistant"] || [model.key isEqualToString:@"var_anesthesiologist"]) {
                UCContactInfoModel *contact = [self.parent.ESWLparentModel valueForKey:model.key];
                details = contact.contactName;
            }
            else{
                details = [self.parent.ESWLparentModel valueForKey:model.key];
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
            NSLog(@"%@",model.key);
            NSLog(@"%@",details);
            model = nil;
        }
    }
    
    [self.procedureTV setText:self.procedureTxt];
}


-(IBAction)bottomBarBtn:(UIButton *)sender{
    
    if (sender.tag == 1) {
        
        
        
    }else if (sender.tag == 2){
        
        if (sender.userInteractionEnabled) {
            
            [sender setUserInteractionEnabled:NO];
            [sender setBackgroundImage:[UIImage imageNamed:@"pr_two_pressed.png"] forState:UIControlStateNormal];
            [prThreeBtn setUserInteractionEnabled:YES];
            
            //set procedure text here...
            
            //( ( Adhesiolysis was necessary and was performed with sharp scissor dissection the dissection took  *20 (> or <) than 30 minutes). *20 (> or <) than 30 minutes).
            NSString *adhesion;
            if ([parent.parentModel.var_adhesions isEqualToString:@"No"]) {
                adhesion = [NSString stringWithFormat:@""];
                
            }else{
                adhesion = [NSString stringWithFormat:@"( Adhesiolysis was necessary and was performed with sharp scissor dissection the dissection took %@.",parent.parentModel.var_adhTook];
            }
            //NSLog(@"%@",adhesion);
            
            NSString *tempStr = [NSString stringWithFormat:@"We began the case by making a small incision in the subcostal region and introducing the 5 french excel sheath with a zero degree lens and looking our way into the abdomen. Once within the abdomen, we achieve a pneumoperitoneum to 15 mm of Hg, We then surveyed the abdomen and there was no evidence of visceral injury. %@ We then placed 4 additional ports under direct vision in a W formation. Two eight mm robotic canulas were place on either side of the 12mm Cameral port. 12mm and 5mm assistant ports were placed medial. We then docked the robotic and introduced our instrumentation under direct vision.",adhesion];
            
            //NSLog(@"%@",tempStr);
            
            [self.procedureTV setText:tempStr];
        }
        
    }else if (sender.tag == 3){
        
        if (sender.userInteractionEnabled) {
            
            [sender setUserInteractionEnabled:NO];
            [sender setBackgroundImage:[UIImage imageNamed:@"pr_three_pressed.png"] forState:UIControlStateNormal];
            [prFourBtn setUserInteractionEnabled:YES];
            
            //set procedure text here...
            
            NSString *str1;
            if ([parent.parentModel.var_preOp isEqualToString:@"Left renal mass"]) {
                str1 = [NSString stringWithFormat:@"spleen"];
            }else if ([parent.parentModel.var_preOp isEqualToString:@"Right renal mass"]){
                str1 = [NSString stringWithFormat:@"liver"];
            }
            
            NSString *str2;
            if ([parent.parentModel.var_vasAnomolies isEqualToString:@"No"]) {
                str2 = [NSString stringWithFormat:@"none"];
            }else{
                str2 = [NSString stringWithFormat:@"%@",parent.parentModel.var_vasAnomolies];
            }
            
            NSString *str3;
            if ([parent.parentModel.var_renalUltraSound isEqualToString:@"YES"]) {
                str3 = [NSString stringWithFormat:@"Intraoperative ultrasound was performed to aid in detection and isolation of the mass."];
            }else{
                str3 = [NSString stringWithFormat:@"No"];
            }
            
            NSString *str4;
            if ([parent.parentModel.var_margin isEqualToString:@"YES"]) {
                str4 = [NSString stringWithFormat:@"A deep margin was taken and sent for frozen section."];
            }else{
                str4 = [NSString stringWithFormat:@"No"];
            }
            
            NSString *str5;
            if ([parent.parentModel.var_RCSRepair isEqualToString:@"YES"]) {
                str5 = [NSString stringWithFormat:@"The collecting system was entered and was repaired with 2-0 v-lock suture."];
            }else{
                str5 = [NSString stringWithFormat:@"No"];
            }
            
            NSString *str6;
            if (![parent.parentModel.var_coagulant isEqualToString:@"No"]) {
                str6 = [NSString stringWithFormat:@"%@",parent.parentModel.var_coagulant];
            }else{
                str6 = [NSString stringWithFormat:@"No"];
            }
            
            NSString *tempStr = [NSString stringWithFormat:@"We began by mobilizing the colon medial and entering the retroperitoneum. The %@ was mobilized exposing the superior pole of the kidney. We then found the left renal vein and renal artery %@. Once the vessels were identified and isolated, the ureter was identified and avoided. Next, the renal mass was isolated. %@ Twelve and half grams of manitol was then given intravenously by the anesthesiologist. The renal artery was clamped with a bulldog clamp. The mass was then excised with sharp scissor dissection and cautery when necessary was utilized to maintain adequate hemostasis.  The mass was then captured in a bag to be retrieved later in the case. %@ %@ The renal capsule was reapproximated with 2-0 V-lock suture. When hemostasis was assured, the bulldog clamp was removed from the artery.  Clamp time was %@. Hemostasis continued to be excellent with the clamp removed. We then lowered the pneumoperitoneum to 0mm of Hg and hemostasis remained assured. We then put %@ over our repair site.",str1, str2, str3, str4, str5, parent.parentModel.var_clamp, str6];
            
            //NSLog(@"%@",tempStr);
            
            [self.procedureTV setText:tempStr];
        }
        
    }else if (sender.tag == 4){
        
        if (sender.userInteractionEnabled) {
            
            [sender setUserInteractionEnabled:NO];
            [sender setBackgroundImage:[UIImage imageNamed:@"pr_four_pressed.png"] forState:UIControlStateNormal];
            [prFiveBtn setUserInteractionEnabled:YES];
            
            //set procedure text here...
            
            NSString *tempStr = [NSString stringWithFormat:@"Next the robot was undocked and we retrieved the specimen which was labaled and sent to pathology. The incision was closed with 0-Vicryl.  The 12mm port was closed with 0-Vicryl with the Carter-Thomason technique. Incision were irrigated with sterile water and closed with subcuticular 4-) vicryl. The incisions were then dressed with benzoin and steri-strips.\n\nNeedle, Instrument and lap counts were correct.\n\nThe patient was awakened from general anesthesia and transported to recovery in stable condition."];
            
            //NSLog(@"%@",tempStr);
            
            [self.procedureTV setText:tempStr];
        }
        
        
    }else if (sender.tag == 5){
        
        if (sender.userInteractionEnabled) {
            
            [sender setUserInteractionEnabled:NO];
            [sender setBackgroundImage:[UIImage imageNamed:@"pr_five_pressed.png"] forState:UIControlStateNormal];
            
            //hiding the text view and un-hiding the table.
            [self.procedureTV setHidden:YES];
            [self.prTable setHidden:NO];
            
            //set procedure table here...
            
            [self loadProcedureTableArrays];
            
        }
    }
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


-(IBAction)forwardBtnPressed:(id)sender{
    UCSendOperativeNoteViewController *controller = [[UCSendOperativeNoteViewController alloc] initWithNibName:@"UCSendOperativeNoteViewController" bundle:nil];
    controller.parent = self.parent;
    controller.indicationText = self.indicationTxt;
    controller.procedureText = self.procedureTxt;
    controller.caseDataArray = self.caseDataArray; 
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    float height = 0;
    if (IS_IPHONE_5) {
        height = self.procedureTV.frame.size.height - 170;
    }else{
        height = self.procedureTV.frame.size.height - 216;
    }
    float x = self.procedureTV.frame.origin.x;
    float y = self.procedureTV.frame.origin.y;
    float width = self.procedureTV.frame.size.width;
    [self.procedureTV setFrame:CGRectMake(x, y, width, height)];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    float height = 0;
    if (IS_IPHONE_5) {
        height = self.procedureTV.frame.size.height + 170;
    }else{
        height = self.procedureTV.frame.size.height + 216;
    }
    float x = self.procedureTV.frame.origin.x;
    float y = self.procedureTV.frame.origin.y;
    float width = self.procedureTV.frame.size.width;
    [self.procedureTV setFrame:CGRectMake(x, y, width, height)];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}

@end
