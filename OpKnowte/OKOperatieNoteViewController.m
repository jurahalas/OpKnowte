//
//  OKOperatieNoteViewController.m
//  OpKnowte
//
//  Created by Olegek on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKOperatieNoteViewController.h"
#import "OKFacilityVC.h"
#import "OKProceduresManager.h"

#import "OKShockwaveLithotripsyModel.h"
#import "OKLRPartialNephrectomyModel.h"
#import "OKProcedureTemplateModel.h"
#import "OKProcedureTemplateVariablesModel.h"
#import "OKContactManager.h"
#import "OKContactModel.h"
#import "OKFakeTableViewCell.h"

@interface OKOperatieNoteViewController () <UITextFieldDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic) IBOutlet UIView *segmentControllView;
@property (strong, nonatomic) IBOutlet UITableView *caseDataTableView;
@property (strong, nonatomic) IBOutlet UIView *IndicationView;
@property (strong, nonatomic) IBOutlet UIView *procedureView;
@property (strong, nonatomic) IBOutlet UIScrollView *indicationScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *procedureScrollView;

@property (strong, nonatomic) NSMutableArray *keysForValues;
@property (strong, nonatomic) NSMutableArray *caseDataValues;


@property (strong, nonatomic) IBOutlet UIView *saveButtonView;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@property (strong, nonatomic) NSMutableDictionary *templateDictionary;
@property (strong, nonatomic) NSMutableArray *caseDataArray;

@property (strong, nonatomic) IBOutlet UIView *segmentedControllView;

@property (strong, nonatomic) IBOutlet UIView *segmentControllios6;

@property (strong, nonatomic) IBOutlet UIButton *caseDatabtn;
@property (strong, nonatomic) IBOutlet UIButton *indicationbtn;
@property (strong, nonatomic) IBOutlet UIButton *procedureBtn;
@property (strong, nonatomic) IBOutlet UITextView *indicationTextView;
@property (strong, nonatomic) IBOutlet UITextView *procedureText;

@property (strong, nonatomic) OKProcedureTemplateModel *templateModel;
@end

@implementation OKOperatieNoteViewController
@synthesize segmentControl,caseDataTableView,IndicationView,procedureView,indicationScrollView,procedureScrollView,segmentControllView,segmentControllios6;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    _keysForValues = [[NSMutableArray alloc] init];
    _caseDataValues =[[NSMutableArray alloc] init];
    _caseDataArray =[[NSMutableArray alloc] init];
    _templateDictionary = [[NSMutableDictionary alloc] init];
    
    OKProceduresManager *procedureManager = [OKProceduresManager instance];
    
    [procedureManager getProcedureTemplateVariablesByProcedureID:[NSString stringWithFormat:@"%d", _procedureID] handler:^(NSString *errorMsg, NSMutableArray *templateVariables) {
        
        NSLog(@"Error - %@", errorMsg);
        _keysForValues = templateVariables;
        [procedureManager getProcedureTemplateByUserID:[OKUserManager instance].currentUser.identifier ProcedureID:[NSString stringWithFormat:@"%d", _procedureID] handler:^(NSString *errorMsg, NSDictionary *template) {
            NSLog(@"Error - %@", errorMsg);
            _templateModel = [[OKProcedureTemplateModel alloc] init];
            [_templateModel  setModelWithDictionary:template];
            
            NSString *tempStr =  _templateModel.caseData;
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@")" withString:@""];
            
            NSMutableArray *selectedCaseDataArray = [NSMutableArray arrayWithArray:[tempStr componentsSeparatedByString:@","]];
            
            for (NSString *str in selectedCaseDataArray) {
                
                for (OKProcedureTemplateVariablesModel *allKeys in self.keysForValues) {
                    
                    if ([str isEqualToString:allKeys.value]) {
                        
                        OKProcedureTemplateVariablesModel *tempModel = [[OKProcedureTemplateVariablesModel alloc]init];
                        
                        tempModel.key = allKeys.key;
                        tempModel.value = allKeys.value;
                        
                        [self.caseDataValues addObject:tempModel];
                        tempModel = nil;
                        break;
                    }
                }
            }
            [self updateCaseDataArray];
            [self.caseDataTableView reloadData];
            [self indicationMethod];
            [self procedureMethod];
            [[OKLoadingViewController instance] hide];
        }];
    }];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    segmentControllView.backgroundColor = [UIColor clearColor];
    _saveButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _saveButton.layer.cornerRadius = 14;
    _saveButton.clipsToBounds = YES;
    _saveButtonView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradientBG"]];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor whiteColor]} forState:UIControlStateSelected];
    
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"segmentControllBG.png"]];
    
    [self.segmentControllView addSubview:backgroundView];
    
    caseDataTableView.backgroundColor = [UIColor clearColor];
    
    self.caseDataTableView.dataSource = self;
    self.caseDataTableView.delegate = self;
    
    [self.caseDataTableView reloadData];
    
    self.caseDataTableView.hidden = NO;
    self.IndicationView.hidden = YES;
    self.procedureView.hidden = YES;
    
    if (IS_IOS7) {
        
        segmentControllios6.hidden = YES;
        
        self.segmentedControllView.layer.borderColor = [[UIColor whiteColor]CGColor];
        self.segmentedControllView.backgroundColor = [UIColor clearColor];
        
        
        [self .segmentControl setSelectedSegmentIndex:0];
        
        
        
        
        for (UIControl *subview in [segmentControl subviews]) {
            
            if ([subview isSelected]){
                [subview setTintColor:[UIColor colorWithRed: 255/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]];
            }
        }
        
        [self.segmentControl setDividerImage:[UIImage imageNamed:@"scSeparator"] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    }else {
        
        self.segmentedControllView.hidden = YES;
        
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
        
        segmentControllios6.backgroundColor = [UIColor clearColor];
        
        _caseDatabtn.tag = 1;
        _indicationbtn.tag = 2;
        _procedureBtn.tag = 3;
        
        self.caseDatabtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1SegmentControll"]];
    }
    [self setupNotifications];
}



