//
//  OKReminderVC.m
//  OpKnowte
//
//  Created by Apple on 12.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKReminderVC.h"

@interface OKReminderVC ()

- (IBAction)updateButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *daysPicker;
@property (strong, nonatomic) IBOutlet OKCustomTextField *daysPickerTextField;
@property (strong, nonatomic) IBOutlet UIButton *updateSettings;
@property (strong, nonatomic) IBOutlet UIButton *sendReminderTo;
@property (strong, nonatomic) NSArray *pickerData;

@end

@implementation OKReminderVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self design];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    
    _pickerData = [[NSArray alloc]init];
    _daysPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    _daysPicker.dataSource = self;
    _daysPicker.delegate = self;
    _daysPicker.hidden=NO;
    [_daysPicker setBackgroundColor:[UIColor colorWithRed:24/255. green:59/255. blue:85/255. alpha:.80]];
    [_daysPickerTextField setBackgroundColor:[UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:.10]];
    self.daysPickerTextField.inputView = _daysPicker;
    self.pickerData = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30"];
}

#pragma mark - Text Fields methods


-(void)design
{
    _daysPickerTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Days" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    _updateSettings.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _updateSettings.layer.cornerRadius = 14;
    _sendReminderTo.layer.borderColor =[UIColor whiteColor].CGColor;
    _sendReminderTo.layer.borderWidth = 1.f;
    _sendReminderTo.layer.cornerRadius = 14;
    


}

#pragma mark - Picker View

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}


-(NSAttributedString*) pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *pickerString = [NSString stringWithFormat:@"%@", [_pickerData objectAtIndex:row]];
    NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    return pickerAttributedString;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.daysPickerTextField.text = self.pickerData[row];
    [self.daysPickerTextField resignFirstResponder];
}

#pragma mark - IBAction

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)updateButton:(id)sender
{
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end