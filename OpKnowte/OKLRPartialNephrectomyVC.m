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
    
    if ([name isEqualToString:@"intraAbdominalAdhesions"]) {
        [self.model setValue:boolToString forKey:name];
        id element = nil;
        for (id searchedElement in self.interactionItems) {
            if ([[searchedElement valueForKey:@"fieldName"] isEqualToString:@"descriptionIntraAbdominalAdhesions"]) {
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
        }
    } else if ([name isEqualToString:@"vuscularAnomalies"]) {
        [self.model setValue:boolToString forKey:name];
        id element = nil;
        for (id searchedElement in self.interactionItems) {
            if ([[searchedElement valueForKey:@"fieldName"] isEqualToString:@"descriptionVuscularAnomalies"]) {
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
        }
    } else if ([name isEqualToString:@"useOfCoagulants?"]) {
        id element = nil;
        for (id searchedElement in self.interactionItems) {
            if ([[searchedElement valueForKey:@"fieldName"] isEqualToString:@"useOfCoagulants"]) {
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
        }
    } else if ([name isEqualToString:@"transfusion?"]) {
        id element = nil;
        for (id searchedElement in self.interactionItems) {
            if ([[searchedElement valueForKey:@"fieldName"] isEqualToString:@"transfusion"]) {
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