-(void) updateCaseDataArray{
    for (int i = 0; i<[_caseDataValues count]; i++) {
        OKProcedureTemplateVariablesModel *variableModel = _caseDataValues[i];
        NSString *variableValue = [[NSString alloc] init];
        if ([[[_model valueForKey:variableModel.value] class] isSubclassOfClass:[NSMutableArray class]] ) {
            NSMutableArray *valuesArray = [[NSMutableArray alloc] init];
            valuesArray = [_model valueForKey:variableModel.value];
            for (int i = 0; i < valuesArray.count; i++) {
                if ([valuesArray[i] isEqualToString:@" "]) {
                    [valuesArray removeObjectAtIndex:i];
                    i--;
                }
            }
            
            variableValue = [[_model valueForKey:variableModel.value] componentsJoinedByString:@"; "];
        }
        //        else if([variableModel.value isEqualToString:@"var_physicans"] || [variableModel.value    isEqualToString:@"var_assistant"] || [variableModel.value isEqualToString:@"var_anesthesiologist"]){
        //            variableValue = [_model valueForKey:[NSString stringWithFormat:@"%@_names",variableModel.value]];
        //        }
        else {
            variableValue = [_model valueForKey:variableModel.value];
        }
        
        OKProcedureTemplateVariablesModel *caseDataObject = [[OKProcedureTemplateVariablesModel alloc]init];
        caseDataObject.key = variableModel.key;
        caseDataObject.value = variableValue;
        
        [self.caseDataArray addObject:caseDataObject];
    }
    
}



