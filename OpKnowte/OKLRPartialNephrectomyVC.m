//
//  OKLRPartialNephrectomyVC.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/3/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKLRPartialNephrectomyVC.h"
#import "OKLRPartialNephrectomyModel.h"

#import "OKProcedureTextField.h"
#import "OKProcedureSwitcher.h"
#import "OKProcedureDatePicker.h"
#import "OKProcedurePicker.h"
#import "OKOperatieNoteViewController.h"
#import "OKProcedureMultiselectVC.h"
#import "OKProcedureMultiselect.h"
#import "OKDatePicker.h"

@interface OKLRPartialNephrectomyVC ()

@end

@implementation OKLRPartialNephrectomyVC

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
	self.navigationItem.title = @"LR Partial Nephrectomy";
    self.plistArray = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LRPNProcedure" ofType:@"plist"]];
    if (!self.currentPage) {
        self.currentPage = 0;
    }
    NSArray *currentPageFieldsArray =[[self.plistArray objectAtIndex:self.currentPage] objectForKey:@"fields" ];
    self.xPoint = 80;
    if (self.model == nil) {
        self.model = [[OKLRPartialNephrectomyModel alloc] init];
        
    }
    
    for (int i = 0; i < currentPageFieldsArray.count; i++) {
        
            [self addCustomElementFromDictionary:[currentPageFieldsArray objectAtIndex:i] withTag:0];
            
    }

}


#pragma mark - OKProcedureTextFieldDelegate
-(void)updateField:(NSString*)name withValue:(NSString*)newValue andTag:(NSInteger)tag
{
    
    if ([name isEqualToString:@"anterior/posterior"]) {
        
    }else {
        if ([name isEqualToString:@"var_patientDOB"]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd/yyyy"];
            NSDate *birthday = [dateFormatter dateFromString:newValue];
            NSDateComponents *ageComponents = [[NSCalendar currentCalendar] components: NSYearCalendarUnit fromDate:birthday toDate:[NSDate date] options:0];
            NSString *age = [NSString stringWithFormat:@"%d", [ageComponents year]];
            [self.model setValue:age forKey:@"var_age"];
            [self.model setValue:newValue forKey:name];
            [self.model setValue:[NSString stringWithFormat:@"%@ %@ , %@", [OKUserManager instance].currentUser.firstName, [OKUserManager instance].currentUser.lastName , [OKUserManager instance].currentUser.title] forKey:@"var_surgeon"];
        } else {
            
            [self.model setValue:newValue forKey:name];
        }
 
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
    
    if ([name isEqualToString:@"var_adhesions"]) {
        [self.model setValue:boolToString forKey:name];
        id element = nil;
        for (id searchedElement in self.interactionItems) {
            if ([[searchedElement valueForKey:@"fieldName"] isEqualToString:@"var_adhTook"]) {
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
            [self.model setValue:@"NO" forKey:@"var_adhTook"];
        }
    } else if ([name isEqualToString:@"var_vasAnomolies?"]) {
        id element = nil;
        for (id searchedElement in self.interactionItems) {
            if ([[searchedElement valueForKey:@"fieldName"] isEqualToString:@"var_vasAnomolies"]) {
                element = searchedElement;
                break;
            }
        }
        
        NSLog(@"------%@", element);
        OKProcedureTextField *anomaliesTF = element;
        if (newValue) {
            anomaliesTF.customTextField.enabled = YES;
        } else {
            anomaliesTF.customTextField.enabled = NO;
            anomaliesTF.customTextField.text = @"";
            [self.model setValue:@"NO" forKey:@"var_vasAnomolies"];
        }
    } else if ([name isEqualToString:@"var_coagulant?"]) {
        id element = nil;
        for (id searchedElement in self.interactionItems) {
            if ([[searchedElement valueForKey:@"fieldName"] isEqualToString:@"var_coagulant"]) {
                element = searchedElement;
                break;
            }
        }
        
        NSLog(@"------%@", element);
        OKProcedureTextField *coagulantsTF = element;
        if (newValue) {
            coagulantsTF.customTextField.enabled = YES;
        } else {
            coagulantsTF.customTextField.enabled = NO;
            coagulantsTF.customTextField.text = @"";
            [self.model setValue:@"NO" forKey:@"var_coagulant"];
        }
    } else if ([name isEqualToString:@"transfusion?"]) {
        id element = nil;
        for (id searchedElement in self.interactionItems) {
            if ([[searchedElement valueForKey:@"fieldName"] isEqualToString:@"var_transfusion"]) {
                element = searchedElement;
                break;
            }
        }
        
        NSLog(@"------%@", element);
        OKProcedureTextField *transfusionTF = element;
        if (newValue) {
            transfusionTF.customTextField.enabled = YES;
        } else {
            transfusionTF.customTextField.enabled = NO;
            transfusionTF.customTextField.text = @"";
            [self.model setValue:@"NO" forKey:@"var_transfusion"];
        }
    } else {
        [self.model setValue:boolToString forKey:name];
    }
    
}
-(id) nextVC{
    OKLRPartialNephrectomyVC *nextVC = [[OKLRPartialNephrectomyVC alloc] init];
    nextVC.model = self.model;
    nextVC.procedureID = self.procedureID;
    
    nextVC.currentPage = (self.currentPage + 1);
    return nextVC;
}

-(BOOL) canGoToNextVC {
    switch (self.currentPage) {
        case 0:{
            if ([self.model valueForKey:@"var_patientName"] == nil ||[self.model valueForKey:@"var_patientDOB"]== nil ||[self.model valueForKey:@"var_MRNumber"]== nil ||[self.model valueForKey:@"var_DOS"]== nil ||[self.model valueForKey:@"var_sex"]== nil ) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 1:{
            if ([self.model valueForKey:@"var_preOp"] == nil ||[self.model valueForKey:@"var_postOp"]== nil ||[self.model valueForKey:@"var_cysto"]== nil ) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 2:{
            if ([self.model valueForKey:@"var_surgeon"] == nil ||[self.model valueForKey:@"var_assistant"]== nil ||[self.model valueForKey:@"var_anesthesiologist"]== nil) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 3:{
            if ([self.model valueForKey:@"var_tumorSize"] == nil ||[self.model valueForKey:@"var_location"]== nil ||[self.model valueForKey:@"var_tumorChar"]== nil ||[self.model valueForKey:@"var_history"]== nil ||[self.model valueForKey:@"var_bmi"]== nil ) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 4:{
            if ([self.model valueForKey:@"var_adhesions"] == nil ||[self.model valueForKey:@"var_adhTook"]== nil ||[self.model valueForKey:@"var_vasAnomolies"]== nil ) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 5:{
            if ([self.model valueForKey:@"var_renalUltraSound"] == nil ||[self.model valueForKey:@"var_margin"]== nil ||[self.model valueForKey:@"var_RCSRepair"]== nil ||[self.model valueForKey:@"var_clamp"]== nil ||[self.model valueForKey:@"var_coagulant"]== nil||[self.model valueForKey:@"var_bloodLoss"]== nil ) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 6:{
            if ([self.model valueForKey:@"var_counselTime"] == nil ||[self.model valueForKey:@"var_roomTime"]== nil ||[self.model valueForKey:@"var_complation"]== nil ||[self.model valueForKey:@"var_transfusion"]== nil ||[self.model valueForKey:@"var_cc"]== nil ) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        default:
            return NO;
            break;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
