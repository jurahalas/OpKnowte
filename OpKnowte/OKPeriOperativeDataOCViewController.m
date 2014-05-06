//
//  OKPeriOperativeDataOCViewController.m
//  OpKnowte
//
//  Created by Olegek on 06.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKPeriOperativeDataOCViewController.h"

@interface OKPeriOperativeDataOCViewController ()
@property (strong, nonatomic) IBOutlet UIButton *updateButton;
@property (strong, nonatomic) IBOutlet UIView *tabBarView;
@property (strong, nonatomic) IBOutlet UITextField *hostitalStayTextField;
@property (strong, nonatomic) IBOutlet UITextField *complicationsTextField;
@property (strong, nonatomic) IBOutlet UITextField *preOpBunTextField;
@property (strong, nonatomic) IBOutlet UITextField *preOpCreatinineTextField;
@property (strong, nonatomic) IBOutlet UITextField *postOpBunTextField;
@property (strong, nonatomic) IBOutlet UITextField *postOpCreatinine;
@property (strong, nonatomic) IBOutlet UITextField *aditionalDiagnosisTextField;
@property (strong, nonatomic) IBOutlet UIView *pickerView;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSArray * PickerData;
@property (nonatomic) int currentTextFieldTag;


@end

@implementation OKPeriOperativeDataOCViewController
@synthesize updateButton,tabBarView,hostitalStayTextField,complicationsTextField,preOpBunTextField,preOpCreatinineTextField,postOpBunTextField,postOpCreatinine,aditionalDiagnosisTextField,pickerView,picker,PickerData,currentTextFieldTag;


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
    
    PickerData = [[NSArray alloc]init];

    [self design];
}

-(void)design{
    
    pickerView.hidden = YES;
    picker.hidden = NO;
    
    pickerView.backgroundColor = [UIColor clearColor];
    
    updateButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    updateButton.layer.cornerRadius = 14;
    
    tabBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradientBG"]];
    tabBarView.backgroundColor = [UIColor clearColor];
    
    [self addRightArrowImageToTextField:hostitalStayTextField withPlaceholder:@"Post-Op Hospital Stay"];
    [self addRightArrowImageToTextField:complicationsTextField withPlaceholder:@"Complications"];
    [self addRightArrowImageToTextField:preOpBunTextField withPlaceholder:@"Pre-operative Bun"];
    [self addRightArrowImageToTextField:preOpCreatinineTextField withPlaceholder:@"Pre-operative Creatinine"];
    [self addRightArrowImageToTextField:postOpBunTextField withPlaceholder:@"Post-operative Bun"];
    [self addRightArrowImageToTextField:postOpCreatinine withPlaceholder:@"Post-operative Creatinine"];
    [self addRightArrowImageToTextField:aditionalDiagnosisTextField withPlaceholder:@"Aditional Diagnosis"];
    
}

-(void) addRightArrowImageToTextField: (UITextField*) textField withPlaceholder:(NSString*) placeholder
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
#pragma mark - Picker View

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
        hostitalStayTextField.text = [NSString stringWithFormat:@"%@", [PickerData objectAtIndex:row]];
    }
    else if(currentTextFieldTag == 2){
        complicationsTextField.text = [NSString stringWithFormat:@"%@", [PickerData objectAtIndex:row]];
    }
//    else if(currentTextFieldTag == 3){
//        mTextField.text = [NSString stringWithFormat:@"%@", [PickerData objectAtIndex:row]];
//    }
//    else if(currentTextFieldTag == 4){
//        tumorCharacteristicsTextField.text = [NSString stringWithFormat:@"%@", [PickerData objectAtIndex:row]];
//    }
//    else if(currentTextFieldTag == 5){
//        fuhrmanGradeTextField.text = [NSString stringWithFormat:@"%@", [PickerData objectAtIndex:row]];
//    }
//    else if(currentTextFieldTag == 6){
//        marginsTextField.text = [NSString stringWithFormat:@"%@", [PickerData objectAtIndex:row]];
//    }
//    else deepMarginTextField.text = [NSString stringWithFormat:@"%@",[PickerData objectAtIndex:row]];
}

#pragma mark - IBAction

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)hospitalStayButton:(id)sender {
    
    pickerView.hidden = !pickerView.hidden;
    tabBarView.hidden = !tabBarView.hidden;
    
    NSMutableArray * HS = [[NSMutableArray alloc]init];
    for(int i = 1; i<=31 ; i++){
        [HS addObject:[NSString stringWithFormat:@"%d Nights", i]];
    }
    
    PickerData = HS;
    
    [self.view bringSubviewToFront:pickerView];
    
    [picker reloadAllComponents];
    
    [self.view endEditing:YES];
    
    currentTextFieldTag = 1;
    
}
- (IBAction)complicationsButton:(id)sender{
    
    pickerView.hidden = !pickerView.hidden;
    tabBarView.hidden = !tabBarView.hidden;
    
    NSArray * complications = [[NSArray alloc]initWithObjects:@"Ileus",@"Bowel injury",@"Infection",@"Urine leak",@"DVT",@"PE",@"Cardiac event",@"Hernia",@"Transfusion",@"Death",@"Other", nil];
    PickerData = complications;
    
    [self.view bringSubviewToFront:pickerView];
    
    [picker reloadAllComponents];
    
    [self.view endEditing:YES];
    
    currentTextFieldTag = 2;
}

- (IBAction)preOpBunButton:(id)sender {
}

- (IBAction)preOpCreatinine:(id)sender {
}

- (IBAction)postOpBunButton:(id)sender {
}

- (IBAction)postOpCreatinineButton:(id)sender {
}

- (IBAction)aditionalDiagnosisButton:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