-(void)setupNotifications
{
    [[NSNotificationCenter defaultCenter]addObserverForName:UIKeyboardWillShowNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        
        CGRect frame_ind = CGRectMake(self.indicationTextView.frame.origin.x, self.indicationTextView.frame.origin.y, self.indicationTextView.frame.size.width, self.indicationTextView.frame.size.height-180);
        CGRect frame_proc = CGRectMake(self.procedureText.frame.origin.x, self.procedureText.frame.origin.y, self.procedureText.frame.size.width, self.procedureText.frame.size.height-180);
        
        [self.indicationTextView setFrame:frame_ind];
        [self.procedureText setFrame:frame_proc];
    }];
    
    [[NSNotificationCenter defaultCenter]addObserverForName:UIKeyboardDidHideNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        CGRect frame_ind = CGRectMake(self.indicationTextView.frame.origin.x, self.indicationTextView.frame.origin.y, self.indicationTextView.frame.size.width, self.indicationTextView.frame.size.height+180);
        CGRect frame_proc = CGRectMake(self.procedureText.frame.origin.x, self.procedureText.frame.origin.y, self.procedureText.frame.size.width, self.procedureText.frame.size.height+180);
        
        [self.indicationTextView setFrame:frame_ind];
        [self.procedureText setFrame:frame_proc];
    }];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        [_templateDictionary setObject:textView.text forKey:@"indicationText"];
    }
    return YES;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)indicationMethod{
    
    IndicationView.backgroundColor = [UIColor clearColor];
    
    NSString *indicationText = _templateModel.indicationText;
    
     if (_procedureID == 10) {
         
        if (![[_model valueForKey:@"var_stonesCount"] isEqualToString:@"1"]) {
            NSString *str = @"";
            NSString * stonesCount = [NSString stringWithFormat:@"%@",[_model valueForKey:@"var_stonesCount"]];
            int numberOfStones = [stonesCount intValue];
            
            for (int i = 0; i<numberOfStones; i++) {
                
                NSString *stoneDesc = [NSString stringWithFormat:@"(var_stonesSizes%d) mm (var_stonesLocations%d) stone, ",i,i];
                
                str = [str stringByAppendingString:
                       [NSString stringWithFormat:@"%@",stoneDesc]];
                
            }
            
            indicationText =  [indicationText stringByReplacingOccurrencesOfString:@"(var_stonesSizes)mm (var_stonesLocations) stone, " withString:str];
        }
         indicationText = [indicationText stringByReplacingOccurrencesOfString:@", (var_complications)" withString:@""];
     }
    
    

    indicationText =  [indicationText stringByReplacingOccurrencesOfString:@"None;" withString:@""];
    indicationText =  [indicationText stringByReplacingOccurrencesOfString:@"NO;" withString:@""];
    indicationText =  [indicationText stringByReplacingOccurrencesOfString:@"NO" withString:@""];
    indicationText =  [indicationText stringByReplacingOccurrencesOfString:@";" withString:@","];
    indicationText =  [indicationText stringByReplacingOccurrencesOfString:@"YES," withString:@""];
    indicationText =  [indicationText stringByReplacingOccurrencesOfString:@"(" withString:@""];
    indicationText =  [indicationText stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    
    for (OKProcedureTemplateVariablesModel *allKeys in self.keysForValues) {
        
        NSString *variableValue = [[NSString alloc] init];
        if ([[[_model valueForKey:allKeys.value] class] isSubclassOfClass:[NSMutableArray class]] ) {
            NSMutableArray *valuesArray = [[NSMutableArray alloc] init];
            valuesArray = [_model valueForKey:allKeys.value];
            for (int i = 0; i < valuesArray.count; i++) {
                if ([valuesArray[i] isEqualToString:@" "]) {
                    [valuesArray removeObjectAtIndex:i];
                    i--;
                }
            }
            
            variableValue = [[_model valueForKey:allKeys.value] componentsJoinedByString:@"; "];
        } else {
            variableValue = [_model valueForKey:allKeys.value];
        }
        if (variableValue != nil) {
            
            if (_procedureID == 10) {
                if ([[self.model valueForKey:@"var_stonesCount"] isEqualToString:@"1"]) {
                    indicationText = [indicationText stringByReplacingOccurrencesOfString:allKeys.value withString:variableValue];
                } else {
                    if ([allKeys.value isEqualToString:@"var_totalShocks"]) {
                        NSArray * array = [_model valueForKey:allKeys.value];
                        for (int i = 0; i<array.count; i++) {
                            NSString *value = [NSString stringWithFormat:@"%@%d",allKeys.value, i];
                            indicationText = [indicationText stringByReplacingOccurrencesOfString:value withString:[[self.model valueForKey:@"var_totalShocks"] objectAtIndex:i]];
                        }
                    } else if ([allKeys.value isEqualToString:@"var_stonesSizes"]){
                        NSArray * array = [_model valueForKey:allKeys.value];
                        for (int i = 0; i<array.count; i++) {
                            NSString *value = [NSString stringWithFormat:@"%@%d",allKeys.value, i];
                            indicationText = [indicationText stringByReplacingOccurrencesOfString:value withString:[[self.model valueForKey:@"var_stonesSizes"] objectAtIndex:i]];
                        }
                    } else if ([allKeys.value isEqualToString:@"var_stonesLocations"]) {
                        NSArray * array = [_model valueForKey:allKeys.value];
                        for (int i = 0; i<array.count; i++) {
                            NSString *value = [NSString stringWithFormat:@"%@%d",allKeys.value, i];
                            indicationText = [indicationText stringByReplacingOccurrencesOfString:value withString:[[self.model valueForKey:@"var_stonesLocations"] objectAtIndex:i]];
                        }
                    } else if ([allKeys.value isEqualToString:@"var_fragmentations"]) {
                        NSArray * array = [_model valueForKey:allKeys.value];
                        for (int i = 0; i<array.count; i++) {
                            NSString *value = [NSString stringWithFormat:@"%@%d",allKeys.value, i];
                            indicationText = [indicationText stringByReplacingOccurrencesOfString:value withString:[[self.model valueForKey:@"var_fragmentations"] objectAtIndex:i]];
                        }
                    }else{
                        indicationText = [indicationText stringByReplacingOccurrencesOfString:allKeys.value withString:variableValue];
                    }
                }
            }else{
                indicationText = [indicationText stringByReplacingOccurrencesOfString:allKeys.value withString:variableValue];
            }
        } else {
            indicationText = [indicationText stringByReplacingOccurrencesOfString:allKeys.value withString:@" "];
        }
    }
    indicationText =  [indicationText stringByReplacingOccurrencesOfString:@"None;" withString:@""];
    indicationText =  [indicationText stringByReplacingOccurrencesOfString:@"NO;" withString:@""];
    indicationText =  [indicationText stringByReplacingOccurrencesOfString:@"NO" withString:@""];
    indicationText =  [indicationText stringByReplacingOccurrencesOfString:@";" withString:@","];
    indicationText =  [indicationText stringByReplacingOccurrencesOfString:@"YES," withString:@""];
    _indicationTextView.text = indicationText;
    [_templateDictionary setObject:indicationText forKey:@"indicationText"];
}


-(void)procedureMethod{
    
    procedureView.backgroundColor = [UIColor clearColor];
    NSString * procedureText = _templateModel.procedureText;
    
    if (_procedureID == 1) {
        procedureText =  [procedureText stringByReplacingOccurrencesOfString:@")" withString:@""];
        procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"(" withString:@""];
        procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"NO." withString:@""];
        procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"None." withString:@""];
        
        
        if ([[_model valueForKey:@"var_pelvicDisection"] isEqualToString:@"YES"]) {
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"Next the if yes to #8 lymph node packets prostate and seminal vesicles were captured in the endocatch bag to be retrieved later in the case. We then checked for hemostasis which was very excellent. There was no evidence of rectal injury." withString:@"    Next the prostate and seminal vesicles were captured in the endocatch bag to be retrieved later in the case. We then checked for hemostasis which was very excellent. There was no evidence of rectal injury."];
        }else{
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"Next the if yes to #8 lymph node packets prostate and seminal vesicles were captured in the endocatch bag to be retrieved later in the case. We then checked for hemostasis which was very excellent. There was no evidence of rectal injury." withString:@""];
        }
        if ([[_model valueForKey:@"var_bladderNeckReconstruction"] isEqualToString:@"NO"]) {
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"var_bladderNeckReconstruction If yes: The bladder neck was then pulled up and repaired with a 2-0 vicryl and a standard “tennis racket repair”." withString:@""];
        }else{
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"var_bladderNeckReconstruction If yes: The bladder neck was then pulled up and repaired with a 2-0 vicryl and a standard “tennis racket repair”." withString:@"The bladder neck was then pulled up and repaired with a 2-0 vicryl and a standard “tennis racket repair”."];
        }
        if ([[_model valueForKey:@"var_sling"] isEqualToString:@"NO"]) {
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"var_slingA pubo-urethral sling was performed." withString:@""];
        }else{
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"var_slingA pubo-urethral sling was performed." withString:@"A pubo-urethral sling was performed"];
        }
        
        
    }else if (_procedureID == 9){
        procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"[" withString:@""];
        procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"]" withString:@""];
        
        if ([_model valueForKey:@"var_dilatedto"] != nil ) {
            procedureText = [procedureText stringByReplacingOccurrencesOfString:@"dilators (var_dilatedto) mm bilaterally" withString:@"dilators (var_dilatedto) bilaterally"];
        }
        
        if ([[_model valueForKey:@"var_reservoirplacement"] isEqualToString:@"inguinal retropubic"]) {
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Reservoir placement is “inguinal retropubic” use this paragraph Using blunt dissection, the (var_reservoirside) inguinal ring was identified and the transversalis pierced to create a retropubic space.  The (var_reservoirplacement) reservoir was placed and filled with (var_reservoirfilled)ml of saline."
                                                                      withString:@" Using blunt dissection, the (var_reservoirside) inguinal ring was identified and the transversalis pierced to create a retropubic space.  The (var_reservoirplacement) reservoir was placed and filled with (var_reservoirfilled)ml of saline."];
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Reservoir placement is “inguinal ectopic” use this paragraph Using blunt dissection, the (var_reservoirside) inguinal ring was identified.  A space above the transversalis but below the anterior fascia was created bluntly and the (var_reservoirplacement) reservoir was placed and filled with(var_reservoirfilled)ml of saline."
                                                                      withString:@""];
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Reservoir placement is “ectopic extraperitoneal” use this paragraph An incision was made lateral near the (var_reservoirside) anterior superior iliac spine.  Blunt dissection was performed to expose the fascia and a small opening in the fascia was made.  Stay sutures were placed and blunt dissection was performed deep to the fascia to create a lateral extraperitoneal space.  The (var_reservoirplacement) reservoir was placed and filled with (var_reservoirfilled)ml of saline.  The fascia was closed using the stay sutures.  The tubing was tunneled to the scrotum with blunt dissection."
                                                                      withString:@""];
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Reservoir placement is “other” use this paragraph An ectopic reservoir placement was performed.  See comments at end of report for details."
                                                                      withString:@""];
            
        }else if ([[_model valueForKey:@"var_reservoirplacement"] isEqualToString:@"inguinal ectopic"]){
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Reservoir placement is “other” use this paragraph An ectopic reservoir placement was performed.  See comments at end of report for details."
                                                                      withString:@""];
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Reservoir placement is “inguinal ectopic” use this paragraph Using blunt dissection, the (var_reservoirside) inguinal ring was identified.  A space above the transversalis but below the anterior fascia was created bluntly and the (var_reservoirplacement) reservoir was placed and filled with(var_reservoirfilled)ml of saline."
                                                                      withString:@" Using blunt dissection, the (var_reservoirside) inguinal ring was identified.  A space above the transversalis but below the anterior fascia was created bluntly and the (var_reservoirplacement) reservoir was placed and filled with(var_reservoirfilled)ml of saline."];
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Reservoir placement is “ectopic extraperitoneal” use this paragraph An incision was made lateral near the (var_reservoirside) anterior superior iliac spine.  Blunt dissection was performed to expose the fascia and a small opening in the fascia was made.  Stay sutures were placed and blunt dissection was performed deep to the fascia to create a lateral extraperitoneal space.  The (var_reservoirplacement) reservoir was placed and filled with (var_reservoirfilled)ml of saline.  The fascia was closed using the stay sutures.  The tubing was tunneled to the scrotum with blunt dissection."
                                                                      withString:@""];
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Reservoir placement is “other” use this paragraph An ectopic reservoir placement was performed.  See comments at end of report for details."
                                                                      withString:@""];
            
        }else if ([[_model valueForKey:@"var_reservoirplacement"] isEqualToString:@"ectopic extraperitoneal"]){
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Reservoir placement is “inguinal retropubic” use this paragraph Using blunt dissection, the (var_reservoirside) inguinal ring was identified and the transversalis pierced to create a retropubic space.  The (var_reservoirplacement) reservoir was placed and filled with (var_reservoirfilled)ml of saline."
                                                                      withString:@""];
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Reservoir placement is “inguinal ectopic” use this paragraph Using blunt dissection, the (var_reservoirside) inguinal ring was identified.  A space above the transversalis but below the anterior fascia was created bluntly and the (var_reservoirplacement) reservoir was placed and filled with(var_reservoirfilled)ml of saline."
                                                                      withString:@""];
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Reservoir placement is “ectopic extraperitoneal” use this paragraph An incision was made lateral near the (var_reservoirside) anterior superior iliac spine.  Blunt dissection was performed to expose the fascia and a small opening in the fascia was made.  Stay sutures were placed and blunt dissection was performed deep to the fascia to create a lateral extraperitoneal space.  The (var_reservoirplacement) reservoir was placed and filled with (var_reservoirfilled)ml of saline.  The fascia was closed using the stay sutures.  The tubing was tunneled to the scrotum with blunt dissection."
                                                                      withString:@"An incision was made lateral near the (var_reservoirside) anterior superior iliac spine.  Blunt dissection was performed to expose the fascia and a small opening in the fascia was made.  Stay sutures were placed and blunt dissection was performed deep to the fascia to create a lateral extraperitoneal space.  The (var_reservoirplacement) reservoir was placed and filled with (var_reservoirfilled)ml of saline.  The fascia was closed using the stay sutures.  The tubing was tunneled to the scrotum with blunt dissection."];
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Reservoir placement is “other” use this paragraph An ectopic reservoir placement was performed.  See comments at end of report for details."
                                                                      withString:@""];
            
        }else{
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Reservoir placement is “inguinal retropubic” use this paragraph Using blunt dissection, the (var_reservoirside) inguinal ring was identified and the transversalis pierced to create a retropubic space.  The (var_reservoirplacement) reservoir was placed and filled with (var_reservoirfilled)ml of saline."
                                                                      withString:@""];
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Reservoir placement is “inguinal ectopic” use this paragraph Using blunt dissection, the (var_reservoirside) inguinal ring was identified.  A space above the transversalis but below the anterior fascia was created bluntly and the (var_reservoirplacement) reservoir was placed and filled with(var_reservoirfilled)ml of saline."
                                                                      withString:@""];
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Reservoir placement is “ectopic extraperitoneal” use this paragraph An incision was made lateral near the (var_reservoirside) anterior superior iliac spine.  Blunt dissection was performed to expose the fascia and a small opening in the fascia was made.  Stay sutures were placed and blunt dissection was performed deep to the fascia to create a lateral extraperitoneal space.  The (var_reservoirplacement) reservoir was placed and filled with (var_reservoirfilled)ml of saline.  The fascia was closed using the stay sutures.  The tubing was tunneled to the scrotum with blunt dissection."
                                                                      withString:@""];
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Reservoir placement is “other” use this paragraph An ectopic reservoir placement was performed.  See comments at end of report for details."
                                                                      withString:@"An ectopic reservoir placement was performed.  See comments at end of report for details."];
            
        }
        if ([[_model valueForKey:@"var_drainplaced"] isEqualToString:@"YES"]) {
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Drain placed? is “yes” then use the following paragraph, if Drain placed? is “no” then exclude the paragraph  A JP drain was placed low in the scrotum and secured using a suture."
                                                                      withString:@" A JP drain was placed low in the scrotum and secured using a suture."];
        }else{
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                              @"If Drain placed? is “yes” then use the following paragraph, if Drain placed? is “no” then exclude the paragraph  A JP drain was placed low in the scrotum and secured using a suture."
                                                                      withString:@""];
        }
        if (![[_model valueForKey:@"var_reservoirplacement"] isEqualToString:@"inguinal retropubic"] && ![[_model valueForKey:@"var_reservoirplacement"] isEqualToString:@"inguinal ectopic"] && ![[_model valueForKey:@"var_reservoirplacement"] isEqualToString:@"ectopic extraperitoneal"]) {
            
            if (![[_model valueForKey:@"var_complications"] isEqualToString:@"NO"]) {
                procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                                  @"If Reservoir placement was “other”, or if Complications? was “yes”, then insert the free text entered here, if neither of those were selected then leave this paragraph out"
                                                                          withString:@"Reservoir placement: (var_reservoirplacement). Complications: (var_complications)."];
            }else{
                procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                                  @"If Reservoir placement was “other”, or if Complications? was “yes”, then insert the free text entered here, if neither of those were selected then leave this paragraph out"
                                                                          withString:@"Reservoir placement: (var_reservoirplacement)."];
            }
            
        }else{
            if (![[_model valueForKey:@"var_complications"] isEqualToString:@"NO"]) {
                procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                                  @"If Reservoir placement was “other”, or if Complications? was “yes”, then insert the free text entered here, if neither of those were selected then leave this paragraph out"
                                                                          withString:@"Reservoir placement: (var_reservoirplacement). Complications: (var_complications)."];
            }else{
                procedureText =  [procedureText stringByReplacingOccurrencesOfString:
                                  @"Additional surgical notes include: If Reservoir placement was “other”, or if Complications? was “yes”, then insert the free text entered here, if neither of those were selected then leave this paragraph out "
                                                                          withString:@""];
            }
        }
    }
    else if (_procedureID == 10) {
        if ([[_model valueForKey:@"var_stonesCount"] isEqualToString:@"1"]) {
            if ([[[_model valueForKey:@"var_totalShocks"]objectAtIndex:0] isEqualToString:@"1"]) {
                procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"A total of (var_totalShocks) were delivered to the" withString:@"A total of (var_totalShocks) shockwave was delivered to the"];
            }else{
                procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"A total of (var_totalShocks) were delivered to the" withString:@"A total of (var_totalShocks) shockwaves were delivered to the"];
            }
            
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"to the (var_stonesSizes) (var_stonesLocations)." withString:@"to the (var_stonesSizes) mm (var_stonesLocations) stone."];
            
        } else {
            
            NSString *str = @"";
            NSString *string = @"";
            NSString * stonesCount = [NSString stringWithFormat:@"%@",[_model valueForKey:@"var_stonesCount"]];
            int numberOfStones = [stonesCount intValue];
            
            for (int i = 0; i<numberOfStones; i++) {
                
                NSString *wasWere = @"";
                
                if ([[[_model valueForKey:@"var_totalShocks"]objectAtIndex:i] isEqualToString:@"1"]) {
                    wasWere = [NSString stringWithFormat:@"A total of (var_totalShocks%d) shockwave was delivered ",i];
                } else {
                    wasWere = [NSString stringWithFormat:@"A total of (var_totalShocks%d) shockwaves were delivered ",i];
                }
                
                NSString *stoneDesc = [NSString stringWithFormat:@"to the (var_stonesSizes%d) mm (var_stonesLocations%d) stone. ",i,i];

                str = [str stringByAppendingString:
                       [NSString stringWithFormat:@"%@%@",wasWere,stoneDesc]];
                
                NSString *description = [NSString stringWithFormat:@" There was (var_fragmentations%d) fragmentation of the (var_stonesSizes%d) mm (var_stonesLocations%d) stone.",i,i,i];
                string = [string stringByAppendingString:[NSString stringWithFormat:@"%@",description]];
                
            }
            
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"A total of (var_totalShocks) were delivered to the (var_stonesSizes) (var_stonesLocations)." withString:str];
            procedureText = [procedureText stringByReplacingOccurrencesOfString:@"There was (var_fragmentations) fragmentation of the (var_stonesSizes) (var_stonesLocations)." withString:string];
        }

        
        procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"Shockwaves were delivered at a rate of (var_rateOfWaves) and (var_KVWaves)." withString:@"Shockwaves were delivered at a rate of (var_rateOfWaves) and (var_KVWaves) Kv."];
        
        if ([[_model valueForKey:@"var_pausePerformed"] isEqualToString:@"YES"]) {
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"(var_pausePerformed). " withString:@"A 2 minute pause was performed at the beginning of the procedure. "];
        }else{
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"(var_pausePerformed). " withString:@""];
        }
        if ([[_model valueForKey:@"var_complications"] isEqualToString:@"None"]) {
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"(var_complications)." withString:@"There were no complications."];
        }else{
            procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"(var_complications)." withString:@"Complications included: (var_complications)."];
        }
        procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"There was (var_fragmentations) fragmentation of the (var_stonesSizes) (var_stonesLocations)." withString:@"There was (var_fragmentations) fragmentation of the (var_stonesSizes) mm (var_stonesLocations) stone."];
        
    }
    
    for (OKProcedureTemplateVariablesModel *allKeys in self.keysForValues) {
        
        NSString *variableValue = [[NSString alloc] init];
        if ([[[_model valueForKey:allKeys.value] class] isSubclassOfClass:[NSMutableArray class]] ) {
            //allKeys.value = var_totalShocks
            NSMutableArray *valuesArray = [[NSMutableArray alloc] init];
            valuesArray = [_model valueForKey:allKeys.value];
            for (int i = 0; i < valuesArray.count; i++) {
                if ([valuesArray[i] isEqualToString:@" "]) {
                    [valuesArray removeObjectAtIndex:i];
                    i--;
                }
            }
            
            variableValue = [[_model valueForKey:allKeys.value] componentsJoinedByString:@"; "];

        
        } else {
            variableValue = [_model valueForKey:allKeys.value];
        }
        if (variableValue != nil) {
            if (_procedureID == 10) {
                if ([[self.model valueForKey:@"var_stonesCount"] isEqualToString:@"1"]) {
                    procedureText = [procedureText stringByReplacingOccurrencesOfString:allKeys.value withString:variableValue];
                } else {
                    if ([allKeys.value isEqualToString:@"var_totalShocks"]) {
                        NSArray * array = [_model valueForKey:allKeys.value];
                        for (int i = 0; i<array.count; i++) {
                            NSString *value = [NSString stringWithFormat:@"%@%d",allKeys.value, i];
                            procedureText = [procedureText stringByReplacingOccurrencesOfString:value withString:[[self.model valueForKey:@"var_totalShocks"] objectAtIndex:i]];
                        }
                    } else if ([allKeys.value isEqualToString:@"var_stonesSizes"]){
                        NSArray * array = [_model valueForKey:allKeys.value];
                        for (int i = 0; i<array.count; i++) {
                            NSString *value = [NSString stringWithFormat:@"%@%d",allKeys.value, i];
                            procedureText = [procedureText stringByReplacingOccurrencesOfString:value withString:[[self.model valueForKey:@"var_stonesSizes"] objectAtIndex:i]];
                        }
                    } else if ([allKeys.value isEqualToString:@"var_stonesLocations"]) {
                        NSArray * array = [_model valueForKey:allKeys.value];
                        for (int i = 0; i<array.count; i++) {
                            NSString *value = [NSString stringWithFormat:@"%@%d",allKeys.value, i];
                            procedureText = [procedureText stringByReplacingOccurrencesOfString:value withString:[[self.model valueForKey:@"var_stonesLocations"] objectAtIndex:i]];
                        }
                    } else if ([allKeys.value isEqualToString:@"var_fragmentations"]) {
                        NSArray * array = [_model valueForKey:allKeys.value];
                        for (int i = 0; i<array.count; i++) {
                            NSString *value = [NSString stringWithFormat:@"%@%d",allKeys.value, i];
                            procedureText = [procedureText stringByReplacingOccurrencesOfString:value withString:[[self.model valueForKey:@"var_fragmentations"] objectAtIndex:i]];
                        }
                    }else{
                       procedureText = [procedureText stringByReplacingOccurrencesOfString:allKeys.value withString:variableValue];
                    }
                }
            } else {
                procedureText = [procedureText stringByReplacingOccurrencesOfString:allKeys.value withString:variableValue];

            }

        } else {
            procedureText = [procedureText stringByReplacingOccurrencesOfString:allKeys.value withString:@" "];
        }
    }
    
    
    procedureText =  [procedureText stringByReplacingOccurrencesOfString:@")" withString:@""];
    procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"(" withString:@""];
    procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"NO." withString:@""];
    procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"NO" withString:@""];
    procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"YES" withString:@""];
    procedureText =  [procedureText stringByReplacingOccurrencesOfString:@"None." withString:@""];
    //
    //
    //    NSString *procedureString = [procedureText stringByReplacingOccurrencesOfString:@"(" withString:@""];
    //    procedureString = [procedureString stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    _procedureText.text = procedureText;
    [_templateDictionary setObject:procedureText forKey:@"procedureText"];
}


