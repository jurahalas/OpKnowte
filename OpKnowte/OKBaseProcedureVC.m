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

@interface OKBaseProcedureVC () <OKProcedureDatePickerDelegate, OKProcedurePickerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, OKProcedureMultiselectDelegate>

@property (nonatomic, strong) NSArray *pickerData;
@property (nonatomic, weak) OKProcedurePicker *pickerObject;
@property (nonatomic, weak) OKProcedureDatePicker *datePickerObject;


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
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonTapped:)];
    self.navigationItem.leftBarButtonItem = backButton;
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"right"] style:UIBarButtonItemStyleBordered target:self action:@selector(rightButtonTapped:)];
    self.navigationItem.rightBarButtonItem = nextButton;
    self.interactionItems = [[NSMutableArray alloc] init];
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-162, 320, 162)];
    self.datePicker = [[OKDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-162, 320, 162)];
    [self.datePicker setTextColor:[UIColor whiteColor]];
    self.picker.hidden = YES;
    self.datePicker.hidden = YES;
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.picker.showsSelectionIndicator = YES;
    [self.view addSubview:self.datePicker];
    [self.view addSubview:self.picker];
}


-(void) addCustomElementFromDictionary: (NSDictionary *) customElementDictionary withTag:(int) tag{
    
    if ([[customElementDictionary objectForKey:@"type"] isEqualToString:@"symbolicTextField"]) {
        OKProcedureTextField *symbolicTextField = [[OKProcedureTextField alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        symbolicTextField.delegate = self;
        
        [self.view addSubview:symbolicTextField];
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
        }
        [self.interactionItems addObject:symbolicTextField];
        
    } else if ([[customElementDictionary objectForKey:@"type"] isEqualToString:@"numericTextField"]) {
        OKProcedureTextField *numericTextField = [[OKProcedureTextField alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        numericTextField.delegate = self;
        
        [self.view addSubview:numericTextField];
        [numericTextField setTagOfTextField:tag];
        if (numericTextField.tagOfTextField >0) {
            NSString *placeholder = [NSString stringWithFormat:@"%@%d)",[customElementDictionary objectForKey:@"placeholder"], numericTextField.tagOfTextField ];
            [numericTextField setPlaceHolder: placeholder];
        }else {
            [numericTextField setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"] ];
            
        }
        [numericTextField setFieldName:[customElementDictionary objectForKey:@"name"]];
        [numericTextField setType:OKProcedureNumericTF];

        [self.interactionItems addObject:numericTextField];
        
    } else if ([[customElementDictionary objectForKey:@"type"] isEqualToString:@"DatePicker"]) {
        OKProcedureDatePicker *datePicker = [[OKProcedureDatePicker alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        datePicker.delegate = self;
        
        [self.view addSubview:datePicker];
        [datePicker setTagOfTextField:tag];
        if (datePicker.tagOfTextField >0) {
            NSString *placeholder = [NSString stringWithFormat:@"%@%d)",[customElementDictionary objectForKey:@"placeholder"], datePicker.tagOfTextField ];
            [datePicker setPlaceHolder: placeholder];
        }else {
            [datePicker setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"] ];
            
        }
        [datePicker setFieldName:[customElementDictionary objectForKey:@"name"]];

        [self.interactionItems addObject:datePicker];
        
        
    } else if ([[customElementDictionary objectForKey:@"type"] isEqualToString:@"picker"]) {
        OKProcedurePicker *picker = [[OKProcedurePicker alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        picker.delegate = self;
        //[picker setup];

        picker.customTextField.inputView = _picker;
        
        [self.view addSubview:picker];
        [picker setTagOfTextField:tag];
        if (picker.tagOfTextField >0) {
            NSString *placeholder = [NSString stringWithFormat:@"%@%d)",[customElementDictionary objectForKey:@"placeholder"], picker.tagOfTextField ];
            [picker setPlaceHolder: placeholder];
        }else {
            [picker setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"] ];
            
        }
        [picker setFieldName:[customElementDictionary objectForKey:@"name"]];
        [picker setDataArray:[customElementDictionary objectForKey:@"items"]];
        NSMutableArray *pickerArray = [[NSMutableArray alloc] init];
        if ([[[customElementDictionary objectForKey:@"items"] objectAtIndex:0] isEqualToString:@"0,1"] ){
            pickerArray = [self convertStoneSizeArray:[customElementDictionary objectForKey:@"items"]];
        } else {
            pickerArray = [customElementDictionary objectForKey:@"items"];
        }
        [picker setDataArray:pickerArray];
        [self.interactionItems addObject:picker];

    } else if ([[customElementDictionary objectForKey:@"type"] isEqualToString:@"multiselect"]) {
        OKProcedureMultiselect *multiselectView = [[OKProcedureMultiselect alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        multiselectView.delegate = self;
        //[multiselectView setup];

        
        [multiselectView setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"]];
        [multiselectView setFieldName:[customElementDictionary objectForKey:@"name"]];
        
        [multiselectView setDataArray:[customElementDictionary objectForKey:@"items"]];
        [self.view addSubview:multiselectView];

        [self.interactionItems addObject:multiselectView];
    
    } else {
        OKProcedureSwitcher *switcher = [[OKProcedureSwitcher alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        switcher.delegate = self;

        [self.view addSubview:switcher];
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
    
    for(float i = .1; i<= 25.1 ; i+=.1){
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
    [OKProcedureMultiselectVC showInViewController:self fieldName:fieldName data:data delegate:sender];
}


-(void)hidePicker
{
    self.pickerObject.customTextField.text = self.pickerData[[self.picker selectedRowInComponent:0]];
    self.picker.hidden = YES;
    self.pickerData = nil;
}


-(void)hideDatePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    
    self.datePickerObject.customTextField.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self.datePicker.date] ];
    [self.datePickerObject.delegate updateField:self.datePickerObject.fieldName withValue:self.datePickerObject.customTextField.text andTag:self.datePickerObject.tagOfTextField];
    self.datePicker.hidden = YES;
    self.pickerData = nil;
    
}


#pragma mark - picker data source



-(NSAttributedString*) pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *pickerString = [NSString stringWithFormat:@"%@", self.pickerData[row]];
    NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    return pickerAttributedString;
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.pickerObject.customTextField.text = self.pickerData[row];
    [self.pickerObject.delegate updateField:self.pickerObject.fieldName withValue:self.pickerObject.customTextField.text andTag:self.pickerObject.tagOfTextField];

    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
}


- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}


- (IBAction)rightButtonTapped:(id)sender {
    if ([self canGoToNextVC]) {
        
        if (self.currentPage < (self.plistArray.count - 1) ) {
            if (self.currentPage == 0) {
                OKProceduresManager *manager = [OKProceduresManager instance];
                [[OKLoadingViewController instance] showWithText:@"Loading..."];
                [manager checkMRNumberByNumber:[self.model valueForKey:@"var_MRNumber"] handler:^(NSString *errorMsg, NSDictionary *response) {
                    if ([[response objectForKey:@"status"] isEqualToString:@"true"]) {
                         [[OKLoadingViewController instance] hide];
                        id nextVC = [self nextVC];
                        [self.navigationController pushViewController:nextVC animated:YES];
                    }
                    else {
                         [[OKLoadingViewController instance] hide];
                        UIAlertView *emptyFieldsError = [[UIAlertView alloc] initWithTitle:@"" message:@"Medical Record Number already exists. Please try another one." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [emptyFieldsError show];
                    }
                    
                }];

            }else {
                id nextVC = [self nextVC];
                [self.navigationController pushViewController:nextVC animated:YES];
            }
            
        } else {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
            OKOperatieNoteViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"OperativeNoteVC"];
            vc.model = self.model;
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

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
