//
//  UCLRPNPageFourViewController.m
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/20/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCLRPNPageFourViewController.h"
#import "CONSTANTS.h"
//#import "UCAppDelegate.h"
#import "UCLRPNPageFiveViewController.h"
#import "RCSwitchOnOff.h"
#import "UCSettingsViewController.h"

#import "OKProceduresManager.h"

@interface UCLRPNPageFourViewController ()

@end

BOOL pickerUP;
BOOL keyboardUP;
BOOL viewUP;

@implementation UCLRPNPageFourViewController
@synthesize parent;
@synthesize extraLocation, extraLocationTF, locations, extraLocations;
@synthesize scroller;
@synthesize bmiButton;

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
    // Do any additional setup after loading the view from its nib.
    
    [self.scroller setContentSize:CGSizeMake(320, 430)];
    
    pickerUP = NO;
    keyboardUP = NO;
    viewUP = NO;
    
    if(IS_IPHONE_5)
    {
        l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    l_Header.text=[OKProceduresManager instance].selectedProcedure.procedureText;
    
    prevAbdominal = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(230, 315, 63, 26)];
    [prevAbdominal setOn:NO];
    [self.scroller addSubview:prevAbdominal];
    
    tumorTxt_.tag = 1;
    tumorTxt_.keyboardType = UIKeyboardTypeDecimalPad;
    bmiTxt_.keyboardType = UIKeyboardTypeDecimalPad;
    bmiTxt_.tag = 5;
    
    characteristic = [[NSArray alloc] initWithObjects:@"Endophytic", @"Exophytic", @"Endophytic and Exophytic", nil];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    bmiTxt_.inputAccessoryView = numberToolbar;
    tumorTxt_.inputAccessoryView = numberToolbar;
}

-(void)cancelNumberPad{
    
    if ([tumorTxt_ isFirstResponder]) {
        [tumorTxt_ resignFirstResponder];
         tumorTxt_.text = @"";
    }else if ([bmiTxt_ isFirstResponder]){
        [bmiTxt_ resignFirstResponder];
         bmiTxt_.text = @"";
    }
}

