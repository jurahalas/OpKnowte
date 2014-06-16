//
//  OKBaseProcedureVC.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/24/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseProcedureVC.h"
#import "OKProcedureTextField.h"
#import "OKProcedureSwitcher.h"
#import "OKProcedureDatePicker.h"
#import "OKProcedurePicker.h"
#import "OKOperatieNoteViewController.h"
#import "OKProcedureMultiselectVC.h"
#import "OKProcedureMultiselect.h"
#import "OKDatePicker.h"
#import "OKProceduresManager.h"
#import "OKSelectContact.h"
#import "OKFacilityVC.h"
#import "OKContactModel.h"
#import "OKBMIViewController.h"

@interface OKBaseProcedureVC () <OKProcedureDatePickerDelegate, OKProcedurePickerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, OKProcedureMultiselectDelegate, UITextFieldDelegate, OKSelectContactDelegate, OKFacilityVCDelegate, OKDatePickerProtocol,OKProcedureTextFieldDelegate,UIAlertViewDelegate,OKBMICalcViewDelegeta>

@property (nonatomic, strong) NSArray *pickerData;
@property (nonatomic, weak) OKProcedurePicker *pickerObject;
@property (nonatomic, weak) OKProcedureDatePicker *datePickerObject;
@property (nonatomic, weak) OKSelectContact *selectContactObject;

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic,strong) UIView *pickerBGView;
@property (nonatomic, strong) UIButton * doneButtonForDatePicker;

@property (nonatomic,strong)UIView * bmiBackgroundView;
@property (nonatomic, strong) OKCustomTextField * height;
@property (nonatomic, strong) OKCustomTextField * weight;
@property (nonatomic, strong) UIButton * calc;
@property (nonatomic, strong) UIButton * cancel;
@property (nonatomic, weak) OKProcedureTextField *BMITextField;

@property (nonatomic,strong) UIButton * BMIButton;

@property (nonatomic, strong) NSString * dateTo;
@property (nonatomic, strong) NSString * dateFrom;

@property (nonatomic,strong)UIView * timeBackgroundView;
@property (nonatomic, strong) UIView *timeView;
@property (nonatomic, strong) OKCustomTextField * timeFrom;
@property (nonatomic, strong) OKCustomTextField * timeTo;
@property (nonatomic, strong) UIButton * timeFromButton;
@property (nonatomic, strong) UIButton * timeToButton;
@property (nonatomic, strong) UIButton * calcTime;
@property (nonatomic, strong) UIButton * cancelTime;
@property (nonatomic, strong) NSString * timeValue;
@property (nonatomic, weak) OKProcedureTextField *TimeTextField;
@property (nonatomic, weak) OKProcedureTextField *TimeRoomTextField;
@property (nonatomic, weak) OKProcedureTextField *TimeOPTextField;
@property (nonatomic, weak) OKProcedureTextField *TimeCTextField;

@property (nonatomic,strong) UIButton * TimeButton;
@property (nonatomic,strong) UIButton * TimeRoomButton;
@property (nonatomic,strong) UIButton * TimeOPButton;
@property (nonatomic,strong) UIButton * TimeCButton;

@property (strong, nonatomic) UIPickerView *timePicker;
@property (strong, nonatomic) UIPickerView *timeToPicker;
@property (nonatomic,strong) UIView *timePickerBGView;

@property (nonatomic, strong) NSMutableArray *hoursArray;
@property (nonatomic, strong) NSMutableArray *minutesArray;
@property (nonatomic, strong) NSMutableArray *ampmArray;
@property (nonatomic, strong) UIButton * doneButtonForTimePicker;


@property (nonatomic, assign) BOOL timeFromButtonTapped;
@property (nonatomic, assign) BOOL timeToButtonTapped;

@property (nonatomic, strong) OKBMIViewController *bmiView;

@property (nonatomic,strong) OKProcedureTextField * currentTF;
@property (nonatomic,strong) UIButton * currentButton;

@property (nonatomic,strong) NSMutableArray * currentTime;
@property (nonatomic) int tag;

@end

@implementation OKBaseProcedureVC


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(id) nextVC{
    return nil;
}


-(BOOL) canGoToNextVC{
    return false;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _hoursArray = [[NSMutableArray alloc] initWithArray:@[@"01",
                                                          @"02",
                                                          @"03",
                                                          @"04",
                                                          @"05",
                                                          @"06",
                                                          @"07",
                                                          @"08",
                                                          @"09",
                                                          @"10",
                                                          @"11",
                                                          @"12"
                                                          ]];
    
    _minutesArray = [[NSMutableArray alloc] initWithArray:@[@"00",
                                                            @"01",
                                                            @"02",
                                                            @"03",
                                                            @"04",
                                                            @"05",
                                                            @"06",
                                                            @"07",
                                                            @"08",
                                                            @"09",
                                                            @"10",
                                                            @"11",
                                                            @"12",
                                                            @"13",
                                                            @"14",
                                                            @"15",
                                                            @"16",
                                                            @"17",
                                                            @"18",
                                                            @"19",
                                                            @"20",
                                                            @"21",
                                                            @"22",
                                                            @"23",
                                                            @"24",
                                                            @"25",
                                                            @"26",
                                                            @"27",
                                                            @"28",
                                                            @"29",@"30",
                                                            @"31",
                                                            @"32",
                                                            @"33",
                                                            @"34",
                                                            @"35",
                                                            @"36",
                                                            @"37",
                                                            @"38",
                                                            @"39",@"40",
                                                            @"41",
                                                            @"42",
                                                            @"43",
                                                            @"44",
                                                            @"45",
                                                            @"46",
                                                            @"47",
                                                            @"48",
                                                            @"49",@"50",
                                                            @"51",
                                                            @"52",
                                                            @"53",
                                                            @"54",
                                                            @"55",
                                                            @"56",
                                                            @"57",
                                                            @"58",
                                                            @"59"
                                                            
                                                            ]];
    _ampmArray = [[NSMutableArray alloc] initWithArray:@[@"AM",
                                                         @"PM"
                                                         ]];
       if (IS_IOS7) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonTapped:)];
        self.navigationItem.leftBarButtonItem = backButton;
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"right"] style:UIBarButtonItemStyleBordered target:self action:@selector(rightButtonTapped:)];
        self.navigationItem.rightBarButtonItem = nextButton;
    }
    else{
        [self addRightButtonForiOS6];
        [self addLeftButtonForiOS6];
    }
    self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-51.f)];
    self.scrollview.contentSize = CGSizeMake(320, 600);
    self.scrollview.hidden = NO;
    self.scrollview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scrollview];
    [self addBottomTabBar];
    
    if (IS_IOS7){
        _pickerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-162, 320, 162)];
    }else{
        _pickerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-206, 320, 162)];
    }
    
    _pickerBGView.backgroundColor = [UIColor colorWithRed:24/255. green:59/255. blue:85/255. alpha:.90];
    _pickerBGView.hidden = YES;
    [self.view addSubview:_pickerBGView];
    
    self.interactionItems = [[NSMutableArray alloc] init];
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 162)];
    self.datePicker = [[OKDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 162)];
    [self.datePicker setTextColor:[UIColor whiteColor]];
    self.picker.hidden = YES;
    self.datePicker.hidden = YES;
    self.datePicker.delegate = self;
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.picker.showsSelectionIndicator = YES;
    [_pickerBGView addSubview:self.datePicker];
    [_pickerBGView addSubview:self.picker];
    

    _doneButtonForDatePicker = [UIButton buttonWithType:UIButtonTypeCustom];
    [_doneButtonForDatePicker addTarget:self action:@selector(doneButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_doneButtonForDatePicker setTitle:@"Done" forState:UIControlStateNormal];
    _doneButtonForDatePicker.frame = CGRectMake(210, _pickerBGView.frame.origin.y-35, 100, 30);
   _doneButtonForDatePicker.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _doneButtonForDatePicker.layer.cornerRadius = 14;
    _doneButtonForDatePicker.clipsToBounds = YES;
    _doneButtonForDatePicker.hidden = YES;
    [self.view addSubview:_doneButtonForDatePicker];
    [self.view bringSubviewToFront:_doneButtonForDatePicker];
    
    [self drawBMIView];
    _bmiBackgroundView.hidden = YES;
  //  _bmiView.hidden = YES;
    
    [self drawTimeView];
    _currentTF = [[OKProcedureTextField alloc]init];
    _currentButton = [[UIButton alloc]init];
    
    _dateTo = [[NSString alloc]init];
    _dateFrom = [[NSString alloc]init];
    
    _currentTime = [[NSMutableArray alloc]init];
}
-(void) BMIButtontapped{
    _BMIButton.hidden = NO;
    [self.view endEditing:YES];
    _alertBMI = [[UIAlertView alloc] initWithTitle:@"BMI Calculator"
                                           message:nil
                                          delegate:self
                                 cancelButtonTitle:@"Manual Input"
                                 otherButtonTitles:@"BMI Calc",nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(offTimeBMi:) name:@"offAlertBMI" object:nil];
    [_alertBMI show];
}
-(void)offTimeBMi:(NSNotification *)not{
    self.alertBMI = nil;
    [self.view endEditing:YES];
}

