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


-(void) setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
}


-(NSInteger) getCurrentPage{
    return _currentPage;
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
    self.picker.hidden = FALSE;
}


-(void)showDatePickerWithDate:(NSDate*)date picker:(OKProcedurePicker*)pickerObject
{
    self.pickerObject = pickerObject;
    self.picker.hidden = TRUE;
    self.datePicker.hidden = FALSE;
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
    self.pickerObject.customTextField.text = self.datePicker.date;
    
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


- (IBAction)backButtonTapped:(id)sender {
}


- (IBAction)rightButtonTapped:(id)sender {
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
