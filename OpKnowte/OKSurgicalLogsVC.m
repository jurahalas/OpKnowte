//
//  OKSurgicalLogsVC.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/11/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSurgicalLogsVC.h"
#import "OKSLListCell.h"
#import "RangeSlider.h"
#import "OKProcedureModel.h"
#import "OKDatePicker.h"
#import "OKSurgicalLogsManager.h"
#import "OKPDFGenerator.h"
#import <MessageUI/MessageUI.h>
#import "OKSendFaxManager.h"
#import "OKFakeTableViewCell.h"


@interface OKSurgicalLogsVC () <OKSLListCellDelegate, MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIView *procedureView;
@property (strong, nonatomic) IBOutlet UILabel *procedureLabel;
@property (strong, nonatomic) IBOutlet UIButton *procedureButton;


@property (strong, nonatomic) IBOutlet UIView *dateView;
@property (strong, nonatomic) IBOutlet OKCustomTextField *dateFromTF;
@property (strong, nonatomic) IBOutlet OKCustomTextField *dateToTF;

@property (strong, nonatomic) OKDatePicker *datePicker;
@property (strong, nonatomic) UIView *pickerBGView;
@property (strong, nonatomic) IBOutlet UIButton *dateFromButton;
@property (strong, nonatomic)IBOutlet UIButton *dateToButton;


@property (strong, nonatomic) IBOutlet UILabel *caseFromLabel;
@property (strong, nonatomic) IBOutlet UILabel *caseToLabel;

@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) IBOutlet UILabel *diselectAllLabel;
@property (strong, nonatomic) IBOutlet UIButton *diselectAllButton;
@property (strong, nonatomic) IBOutlet UILabel *searchLabel;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@property (strong, nonatomic) IBOutlet UITableView *listTableView;

@property (strong, nonatomic) IBOutlet UIView *emailAndFaxView;
@property (strong, nonatomic) IBOutlet UIButton *emailButton;
@property (strong, nonatomic) IBOutlet UIButton *faxButton;

@property(strong,nonatomic) RangeSlider *slider;


@property (nonatomic, strong) NSMutableArray *detailsArray;
@property (nonatomic, strong) NSMutableArray *choosedDetails;
@property (nonatomic, assign) BOOL deselectAll;
@property (nonatomic, strong) NSDateFormatter *dateformater;
@property (nonatomic, assign) BOOL dateFromButtonTapped;
@property (nonatomic, assign) BOOL dateToButtonTapped;
@end

@implementation OKSurgicalLogsVC

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
    self.listTableView.delegate=self;
    self.listTableView.dataSource=self;
    _detailsArray = [[NSMutableArray alloc] init];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"Surgical Logs";
    [self addLeftButtonToNavbar];
    _procedureLabel.text = _procTitle;
    _choosedDetails = [[NSMutableArray alloc] init];
    [self setDatePickerDesign];
	[self setDesign];
    [_listTableView reloadData];
    _dateFromButton.tag = 1;
    _dateToButton.tag = 2;

    
    
}

-(void) setDatePickerDesign {
    float yPoint;
    if (IS_IPHONE_5 ) {
        yPoint = 406;
    } else {
        yPoint = 318;
    }
    _pickerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, yPoint, 320, 162)];
    _pickerBGView.backgroundColor = [UIColor colorWithRed:24/255. green:59/255. blue:85/255. alpha:.90];
    self.datePicker = [[OKDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 162)];
    [self.datePicker setTextColor:[UIColor whiteColor]];
    _dateformater = [[NSDateFormatter alloc] init];
    [_dateformater setDateFormat:@"MM-dd-yyyy"];
    [self.datePicker setMaximumDate:[NSDate date]];
    [self.view addSubview:_pickerBGView];
    [_pickerBGView addSubview:_datePicker];
    _pickerBGView.hidden = YES;
    
    
    
}
-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    if (IS_IOS7) {
        right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width, [UIImage imageNamed:@"back"].size.height );
    } else {
        right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width +27, [UIImage imageNamed:@"back"].size.height );}
    
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
}


-(void)viewWillAppear:(BOOL)animated{
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    OKSurgicalLogsManager *surgicalLogsManager = [OKSurgicalLogsManager instance];
    [surgicalLogsManager getSurgeonDatesByUserID:[OKUserManager instance].currentUser.identifier AndProcedureID:_procID handler:^(NSString *errorMsg, id dates) {
        NSLog(@"Eror - %@", errorMsg);

        if ((dates) && ([dates count] > 0)) {
            
            int count = [dates count];
            _dateFromTF.text = [dates objectAtIndex:0];
            _dateToTF.text = [dates objectAtIndex:count-1];
            
        }
        [[OKLoadingViewController instance] hide];
    }];
    
}


