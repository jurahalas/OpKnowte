//
//  OKOngoingClinicalPRViewController.m
//  OpKnowte
//
//  Created by Olegek on 05.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKOngoingClinicalPRViewController.h"

@interface OKOngoingClinicalPRViewController ()
@property (strong, nonatomic) IBOutlet UIView *tabBarView;
@property (strong, nonatomic) IBOutlet UIButton *updateButton;
@property (strong, nonatomic) IBOutlet UITextField *tTextField;
@property (strong, nonatomic) IBOutlet UITextField *nTextField;
@property (strong, nonatomic) IBOutlet UITextField *mTextField;
@property (strong, nonatomic) IBOutlet UITextField *tumorCharacteristicsTextField;
@property (strong, nonatomic) IBOutlet UITextField *fuhrmanGradeTextField;
@property (strong, nonatomic) IBOutlet UITextField *marginsTextField;
@property (strong, nonatomic) IBOutlet UITextField *deepMarginTextField;
@property (strong, nonatomic) IBOutlet UIView *pickerView;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (nonatomic) int currentTextFieldTag;
@property (strong, nonatomic) NSArray *PickerData;

@end

@implementation OKOngoingClinicalPRViewController
@synthesize tabBarView,updateButton,tTextField,nTextField,mTextField,tumorCharacteristicsTextField,fuhrmanGradeTextField,marginsTextField,deepMarginTextField,pickerView,picker,currentTextFieldTag,PickerData;

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
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self design];
    
    PickerData = [[NSArray alloc]init];
    
    tTextField.text= nil;
    nTextField.text= nil;
    mTextField.text= nil;
    tumorCharacteristicsTextField.text= nil;
    fuhrmanGradeTextField.text= nil;
    marginsTextField.text= nil;
    deepMarginTextField.text= nil;
}

-(void)addRightArrowImageToTextField: (UITextField*) textField withPlaceholder:(NSString*) placeholder
{
    UIView *textFieldDownArrowView = [[UIView alloc] init];
    UIImageView *textFieldDownArrow = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 20, 20)] ;
    textFieldDownArrow.image = [UIImage imageNamed:@"right"];
    textFieldDownArrowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    textFieldDownArrowView.backgroundColor = [UIColor clearColor];
    [textFieldDownArrowView addSubview:textFieldDownArrow];
    textField.rightView = textFieldDownArrowView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0f];
    textField.layer.borderWidth = 1.f;
    textField.clipsToBounds = YES;
    
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
}


-(void)design{
    
    updateButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    updateButton.layer.cornerRadius = 14;
    
    tabBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradientBG"]];
    tabBarView.backgroundColor = [UIColor clearColor];
    
    picker.hidden = NO;
    pickerView.hidden = YES;
    //pickerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    pickerView.backgroundColor = [UIColor clearColor];
    [self.pickerView bringSubviewToFront:tabBarView];
    
    [self addRightArrowImageToTextField:tTextField withPlaceholder:@"T"];
    [self addRightArrowImageToTextField:nTextField withPlaceholder:@"N"];
    [self addRightArrowImageToTextField:mTextField withPlaceholder:@"M"];
    [self addRightArrowImageToTextField:tumorCharacteristicsTextField withPlaceholder:@"Tumor Characteristics"];
    [self addRightArrowImageToTextField:fuhrmanGradeTextField withPlaceholder:@"Fuhrman Grade"];
    [self addRightArrowImageToTextField:marginsTextField withPlaceholder:@"Margins"];
    [self addRightArrowImageToTextField:deepMarginTextField withPlaceholder:@"Deep Margin"];
}

#pragma mark Picker View

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSUInteger numRows=[PickerData count];
    return numRows;
}

-(NSAttributedString*) pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *pickerString = [NSString stringWithFormat:@"%@", [PickerData objectAtIndex:row]];
    NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    return pickerAttributedString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(currentTextFieldTag == 1){
        tTextField.text = [NSString stringWithFormat:@"%@", [PickerData objectAtIndex:row]];
    }
    else if(currentTextFieldTag == 2){
        nTextField.text = [NSString stringWithFormat:@"%@", [PickerData objectAtIndex:row]];
    }
    else if(currentTextFieldTag == 3){
        mTextField.text = [NSString stringWithFormat:@"%@", [PickerData objectAtIndex:row]];
    }
    else if(currentTextFieldTag == 4){
        tumorCharacteristicsTextField.text = [NSString stringWithFormat:@"%@", [PickerData objectAtIndex:row]];
    }
    else if(currentTextFieldTag == 5){
        fuhrmanGradeTextField.text = [NSString stringWithFormat:@"%@", [PickerData objectAtIndex:row]];
    }
    else if(currentTextFieldTag == 6){
        marginsTextField.text = [NSString stringWithFormat:@"%@", [PickerData objectAtIndex:row]];
    }
    else deepMarginTextField.text = [NSString stringWithFormat:@"%@",[PickerData objectAtIndex:row]];
}

