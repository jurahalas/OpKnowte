//
//  UCAddNewInstitutionViewController.m
//  MZUroCapture
//
//  Created by Omer on 5/27/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCAddNewInstitutionViewController.h"

#import "OKContactManager.h"

@implementation UCAddNewInstitutionViewController

@synthesize contactRoleID, titleText;
@synthesize contactInfo;
@synthesize stateTF, cityTF, countryTF, emailTF, faxTF, nameTF, streetAddressTF, zipTF;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.contactInfo != nil) {
        if ([self.contactInfo contactID].length > 0) {
            
            [self.nameTF setText:[self.contactInfo contactName]];
            [self.emailTF setText:[self.contactInfo contactEmail]];
            [self.stateTF setText:[self.contactInfo contactState]];
            [self.cityTF setText:[self.contactInfo contactCity]];
            [self.countryTF setText:[self.contactInfo contactCountry]];
            [self.faxTF setText:[self.contactInfo contactFax]];
            [self.streetAddressTF setText:[self.contactInfo contactStreetAddress]];
            [self.zipTF setText:[self.contactInfo contactZip]];
            
        }
    }
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    faxTF.inputAccessoryView = numberToolbar;
    
    headerLbl_.text = self.titleText;
}

-(void)cancelNumberPad{
    [faxTF resignFirstResponder];
}

-(void)doneWithNumberPad{
    [faxTF resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    if (IS_IPHONE_5) {
        int movementDistance;
        if (textField == faxTF) {
            movementDistance = 195;
        }else{
            movementDistance = 150;
        }
        
         // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        int movement = (up ? -movementDistance : movementDistance);
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
        
    }else{
        
        int movementDistance;
        if (textField == faxTF) {
            movementDistance = 245;
        }else{
            movementDistance = 200;
        }
        
        //const int movementDistance = 200; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        int movement = (up ? -movementDistance : movementDistance);
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
        
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag == 8 || textField.tag == 7 || textField.tag == 6 || textField.tag == 5)
    {
        [self animateTextField:textField up:YES];
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField.tag == 8 || textField.tag == 7 || textField.tag == 6 || textField.tag == 5)
    {
        [self animateTextField:textField up:NO];
    }
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}


-(IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)submitButtonPressed:(id)sender
{
    if([nameTF.text isEqual: @""])
    {
        [UCUtility showInfoAlertView:@"Error" withMessage:@"Please enter name."];
    }
    else
    {
        if ([emailTF.text isEqual: @""]) {
            
            [UCUtility showInfoAlertView:@"Error" withMessage:@"Please enter email."];
            
        }else if (![UCUtility validateEmail:emailTF.text]) {
          //if (emailTF.text.length > 0 && ![UCUtility validateEmail:emailTF.text]) {
              
              [UCUtility showInfoAlertView:@"Error" withMessage:@"invalid email"];
            
          }
          else
          {
              NSLog(@"{ ROLE ID = %@ }",self.contactRoleID);
              [UCUtility showBlockView];
              if (self.contactInfo != nil) {
                  
                  [[OKContactManager instance] addContactWithRoleID:self.contactRoleID withName:nameTF.text withEmail:emailTF.text withSteetAddress:streetAddressTF.text withCity:cityTF.text withState:stateTF.text withZip:zipTF.text withCountry:countryTF.text withFax:faxTF.text withContactID:self.contactInfo.contactID ];
                  
              }else{
                  
                  [UCWebServerHandler addContactWithRoleID:self.contactRoleID withName:nameTF.text withEmail:emailTF.text withSteetAddress:streetAddressTF.text withCity:cityTF.text withState:stateTF.text withZip:zipTF.text withCountry:countryTF.text withFax:faxTF.text withContactID:@"" withDelegate:self];
                  
              }
          }
    }
    
}


- (void)AddContactSuccessHandler:(ASIHTTPRequest *)request {
    [UCUtility hideBlockView];
    NSString *response = [request responseString];
    NSLog(@"%@",response);
    id result = [response JSONValue];
    //NSLog(@"%@",result);
    
    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
       [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [UCUtility showInfoAlertView:@"Error" withMessage:@"Not Saved, Try Again."];
    }
    
    result = nil;
    response = nil;
}

- (void)AddContactErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}

@end