- (IBAction)procedureButtonTapped:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)faxButtonTapped:(id)sender {
    if (_choosedDetails.count) {
        UIAlertView *customAlertView = [[UIAlertView alloc] initWithTitle:@"Send fax"
                                                                  message:@"Please enter fax number."
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                        otherButtonTitles:@"Send", nil];
        
        customAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [customAlertView textFieldAtIndex:0].placeholder = @"Fax Number";
        [customAlertView show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Choose at least one case"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }

    
   
    

    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        NSLog(@"THE 'Cancel' BUTTON WAS PRESSED");

    }
    if (buttonIndex == 1) {
        
        if ([alertView.title isEqualToString:@"Send fax"]) {
            
            if ([alertView textFieldAtIndex:0].text.length) {
                [[OKLoadingViewController instance] showWithText:@"Loading..."];
                NSString *faxNumber = [[NSString alloc] init];
                faxNumber = [NSString stringWithFormat:@"%@@smartfax.com",[alertView textFieldAtIndex:0].text];

                [self sendFaxTo:faxNumber];
                
            } else {
 
            }
            
        }
    }
}
-(void) sendFaxTo:(NSString*)faxNumberList{
    
    NSString *faxBody = [self getMessageBody];
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

- (IBAction)emailButtonTapped:(id)sender {
    if (_choosedDetails.count) {
        [self generatePDF];
        [self sendEmail:[self getMessageBody]];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Choose at least one case"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}


- (void) generatePDF {
    OKPDFGenerator *pdfController = [[OKPDFGenerator alloc] init];
    [pdfController genratePdfFile:[self getMessageBody] withPath:[NSString stringWithFormat:@"report.pdf"] size:[_choosedDetails count]];
    
}


-(NSString*) getMessageBody{
    NSString *body = @"";
    
    for (int i = 0; i < [_choosedDetails count]; i++) {
        //UCLRPNModel *parentModel = [UCUtility getCaseMode:[self.selectedCases objectAtIndex:i]];
        
        id caseData = [_choosedDetails objectAtIndex:i];
        
        //NSLog(@"%@",caseData);
        
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd"];
        NSDate *d1 = [formater dateFromString:[caseData valueForKey:@"var_DOS"]];
        [formater setDateFormat:@"MM-dd-yyyy"];
        NSString *str = [formater stringFromDate:d1];
        
        
        if ([[caseData valueForKey:@"var_procedureName"] isEqualToString:@"Shockwave Lithotripsy"]) {
             body = [body stringByAppendingFormat:@"%i:\nPatient Name: %@\nProcedure Name: %@\nDate Of Service: %@\nMedical record No. %@\nComplications: %@",i+1,[caseData valueForKey:@"var_patientName"],[caseData valueForKey:@"var_procedureName"],str,[caseData valueForKey:@"var_MRNumber"],[caseData valueForKey:@"var_complications"]];
        }else if ([[caseData valueForKey:@"var_procedureName"] isEqualToString:@"Laparoscopic Robotic Radical Prostatectomy"]) {
            body = [body stringByAppendingFormat:@"%i:\nPatient Name: %@\nProcedure Name: %@\nDate Of Service: %@\nMedical record No. %@",i+1,[caseData valueForKey:@"var_patientName"],[caseData valueForKey:@"var_procedureName"],str,[caseData valueForKey:@"var_MRNumber"]];
        }else if ([[caseData valueForKey:@"var_procedureName"] isEqualToString:@"Insertion of Penile Prosthesis"]) {
            body = [body stringByAppendingFormat:@"%i:\nPatient Name: %@\nProcedure Name: %@\nDate Of Service: %@\nMedical record No. %@\nComplications: %@",i+1,[caseData valueForKey:@"var_patientName"],[caseData valueForKey:@"var_procedureName"],str,[caseData valueForKey:@"var_MRNumber"],[caseData valueForKey:@"var_complications"]];
        }else {
             body = [body stringByAppendingFormat:@"%i:\nPatient Name: %@\nProcedure Name: %@\nDate Of Service: %@\nMedical record No. %@\nComplications: %@",i+1,[caseData valueForKey:@"var_patientName"],[caseData valueForKey:@"var_procedureName"],str,[caseData valueForKey:@"var_MRNumber"],[caseData valueForKey:@"var_complation"]];
        }
       
        
        if (i != [_choosedDetails count]-1) {
            body = [body stringByAppendingFormat:@"\n\n"];
        }
        
    }
    return body;
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
        alertFailure = nil;
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:{
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;}
        case MFMailComposeResultSaved:{
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            UIAlertView *alertSave = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"Email saved in Drafts"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
            [alertSave show];
            break;}
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
    [self deletePDF:filePath withDelay:120];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)deletePDF:(NSString *)path withDelay:(int)delay{
    [self performSelector:@selector(deleteFile:) withObject:path afterDelay:delay];
}

- (void)deleteFile:(NSString *)fileName{
    NSLog(@"%@",fileName);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:fileName error:nil];
}

- (IBAction)diselectAllButton:(id)sender {
    [_choosedDetails removeAllObjects];
    _deselectAll = YES;
    [_listTableView reloadData];
}


- (IBAction)searchButton:(id)sender {
    if (_dateFromTF.text.length == 0 || _dateToTF.text.length == 0) {
        UIAlertView *emptyFieldsError = [[UIAlertView alloc] initWithTitle:@"" message:@"Please fill all required fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [emptyFieldsError show];
    }else{
        
        if ([self varifyDates]) {
            [[OKLoadingViewController instance] showWithText:@"Loading..."];
           
            OKSurgicalLogsManager *surgicalLogsManager = [OKSurgicalLogsManager instance];
            [surgicalLogsManager getSurgeonPerformanceDataByUserID:[OKUserManager instance].currentUser.identifier ProcedureID:_procID FromTime:_dateFromTF.text ToTime:_dateToTF.text FromRecordNum:_caseFromLabel.text ToRecordNum:_caseToLabel.text handler:^(NSString *errorMsg, NSMutableArray *dataArray) {
                NSLog(@"Eror - %@", errorMsg);
                
                _detailsArray = [self getFilterArray:dataArray];
                _deselectAll = YES;
                [_listTableView reloadData];
                [[OKLoadingViewController instance] hide];
            }];
    }else{
        UIAlertView *dateError = [[UIAlertView alloc] initWithTitle:@"" message:@"From time cannot be in future of To time" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [dateError show];

    }
}

}

-(NSMutableArray *)getFilterArray:(NSMutableArray *)data{
    NSMutableArray *filtered = [[NSMutableArray alloc] init];
    
   
    int total = [data count];
    int from = [_caseFromLabel.text intValue];
    int to = [_caseToLabel.text intValue];

    
    for (int i = 0; i<total; i++) {
        id model = data[i];
        int MRNumber =[[model valueForKey:@"var_MRNumber"] intValue];
        if ( MRNumber >= from && MRNumber <=to ) {
            [filtered addObject:data[i]];
        }
    }
    
    return filtered;
}


-(BOOL)varifyDates{
    NSDate *d1;
    NSDate *d2;
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"MM-dd-yyyy"];
    d1 = [dateFormat1 dateFromString:_dateFromTF.text];
    d2 = [dateFormat1 dateFromString:_dateToTF.text];
    
    NSComparisonResult result = [d2 compare:d1];
    
    switch (result)
    {
        case NSOrderedAscending: NSLog(@"%@ is in future from %@", d1, d2);
            return NO;
            break;
        case NSOrderedDescending: NSLog(@"%@ is in past from %@", d1, d2);
            return YES;
            break;
        case NSOrderedSame: NSLog(@"%@ is the same as %@", d1, d2);
            return YES;
            break;
        default: NSLog(@"erorr dates %@, %@", d1, d2);
            return NO;
            break;
    }
}


- (IBAction)dateFromButtonTapped:(id)sender {
    if (!_dateToButtonTapped) {
        if (_pickerBGView.hidden) {
            if (_dateFromTF.text.length > 0) {
                [self.datePicker setDate:[_dateformater dateFromString:_dateFromTF.text]];
            } else {
                NSString *str = @"01-01-1950";
                [self.datePicker setDate:[_dateformater dateFromString:str]];
            }
            _dateFromButtonTapped = YES;
        } else {
            _dateFromTF.text = [NSString stringWithFormat:@"%@", [_dateformater stringFromDate:self.datePicker.date]];
            _dateFromButtonTapped = NO;
        }
        _pickerBGView.hidden = !_pickerBGView.hidden;

    }
    
}
- (IBAction)dateToButtonTapped:(id)sender {
    if (!_dateFromButtonTapped) {
        if (_pickerBGView.hidden) {
            if (_dateToTF.text.length > 0) {
                [self.datePicker setDate:[_dateformater dateFromString:_dateToTF.text]];
            } else {
                [self.datePicker setDate:[NSDate date]];
            }
            _dateToButtonTapped = YES;
        } else {
            _dateToTF.text = [NSString stringWithFormat:@"%@", [_dateformater stringFromDate:self.datePicker.date]];
            _dateToButtonTapped = NO;
        }
        _pickerBGView.hidden = !_pickerBGView.hidden;
    }
    

}

- (void)backButton {
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void) setDesign{
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    _procedureView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellDark"]];
    _listTableView.backgroundColor = [UIColor clearColor];
    _dateView.backgroundColor = [UIColor colorWithRed:19/255.f green:65/255.f blue:91/255.f alpha:1];
    _dateFromTF.text = @"";
    _dateToTF.text = @"";
    
    
    
    _searchView.backgroundColor = [UIColor clearColor];
    _emailAndFaxView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradientBG"]];
    _emailButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _emailButton.layer.cornerRadius = 14;
    _emailButton.clipsToBounds = YES;
    _faxButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _faxButton.layer.cornerRadius = 14;
    _faxButton.clipsToBounds = YES;
    
    
    
    _slider = [[RangeSlider alloc] initWithFrame:CGRectMake(60, 90, 244, 20)]; // the slider enforces a height of 30, although I'm not sure that this is necessary
	_slider.minimumRangeLength = .000005; // this property enforces a minimum range size. By default it is set to 0.0
	[_slider setMinThumbImage:[UIImage imageNamed:@"rangethumb.png"]]; // the two thumb controls are given custom images
	[_slider setMaxThumbImage:[UIImage imageNamed:@"rangethumb.png"]];
	UIImage *image; // there are two track images, one for the range "track", and one for the filled in region of the track between the slider thumbs
	[_slider setTrackImage:[[UIImage imageNamed:@"fullrange.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(9.0, 9.0, 9.0, 9.0)]];
	image = [UIImage imageNamed:@"fillrange.png"];
	[_slider setInRangeTrackImage:image];
    [_slider addTarget:self action:@selector(report:) forControlEvents:UIControlEventValueChanged]; // The slider sends actions when the value of the minimum or maximum changes
	NSString *caseFromString = [NSString stringWithFormat:@"%d", (int)(_slider.min*100000)];
	_caseFromLabel.text = caseFromString;
    NSString *caseToString = [NSString stringWithFormat:@"%d", (int)(_slider.max*100000)];
    _caseToLabel.text = caseToString;
    [self.dateView addSubview:_slider];
    
}


- (void)report:(RangeSlider *)sender {
	NSString *caseFromString = [NSString stringWithFormat:@"%d", (int)(_slider.min*100000)];
	_caseFromLabel.text = caseFromString;
    NSString *caseToString = [NSString stringWithFormat:@"%d", (int)(_slider.max*100000)];
    _caseToLabel.text = caseToString;
    
}
#pragma mark - tableView methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_detailsArray.count) {
        return 0;
    } else {
         return _detailsArray.count+1;
    }
    
    
}
-(void)addModelToList:(id)model{
    [_choosedDetails addObject:model];
    
}
-(void)deleteModelFromList:(id)model{
    for (int i = 0; i<_choosedDetails.count; i++) {
        if ([[_choosedDetails[i] valueForKey:@"DetailID"] isEqualToString:[model valueForKey:@"DetailID"]]) {
            [_choosedDetails removeObjectAtIndex:i];
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SLlistCell";
    OKSLListCell  * cell = [[OKSLListCell alloc]init];
    
    static NSString *FakeCellIdentifier = @"FakeCell";
    OKFakeTableViewCell *FakeCell = [[OKFakeTableViewCell alloc] init];
    
    if (indexPath.row < [_detailsArray count]) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[OKSLListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]  ;
        }
        if (_deselectAll) {
            [cell setCellButtonBGImageWithGreenMinusIcon:NO];
            if (indexPath.row == _detailsArray.count-1) {
                _deselectAll = NO;
            }
        }
    
    
        id model = _detailsArray[indexPath.row];
        cell.model = model;
        cell.nameLabel.text = [model valueForKey:@"var_patientName"];
        cell.dateLabel.text = [model valueForKey:@"var_DOS"];
        cell.delegate = self;
        return cell;
    }

    else{
        FakeCell = [tableView dequeueReusableCellWithIdentifier:FakeCellIdentifier forIndexPath:indexPath];
        if (!FakeCell) {
            FakeCell = [[OKFakeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FakeCellIdentifier];
        }
        return FakeCell;
    }
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
