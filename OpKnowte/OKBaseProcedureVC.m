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


@interface OKBaseProcedureVC () <OKProcedureTextFieldDelegate, OKProcedureDatePickerDelegate, OKProcedurePickerDelegate, OKProcedureSwitcherDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


-(void) addCustomElementFromDictionary: (NSDictionary *) customElementDictionary {
    if ([[customElementDictionary objectForKey:@"type"] isEqualToString:@"symbolicTextField"]) {
        OKProcedureTextField *symbolicTextField = [[OKProcedureTextField alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        [self.view addSubview:symbolicTextField.view];
        [symbolicTextField setFieldName:[customElementDictionary objectForKey:@"name"]];
        [symbolicTextField setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"] ];
        [symbolicTextField setType:0];
        [self.interactionItems addObject:symbolicTextField];
        
    } else if ([[customElementDictionary objectForKey:@"type"] isEqualToString:@"numericTextField"]) {
        OKProcedureTextField *numericTextField = [[OKProcedureTextField alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        [self.view addSubview:numericTextField.view];
        [numericTextField setFieldName:[customElementDictionary objectForKey:@"name"]];
        [numericTextField setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"] ];
        [numericTextField setType:1];
        [self.interactionItems addObject:numericTextField];
        
    } else if ([[customElementDictionary objectForKey:@"type"] isEqualToString:@"DatePicker"]) {
        OKProcedureDatePicker *datePicker = [[OKProcedureDatePicker alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        [self.view addSubview:datePicker.view];
        [datePicker setFieldName:[customElementDictionary objectForKey:@"name"]];
        [datePicker setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"] ];
        [self.interactionItems addObject:datePicker];
        
        
    } else if ([[customElementDictionary objectForKey:@"type"] isEqualToString:@"picker"]) {
        OKProcedurePicker *picker = [[OKProcedurePicker alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        [self.view addSubview:picker.view];
        [picker setFieldName:[customElementDictionary objectForKey:@"name"]];
        [picker setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"] ];
        [picker setDataArray:[customElementDictionary objectForKey:@"items"]];
        [self.interactionItems addObject:picker];


    } else {
        OKProcedureSwitcher *switcher = [[OKProcedureSwitcher alloc] initWithFrame:CGRectMake(0, _xPoint, 320, 43)];
        [self.view addSubview:switcher.view];
        [switcher setFieldName:[customElementDictionary objectForKey:@"name"]];
        [switcher setPlaceHolder:[customElementDictionary objectForKey:@"placeholder"] ];
        [self.interactionItems addObject:switcher];
    }
    _xPoint += 43;
}


#pragma mark - OKProcedureTextFieldDelegate
-(void)updateField:(NSString*)name withValue:(NSString*)newValue
{

}


#pragma mark - OKProcedureSwitcherDelegate
-(void)updateField:(NSString*)name withBoolValue:(BOOL)newValue{
    
}


-(void)showPickerWithData:(NSArray*)pickerData picker:(OKProcedurePicker*)pickerObject
{
    self.pickerObject = pickerObject;
    self.picker.hidden = NO;
    self.datePicker.hidden = YES;
}


-(void)showDatePickerWithDate:(NSDate*)date picker:(OKProcedureDatePicker*)datePickerObject
{
    self.datePickerObject = datePickerObject;
    self.picker.hidden = YES;
    self.datePicker.hidden = NO;
    if(date)
        [self.datePicker setDate:date];
    else
        [self.datePicker setDate:[NSDate date]];
}


-(void)hidePicker
{
    self.pickerObject.customTextField.text = self.pickerData[[self.picker selectedRowInComponent:0]];
    self.picker.hidden = YES;
    self.pickerData = nil;
}


-(void)hideDatePicker
{
    self.pickerObject.customTextField.text = [NSString stringWithFormat:@"%@", self.datePicker.date];
    self.datePicker.hidden = YES;
    self.pickerData = nil;
}


#pragma mark - picker data source

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerData[row];
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.pickerObject.customTextField.text = self.pickerData[row];
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    //    if (self.currentPage > 0 ) {
    //        self.currentPage = (self.currentPage - 1);
    //    }
}


- (IBAction)rightButtonTapped:(id)sender {
    if (self.currentPage < (self.plistArray.count - 1) ) {
        id nextVC = [self nextVC];
        
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