#pragma mark - IBAction

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)tButton:(id)sender {
    
    pickerView.hidden = !pickerView.hidden;
    tabBarView.hidden = !tabBarView.hidden;
        
    NSArray * T = [[NSArray alloc]initWithObjects:@"TX",@"T0",@"T1",@"T1a",@"T1b",@"T2",@"T2a",@"T2b",@"T3",@"T3a",@"T3b",@"T3c",@"T4", nil];
    PickerData = T;
    
    [self.view bringSubviewToFront:pickerView];
    
    [picker reloadAllComponents];
        
    [self.view endEditing:YES];
    
    currentTextFieldTag = 1;
}

- (IBAction)nButton:(id)sender {
    pickerView.hidden = !pickerView.hidden;
    tabBarView.hidden = !tabBarView.hidden;
    
    NSArray * N = [[NSArray alloc]initWithObjects:@"N",@"NX",@"N0",@"N1",nil];
    PickerData = N;
    
    [self.view bringSubviewToFront:pickerView];
    
    [picker reloadAllComponents];
    
    [self.view endEditing:YES];
    
    currentTextFieldTag = 2;
}

- (IBAction)mButton:(id)sender {
    pickerView.hidden = !pickerView.hidden;
    tabBarView.hidden = !tabBarView.hidden;
    
    NSArray * M = [[NSArray alloc]initWithObjects:@"M",@"M0",@"M1", nil];
    PickerData = M;
    
    [self.view bringSubviewToFront:pickerView];
    
    [picker reloadAllComponents];
    
    [self.view endEditing:YES];
    
    currentTextFieldTag = 3;
}
- (IBAction)tumorCharacteristicsButton:(id)sender {
    pickerView.hidden = !pickerView.hidden;
    tabBarView.hidden = !tabBarView.hidden;
    
    NSArray * tumor = [[NSArray alloc]initWithObjects:@"Clear Cell",@"Papillary",@"Chromophobe",@"Sarcomatoid",@"angiomyolipoma",@"oncocytoma",@"other",nil];
    PickerData = tumor;
    
    [self.view bringSubviewToFront:pickerView];
    
    [picker reloadAllComponents];
    
    [self.view endEditing:YES];
    
    currentTextFieldTag = 4;
}
- (IBAction)fuhrmanButton:(id)sender {
    pickerView.hidden = !pickerView.hidden;
    tabBarView.hidden = !tabBarView.hidden;
    
    NSArray * fuhrman = [[NSArray alloc]initWithObjects:@"1/4",@"2/4",@"3/4",@"4/4", nil];
    PickerData = fuhrman;
    
    [self.view bringSubviewToFront:pickerView];
    
    [picker reloadAllComponents];
    
    [self.view endEditing:YES];
    
    currentTextFieldTag = 5;
}
- (IBAction)marginsButton:(id)sender {
    pickerView.hidden = !pickerView.hidden;
    tabBarView.hidden = !tabBarView.hidden;
    
    NSArray * margins = [[NSArray alloc]initWithObjects:@"Positive",@"Negative", nil];
    PickerData = margins;
    
    [self.view bringSubviewToFront:pickerView];
    
    [picker reloadAllComponents];
    
    [self.view endEditing:YES];
    
    currentTextFieldTag = 6;
}
- (IBAction)deepMarginsButton:(id)sender {
    pickerView.hidden = !pickerView.hidden;
    tabBarView.hidden = !tabBarView.hidden;
    
    NSArray * deep = [[NSArray alloc]initWithObjects:@"Positive",@"Negative", nil];
    PickerData = deep;
    
    [self.view bringSubviewToFront:pickerView];
    
    [picker reloadAllComponents];
    
    [self.view endEditing:YES];
    
    currentTextFieldTag = 7;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
