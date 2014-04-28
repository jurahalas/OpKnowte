//
//  OKShockwaveLithotripsyVC.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/24/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKShockwaveLithotripsyVC.h"
#import "OKProcedureTextField.h"
#import "OKProcedureSwitcher.h"
#import "OKProcedureDatePicker.h"
#import "OKProcedurePicker.h"
#import "OKShockwaveLithotripsyModel.h"

@interface OKShockwaveLithotripsyVC ()
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (nonatomic,strong) NSArray *plistArray;
@property (nonatomic, strong) OKShockwaveLithotripsyModel *SLModel;
@end

@implementation OKShockwaveLithotripsyVC

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
    _plistArray = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SLProcedure" ofType:@"plist"]];
    if (![self getCurrentPage]) {
        [self setCurrentPage:0];
    }
    NSArray *currentPageFieldsArray =[[_plistArray objectAtIndex:[self getCurrentPage]] objectForKey:@"fields" ];
    int xPoint = 80;
    
    for (int i = 0; i< currentPageFieldsArray.count; i++) {
//
//        if (<#condition#>) {
//            <#statements#>
//        }
        if ([[[currentPageFieldsArray objectAtIndex:i]objectForKey:@"type"] isEqualToString:@"symbolicTextField"]) {
            OKProcedureTextField *symbolicTextField = [[OKProcedureTextField alloc] initWithFrame:CGRectMake(0, xPoint, 320, 43)];
            [self.view addSubview:symbolicTextField.view];
            [symbolicTextField setFieldName:[[currentPageFieldsArray objectAtIndex:i]objectForKey:@"name"]];
            [symbolicTextField setPlaceHolder:[[currentPageFieldsArray objectAtIndex:i]objectForKey:@"placeholder"] ];
            [symbolicTextField setType:0];
            
        } else if ([[[currentPageFieldsArray objectAtIndex:i]objectForKey:@"type"] isEqualToString:@"numericTextField"]) {
            OKProcedureTextField *numericTextField = [[OKProcedureTextField alloc] initWithFrame:CGRectMake(0, xPoint, 320, 43)];
            [self.view addSubview:numericTextField.view];
            [numericTextField setFieldName:[[currentPageFieldsArray objectAtIndex:i]objectForKey:@"name"]];
            [numericTextField setPlaceHolder:[[currentPageFieldsArray objectAtIndex:i]objectForKey:@"placeholder"] ];
            [numericTextField setType:1];

        } else if ([[[currentPageFieldsArray objectAtIndex:i]objectForKey:@"type"] isEqualToString:@"DatePicker"]) {
            OKProcedureDatePicker *datePicker = [[OKProcedureDatePicker alloc] initWithFrame:CGRectMake(0, xPoint, 320, 43)];
            [self.view addSubview:datePicker.view];
            [datePicker setFieldName:[[currentPageFieldsArray objectAtIndex:i]objectForKey:@"name"]];
            [datePicker setPlaceHolder:[[currentPageFieldsArray objectAtIndex:i]objectForKey:@"placeholder"] ];
            
        } else if ([[[currentPageFieldsArray objectAtIndex:i]objectForKey:@"type"] isEqualToString:@"picker"]) {
            OKProcedurePicker *picker = [[OKProcedurePicker alloc] initWithFrame:CGRectMake(0, xPoint, 320, 43)];
            [self.view addSubview:picker.view];
            [picker setFieldName:[[currentPageFieldsArray objectAtIndex:i]objectForKey:@"name"]];
            [picker setPlaceHolder:[[currentPageFieldsArray objectAtIndex:i]objectForKey:@"placeholder"] ];

        } else {
            OKProcedureSwitcher *switcher = [[OKProcedureSwitcher alloc] initWithFrame:CGRectMake(0, xPoint, 320, 43)];
            [self.view addSubview:switcher.view];
            [switcher setFieldName:[[currentPageFieldsArray objectAtIndex:i]objectForKey:@"name"]];
            [switcher setPlaceHolder:[[currentPageFieldsArray objectAtIndex:i]objectForKey:@"placeholder"] ];

        }
        xPoint += 43;
    }
}
#pragma mark - OKProcedureTextFieldDelegate
-(void)updateField:(NSString*)name withValue:(NSString*)newValue
{

    if ([name isEqualToString:@"patientName"]) {
        _SLModel.patientName = newValue;
    } else if ([name isEqualToString:@"PatientDOB"]){
        _SLModel.patientDOB = newValue;
    } else if ([name isEqualToString:@"PatientDOB"]){
        _SLModel.patientDOB = newValue;
    } else if ([name isEqualToString:@"medicalRecordNumber"]){
        _SLModel.mrNumber = newValue;
    } else if ([name isEqualToString:@"DateOfService"]){
        _SLModel.dateOfService = newValue;
    } else if ([name isEqualToString:@"sex"]){
        _SLModel.gender = newValue;
    } else if ([name isEqualToString:@"anesthesia"]){
        _SLModel.anesthesiaPerformed = newValue;
    } else if ([name isEqualToString:@"rightOrLeft"]){
        _SLModel.anesthesiaLocation = newValue;
    } else if ([name isEqualToString:@"numberOfStones"]){
        _SLModel.sonesCount = newValue;
    } else if ([name isEqualToString:@"stoneLocation"]){
        [_SLModel.stonesLocations addObject:newValue];
    } else if ([name isEqualToString:@"stoneSize"]){
        [_SLModel.stonesSizes addObject:newValue];
    } else if ([name isEqualToString:@"numberOfShockwaves"]){
        [_SLModel.totalShocks addObject:newValue];
    } else if ([name isEqualToString:@"stoneFragmentations"]){
        [_SLModel.degreeOfFragmentation addObject:newValue];
    } else if ([name isEqualToString:@"rateOfShockwaves"]){
        _SLModel.rateOfWaves = newValue;
    } else if ([name isEqualToString:@"voltageOfShockwaves"]){
        _SLModel.kvOfWaves = newValue;
    } else if ([name isEqualToString:@"complicationsDescriptions"]){
        _SLModel.complications = newValue;
    } else if ([name isEqualToString:@"followUp"]){
        _SLModel.followUp = newValue;
    }
}
#pragma mark - OKProcedureSwitcherDelegate
-(void)updateField:(NSString*)name withBoolValue:(BOOL)newValue{
    NSString *boolToString = @"";
    if (newValue) {
        boolToString = @"YES";
    } else {
        boolToString = @"NO";
    }
    if ([name isEqualToString:@"twoMinutesPausePerformed"]) {
        _SLModel.pausePerformed = boolToString;
    } else if ([name isEqualToString:@"complications"]) {
        
    }
}


#pragma mark - IBActions
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)nextButton:(id)sender {
    
    if ([self getCurrentPage] < (_plistArray.count - 1) ) {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