#pragma mark IBAction
- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)segmentControlButton:(UISegmentedControl *)sender {
    UIColor *selectedColor = [UIColor colorWithRed: 255/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    UIColor *deselectedColor = [UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    
    for (UIControl *subview in [segmentControl subviews]) {
        
        if ([subview isSelected]){
            [subview setTintColor:selectedColor];
        }
        else
            [subview setTintColor:deselectedColor];
    }
    
    self.IndicationView.hidden = YES;
    self.procedureView.hidden = YES;
    self.caseDataTableView.hidden = YES;
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.caseDataTableView.hidden = NO;
            break;
        case 1:
            self.IndicationView.hidden = NO;
            break;
        case 2:
            self.procedureView.hidden = NO;
        default:
            break;
    }
    
    
}
#pragma mark Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _caseDataValues.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FakeCellIdentifier = @"FakeCell";
    OKFakeTableViewCell *FakeCell = [[OKFakeTableViewCell alloc] init];
    
    static NSString *cellIdentifier = @"caseData";
    OKOperatieNoteTableViewCell * cell = [[OKOperatieNoteTableViewCell alloc]init];
    if (indexPath.row < [_caseDataValues count]) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[OKOperatieNoteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
//        //      OKContactManager *contactsManager = [OKContactManager instance];
//        OKProcedureTemplateVariablesModel *variableModel = _caseDataValues[indexPath.row];
//        NSString *variableValue = [[NSString alloc] init];
//        if ([[[_model valueForKey:variableModel.value] class] isSubclassOfClass:[NSMutableArray class]] ) {
//            NSMutableArray *valuesArray = [[NSMutableArray alloc] init];
//            valuesArray = [_model valueForKey:variableModel.value];
//            for (int i = 0; i < valuesArray.count; i++) {
//                if ([valuesArray[i] isEqualToString:@" "]) {
//                    [valuesArray removeObjectAtIndex:i];
//                    i--;
//                }
//            }
//            
//            variableValue = [[_model valueForKey:variableModel.value] componentsJoinedByString:@"; "];
//        }
//        //        else if([variableModel.value isEqualToString:@"var_physicans"] || [variableModel.value    isEqualToString:@"var_assistant"] || [variableModel.value isEqualToString:@"var_anesthesiologist"]){
//        //            variableValue = [_model valueForKey:[NSString stringWithFormat:@"%@_names",variableModel.value]];
//        //        }
//        else {
//            variableValue = [_model valueForKey:variableModel.value];
//        }
//        
//        OKProcedureTemplateVariablesModel *caseDataObject = [[OKProcedureTemplateVariablesModel alloc]init];
//        caseDataObject.key = variableModel.key;
//        caseDataObject.value = variableValue;
//        
//        [self.caseDataArray addObject:caseDataObject];

        
//        NSMutableArray *caseData = [[NSMutableArray alloc]init];
//        [caseData addObject:caseDataObject];
        
        
//       if([[caseData objectAtIndex:indexPath.row] valueForKey:@"key"] isEqualToString:[self.caseDataArray objectAtIndex:inde])

        
        //[cell setLabelsWithKey:variableModel.key AndValue:variableValue ];
        [cell setLabelsWithKey:[[_caseDataArray objectAtIndex:indexPath.row] valueForKey:@"key"] AndValue:[[_caseDataArray objectAtIndex:indexPath.row] valueForKey:@"value"]];
        [tableView setContentInset:UIEdgeInsetsMake(1.0, 0.0, 0.0, 0.0)];
        return cell;
        
    }else{
        FakeCell = [tableView dequeueReusableCellWithIdentifier:FakeCellIdentifier forIndexPath:indexPath];
        if (!FakeCell) {
            FakeCell = [[OKFakeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FakeCellIdentifier];
        }
        return FakeCell;
    }
}
- (IBAction)saveButtonTapped:(id)sender {
    
    NSMutableSet * mySet = [[NSMutableSet alloc]initWithArray:self.caseDataArray ];
    self.caseDataArray = nil;
    self.caseDataArray = [[NSMutableArray alloc]initWithArray:[mySet allObjects]];
    NSMutableSet * newSet = [[NSMutableSet alloc]initWithArray:self.caseDataArray ];
    self.caseDataArray = nil;
    self.caseDataArray = [[NSMutableArray alloc]initWithArray:[newSet allObjects]];
    
//  if(self.procedureID == 1)
//    NSMutableArray *caseData = [[NSMutableArray alloc]init];
//
//    for(int i = 0; i<=self.caseDataArray.count; i++){
//        if(caseData.count ==0 || ![caseData containsObject:self.caseDataArray]){
//            [caseData addObject:[self.caseDataArray objectAtIndex:i]];
//        }
//    }
//    self.caseDataArray = caseData;
    
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    OKProceduresManager *proceduresManager = [OKProceduresManager instance];
    
    [proceduresManager saveProcedureWithSurgeonID:[OKUserManager instance].currentUser.identifier ProcedureID:[NSString stringWithFormat:@"%d", _procedureID] AndProcedureModel:self.model handler:^(NSString *errorMsg, id json) {
        
        NSLog(@"Error - %@", errorMsg);
        [[OKLoadingViewController instance] hide];
        if (errorMsg == nil) {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
            OKFacilityVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"FacilityVC"];
//            NSSet *caseSet = [NSSet setWithArray:_caseDataArray];
//            NSMutableArray *arrayFromSet = [[NSMutableArray alloc] init];
//            for (id model in caseSet) {
//                [arrayFromSet addObject:model];
//            }
//            
            [_templateDictionary setObject:_caseDataArray forKey:@"caseData"];
            
            vc.templateDictionary = _templateDictionary;
            vc.model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
            //[self performSegueWithIdentifier:@"fromOpNoteToFacility" sender:self];
            
        } else {
            if ([[json valueForKey:@"status"] isEqualToString:@"false"]) {
                UIAlertView *alertNoContacts = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                          message:[json valueForKey:@"msg"]
                                                                         delegate:nil
                                                                cancelButtonTitle:@"OK"
                                                                otherButtonTitles: nil];
                [alertNoContacts show];
                
            }else {
                UIAlertView *alertNoContacts = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                          message:errorMsg
                                                                         delegate:nil
                                                                cancelButtonTitle:@"OK"
                                                                otherButtonTitles: nil];
                [alertNoContacts show];
            }
        }
        
        [[OKLoadingViewController instance] hide];
        
        
    }];
    
}
- (IBAction)segmentControllIOS6:(UIButton *)sender {
    self.IndicationView.hidden = YES;
    self.procedureView.hidden = YES;
    self.caseDataTableView.hidden = YES;
    
    self.caseDatabtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1SegmentControll"]];
    self.indicationbtn.backgroundColor = nil;
    self.procedureBtn.backgroundColor = nil;
    
    switch (sender.tag) {
        case 1:
            self.caseDataTableView.hidden = NO;
            self.caseDatabtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1SegmentControll"]];
            break;
        case 2:
            self.IndicationView.hidden = NO;
            self.indicationbtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2SegmentControll"]];
            self.caseDatabtn.backgroundColor = nil;
            break;
        case 3:
            self.procedureView.hidden = NO;
            self.procedureBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"3SegmentControll"]];
            self.caseDatabtn.backgroundColor = nil;
        default:
            break;
    }
}

@end