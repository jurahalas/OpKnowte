//
//  OKShockwaveLithotripsyVC.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/24/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKShockwaveLithotripsyVC.h"
#import "OKShockwaveLithotripsyModel.h"

#import "OKProcedureTextField.h"
#import "OKProcedureSwitcher.h"
#import "OKProcedureDatePicker.h"
#import "OKProcedurePicker.h"
#import "OKOperatieNoteViewController.h"
#import "OKProcedureMultiselectVC.h"
#import "OKProcedureMultiselect.h"
#import "OKDatePicker.h"

@interface OKShockwaveLithotripsyVC ()



@end

@implementation OKShockwaveLithotripsyVC

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
    self.navigationItem.title = @"Shockwave Lithotripsy";
    self.plistArray = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SLProcedure" ofType:@"plist"]];
    if (!self.currentPage) {
       self.currentPage = 0;
    }
    NSArray *currentPageFieldsArray =[[self.plistArray objectAtIndex:self.currentPage] objectForKey:@"fields" ];
    self.xPoint = 16;
    if (self.model == nil) {
        self.model = [[OKShockwaveLithotripsyModel alloc] init];

    }
    
    for (int i = 0; i < currentPageFieldsArray.count; i++) {
    
        if (self.currentPage >=2 && self.currentPage <= 5) {
            for (int j = 0; j < [[self.model valueForKey:@"var_stonesCount" ] intValue]; j++) {
                [self addCustomElementFromDictionary:[currentPageFieldsArray objectAtIndex:i] withTag:j+1];
            }
        } else {
            [self addCustomElementFromDictionary:[currentPageFieldsArray objectAtIndex:i] withTag:0];

        }
    }
}

#pragma mark - OKProcedureTextFieldDelegate
-(void)updateField:(NSString*)name withValue:(NSString*)newValue andTag:(NSInteger)tag
{
    if (tag > 0) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@" ",@" ",@" ",@" ",@" ", nil];
        if ([self.model valueForKey:name] != nil) {
            array = [self.model valueForKey:name];
        }
        
        [array replaceObjectAtIndex:(tag-1) withObject:newValue];
        [self.model setValue:array forKey:name];


    } else {
        
        if ([name isEqualToString:@"var_patientDOB"]) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM-dd-yyyy"];
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
        complicationsTF.customTextField.enabled = NO;
        if (newValue) {
            complicationsTF.customTextField.enabled = YES;
        } else {
            complicationsTF.customTextField.enabled = NO;
            complicationsTF.customTextField.text = @"";
            [self.model setValue:@"None" forKey:@"var_complications"];
        }
    } else {
        
        [self.model setValue:boolToString forKey:name];

    }
}
-(id) nextVC{
    OKShockwaveLithotripsyVC *nextVC = [[OKShockwaveLithotripsyVC alloc] init];
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
            if ([self.model valueForKey:@"var_anesthesiaPerformed"] == nil ||[self.model valueForKey:@"var_anesthesiaLocation"]== nil ||[self.model valueForKey:@"var_stonesCount"]== nil ) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 2:{
            if ([self.model valueForKey:@"var_stonesLocations"] == nil || [[self.model valueForKey:@"var_stonesLocations"] containsObject:@""] ) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 3:{
            if ([self.model valueForKey:@"var_stonesSizes"] == nil || [[self.model valueForKey:@"var_stonesSizes"] containsObject:@""] ) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 4:{
            if ([self.model valueForKey:@"var_totalShocks"] == nil || [[self.model valueForKey:@"var_totalShocks"] containsObject:@""] ) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 5:{
            if ([self.model valueForKey:@"var_fragmentations"] == nil || [[self.model valueForKey:@"var_fragmentations"] containsObject:@""] ) {
                return NO;
            } else {
                return YES;
            }
            break;
        }
        case 6:{
            if ([self.model valueForKey:@"var_rateOfWaves"] == nil ||[self.model valueForKey:@"var_KVWaves"]== nil ||[self.model valueForKey:@"var_pausePerformed"]== nil ||[self.model valueForKey:@"var_complications"]== nil ||[self.model valueForKey:@"var_followUp"]== nil ) {
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