-(void)drawBMIButton
{
    _BMIButton = [[UIButton alloc]initWithFrame:_BMITextField.frame];
    [_BMIButton addTarget:self action:@selector(BMIButtontapped) forControlEvents:UIControlEventTouchUpInside ];
    [self.scrollview addSubview:_BMIButton];
    [self.scrollview bringSubviewToFront:_BMIButton];
}

-(void) drawBMIView{
    
    _bmiBackgroundView = [[UIView alloc]init];
    if (IS_IOS7) {
        _bmiBackgroundView.frame = self.view.frame;
    }else{
        _bmiBackgroundView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -20, self.view.frame.size.width, self.view.frame.size.height);
    }
    _bmiBackgroundView.backgroundColor = [UIColor whiteColor];
    _bmiBackgroundView.alpha = 0.3f;
    
    _bmiView = [[OKBMIViewController alloc]initWithNibName:@"OKBMIViewController" bundle:nil];
    if (IS_IPHONE_5) {
        [_bmiView.view setFrame:CGRectMake(5, 170, self.view.frame.size.width-10, self.view.frame.size.height-400)];
    }else if (!IS_IPHONE_5){
        if (IS_IOS6) {
            [_bmiView.view setFrame:CGRectMake(5, 20, self.view.frame.size.width-10, self.view.frame.size.height-240)];
        }else{
            [_bmiView.view setFrame:CGRectMake(5, 80, self.view.frame.size.width-10, self.view.frame.size.height-300)];
        }
    }
        
    _bmiView.view.layer.cornerRadius = 14.f;
    _bmiView.view.alpha = 1.f;
    _bmiView.view.backgroundColor = [UIColor colorWithRed:40.f/255 green:67.f/255 blue:89.f/255 alpha:1.f];
    _bmiView.view.hidden = YES;
    [self.view addSubview:_bmiBackgroundView];
    [self.view addSubview:_bmiView.view];
    _bmiView.delegate = self;
}

-(void)bmiCancelBtnTapped{
    _bmiView.view.hidden = YES;
    _bmiBackgroundView.hidden = YES;
    [self.view endEditing:YES];
    
    
}
-(void)bmiCalculateBtnTapped{
    
    _bmiView.view.hidden = YES;
    _bmiBackgroundView.hidden = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   _BMIValue = [NSString stringWithString:[defaults stringForKey:@"BMI_Value"]];
    NSLog(@"%@", _BMIValue);
    
    _BMITextField.customTextField.text = _BMIValue;
    [_BMITextField.delegate updateField:_BMITextField.fieldName withValue:_BMITextField.customTextField.text andTag:_BMITextField.tagOfTextField];
}

