//
//  OKPenileProsthesisVC.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/6/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKPenileProsthesisVC.h"
#import "OKPenileProsthesisModel.h"

#import "OKProcedureTextField.h"
#import "OKProcedureSwitcher.h"
#import "OKProcedureDatePicker.h"
#import "OKProcedurePicker.h"
#import "OKOperatieNoteViewController.h"
#import "OKProcedureMultiselectVC.h"
#import "OKProcedureMultiselect.h"
#import "OKDatePicker.h"

@interface OKPenileProsthesisVC ()

@end

@implementation OKPenileProsthesisVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Penile Prosthesis";
    self.plistArray = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IPPProcedure" ofType:@"plist"]];
    if (!self.currentPage) {
        self.currentPage = 0;
    }
    NSArray *currentPageFieldsArray =[[self.plistArray objectAtIndex:self.currentPage] objectForKey:@"fields" ];
    self.xPoint = 80;
    if (self.model == nil) {
        self.model = [[OKPenileProsthesisModel alloc] init];
        
    }
    
    for (int i = 0; i < currentPageFieldsArray.count; i++) {

            [self addCustomElementFromDictionary:[currentPageFieldsArray objectAtIndex:i] withTag:0];

    }
}





#pragma mark - OKProcedureTextFieldDelegate
-(void)updateField:(NSString*)name withValue:(NSString*)newValue andTag:(NSInteger)tag
{

        
        if ([name isEqualToString:@"var_patientDOB"]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd/yyyy"];
            NSDate *birthday = [dateFormatter dateFromString:newValue];
            NSDateComponents *ageComponents = [[NSCalendar currentCalendar] components: NSYearCalendarUnit fromDate:birthday toDate:[NSDate date] options:0];
            NSString *age = [NSString stringWithFormat:@"%d", [ageComponents year]];
            [self.model setValue:age forKey:@"var_age"];
            [self.model setValue:newValue forKey:name];
            [self.model setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID" ]  forKey:@"var_surgeon"];
        } else if ([name isEqualToString:@"var_reservoirplacement?"] ) {

            id element = nil;
            for (id searchedElement in self.interactionItems) {
                if ([[searchedElement valueForKey:@"fieldName"] isEqualToString:@"var_reservoirplacement"]) {
                    element = searchedElement;
                    break;
                }
            }
            NSLog(@"------%@", element);
            OKProcedureTextField *complicationsTF = element;
            if ([newValue isEqualToString:@"other"]) {
                complicationsTF.customTextField.enabled = YES;
            } else {
                complicationsTF.customTextField.enabled = NO;
                complicationsTF.customTextField.text = @"";
                [self.model setValue:@"NO" forKey:@"var_reservoirplacement"];
            }
            
        } else {
            
            [self.model setValue:newValue forKey:name];
        }
    
}
#pragma mark - OKProcedureSwitcherDelegate
-(void)updateField:(NSString*)name withBoolValue:(BOOL)newValue{
    NSString *boolToString = @"";
    if (newValue) {
        boolToString = @"YES";
    } else {
        boolToString = @"NO";
    }
    
    if ([name isEqualToString:@"complications?"]) {
        id element = nil;
        for (id searchedElement in self.interactionItems) {
            if ([[searchedElement valueForKey:@"fieldName"] isEqualToString:@"var_complications"]) {
                element = searchedElement;
                break;
            }
        }
        
        NSLog(@"------%@", element);
        OKProcedureTextField *complicationsTF = element;
        if (newValue) {
            complicationsTF.customTextField.enabled = YES;
        } else {
            complicationsTF.customTextField.enabled = NO;
            complicationsTF.customTextField.text = @"";
            [self.model setValue:@"NO" forKey:@"var_complications"];
        }
    } else {
       [self.model setValue:boolToString forKey:name];
    }
}
-(id) nextVC{
    OKPenileProsthesisVC *nextVC = [[OKPenileProsthesisVC alloc] init];
    nextVC.model = self.model;
    nextVC.procedureID = self.procedureID;
    nextVC.currentPage = (self.currentPage + 1);
    return nextVC;
}

-(void)updateField:(NSString*)field withData:(NSArray*)data
{

    NSString *dataString = [[NSString alloc] init];
    dataString =  [data componentsJoinedByString:@"; "];
    [self.model setValue:dataString forKey:field];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
