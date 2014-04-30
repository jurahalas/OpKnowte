//
//  OKOngoingClinicalViewController.m
//  OpKnowte
//
//  Created by Olegek on 28.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKOngoingClinicalViewController.h"

@interface OKOngoingClinicalViewController () 
@property (strong, nonatomic) IBOutlet UIButton *updateButton;
@property (strong, nonatomic) IBOutlet OKCustomTextField *chestXrayPiker;
@property (strong, nonatomic) IBOutlet OKCustomTextField *chestXray;
@property (strong, nonatomic) IBOutlet OKCustomTextField *bun;
@property (strong, nonatomic) IBOutlet OKCustomTextField *creatinine;
@property (strong, nonatomic) IBOutlet OKCustomTextField *liverEnzymesPiker;
@property (strong, nonatomic) IBOutlet OKCustomTextField *liverEnzymes;
@property (strong, nonatomic) IBOutlet OKCustomTextField *portSiteHerniaPiker;
@property (strong, nonatomic) IBOutlet OKCustomTextField *ctScanPiker;
@property (strong, nonatomic) IBOutlet OKCustomTextField *outher;
@property (strong, nonatomic) IBOutlet UIPickerView *MDPiker;
@property (strong, nonatomic) IBOutlet UIView *PikerView;
@property (strong, nonatomic) NSArray *MDPickerData;
@property (nonatomic) BOOL animatedKeyboard;
@property (nonatomic) int currentTextFieldTag;
@property (strong, nonatomic) IBOutlet UIView *bottonTabBarButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation OKOngoingClinicalViewController
@synthesize animatedKeyboard,updateButton,chestXrayPiker,chestXray,bun,creatinine,liverEnzymesPiker,liverEnzymes,portSiteHerniaPiker,ctScanPiker,outher,MDPickerData,MDPiker,currentTextFieldTag,PikerView,bottonTabBarButton,scrollView;


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
    [self design];
    [self addBottomTabBarButton];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    
    MDPickerData = [[NSArray alloc]init];
    MDPiker.hidden = NO;
    PikerView.hidden = YES;
    
    PikerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
    chestXrayPiker.text = nil;
    chestXray.text = nil;
    bun.text = nil;
    creatinine.text = nil;
    liverEnzymesPiker.text = nil;
    liverEnzymes.text = nil;
    portSiteHerniaPiker.text = nil;
    ctScanPiker.text = nil;
    outher.text = nil;
    
    chestXrayPiker.tag = 1;
    chestXray.tag = 2;
    bun.tag = 3;
    creatinine.tag = 4;
    liverEnzymesPiker.tag = 5;
    liverEnzymes.tag = 6;
    portSiteHerniaPiker.tag = 7;
    ctScanPiker.tag = 8;
    outher.tag = 9;
}

-(void)addBottomTabBarButton
{
  bottonTabBarButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradientBG"]];
}

#pragma mark - Text Fields methods

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 180;
    const float movementDuration = 0.3f;
    int movement = (up ? -movementDistance : movementDistance);
    [UIView animateWithDuration:movementDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    } completion:nil];
    if (up) {
        animatedKeyboard = YES;
    } else {
        animatedKeyboard = NO;
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UIResponder* nextResponder = [textField.superview viewWithTag:(textField.tag + 1)];
    if (textField.tag != outher.tag && textField.tag != creatinine.tag && textField.tag != liverEnzymes.tag) {
        [textField resignFirstResponder];
        [nextResponder becomeFirstResponder];
    } else if (textField.tag == creatinine.tag|| textField.tag ==portSiteHerniaPiker.tag){
        MDPiker.hidden = NO;
        [textField resignFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self animateTextField: textField up: NO];
    }
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == outher.tag) {
        textField.returnKeyType = UIReturnKeyDone;
    } else {
        textField.returnKeyType = UIReturnKeyNext;
    }
    
    if(textField.tag == chestXrayPiker.tag || textField.tag == liverEnzymesPiker.tag || textField.tag == portSiteHerniaPiker.tag || textField.tag == ctScanPiker.tag) {
        [self.view endEditing:YES];
        PikerView.hidden = NO;
        [chestXrayPiker resignFirstResponder];
        [liverEnzymesPiker resignFirstResponder];
        [portSiteHerniaPiker resignFirstResponder];
        [ctScanPiker resignFirstResponder];
    } else {
        PikerView.hidden = YES;
    }
    if (textField.tag > 4  && !animatedKeyboard){
        [self animateTextField: textField up: YES];
    } else if (textField.tag <=4 && animatedKeyboard){
        [self animateTextField: textField up: NO];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
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

-(void)design
{
    [self addRightArrowImageToTextField:chestXrayPiker withPlaceholder:@"Chest X-ray"];
    chestXray.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Chest X-ray" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    bun.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Bun" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    creatinine.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Creatinine" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    [self addRightArrowImageToTextField:liverEnzymesPiker withPlaceholder:@"Liver Enzymes"];
    liverEnzymes.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Liver Enzymes" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    [self addRightArrowImageToTextField:portSiteHerniaPiker withPlaceholder:@"Port Site Hernia"];
    [self addRightArrowImageToTextField:ctScanPiker withPlaceholder:@"CT-Scan"];
    outher.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Outher" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    
    updateButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    updateButton.layer.cornerRadius = 14;
}

#pragma mark - Picker View

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSUInteger numRows=[MDPickerData count];
    return numRows;
}

