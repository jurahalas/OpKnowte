//
//  UCEditIndicationsControllerViewController.m
//  MZUroCapture
//
//  Created by Atif Joyia on 17/05/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCEditIndicationsViewController.h"

@interface UCEditIndicationsViewController ()

@end

@implementation UCEditIndicationsViewController

@synthesize headerLbl;
@synthesize textView;
@synthesize editableText;
@synthesize t_toolbar;
@synthesize parent;
@synthesize hintPicker;

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
    
    [self.t_toolbar setHidden:YES];
    [self.hintPicker setHidden:YES];
    
    if(IS_IPHONE_5)
    {
        headerLbl.frame=CGRectMake(headerLbl.frame.origin.x, headerLbl.frame.origin.y+5, headerLbl.frame.size.width, headerLbl.frame.size.height);
    }
    [headerLbl setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    
    self.editableText = [self.parent.templateModel indicationText];
    
    
    self.editableText = [self.editableText stringByReplacingOccurrencesOfString:@"(" withString:@""];
    self.editableText = [self.editableText stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    for(int i=0;i<self.parent.templateVariables.count;i++)
    {
        
        UCTemplateVariablesModel *model = [self.parent.templateVariables objectAtIndex:i];
        
        if ([self.editableText rangeOfString:[model key]].location == NSNotFound) {
            
        } else {
            
            self.editableText = [self.editableText stringByReplacingOccurrencesOfString:model.key withString:[NSString stringWithFormat:@"(%@)",model.ID]];
        }
        model = nil;
    }
    
    [self.textView setText:self.editableText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickerDone:(id)sender {
    [self.t_toolbar setHidden:YES];
    [self.hintPicker setHidden:YES];
}
- (IBAction)helpBtn:(id)sender {
    [self.t_toolbar setHidden:NO];
    [self.hintPicker setHidden:NO];
}
-(IBAction)saveTemplate:(id)sender{
    
    self.editableText = self.textView.text;
    
    for(int i=0;i<self.parent.templateVariables.count;i++)
    {
        UCTemplateVariablesModel *model = [self.parent.templateVariables objectAtIndex:i];
        
        self.editableText = [self.editableText stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",model.ID] withString:[NSString stringWithFormat:@"%@",[model key]]];
        model = nil;
    }
    
   // NSLog(@"%@",editableText);
    self.parent.templateModel.indicationText = self.editableText;
}


-(IBAction)back:(id)sender{
    
    if ([self.editableText isEqualToString:self.textView.text]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Do you want to save changes locally?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        alert.tag = 302;
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 302) {
        if (buttonIndex == 0) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if (buttonIndex == 1){
            
            self.editableText = self.textView.text;
            
            for(int i=0;i<self.parent.templateVariables.count;i++)
            {
                UCTemplateVariablesModel *model = [self.parent.templateVariables objectAtIndex:i];
                
                self.editableText = [self.editableText stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"(%@)",model.ID] withString:[NSString stringWithFormat:@"(%@)",[model key]]];
                model = nil;
            }
            
            // NSLog(@"%@",editableText);
            self.parent.templateModel.indicationText = self.editableText;
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [self.textView resignFirstResponder];
    return YES;
}


#pragma mark - Picker View Delegate Method

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.parent.templateVariables count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    UCTemplateVariablesModel *model = [self.parent.templateVariables objectAtIndex:row];
    return [NSString stringWithFormat:@"%@. %@",model.ID, model.value];
}

#pragma mark - End

@end
