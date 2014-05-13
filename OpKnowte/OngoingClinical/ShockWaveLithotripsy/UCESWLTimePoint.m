//
//  UCESWLTimePoint.m
//  MZUroCapture
//
//  Created by Atif Joyia on 07/08/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCESWLTimePoint.h"
#import "RCSwitchOnOff.h"

#import "OKClinicalManager.h"
#import "OKProceduresManager.h"

int selectionTag;

@implementation UCESWLTimePoint

@synthesize fragmentationBtn1, fragmentationBtn2, fragmentationBtn3, fragmentationBtn4, fragmentationBtn5, fragmentationLbl1, fragmentationLbl2, fragmentationLbl3, fragmentationLbl4, fragmentationLbl5, descTF, t_toolbar, picker, pickerArray, scroller, stonesCount, caseID, urlProcedureID, urlUserID, isComingFromURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.isComingFromURL = NO;
    }
    return self;
}


-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (IS_IPHONE_5) {
        l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    
    compSwitch = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(225, 75, 63, 26)];
    [compSwitch addTarget: self action: @selector(flipComp:) forControlEvents:UIControlEventValueChanged];
    [compSwitch setOn:NO];
    [self.view addSubview:compSwitch];
    
    selectionTag = 0;
    
    if ([self.stonesCount intValue] > 0) {
        [self setViewValues];
    }else{
        
    }
    
    self.pickerArray = [[NSMutableArray alloc] initWithObjects:@"Excellent", @"Good", @"Moderate", @"Poor", nil];
    
}


-(void)setViewValues{
    switch ([self.stonesCount intValue]) {
        case 1:{
            [self.fragmentationBtn1 setHidden:NO];
            [self.fragmentationLbl1 setHidden:NO];
            
            [self.fragmentationBtn2 setHidden:YES];
            [self.fragmentationLbl2 setHidden:YES];
            
            [self.fragmentationBtn3 setHidden:YES];
            [self.fragmentationLbl3 setHidden:YES];
            
            [self.fragmentationBtn4 setHidden:YES];
            [self.fragmentationLbl4 setHidden:YES];
            
            [self.fragmentationBtn5 setHidden:YES];
            [self.fragmentationLbl5 setHidden:YES];
            
        }
            break;
        case 2:{
            [self.fragmentationBtn1 setHidden:NO];
            [self.fragmentationLbl1 setHidden:NO];
            
            [self.fragmentationBtn2 setHidden:NO];
            [self.fragmentationLbl2 setHidden:NO];
            
            [self.fragmentationBtn3 setHidden:YES];
            [self.fragmentationLbl3 setHidden:YES];
            
            [self.fragmentationBtn4 setHidden:YES];
            [self.fragmentationLbl4 setHidden:YES];
            
            [self.fragmentationBtn5 setHidden:YES];
            [self.fragmentationLbl5 setHidden:YES];
        }
            break;
        case 3:{
            [self.fragmentationBtn1 setHidden:NO];
            [self.fragmentationLbl1 setHidden:NO];
            
            [self.fragmentationBtn2 setHidden:NO];
            [self.fragmentationLbl2 setHidden:NO];
            
            [self.fragmentationBtn3 setHidden:NO];
            [self.fragmentationLbl3 setHidden:NO];
            
            [self.fragmentationBtn4 setHidden:YES];
            [self.fragmentationLbl4 setHidden:YES];
            
            [self.fragmentationBtn5 setHidden:YES];
            [self.fragmentationLbl5 setHidden:YES];
        }
            break;
        case 4:{
            [self.fragmentationBtn1 setHidden:NO];
            [self.fragmentationLbl1 setHidden:NO];
            
            [self.fragmentationBtn2 setHidden:NO];
            [self.fragmentationLbl2 setHidden:NO];
            
            [self.fragmentationBtn3 setHidden:NO];
            [self.fragmentationLbl3 setHidden:NO];
            
            [self.fragmentationBtn4 setHidden:NO];
            [self.fragmentationLbl4 setHidden:NO];
            
            [self.fragmentationBtn5 setHidden:YES];
            [self.fragmentationLbl5 setHidden:YES];
        }
            break;
        case 5:{
            [self.fragmentationBtn1 setHidden:NO];
            [self.fragmentationLbl1 setHidden:NO];
            
            [self.fragmentationBtn2 setHidden:NO];
            [self.fragmentationLbl2 setHidden:NO];
            
            [self.fragmentationBtn3 setHidden:NO];
            [self.fragmentationLbl3 setHidden:NO];
            
            [self.fragmentationBtn4 setHidden:NO];
            [self.fragmentationLbl4 setHidden:NO];
            
            [self.fragmentationBtn5 setHidden:NO];
            [self.fragmentationLbl5 setHidden:NO];
        }
            break;
            
        default:
            break;
    }
}