-(void) doneButtonTapped{
    if (!self.picker.hidden) {
        [self hidePicker];
    }
    if (!self.datePicker.hidden) {
        [self hideDatePicker];
    }

}
-(void)addRightButtonForiOS6{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"right"].size.width+27, [UIImage imageNamed:@"right"].size.height );
    [right setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(rightButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

-(void)addLeftButtonForiOS6 {
    UIButton *left = [[UIButton alloc] init];
    left.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width+27, [UIImage imageNamed:@"back"].size.height );
    [left setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:left];
    self.navigationItem.leftBarButtonItem = anotherButton;
}

-(void)setContactFieldWithContactArray:(NSMutableArray *)contactsArray{
    
    _selectContactObject.contactsArray = contactsArray;
    
    NSMutableArray *contactnamesArray = [[NSMutableArray alloc] init];
    NSMutableArray *contactIDsArray = [[NSMutableArray alloc] init];
    NSMutableArray *contactEmailsArray = [[NSMutableArray alloc] init];
    for (OKContactModel *model in contactsArray) {
        [contactnamesArray addObject:model.name];
        [contactIDsArray addObject:model.identifier];
        [contactEmailsArray addObject:model.contactEmail];
    }
    NSString *contactIDs = [contactIDsArray componentsJoinedByString:@","];
    NSString *contactNames = [contactnamesArray componentsJoinedByString:@", "];
    NSString *contactEmails= [contactEmailsArray componentsJoinedByString:@","];
    
    if ([_selectContactObject.roleID isEqualToString:@"7"]) {
        _selectContactObject.customTextField.text = contactEmails;
        _selectContactObject.contactIDs = contactEmails;
        [self.selectContactObject.delegate updateField:self.selectContactObject.fieldName withValue:self.selectContactObject.contactIDs andTag:self.selectContactObject.tagOfTextField];
        
    } else {
        [self.model setValue:contactNames forKey:[NSString stringWithFormat:@"%@_names",self.selectContactObject.fieldName]];
        _selectContactObject.customTextField.text = contactNames;
        _selectContactObject.contactIDs = contactNames;
        [self.selectContactObject.delegate updateField:self.selectContactObject.fieldName withValue:self.selectContactObject.contactIDs andTag:self.selectContactObject.tagOfTextField];
        if ([_selectContactObject.roleID isEqualToString:@"2"]) {
            [[NSUserDefaults standardUserDefaults] setObject:contactNames forKey:@"lastAssistant"];
        } else if ([_selectContactObject.roleID isEqualToString:@"5"]) {
            [[NSUserDefaults standardUserDefaults] setObject:contactNames forKey:@"lastPhysician"];
        }
    }

    
}

-(void)goToSelectContactViewWithRoleID:(NSString *)roleID selectContactObject:(id)selectContactObject{
    _selectContactObject  = selectContactObject;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    OKFacilityVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"FacilityVC"];
    vc.roleID = roleID;
    vc.delegate = self;
    vc.cameFromVC = @"createProcedureVC";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void) addCustomElementFromDictionary: (NSDictionary *) customElementDictionary withTag:(int) tag{
    
    if ([[customElementDictionary objectForKey:@"type"] isEqualToString:@"symbolicTextField"]) {
        OKProcedureTextField *symbolicTextField = [[OKProcedureTextField alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        symbolicTextField.delegate = self;
        
        //[self.view addSubview:symbolicTextField];
        [self.scrollview addSubview:symbolicTextField];
        
        
        [symbolicTextField setTagOfTextField:tag];
        if (symbolicTextField.tagOfTextField >0) {
            NSString *placeholder = [NSString stringWithFormat:@"%@%d)",[customElementDictionary objectForKey:@"placeholder"], symbolicTextField.tagOfTextField ];
            [symbolicTextField setPlaceHolder: placeholder];
        }else {
            [symbolicTextField setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"] ];

        }
     
        [symbolicTextField setFieldName:[customElementDictionary objectForKey:@"name"]];
        [symbolicTextField setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"] ];
        [symbolicTextField setType:0];
        if ([[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_surgeon"]) {
            symbolicTextField.customTextField.text = [NSString stringWithFormat:@"%@ %@ , %@", [OKUserManager instance].currentUser.firstName, [OKUserManager instance].currentUser.lastName , [OKUserManager instance].currentUser.title];
        }else if ([[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_postOp"]){
            symbolicTextField.customTextField.text = @"same";
            [symbolicTextField setupWithValue:@"same"];
        }else if ([[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_complation"]){
            symbolicTextField.customTextField.text = @"None";
            [symbolicTextField setupWithValue:@"None"];
        }

        
        if (_procedureID == 2 && [[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_vasAnomolies"]) {
            symbolicTextField.customTextField.enabled = NO;
        } else if (_procedureID == 2  && [[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_coagulant"]){
            symbolicTextField.customTextField.enabled = NO;
        } else if (_procedureID == 2  && [[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_transfusion"]){
            symbolicTextField.customTextField.enabled = NO;
        } else if (_procedureID == 9  && [[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_complications"]){
            symbolicTextField.customTextField.enabled = NO;
        } else if (_procedureID == 10  && [[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_complications"]){
            symbolicTextField.customTextField.enabled = NO;
        } else if (_procedureID == 1  && [[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_preOpDX"]){
            symbolicTextField.customTextField.text = @"Prostate Cancer";
            [symbolicTextField setupWithValue:symbolicTextField.customTextField.text];        
        }
        if (self.model) {
            if (![[customElementDictionary objectForKey:@"name"]isEqualToString:@"var_vasAnomolies"] ||
                ![[customElementDictionary objectForKey:@"name"]isEqualToString:@"var_coagulant"] ||
                ![[customElementDictionary objectForKey:@"name"]isEqualToString:@"var_transfusion"] ||
                ![[customElementDictionary objectForKey:@"name"]isEqualToString:@"var_complications"]) {
                [symbolicTextField setupWithValue:[self.model valueForKey:[customElementDictionary objectForKey:@"name"]]];
            }
        }
        
        [self.interactionItems addObject:symbolicTextField];
        
    } else if ([[customElementDictionary objectForKey:@"type"] isEqualToString:@"selectContact"]) {
        OKSelectContact *selectContact = [[OKSelectContact alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        selectContact.delegate = self;
        if ([[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_assistant"]){
            if (selectContact.contactIDs) {
                [selectContact setupWithValue:_selectContactObject];
            }
        }
        
        //[self.view addSubview:selectContact];
        [self.scrollview addSubview:selectContact];

        [selectContact setTagOfTextField:tag];

        [selectContact setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"] ];
        [selectContact setFieldName:[customElementDictionary objectForKey:@"name"]];
        [selectContact setRoleID:[[customElementDictionary objectForKey:@"items"]objectAtIndex:0 ]];
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"lastAssistant"] != nil && [[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_assistant"]) {
            selectContact.customTextField.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastAssistant"];
            [selectContact setupWithValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"lastAssistant"]];
        }else if ([[NSUserDefaults standardUserDefaults] valueForKey:@"lastPhysician"] != nil && [[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_physicans"]) {
            selectContact.customTextField.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastPhysician"];
            [selectContact setupWithValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"lastPhysician"]];
        }else if (self.model) {
            selectContact.customTextField.text = [self.model valueForKey:[customElementDictionary objectForKey:@"name"]];
            [selectContact setupWithValue:[self.model valueForKey:[customElementDictionary objectForKey:@"name"]]];
        }
        

        
        
        [self.interactionItems addObject:selectContact];
        
    } else if ([[customElementDictionary objectForKey:@"type"] isEqualToString:@"numericTextField"]) {
        OKProcedureTextField *numericTextField = [[OKProcedureTextField alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        numericTextField.delegate = self;
        [self.scrollview addSubview:numericTextField];
        
        if ([[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_BMI"] || [[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_bmi"]) {
            _BMITextField = numericTextField;
            [self drawBMIButton];
        }
        if ([[customElementDictionary objectForKey:@"name"] isEqualToString: @"var_counselTime"]) {
            _TimeTextField = numericTextField;
            [self drawTimeButton];
        }
        if ([[customElementDictionary objectForKey:@"name"] isEqualToString: @"var_roomTime"]) {
            _TimeRoomTextField = numericTextField;
            [self drawRoomButton];
        }
        if ([[customElementDictionary objectForKey:@"name"] isEqualToString: @"var_operativeTime"] ) {
            _TimeOPTextField = numericTextField;
            [self drawOPButton];
        }
        if ([[customElementDictionary objectForKey:@"name"] isEqualToString: @"var_consulTime"] ) {
            _TimeCTextField = numericTextField;
            [self drawCButton];
        }
        [numericTextField setTagOfTextField:tag];
        if (numericTextField.tagOfTextField >0) {
            NSString *placeholder = [NSString stringWithFormat:@"%@%d)",[customElementDictionary objectForKey:@"placeholder"], numericTextField.tagOfTextField ];
            [numericTextField setPlaceHolder: placeholder];
        }else {
            [numericTextField setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"] ];
            
        }
        [numericTextField setFieldName:[customElementDictionary objectForKey:@"name"]];
        [numericTextField setType:OKProcedureNumericTF];
        
        if (self.model) {
            
            [numericTextField setupWithValue:[self.model valueForKey:[customElementDictionary objectForKey:@"name"]]];
        }
        
        
        [self.interactionItems addObject:numericTextField];
        
    } else if ([[customElementDictionary objectForKey:@"type"] isEqualToString:@"DatePicker"]) {
        OKProcedureDatePicker *datePicker = [[OKProcedureDatePicker alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        datePicker.delegate = self;
        
        if ([[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_patientDOB"]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM-dd-yyyy"];
            NSDate *temp = [dateFormatter dateFromString:@"01-01-1964"];
            [datePicker setStartDate:temp];
        }
        
        //[self.view addSubview:datePicker];
        [self.scrollview addSubview:datePicker];

        [datePicker setTagOfTextField:tag];
        if (datePicker.tagOfTextField >0) {
            NSString *placeholder = [NSString stringWithFormat:@"%@%d)",[customElementDictionary objectForKey:@"placeholder"], datePicker.tagOfTextField ];
            [datePicker setPlaceHolder: placeholder];
        }else {
            [datePicker setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"] ];
            
        }
        [datePicker setFieldName:[customElementDictionary objectForKey:@"name"]];

        
        if (self.model) {
            
            [datePicker setupWithValue:[self.model valueForKey:[customElementDictionary objectForKey:@"name"]]];
        }

        [self.interactionItems addObject:datePicker];
        
        
    } else if ([[customElementDictionary objectForKey:@"type"] isEqualToString:@"picker"]) {
        OKProcedurePicker *picker = [[OKProcedurePicker alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        picker.delegate = self;
        [picker setFieldName:[customElementDictionary objectForKey:@"name"]];
        [picker setDataArray:[customElementDictionary objectForKey:@"items"]];
        //[picker setup];
        if ([[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_factors"]) {
            picker.customTextField.text = [[customElementDictionary objectForKey:@"items"] objectAtIndex:0];
            [picker setupWithValue:[[customElementDictionary objectForKey:@"items"] objectAtIndex:0]];
        }

        
        if (_procedureID == 1 || _procedureID ==9) {
            NSMutableArray *pickerArray = [[NSMutableArray alloc] initWithObjects:@"Male", nil];

            if ([[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_sex"]) {

                picker.customTextField.text = [pickerArray objectAtIndex:0];
                [picker setDataArray:pickerArray];
                [picker setValue:@"Male"];
                [picker setupWithValue:@"Male"];
            }
        }else{
            [picker setDataArray:[customElementDictionary objectForKey:@"items"]];

        }
        
        picker.customTextField.inputView = _picker;
        
     //   [self.view addSubview:picker];
        [self.scrollview addSubview:picker];

        
        [picker setTagOfTextField:tag];
        if (picker.tagOfTextField >0) {
            NSString *placeholder = [NSString stringWithFormat:@"%@%d)",[customElementDictionary objectForKey:@"placeholder"], picker.tagOfTextField ];
            [picker setPlaceHolder: placeholder];
        }else {
            [picker setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"] ];
            
        }
       
        NSMutableArray *pickerArray = [[NSMutableArray alloc] init];
        if ([[[customElementDictionary objectForKey:@"items"] objectAtIndex:0] isEqualToString:@"0,1"] ){
            [picker setDataArray:[self convertStoneSizeArray:[customElementDictionary objectForKey:@"items"]]];
        } else {
            pickerArray = [customElementDictionary objectForKey:@"items"];
        }
        
        if (_procedureID == 1 && [[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_lysisOfAdhesions"]) {
            [picker setButtonEnabled:NO];
        } else if (_procedureID == 2 && [[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_adhTook"]){
            [picker setButtonEnabled:NO];
        }
        if (self.model) {
            if (![[customElementDictionary objectForKey:@"name"] isEqualToString:@"anterior/posterior"] && ![[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_reservoirplacement?"]){
                
                if (![[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_lysisOfAdhesions"] || ![[customElementDictionary objectForKey:@"name"] isEqualToString:@"var_adhTook"]) {
                
                [picker setupWithValue:[self.model valueForKey:[customElementDictionary objectForKey:@"name"]]];
                
                }
                
            }
        }
        
        [self.interactionItems addObject:picker];

    } else if ([[customElementDictionary objectForKey:@"type"] isEqualToString:@"multiselect"]) {
        OKProcedureMultiselect *multiselectView = [[OKProcedureMultiselect alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        multiselectView.delegate = self;
        //[multiselectView setup];

        
        [multiselectView setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"]];
        [multiselectView setFieldName:[customElementDictionary objectForKey:@"name"]];
        
        [multiselectView setDataArray:[customElementDictionary objectForKey:@"items"]];
       /// [self.view addSubview:multiselectView];
        [self.scrollview addSubview:multiselectView];

        if (self.model) {
            
            [multiselectView setupWithValue:[self.model valueForKey:[customElementDictionary objectForKey:@"name"]]];
        }

        [self.interactionItems addObject:multiselectView];
    
    } else {
        OKProcedureSwitcher *switcher = [[OKProcedureSwitcher alloc] init];
        
            switcher.frame =CGRectMake(0, _xPoint, 320, 43);
        
        switcher.delegate = self;

        //[self.view addSubview:switcher];
        [self.scrollview addSubview:switcher];

        [switcher setFieldName:[customElementDictionary objectForKey:@"name"]];
        [switcher setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"] ];
        [switcher setup];

        [self.interactionItems addObject:switcher];
    }
    _xPoint += 43;
}


-(NSMutableArray*)convertStoneSizeArray:(NSMutableArray *) Array
{
    NSMutableArray * b = [[NSMutableArray alloc]init];
    
    for(float i = .5; i<= 25 ; i+=.5){
        NSString *fltString = [NSString stringWithFormat:@"%.1f", i];
        
        [b addObject:fltString];
    }
    
    Array = b;
    
    return Array;
}


#pragma mark - OKProcedureTextFieldDelegate
-(void)updateField:(NSString*)name withValue:(NSString*)newValue  andTag:(NSInteger) tag
{
    

}


- (void)goToNextElementFrom:(id)sender
{
    [self.view endEditing:YES];
    OKProcedureTextField *nextItem = nil;
    int rangeStart = [self.interactionItems indexOfObject:sender];
    for (int index = rangeStart; index < self.interactionItems.count; index++){
        UIView *view = self.interactionItems[index];
        if([[view class]isSubclassOfClass:[OKProcedureTextField class]] && view != sender){
            nextItem = (OKProcedureTextField*)view;
            break;
        }
    }
    if(nextItem)
        [nextItem.customTextField becomeFirstResponder];
    else
        [sender resignFirstResponder];
}

#pragma mark - OKProcedureSwitcherDelegate
-(void)updateField:(NSString*)name withBoolValue:(BOOL)newValue{
    
    
}


#pragma mark - OKProcedureMultiselectDelegate
-(void)updateField:(NSString*)field withData:(NSArray*)data
{
    
}



-(void)showPickerWithData:(NSArray*)pickerData picker:(OKProcedurePicker*)pickerObject
{
    
    if (self.picker.hidden) {
        self.pickerObject = pickerObject;
        self.pickerData = pickerData;
        _pickerBGView.hidden = NO;
        self.picker.hidden = NO;
        self.datePicker.hidden = YES;
        [self.picker reloadAllComponents];
        
    } else {
        [self hidePicker];
    }

    [self.view endEditing:YES];
}


-(void)showDatePickerWithDate:(NSDate*)date picker:(OKProcedureDatePicker*)datePickerObject
{
    if (self.datePicker.hidden) {
        
        self.datePickerObject = datePickerObject;
        _pickerBGView.hidden = NO;
        _doneButtonForDatePicker.hidden = NO;

        self.picker.hidden = YES;
        self.datePicker.hidden = NO;
        if(date)
            [self.datePicker setDate:date];
        else
            [self.datePicker setDate:[NSDate date]];
    }else {
        [self hideDatePicker];
    }
    [self.view endEditing:YES];
}


-(void)showMultiselectVCForFieldWithName:(NSString*)fieldName withData:(NSArray*)data sender:(id)sender
{
    [self.view endEditing:YES];
    if (!self.picker.hidden) {
        [self hidePicker];
    }
    if (!self.datePicker.hidden) {
        [self hideDatePicker];
    }
    [OKProcedureMultiselectVC showInViewController:self fieldName:fieldName data:data delegate:sender];
}


-(void)hidePicker
{
    _doneButtonForDatePicker.hidden = YES;

    self.pickerObject.customTextField.text = self.pickerData[[self.picker selectedRowInComponent:0]];
    self.picker.hidden = YES;
    _pickerBGView.hidden = YES;
    self.pickerData = nil;
}



-(void)hideDatePicker
{
    _doneButtonForDatePicker.hidden = YES;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    
    self.datePickerObject.customTextField.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self.datePicker.date] ];
    [self.datePickerObject.delegate updateField:self.datePickerObject.fieldName withValue:self.datePickerObject.customTextField.text andTag:self.datePickerObject.tagOfTextField];
    self.datePicker.hidden = YES;
    _pickerBGView.hidden = YES;
    
}
-(void)hidePickersWhenTextFieldBeginsEditing{
    if (!self.picker.hidden) {
        [self hidePicker];
    }
    if (!self.datePicker.hidden) {
        [self hideDatePicker];
    }
}

#pragma mark - picker data source

-(NSAttributedString*) pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    UIColor *color = [UIColor whiteColor];
    if (IS_IOS6) {
        color = [UIColor blackColor];
    }
    if (pickerView.tag == 200) {
        if (component == 0) {
            
            NSString *pickerString = [NSString stringWithFormat:@"%@", _hoursArray[row%12]];
            NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: color}];
            
            return pickerAttributedString;
        } else if (component == 1){
            NSString *pickerString = [NSString stringWithFormat:@"%@", _minutesArray[row%60]];
            NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: color}];
            return pickerAttributedString;
        } else{
            NSString *pickerString = [NSString stringWithFormat:@"%@", _ampmArray[row]];
            NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: color}];
            return pickerAttributedString;
        }

    }else{
        NSString *pickerString = [NSString stringWithFormat:@"%@", self.pickerData[row]];
        NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: color}];
        return pickerAttributedString;

    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 200) {
        if (component == 0) {
            return 144;
        } else if (component == 1){
            return 360;
        } else{
            return 2;
        }
        
    }else {
        return self.pickerData.count;
    }
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (pickerView.tag == 200) {
        return 3;
    }else {
        return 1;
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.pickerObject.customTextField.text = self.pickerData[row];
    [self.pickerObject.delegate updateField:self.pickerObject.fieldName withValue:self.pickerObject.customTextField.text andTag:self.pickerObject.tagOfTextField];
    if (!self.picker.hidden) {
        [self hidePicker];
    }
    if (!self.datePicker.hidden) {
        [self hideDatePicker];
    }

}


-(void)addDataToTFAndHideIt{

}


- (IBAction)backButtonTapped:(id)sender {
     [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
   
}

-(BOOL)checkForFillFileds{
    for (id textField in self.interactionItems) {
        if ([textField isKindOfClass:[OKProcedureTextField class]]) {
            OKProcedureTextField *tF = textField;
            if ([tF.customTextField.placeholder isEqualToString:@"Descriprion (if Yes)"] || [tF.customTextField.placeholder isEqualToString:@"Enter Coagulants"] || [tF.customTextField.placeholder isEqualToString:@"# of units (is Yes)"] || [tF.customTextField.placeholder isEqualToString:@"Complications description"]){
                
            }else if([tF.customTextField.text isEqualToString:@""]){
                return NO;
                break;
            }
        }
        if ([textField isKindOfClass:[OKProcedureDatePicker class]]) {
            OKProcedureDatePicker * dPicker = textField;
            if ([dPicker.customTextField.text isEqualToString:@""]) {
                return NO;
                break;
            }
        }
        if ([textField isKindOfClass:[OKProcedurePicker class]]) {
            OKProcedurePicker * procPicker = textField;
            if ([procPicker.customTextField.placeholder isEqualToString:@"Lysis of Adhesions"]) {
                
            }else if ([procPicker.customTextField.text isEqualToString:@""]) {
                return NO;
                break;
            }
        }
    }

    return YES;
}

- (IBAction)rightButtonTapped:(id)sender {
    
    if ([self checkForFillFileds]) {
    if ([self canGoToNextVC]) {
        
        [self.view endEditing:YES];
        
        if (self.currentPage < (self.plistArray.count - 1) ) {
            
            if (self.currentPage == 0) {
                [self.model setValue:_procedureName forKey:@"var_procedureName"];
                id nextVC = [self nextVC];
                [self.navigationController pushViewController:nextVC animated:YES];
            }else {
                id nextVC = [self nextVC];
                [self.navigationController pushViewController:nextVC animated:YES];
            }
        } else {
            if (_procedureID == 1 && ([[self.model valueForKey:@"var_physicans"] isEqualToString:@""] || [self.model valueForKey:@"var_physicans"] == nil)) {
                  [self.model setValue:@"None" forKey:@"var_physicans"];
                [self.model setValue:@"None" forKey:@"var_physicans_names"];
            }
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
            OKOperatieNoteViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"OperativeNoteVC"];
            vc.model = self.model;
            if (_procedureID == 1) {
                [vc.model setValue:[NSString stringWithFormat:@"%@; %@; %@; %@; %@",[vc.model valueForKey:@"var_nervesparing"],[vc.model valueForKey:@"var_pelvicDisection"],[vc.model valueForKey:@"var_bladderNeckReconstruction"],[vc.model valueForKey:@"var_sling"],[vc.model valueForKey:@"var_lysisOfAdhesions"]] forKey:@"var_technique"];
            }
            vc.procedureID = self.procedureID;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please fill all fields"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please fill all fields"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}


-(void)drawTimeButton
{
    _TimeButton = [[UIButton alloc]initWithFrame:_TimeTextField.frame];
    [_TimeButton addTarget:self action:@selector(TimeButtontapped:) forControlEvents:UIControlEventTouchUpInside ];
    [self.scrollview addSubview:_TimeButton];
    [self.scrollview bringSubviewToFront:_TimeButton];
    _TimeButton.tag = 100;
}
-(void)drawRoomButton
{
    _TimeRoomButton = [[UIButton alloc]initWithFrame:_TimeRoomTextField.frame];
    [_TimeRoomButton addTarget:self action:@selector(TimeButtontapped:) forControlEvents:UIControlEventTouchUpInside ];
    [self.scrollview addSubview:_TimeRoomButton];
    [self.scrollview bringSubviewToFront:_TimeRoomButton];
    _TimeRoomButton.tag = 200;
}
-(void)drawOPButton
{
    _TimeOPButton = [[UIButton alloc]initWithFrame:_TimeOPTextField.frame];
    [_TimeOPButton addTarget:self action:@selector(TimeButtontapped:) forControlEvents:UIControlEventTouchUpInside ];
    [self.scrollview addSubview:_TimeOPButton];
    [self.scrollview bringSubviewToFront:_TimeOPButton];
    _TimeOPButton.tag = 300;
    

}
-(void)drawCButton
{
    _TimeCButton = [[UIButton alloc]initWithFrame:_TimeCTextField.frame];
    [_TimeCButton addTarget:self action:@selector(TimeButtontapped:) forControlEvents:UIControlEventTouchUpInside ];
    [self.scrollview addSubview:_TimeCButton];
    [self.scrollview bringSubviewToFront:_TimeCButton];
    _TimeCButton.tag = 400;

}

-(void) TimeButtontapped: (id) sender{
    NSInteger tid = ((UIControl *) sender).tag;
    if (tid == 100){
        _currentTF = nil;
        _currentButton = nil;
        _currentTF = _TimeTextField;
        _currentButton = _TimeButton;
    } else if (tid == 200){
        _currentTF = nil;
        _currentButton = nil;
        _currentTF = _TimeRoomTextField;
        _currentButton = _TimeRoomButton;
    } else if (tid == 300){
        _currentTF = nil;
        _currentButton = nil;
        _currentTF = _TimeOPTextField;
        _currentButton = _TimeOPButton;
    }else if (tid ==400){
        _currentTF = nil;
        _currentButton = nil;
        _currentTF = _TimeCTextField;
        _currentButton = _TimeCButton;
    }
    _currentButton.hidden = NO;
    [self.view endEditing:YES];
            _alertTime = [[UIAlertView alloc] initWithTitle:@"Time Calculator"
                                                   message:nil
                                                  delegate:self
                                         cancelButtonTitle:@"Manual Input"
                                         otherButtonTitles:@"Time Calc",nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(offTimeAlert:) name:@"offTimeAlert" object:nil];
    [_alertTime show];
}
-(void)offTimeAlert:(NSNotification *)not{
    self.alertTime = nil;
    [self.view endEditing:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex ==1){
        if ([alertView.title isEqualToString:@"BMI Calculator"]) {
            [self.view endEditing:YES];
            
            _bmiBackgroundView.hidden = NO;
            _bmiView.view.hidden = NO;
        } else {
            [self.view endEditing:YES];
            [_currentTF resignFirstResponder];

            _timeView.hidden = NO;
            _timeBackgroundView.hidden = NO;

        }
        
    } else {
         if ([alertView.title isEqualToString:@"BMI Calculator"]) {
            // _BMIButton.hidden = YES;
             [_BMITextField becomeCustomTextFieldFirstResponder];
             [_alertBMI dismissWithClickedButtonIndex:[_alertBMI cancelButtonIndex] animated:YES];
             self.alertBMI = nil;
         } else {
            // _currentButton.hidden = YES;
             [_currentTF becomeCustomTextFieldFirstResponder];
             [_alertTime dismissWithClickedButtonIndex:[_alertTime cancelButtonIndex] animated:YES];
             _alertTime = nil;
         }
       
        
    }
}

-(void)drawTimeView{
    
    UIColor *color = [UIColor lightGrayColor];
    
    _timeBackgroundView = [[UIView alloc]init];
    if (IS_IOS7) {
        _timeBackgroundView.frame = self.view.frame;
    }else{
        _timeBackgroundView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -20, self.view.frame.size.width, self.view.frame.size.height);
    }
    _timeBackgroundView.backgroundColor = [UIColor whiteColor];
    _timeBackgroundView.alpha = 0.3f;
    
    if(IS_IPHONE_5){
        _timeView = [[UIView alloc]initWithFrame:CGRectMake(5, 170, self.view.frame.size.width-10, self.view.frame.size.height-400)];
    }else if(!IS_IPHONE_5){
        if (IS_IOS6){
            _timeView = [[UIView alloc]initWithFrame:CGRectMake(5, 40, self.view.frame.size.width-10, self.view.frame.size.height-290)];
        }else{
            _timeView = [[UIView alloc]initWithFrame:CGRectMake(5, 100, self.view.frame.size.width-10, self.view.frame.size.height-310)];
        }
    }
    _timeView.backgroundColor = [UIColor colorWithRed:40.f/255 green:67.f/255 blue:89.f/255 alpha:1.f];
    _timeView.layer.cornerRadius = 14;
    _timeView.layer.masksToBounds = YES;
    
    
    
    _timeFrom = [[OKCustomTextField alloc] initWithFrame:CGRectMake(20, 10, 280, 38)];
    _timeFrom.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Start time"attributes:@{NSForegroundColorAttributeName: color}];
    [_timeFrom setKeyboardType:UIKeyboardTypeNumberPad];
    _timeFrom.borderStyle = UITextBorderStyleRoundedRect;
    _timeFrom.backgroundColor = [UIColor clearColor];
    _timeFrom.layer.cornerRadius = 14;
    _timeFrom.layer.masksToBounds=YES;
    _timeFrom.layer.borderColor=[[UIColor whiteColor]CGColor];
    _timeFrom.layer.borderWidth= 1.0f;
    _timeFrom.textColor = [UIColor whiteColor];
    _timeFrom.delegate = self;
    [_timeView addSubview:_timeFrom];
    
    
    _timeFromButton =[[UIButton alloc]initWithFrame:CGRectMake(20, 10, 280, 38)];
    [UIButton buttonWithType:UIButtonTypeCustom];
    [_timeFromButton setTitle:@"" forState:UIControlStateNormal];
    _timeFromButton.layer.cornerRadius = 14;
    _timeFromButton.backgroundColor = [UIColor clearColor];
    [_timeFromButton addTarget:self action:@selector(timeFromButtomTapped) forControlEvents:UIControlEventTouchUpInside];
    [_timeView addSubview:_timeFromButton];
    
    
    
    _timeTo = [[OKCustomTextField alloc] initWithFrame:CGRectMake(20, 63, 280, 38)];
    [_timeTo setKeyboardType:UIKeyboardTypeNumberPad];
    _timeTo.borderStyle = UITextBorderStyleRoundedRect;
    _timeTo.backgroundColor = [UIColor clearColor];
    _timeTo.layer.cornerRadius = 14;
    _timeTo.layer.masksToBounds=YES;
    _timeTo.layer.borderColor=[[UIColor whiteColor]CGColor];
    _timeTo.layer.borderWidth= 1.0f;
    _timeTo.textColor = [UIColor whiteColor];
    _timeTo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"End time" attributes:@{NSForegroundColorAttributeName: color}];
    _timeTo.delegate = self;
    [_timeView addSubview:_timeTo];
    
    
    
    _timeToButton =[[UIButton alloc]initWithFrame:CGRectMake(20, 63, 280, 38)];
    [UIButton buttonWithType:UIButtonTypeCustom];
    [_timeToButton setTitle:@"" forState:UIControlStateNormal];
    _timeToButton.layer.cornerRadius = 14;
    _timeToButton.backgroundColor = [UIColor clearColor];
    [_timeToButton addTarget:self action:@selector(timeToButtomTapped) forControlEvents:UIControlEventTouchUpInside];
    [_timeView addSubview:_timeToButton];
    

    
    
    _calcTime = [[UIButton alloc]initWithFrame:CGRectMake(20, 120, 133, 38)];
    [UIButton buttonWithType:UIButtonTypeCustom];
    [_calcTime setTitle:@"Calcucate Time" forState:UIControlStateNormal];
    _calcTime.layer.cornerRadius = 14;
    _calcTime.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    [_calcTime addTarget:self action:@selector(timeButtonCacl) forControlEvents:UIControlEventTouchUpInside];
    [_timeView addSubview:_calcTime];
    
    _cancelTime = [[UIButton alloc]initWithFrame:CGRectMake(160, 120, 133, 38)];
    [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelTime setTitle:@"Cancel" forState:UIControlStateNormal];
    _cancelTime.layer.cornerRadius = 14;
    _cancelTime.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    [_cancelTime addTarget:self action:@selector(timeCancel) forControlEvents:UIControlEventTouchUpInside];
    [_timeView addSubview:_cancelTime];
    
    
    
    
    
    [self.view addSubview:_timeBackgroundView];
    [self.view addSubview:_timeView];
    _timeView.hidden = YES;
    _timeBackgroundView.hidden = YES;
    if (IS_IOS7){
        _timePickerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-162, 320, 162)];
    }else{
        _timePickerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-206, 320, 162)];
    }
    
    _timePickerBGView.backgroundColor = [UIColor colorWithRed:24/255. green:59/255. blue:85/255. alpha:.90];
    _timePickerBGView.hidden = YES;
    [self.view addSubview:_timePickerBGView];
    
    
    self.timePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 162)];
//    self.timePicker.hidden = YES;
    self.timePicker.delegate = self;
    self.timePicker.dataSource = self;
    self.timePicker.showsSelectionIndicator = YES;
    [_timePickerBGView addSubview:self.timePicker];
    self.timePicker.tag = 200;
    
    _doneButtonForTimePicker = [UIButton buttonWithType:UIButtonTypeCustom];
    [_doneButtonForTimePicker addTarget:self action:@selector(doneTimeButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_doneButtonForTimePicker setTitle:@"Done" forState:UIControlStateNormal];
    _doneButtonForTimePicker.frame = CGRectMake(210, _pickerBGView.frame.origin.y-35, 100, 30);
    _doneButtonForTimePicker.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _doneButtonForTimePicker.layer.cornerRadius = 14;
    _doneButtonForTimePicker.clipsToBounds = YES;
    _doneButtonForTimePicker.hidden = YES;
    [self.view addSubview:_doneButtonForTimePicker];
    [self.view bringSubviewToFront:_doneButtonForTimePicker];
    
}

-(void)timeButtonCacl{
    
    if ([_timeTo.text isEqualToString:@"" ]|| [_timeFrom.text isEqualToString:@""]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please fill all field" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else{
        if ([_dateTo floatValue] < [_dateFrom floatValue]) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"Time To can't be smaller that Time From" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }else{
        NSDateFormatter *dateFromatter = [[NSDateFormatter alloc]init];
        [dateFromatter setDateFormat:@"hh:mma"];
        NSDate *dateFrom = [dateFromatter dateFromString:_timeFrom.text];
        NSDate *dateTo = [dateFromatter dateFromString:_timeTo.text];
        NSTimeInterval timeInterval = [dateTo timeIntervalSinceDate:dateFrom];
        NSInteger minutes = timeInterval / 60.f ;
        
        _currentTF.customTextField.text = [NSString stringWithFormat:@"%d", minutes];
        [_currentTF resignCustomTextFieldFirstResponder];
            
        [_currentTF.delegate updateField:_currentTF.fieldName withValue:_currentTF.customTextField.text andTag:_currentTF.tagOfTextField];

        [self.view endEditing:YES];
        _timeView.hidden = YES;
        
        
        _timeTo.text = @"";
        _timeFrom.text = @"";

        _timeBackgroundView.hidden = YES;
        _doneButtonForTimePicker.hidden = YES;
        }
    }
        
}

-(void)timeCancel{
    [self.view endEditing:YES];
    _timePickerBGView.hidden = YES;
    _doneButtonForTimePicker.hidden = YES;
    _timeView.hidden = YES;
    [_currentTF resignCustomTextFieldFirstResponder];

    _timeBackgroundView.hidden = YES;
}

-(void) timeFromButtomTapped {
    if (!_timeToButtonTapped) {
        if (_timePickerBGView.hidden) {
            _timeFromButtonTapped = YES;
            if ([_timeFrom.text isEqualToString:@""]) {
                [_timePicker selectRow:12*6 inComponent:0 animated:YES];
                [_timePicker selectRow:60*3 inComponent:1 animated:YES];
            }  else{
                NSString *hoursSTR = [_timeFrom.text substringWithRange:NSMakeRange(0,2)]  ;
                NSString *minutesSTR = [_timeFrom.text substringWithRange:NSMakeRange(3, 2)];
                NSString *ampmSTR = [_timeFrom.text substringWithRange:NSMakeRange(5, 2)];
                NSArray *arr = [[NSArray alloc] initWithArray:[self getHoursIn:hoursSTR andMinutes:minutesSTR andAMorPMvalue:ampmSTR]];
                int hourInt = (int)[arr objectAtIndex:0 ];
                int minuteInt = (int)[arr objectAtIndex:1 ];
                int ampmInt = (int)[arr objectAtIndex:2 ];
                
                [_timePicker selectRow:hourInt inComponent:0 animated:YES];
                [_timePicker selectRow:minuteInt inComponent:1 animated:YES];
                [_timePicker selectRow:ampmInt inComponent:2 animated:YES];
                
            }
            
        } else {
            
            NSString *hoursSTR = [_hoursArray objectAtIndex:( [_timePicker selectedRowInComponent:0] % [_hoursArray count])];
            NSString *minutesSTR =[_minutesArray objectAtIndex:( [_timePicker selectedRowInComponent:1] % [_minutesArray count])];;
            NSString *ampmSTR =_ampmArray[[_timePicker selectedRowInComponent:2]];
            NSString *timeFrom = [NSString stringWithFormat:@"%@:%@%@",hoursSTR, minutesSTR, ampmSTR];
            _timeFrom.text = timeFrom;
            
       //     [self getHoursIn:hoursSTR andMinutes:minutesSTR andAMorPMvalue:ampmSTR];
            if ([ampmSTR isEqualToString:@"AM"]) {
                ampmSTR = @"0";
            }else {
                ampmSTR = @"12";
            }
            
            _dateFrom = [NSString stringWithFormat:@"%@.%@.%@",ampmSTR ,hoursSTR, minutesSTR ];
            
            _timeFromButtonTapped = NO;

        }
        _timePicker.hidden = NO;
        _timePickerBGView.hidden = !_timePickerBGView.hidden;
        
        _doneButtonForTimePicker.hidden = !_doneButtonForTimePicker.hidden;
    }
    
}
-(NSArray*) getHoursIn:(NSString *)hour andMinutes:(NSString *)minutes andAMorPMvalue:(NSString *)ampm{
    int hoursInt = [hour intValue];
    hoursInt = (hoursInt-1)*6;
    int minutesInt = [minutes intValue];
    minutesInt = minutesInt*3;
    int ampmInt;
    if ([ampm isEqualToString:@"AM"]) {
        ampmInt = 0;
    }else {
        ampmInt = 1;
    }
    NSArray *arr = @[[NSNumber numberWithInt:hoursInt], [NSNumber numberWithInt:minutesInt], [NSNumber numberWithInt: ampmInt]];
    
    return arr;
}

-(void) timeToButtomTapped {
    
    
    if (!_timeFromButtonTapped) {
        if (_timePickerBGView.hidden) {
            _timeToButtonTapped = YES;
            
            if ([_timeTo.text isEqualToString:@""]) {
                [_timePicker selectRow:12*6 inComponent:0 animated:YES];
                [_timePicker selectRow:60*3 inComponent:1 animated:YES];
            }else{
                NSString *hoursSTR = [_timeTo.text substringWithRange:NSMakeRange(0,2)]  ;
                NSString *minutesSTR = [_timeTo.text substringWithRange:NSMakeRange(3, 2)];
                NSString *ampmSTR = [_timeTo.text substringWithRange:NSMakeRange(5, 2)];
                NSArray *arr = [[NSArray alloc] initWithArray:[self getHoursIn:hoursSTR andMinutes:minutesSTR andAMorPMvalue:ampmSTR]];
                int hourInt = (int)[arr objectAtIndex:0 ];
                int minuteInt = (int)[arr objectAtIndex:1 ];
                int ampmInt = (int)[arr objectAtIndex:2 ];

                [_timePicker selectRow:hourInt inComponent:0 animated:YES];
                [_timePicker selectRow:minuteInt inComponent:1 animated:YES];
                [_timePicker selectRow:ampmInt inComponent:2 animated:YES];
                
            }

            

        } else {
            NSString *hoursSTR = [_hoursArray objectAtIndex:( [_timePicker selectedRowInComponent:0] % [_hoursArray count])];
            NSString *minutesSTR =[_minutesArray objectAtIndex:( [_timePicker selectedRowInComponent:1] % [_minutesArray count])];;
            NSString *ampmSTR =_ampmArray[[_timePicker selectedRowInComponent:2]];
            NSString *timeTo = [NSString stringWithFormat:@"%@:%@%@",hoursSTR, minutesSTR, ampmSTR];
            _timeTo.text = timeTo;
            
            //[self getHoursIn:hoursSTR andMinutes:minutesSTR andAMorPMvalue:ampmSTR];
            
            if ([ampmSTR isEqualToString:@"AM"]) {
                ampmSTR = @"0";
            }else {
                ampmSTR = @"12";
            }
            
            _dateTo = [NSString stringWithFormat:@"%@.%@.%@",ampmSTR ,hoursSTR, minutesSTR ];
            
            _timeToButtonTapped = NO;
            
        }
        _timePicker.hidden = NO;
        _timePickerBGView.hidden = !_timePickerBGView.hidden;
        _doneButtonForTimePicker.hidden = !_doneButtonForTimePicker.hidden;
        
    }
}

-(void) doneTimeButtonTapped{
    
    if (!_timeToButtonTapped) {
        if (_timePickerBGView.hidden) {
            _timeFromButtonTapped = YES;
            if ([_timeFrom.text isEqualToString:@""]) {
                [_timePicker selectRow:12*6 inComponent:0 animated:YES];
                [_timePicker selectRow:60*3 inComponent:1 animated:YES];
                [_timePicker selectRow:0 inComponent:2 animated:YES];
            }  else{
                NSString *hoursSTR = [_timeFrom.text substringWithRange:NSMakeRange(0,2)]  ;
                NSString *minutesSTR = [_timeFrom.text substringWithRange:NSMakeRange(3, 2)];
                NSString *ampmSTR = [_timeFrom.text substringWithRange:NSMakeRange(5, 2)];
                NSArray *arr = [[NSArray alloc] initWithArray:[self getHoursIn:hoursSTR andMinutes:minutesSTR andAMorPMvalue:ampmSTR]];
                int hourInt = (int)[arr objectAtIndex:0 ];
                int minuteInt = (int)[arr objectAtIndex:1 ];
                int ampmInt = (int)[arr objectAtIndex:2 ];
                
                [_timePicker selectRow:hourInt inComponent:0 animated:YES];
                [_timePicker selectRow:minuteInt inComponent:1 animated:YES];
                [_timePicker selectRow:ampmInt inComponent:2 animated:YES];
                
            }

        } else {
            
            NSString *hoursSTR = [_hoursArray objectAtIndex:( [_timePicker selectedRowInComponent:0] % [_hoursArray count])];
            NSString *minutesSTR =[_minutesArray objectAtIndex:( [_timePicker selectedRowInComponent:1] % [_minutesArray count])];
            NSString *ampmSTR =_ampmArray[[_timePicker selectedRowInComponent:2]];
            NSString *timeFrom = [NSString stringWithFormat:@"%@:%@%@",hoursSTR, minutesSTR, ampmSTR];
            _timeFrom.text = timeFrom;
            
            if ([ampmSTR isEqualToString:@"AM"]) {
                ampmSTR = @"0";
            }else {
                ampmSTR = @"12";
            }
            
            _dateFrom = [NSString stringWithFormat:@"%@.%@.%@",ampmSTR ,hoursSTR, minutesSTR ];
            
            _timeFromButtonTapped = NO;
            
        }
        
        _timePickerBGView.hidden = !_timePickerBGView.hidden;
        
    }else {
        if (_timePickerBGView.hidden) {
            _timeToButtonTapped = YES;
            if ([_timeTo.text isEqualToString:@""]) {
                [_timePicker selectRow:12*6 inComponent:0 animated:YES];
                [_timePicker selectRow:60*3 inComponent:1 animated:YES];
                [_timePicker selectRow:0 inComponent:2 animated:YES];
            }else{
                NSString *hoursSTR = [_timeTo.text substringWithRange:NSMakeRange(0,2)]  ;
                NSString *minutesSTR = [_timeTo.text substringWithRange:NSMakeRange(3, 2)];
                NSString *ampmSTR = [_timeTo.text substringWithRange:NSMakeRange(5, 2)];
                NSArray *arr = [[NSArray alloc] initWithArray:[self getHoursIn:hoursSTR andMinutes:minutesSTR andAMorPMvalue:ampmSTR]];
                int hourInt = (int)[arr objectAtIndex:0 ];
                int minuteInt = (int)[arr objectAtIndex:1 ];
                int ampmInt = (int)[arr objectAtIndex:2 ];
                
                [_timePicker selectRow:hourInt inComponent:0 animated:YES];
                [_timePicker selectRow:minuteInt inComponent:1 animated:YES];
                [_timePicker selectRow:ampmInt inComponent:2 animated:YES];
                
            }
        } else {
            NSString *hoursSTR = [_hoursArray objectAtIndex:( [_timePicker selectedRowInComponent:0] % [_hoursArray count])];
            NSString *minutesSTR =[_minutesArray objectAtIndex:( [_timePicker selectedRowInComponent:1] % [_minutesArray count])];
            NSString *ampmSTR =_ampmArray[[_timePicker selectedRowInComponent:2]];
            NSString *timeTo = [NSString stringWithFormat:@"%@:%@%@",hoursSTR, minutesSTR, ampmSTR];
            
            _timeTo.text = timeTo;
            
            if ([ampmSTR isEqualToString:@"AM"]) {
                ampmSTR = @"0";
            }else {
                ampmSTR = @"12";
            }
            
            _dateTo = [NSString stringWithFormat:@"%@.%@.%@",ampmSTR ,hoursSTR, minutesSTR ];
            
            _timeToButtonTapped = NO;
            
        }
        _timePickerBGView.hidden = !_timePickerBGView.hidden;
    }
    _timePicker.hidden = NO;
    _doneButtonForTimePicker.hidden = !_doneButtonForTimePicker.hidden;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