-(NSAttributedString*) pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *pickerString = [NSString stringWithFormat:@"%@", [MDPickerData objectAtIndex:row]];
    NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    return pickerAttributedString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(currentTextFieldTag == 1){
        chestXrayPiker.text = [NSString stringWithFormat:@"%@", [MDPickerData objectAtIndex:row]];
    }
    else if(currentTextFieldTag == 2){
        liverEnzymesPiker.text = [NSString stringWithFormat:@"%@", [MDPickerData objectAtIndex:row]];
    }
    else if(currentTextFieldTag == 3){
        portSiteHerniaPiker.text = [NSString stringWithFormat:@"%@", [MDPickerData objectAtIndex:row]];
    }
    else ctScanPiker.text = [NSString stringWithFormat:@"%@", [MDPickerData objectAtIndex:row]];
}

#pragma mark - IBAction

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)chestXrayButton:(id)sender
{
    PikerView.hidden = !PikerView.hidden;
    
    NSArray * xRay = [[NSArray alloc]initWithObjects:@"Positive",@"Negative", nil];
    MDPickerData = xRay;
    
    [self.view bringSubviewToFront:PikerView];
    
    [MDPiker reloadAllComponents];
    
    [self.view endEditing:YES];
    
    if (animatedKeyboard) {
        [self animateTextField: outher up: NO];
    }
    currentTextFieldTag = 1;
        
}
- (IBAction)liverEnzumesButton:(id)sender
{
    PikerView.hidden = !PikerView.hidden;
    
    NSArray * liver = [[NSArray alloc]initWithObjects:@"Normal",@"Abnormal", nil];
    MDPickerData = liver;

    [self.view bringSubviewToFront:PikerView];
    
    [MDPiker reloadAllComponents];

    [self.view endEditing:YES];
    
    if (animatedKeyboard) {
        [self animateTextField: outher up: NO];
    }
    currentTextFieldTag = 2;
    
}
- (IBAction)postSiteHernia:(id)sender
{
    PikerView.hidden = !PikerView.hidden;
    
    NSArray * postSH = [[NSArray alloc]initWithObjects:@"Yes",@"No", nil];
    MDPickerData = postSH;
    
    [self.view bringSubviewToFront:PikerView];
    
    [MDPiker reloadAllComponents];

    [self.view endEditing:YES];
    
    if (animatedKeyboard) {
        [self animateTextField: outher up: NO];
    }
    currentTextFieldTag = 3;
}
- (IBAction)ctScan:(id)sender
{
    PikerView.hidden = !PikerView.hidden;

    
    NSArray * ctScan = [[NSArray alloc]initWithObjects:@"No evidence of metastatic disease",@"Local recurrence",@"Lymphadenopathy",@"Liver metastasis",@"Bone metastasis",@"Brain metastasis",@"Not performed", nil];
    MDPickerData = ctScan;
    
    [self.view bringSubviewToFront:PikerView];
    
    [MDPiker reloadAllComponents];

    [self.view endEditing:YES];
    
    if (animatedKeyboard) {
        [self animateTextField: outher up: NO];
    }
    currentTextFieldTag = 4;
}

- (void)scrollViewToOptimalPosition:(NSInteger)index
{
    CGRect scrollFrame = CGRectZero;
    
//    if(index < self.elements.count-1){
//        scrollFrame = ((UIView*)[self.elements objectAtIndex:2]).superview.frame;
//    }else{
//        scrollFrame = ((UIView*)[self.elements lastObject]).frame;
//    }
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize: scrollFrame.size];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    [self.scrollView scrollsToTop];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
