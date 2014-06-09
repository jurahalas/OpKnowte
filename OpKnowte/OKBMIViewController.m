//
//  OKBMIViewController.m
//  OpKnowte
//
//  Created by Olegek on 09.06.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBMIViewController.h"
#import "OKBaseProcedureVC.h"

@interface OKBMIViewController ()

@end

@implementation OKBMIViewController

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
    
    UIColor * color = [UIColor lightGrayColor];
    
    _calculateBtn.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _cancelBtn.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _height.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Height (inches)"attributes:@{NSForegroundColorAttributeName: color}];
    _weight.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Weight (pounds)" attributes:@{NSForegroundColorAttributeName: color}];
    [_height setKeyboardType:UIKeyboardTypeDecimalPad];
    [_weight setKeyboardType:UIKeyboardTypeDecimalPad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)canlecBtn:(id)sender {
    [self.view endEditing:YES];
    [self.delegate bmiCancelBtnTapped];
}

- (IBAction)calculateBtn:(id)sender {
    
            [self.view endEditing:YES];
    
    if ([_height.text isEqualToString:@""]||[_weight.text isEqualToString:@""]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil
                                                         message:@"Please fill all fields"
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
        [alert show];
        
    } else {
        float value = ([_weight.text floatValue]/([_height.text floatValue]*[_height.text floatValue]))*703;
        _BMIValue = [NSString stringWithFormat:@"%.2f", value];
        NSLog(@"BMI Value %@",_BMIValue);
        [self.view endEditing:YES];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:_BMIValue forKey:@"BMI_Value"];
        [userDefaults synchronize];
        [self.delegate bmiCalculateBtnTapped];

    }
}
@end