-(void) flipComp:(id)sender
{
    if(compSwitch.on)
    {
        self.descTF.enabled = true;
        
    }
    else{
        self.descTF.enabled = false;
        self.descTF.text = @"";
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)showPicker:(UIButton *)sender{
    [self.t_toolbar setHidden:NO];
    [self.picker setHidden:NO];
    selectionTag = sender.tag;
}


-(IBAction)pickerDone:(id)sender{
    int row = [self.picker selectedRowInComponent:0];
    switch (selectionTag) {
        case 1:{
            [self.fragmentationLbl1 setText:[self.pickerArray objectAtIndex:row]];
        }
            break;
        case 2:{
            [self.fragmentationLbl2 setText:[self.pickerArray objectAtIndex:row]];
        }
            break;
        case 3:{
            [self.fragmentationLbl3 setText:[self.pickerArray objectAtIndex:row]];
        }
            break;
        case 4:{
            [self.fragmentationLbl4 setText:[self.pickerArray objectAtIndex:row]];
        }
            break;
        case 5:{
            [self.fragmentationLbl5 setText:[self.pickerArray objectAtIndex:row]];
        }
            break;
            
        default:
            break;
    }
    
    selectionTag = 0;
    [self.t_toolbar setHidden:YES];
    [self.picker setHidden:YES];
}

#pragma mark - Picker View Delegate Method

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.pickerArray objectAtIndex:row];
}



