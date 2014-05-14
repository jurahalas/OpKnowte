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
    self.navigationItem.title = @"LR Radical Prostatectomy";
    self.plistArray = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LRRPProcedure" ofType:@"plist"]];
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
        [self.model setValue:[NSString stringWithFormat:@"%@ %@ , %@", [OKUserManager instance].currentUser.firstName, [OKUserManager instance].currentUser.lastName , [OKUserManager instance].currentUser.title] forKey:@"var_surgeon"];
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
-(void)updateField:(NSString*)field withData:(NSArray*)data
{
    
    NSString *dataString = [[NSString alloc] init];
    dataString =  [data componentsJoinedByString:@"; "];
    [self.model setValue:dataString forKey:field];

}
-(id) nextVC{
    OKLRRadicalProstatectomyVC *nextVC = [[OKLRRadicalProstatectomyVC alloc] init];
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
            if ([self.model valueForKey:@"var_preOpDX"] == nil ||[self.model valueForKey:@"var_postOp"]== nil ||[self.model valueForKey:@"var_nervesparing"]== nil ) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 2:{
            if ([self.model valueForKey:@"var_pelvicDisection"] == nil ||[self.model valueForKey:@"var_bladderNeckReconstruction"]== nil ||[self.model valueForKey:@"var_sling"]== nil ||[self.model valueForKey:@"var_lysisOfAdhesions"]== nil ) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 3:{
            if ([self.model valueForKey:@"var_surgeon"] == nil ||[self.model valueForKey:@"var_assistant"]== nil ||[self.model valueForKey:@"var_anesthesia"]== nil ) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 4:{
            if ([self.model valueForKey:@"var_ethnicity"] == nil ||[self.model valueForKey:@"var_stage"]== nil ||[self.model valueForKey:@"var_grade"]== nil ||[self.model valueForKey:@"var_numberOfCores"]== nil||[self.model valueForKey:@"var_greatestPercentage"]== nil ) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 5:{
            if ([self.model valueForKey:@"var_preBX"] == nil ||[self.model valueForKey:@"var_prostateVolume"]== nil ||[self.model valueForKey:@"var_BMI"]== nil ||[self.model valueForKey:@"var_factors"]== nil) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 6:{
            if ([self.model valueForKey:@"var_roomTime"] == nil ||[self.model valueForKey:@"var_operativeTime"]== nil ||[self.model valueForKey:@"var_consulTime"]== nil  ) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 7:{
            if ([self.model valueForKey:@"var_EBL"] == nil ||[self.model valueForKey:@"var_fluids"]== nil ||[self.model valueForKey:@"var_preOpSHIM"]== nil ||[self.model valueForKey:@"var_preOpAUA"]== nil ||[self.model valueForKey:@"var_physicans"]== nil ) {
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