-(void)doneWithNumberPad{
    
    if ([tumorTxt_ isFirstResponder]) {
        [tumorTxt_ resignFirstResponder];
    }else if ([bmiTxt_ isFirstResponder]){
        [bmiTxt_ resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

-(IBAction)extraLocationBtn:(id)sender{
    
    if (self.extraLocations == nil) {
        self.extraLocations = [[NSMutableArray alloc] init];
    }
    [self.extraLocations removeAllObjects];
    [self.extraLocations addObject:@"Anterior"];
    [self.extraLocations addObject:@"Posterior"];
    
    isExtraLocationPressed = YES;
    extraLocation.hidden = true;
    [picker_ reloadAllComponents];
    
    if([self.extraLocationTF.text isEqualToString:[self.extraLocations objectAtIndex:0]]) {
        [picker_ selectRow:0 inComponent:0 animated:NO];
    }
    else if([self.extraLocationTF.text isEqualToString:[self.extraLocations objectAtIndex:1]])
        [picker_ selectRow:1 inComponent:0 animated:NO];
    
    if (viewUP) {
        viewUP = NO;
        //[self animateTextField:bmiTxt_ up:NO];
    }
    
    if (tumorTxt_.isFirstResponder) {
        [tumorTxt_ resignFirstResponder];
    }else if (bmiTxt_.isFirstResponder){
        [bmiTxt_ resignFirstResponder];
    }
    
    pickerUP = YES;
    picker_.hidden = NO;
    t_toolbar.hidden = NO;
    [prevAbdominal setHidden:YES];
    
    self.extraLocationTF.text = (NSString*)[self.extraLocations objectAtIndex:[picker_ selectedRowInComponent:0]];
}

- (IBAction)locationBtnPressed:(id)sender {
    self.locations = [[NSMutableArray alloc] init];
    [self.locations addObject:@"upper pole"];
    [self.locations addObject:@"mid-kidney"];
    [self.locations addObject:@"lower pole"];
    
    
    isLocationPressed = YES;
    locationLbl_.hidden = true;
    [picker_ reloadAllComponents];
    
    if([locationTxt_.text isEqualToString:[self.locations objectAtIndex:0]]) {
        [picker_ selectRow:0 inComponent:0 animated:NO];
    }
    else if([locationTxt_.text isEqualToString:[self.locations objectAtIndex:1]])
        [picker_ selectRow:1 inComponent:0 animated:NO];
    else if([locationTxt_.text isEqualToString:[self.locations objectAtIndex:2]])
        [picker_ selectRow:2 inComponent:0 animated:NO];
    
    if (viewUP) {
        viewUP = NO;
        //[self animateTextField:bmiTxt_ up:NO];
    }
    
    if (tumorTxt_.isFirstResponder) {
        [tumorTxt_ resignFirstResponder];
    }else if (bmiTxt_.isFirstResponder){
        [bmiTxt_ resignFirstResponder];
    }
    
    pickerUP = YES;
    picker_.hidden = NO;
    t_toolbar.hidden = NO;
    [prevAbdominal setHidden:YES];
    
    locationTxt_.text = (NSString*)[self.locations objectAtIndex:[picker_ selectedRowInComponent:0]];
}

- (IBAction)forwardButtonPressed:(id)sender {
    
    if (([tumorTxt_.text length] == 0) || ([locationTxt_.text length] == 0) || ([characteristicTxt_.text length] == 0) || (self.extraLocationTF.text.length == 0) || ([bmiTxt_.text length] == 0)) {
        [UCUtility showInfoAlertView:@"Error" withMessage:@"Please complete all required fields."];
    }
    else {
        parent.parentModel.var_tumorSize = [NSString stringWithFormat:@"%@ cm", tumorTxt_.text];
        parent.parentModel.var_location = locationTxt_.text;
        parent.parentModel.var_tumorChar = characteristicTxt_.text;
        parent.parentModel.var_bmi = bmiTxt_.text;
        
        if ([prevAbdominal isOn]) {
            parent.parentModel.var_history = @"a history";
        }
        else {
            parent.parentModel.var_history = @"no history";
        }
        
        UCLRPNPageFiveViewController *homeScreenTemp;
        
        if(IS_IPHONE_5) {
            homeScreenTemp = [[UCLRPNPageFiveViewController alloc] initWithNibName:@"UCLRPNPageFiveViewController" bundle:nil];
        }
        else {
            homeScreenTemp = [[UCLRPNPageFiveViewController alloc] initWithNibName:@"UCLRPNPageFiveViewController" bundle:nil];
        }
        
        homeScreenTemp.parent = parent;
        [self.navigationController pushViewController:homeScreenTemp animated:NO];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    if(isLocationPressed){
        //isLocationPressed = NO;
        locationTxt_.text = (NSString*)[self.locations objectAtIndex:row];
    }else if(isCharacteristicPressed){
        //isCharacteristicPressed = NO;
        characteristicTxt_.text = (NSString*)[characteristic objectAtIndex:row];
    }else if (isExtraLocationPressed){
        
        extraLocationTF.text = (NSString*)[self.extraLocations objectAtIndex:row];
    }
        
    
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSUInteger numRows=0;
    if(isLocationPressed)
    {
        numRows = [self.locations count];
    }
    else if(isCharacteristicPressed)
    {
        numRows = [characteristic count];
    }
    else if (isExtraLocationPressed){
        numRows = [self.extraLocations count];
    }
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = @"";
    if(isLocationPressed)
    {
        title = (NSString*)[self.locations objectAtIndex:row];
    }
    else if(isCharacteristicPressed)
    {
        title = (NSString*)[characteristic objectAtIndex:row];
    }
    else if (isExtraLocationPressed){
        title = (NSString*)[self.extraLocations objectAtIndex:row];
    }
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}
- (void)viewDidUnload {
    tumorLbl_ = nil;
    tumorTxt_ = nil;
    locationTxt_ = nil;
    locationLbl_ = nil;
    tumorLbl_ = nil;
    charcteristicLbl_ = nil;
    characteristicTxt_ = nil;
    [self setCharacteristicBtnPresed:nil];
    t_toolbar = nil;
    picker_ = nil;
    bmiLbl_ = nil;
    bmiSelectLbl_ = nil;
    bmiTxt_ = nil;
    [super viewDidUnload];
}
- (IBAction)pickerDonePressed:(id)sender {
    [prevAbdominal setHidden:NO];
    t_toolbar.hidden = true;
    picker_.hidden = true;
    pickerUP = NO;
    [bmiTxt_ resignFirstResponder];
    isCharacteristicPressed = NO;
    isLocationPressed = NO;
    isExtraLocationPressed = NO;
}

- (IBAction)characteristicBtnPressed:(id)sender {    
     isCharacteristicPressed = YES;
    
     [picker_ reloadAllComponents];
    if([characteristicTxt_.text isEqualToString:[characteristic objectAtIndex:0]] )
    {
        [picker_ selectRow:0 inComponent:0 animated:NO];
    }
    else if([characteristicTxt_.text isEqualToString:[characteristic objectAtIndex:1]] ){
        [picker_ selectRow:1 inComponent:0 animated:NO];
    }else if([characteristicTxt_.text isEqualToString:[characteristic objectAtIndex:2]] ){
        [picker_ selectRow:2 inComponent:0 animated:NO];
    }
    
    if (viewUP) {
        viewUP = NO;
        //[self animateTextField:bmiTxt_ up:NO];
    }
    
    if (tumorTxt_.isFirstResponder) {
        [tumorTxt_ resignFirstResponder];
    }else if (bmiTxt_.isFirstResponder){
        [bmiTxt_ resignFirstResponder];
    }
    
    pickerUP = YES;
    picker_.hidden = NO;
    t_toolbar.hidden = NO;
    [prevAbdominal setHidden:YES];
    
    characteristicTxt_.text = (NSString*)[characteristic objectAtIndex:[picker_ selectedRowInComponent:0]];
    charcteristicLbl_.hidden = true;
   
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (pickerUP) {
        t_toolbar.hidden = YES;
        picker_.hidden = YES;
        pickerUP = NO;
    }
    if(textField.tag ==1)
    {
        tumorLbl_.hidden = YES;
    }
    else if(textField.tag == 5)
    {
        bmiSelectLbl_.hidden = YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField.tag == 1)
    {
        if(textField.text.length < 1 || [textField.text floatValue]<=0)
        {
            tumorTxt_.text = @"";
            tumorLbl_.hidden = NO;
        }
        
    }
    else if(textField.tag == 5)
    {
        if(textField.text.length < 1 || [textField.text floatValue]<=0)
        {
            textField.text = @"";
            bmiSelectLbl_.hidden = NO;
            bmiLbl_.hidden = NO;
        }
        [self.bmiButton setEnabled:YES];
        viewUP = NO;
        [self animateTextField: textField up: NO];
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    t_toolbar.hidden = true;
    return NO;
}
- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    if (IS_IPHONE_5) {
        
        const int movementDistance = 180; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        int movement = (up ? -movementDistance : movementDistance);
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
        
    }else{
        
        const int movementDistance = 230; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        int movement = (up ? -movementDistance : movementDistance);
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
        
    }
    
}
- (IBAction)homeButtonPressed:(id)sender {
    if (DELEGATE.isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@".0123456789 "] invertedSet];
    if ([textField.text rangeOfCharacterFromSet:set].location != NSNotFound)
    {
        
        // NSString *text;
        // text =[[textField text] stringByAppendingString:string];
        NSString *newString = [textField.text substringToIndex:[textField.text length]-1];
        
        // newString=[newString stringByAppendingString:string];
        
        textField.text=newString;
        
        
        
        NSLog(@"This string contains illegal characters%@ %i",string,range.length);;
        
    }
    return TRUE;
}

-(BOOL)isValidText:(NSString *)text
{
    
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    if ([text rangeOfCharacterFromSet:set].location == NSNotFound)
    {
        return TRUE;
    }
    else
        return TRUE;
}
-(IBAction)SettingsView:(id)sender
{
    UCSettingsViewController *setting = nil;
    //if(IS_IPHONE_5) {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController" bundle:nil];
    /*}
    else {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController_iphone" bundle:nil];
    }*/
    
    //UCSettingsViewController * setting =[[UCSettingsViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}


-(IBAction)bmiValueGet:(UIButton *)sender{
    
    [self.bmiButton setEnabled:NO];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Select from options" delegate:self cancelButtonTitle:@"Manual input" otherButtonTitles:@"BMI Calculator", nil];
    [alert setTag:101];
    [alert show];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 101) {
        if (buttonIndex == 0) {
            [bmiTxt_ becomeFirstResponder];
            viewUP = YES;
            [self animateTextField:bmiTxt_ up:YES];
            //t_toolbar.hidden = false;
            
        }else if (buttonIndex == 1){
            
            [self.bmiButton setEnabled:YES];
            
            UIAlertView *alertCalc = [[UIAlertView alloc] initWithTitle:@"Insert Values" message:@"\n \n \n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            [alertCalc setTag:102];
            // Insert a username text field
            UITextField *height= [[UITextField alloc] initWithFrame:CGRectMake(12, 50, 260, 30)];
            height.placeholder = @"Height (inches)";
            height.tag = 10;
            [height setBackgroundColor:[UIColor whiteColor]];
            [height setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
            
            // insert a password text field
            UITextField *weight = [[UITextField alloc] initWithFrame:CGRectMake(12, 85, 260, 30)];
            weight.placeholder = @"Weight (pounds)";
            weight.tag = 11;
            [weight setBackgroundColor:[UIColor whiteColor]];
            [weight setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
            
            [alertCalc addSubview:height];
            [alertCalc addSubview:weight];
            
            CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 0);
            [alertCalc setTransform:transform];
            
            [alertCalc show];
            
            
        }
    }else if (alertView.tag == 102){
        if (buttonIndex == 1){
            
            NSString *height = [[NSString alloc] init];
            NSString *weight = [[NSString alloc] init];
            
            for (UIView *tf in alertView.subviews) {
                
                NSString *str = [NSString stringWithFormat:@"%@",[tf class]];
                if ([str isEqualToString:@"UITextField"]) {
                    [((UITextField *)tf) text];
                    
                    if ([((UITextField *)tf) tag] == 10) {
                        height = [((UITextField *)tf) text];
                    }
                    else if ([((UITextField *)tf) tag] == 11){
                        weight = [((UITextField *)tf) text];
                    }
                    
                    
                }
            }
            
            float bmiValue = ([weight floatValue]/([height floatValue]*[height floatValue]))*703;
            
            bmiSelectLbl_.hidden = true;
            [bmiTxt_ setText:[NSString stringWithFormat:@"%.2f",bmiValue]];
        }
    }
}
@end