-(IBAction)update:(UIButton *)sender{
    
    NSString *locationStones;
    NSString *complications;
    BOOL alert = NO;
    
    if (compSwitch.on) {
        if (self.descTF.text.length == 0) {
            [UCUtility showInfoAlertView:@"" withMessage:@"Please ender some description of complication."];
        }else{
            complications = self.descTF.text;
        }
    }else{
        complications = @"NO";
    }
    
    switch ([self.stonesCount intValue]) {
        case 1:{
            if (self.fragmentationLbl1.text.length == 0 || [self.fragmentationLbl1.text isEqualToString:@"Degree of fragmentation for stone#1"])  {
                [UCUtility showInfoAlertView:@"" withMessage:@"Please fill all fields."];
                alert = YES;
            }else{
                locationStones = [NSString stringWithFormat:@"%@",self.fragmentationLbl1.text];
                alert = NO;
            }
        }
            break;
        case 2:{
            if (self.fragmentationLbl1.text.length == 0 || [self.fragmentationLbl1.text isEqualToString:@"Degree of fragmentation for stone#1"] || self.fragmentationLbl2.text.length == 0 || [self.fragmentationLbl2.text isEqualToString:@"Degree of fragmentation for stone#2"])  {
                [UCUtility showInfoAlertView:@"" withMessage:@"Please fill all fields."];
                alert = YES;
            }else{
                locationStones = [NSString stringWithFormat:@"%@,%@",self.fragmentationLbl1.text,fragmentationLbl2.text];
                alert = NO;
            }
        }
            break;
        case 3:{
            if (self.fragmentationLbl1.text.length == 0 || [self.fragmentationLbl1.text isEqualToString:@"Degree of fragmentation for stone#1"] || self.fragmentationLbl2.text.length == 0 || [self.fragmentationLbl2.text isEqualToString:@"Degree of fragmentation for stone#2"] || self.fragmentationLbl3.text.length == 0 || [self.fragmentationLbl3.text isEqualToString:@"Degree of fragmentation for stone#3"])  {
                [UCUtility showInfoAlertView:@"" withMessage:@"Please fill all fields."];
                alert = YES;
            }else{
                locationStones = [NSString stringWithFormat:@"%@,%@,%@",self.fragmentationLbl1.text,self.fragmentationLbl2.text, self.fragmentationLbl3.text];
                alert = NO;
            }
        }
            break;
        case 4:{
            if (self.fragmentationLbl1.text.length == 0 || [self.fragmentationLbl1.text isEqualToString:@"Degree of fragmentation for stone#1"] || self.fragmentationLbl2.text.length == 0 || [self.fragmentationLbl2.text isEqualToString:@"Degree of fragmentation for stone#2"] || self.fragmentationLbl3.text.length == 0 || [self.fragmentationLbl3.text isEqualToString:@"Degree of fragmentation for stone#3"] || self.fragmentationLbl4.text.length == 0 || [self.fragmentationLbl4.text isEqualToString:@"Degree of fragmentation for stone#4"])  {
                [UCUtility showInfoAlertView:@"" withMessage:@"Please fill all fields."];
                alert = YES;
            }else{
                locationStones = [NSString stringWithFormat:@"%@,%@,%@,%@",self.fragmentationLbl1.text,self.fragmentationLbl2.text, self.fragmentationLbl3.text, self.fragmentationLbl4.text];
                alert = NO;
            }
        }
            break;
        case 5:{
            if (self.fragmentationLbl1.text.length == 0 || [self.fragmentationLbl1.text isEqualToString:@"Degree of fragmentation for stone#1"] || self.fragmentationLbl2.text.length == 0 || [self.fragmentationLbl2.text isEqualToString:@"Degree of fragmentation for stone#2"] || self.fragmentationLbl3.text.length == 0 || [self.fragmentationLbl3.text isEqualToString:@"Degree of fragmentation for stone#3"] || self.fragmentationLbl4.text.length == 0 || [self.fragmentationLbl4.text isEqualToString:@"Degree of fragmentation for stone#4"] || self.fragmentationLbl5.text.length == 0 || [self.fragmentationLbl5.text isEqualToString:@"Degree of fragmentation for stone#5"]) {
                [UCUtility showInfoAlertView:@"" withMessage:@"Please fill all fields."];
                alert = YES;
            }else{
                locationStones = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",self.fragmentationLbl1.text,self.fragmentationLbl2.text, self.fragmentationLbl3.text, self.fragmentationLbl4.text,self.fragmentationLbl5.text];
                alert = NO;
            }
        }
            break;
            
        default:
            break;
    }
    
    if (alert == NO) {
        
        [UCUtility showBlockView];

        if (self.isComingFromURL) {
            
            [OKClinicalManager addOngoingClinicalDetail:self.caseID withProcedureID:self.urlProcedureID withFragmentations:locationStones withUserID:self.urlUserID withUserComplications:complications handler:^(NSString *errorMsg, id responseJSON) {
                
                [UCUtility hideBlockView];
                if(!errorMsg)
                   [self addOnGoingDetailsSucceded:responseJSON];
                else
                    [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
            }];
            
        }else{
            
            [OKClinicalManager addOngoingClinicalDetail:self.caseID withProcedureID:[OKProceduresManager instance].selectedProcedure.procedureID withFragmentations:locationStones withUserID:[OKUserManager instance].currentUser.userID withUserComplications:complications handler:^(NSString *errorMsg, id responseJSON) {
                
                [UCUtility hideBlockView];
                if(!errorMsg)
                    [self addOnGoingDetailsSucceded:responseJSON];
                else
                    [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];

            }];
        }
        
    }
}


- (void)addOnGoingDetailsSucceded:(id)response {
    
    id result = response;
    
    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
        
        [UCUtility showInfoAlertView:@"" withMessage:[result objectForKey:@"msg"]];
        
        if (self.isComingFromURL) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else {
        [UCUtility showInfoAlertView:@"Error" withMessage:[result objectForKey:@"msg"]];
    }
}

@end
