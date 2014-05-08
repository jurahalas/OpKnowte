//
//  OKLRRadicalProstatectomyVC.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/7/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKLRRadicalProstatectomyVC.h"
#import "OKLRRadicalProstatectomyModel.h"

#import "OKProcedureTextField.h"
#import "OKProcedureSwitcher.h"
#import "OKProcedureDatePicker.h"
#import "OKProcedurePicker.h"
#import "OKOperatieNoteViewController.h"
#import "OKProcedureMultiselectVC.h"
#import "OKProcedureMultiselect.h"
#import "OKDatePicker.h"
@interface OKLRRadicalProstatectomyVC ()

@end

@implementation OKLRRadicalProstatectomyVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Shockwave Lithotripsy";
    self.plistArray = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SLProcedure" ofType:@"plist"]];
    if (!self.currentPage) {
        self.currentPage = 0;
    }
    NSArray *currentPageFieldsArray =[[self.plistArray objectAtIndex:self.currentPage] objectForKey:@"fields" ];
    self.xPoint = 80;
    if (self.model == nil) {
        self.model = [[OKLRRadicalProstatectomyModel alloc] init];
        
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
    } else if ([name isEqualToString:@"var_ethnicity?"] ) {
        id element = nil;
        for (id searchedElement in self.interactionItems) {
            if ([[searchedElement valueForKey:@"fieldName"] isEqualToString:@"var_ethnicity"]) {
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
             [self.model setValue:newValue forKey:@"var_ethnicity"];
        }

        
    }else {
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
    
    if ([name isEqualToString:@"var_lysisOfAdhesions?"]) {
        id element = nil;
        for (id searchedElement in self.interactionItems) {
            if ([[searchedElement valueForKey:@"fieldName"] isEqualToString:@"var_lysisOfAdhesions"]) {
                element = searchedElement;
                break;
            }
        }
        
        NSLog(@"------%@", element);
        OKProcedurePicker *adhesionP = element;
        if (newValue) {
            adhesionP.button.enabled = YES;
        } else {
            adhesionP.button.enabled = NO;
            adhesionP.customTextField.text = @"";
            [self.model setValue:@"NO" forKey:@"var_lysisOfAdhesions"];
        }
    } else {
        [self.model setValue:boolToString forKey:name];
    }
    
}
-(id) nextVC{
    OKLRRadicalProstatectomyVC *nextVC = [[OKLRRadicalProstatectomyVC alloc] init];
    nextVC.model = self.model;
    nextVC.procedureID = self.procedureID;
    nextVC.currentPage = (self.currentPage + 1);
    return nextVC;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
