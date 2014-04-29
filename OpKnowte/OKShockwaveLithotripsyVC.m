//
//  OKShockwaveLithotripsyVC.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/24/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKShockwaveLithotripsyVC.h"
#import "OKProcedureTextField.h"
#import "OKProcedureSwitcher.h"
#import "OKProcedureDatePicker.h"
#import "OKProcedurePicker.h"
#import "OKShockwaveLithotripsyModel.h"

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
    self.plistArray = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SLProcedure" ofType:@"plist"]];
    if (!self.currentPage) {
       self.currentPage = 0;
    }
    NSArray *currentPageFieldsArray =[[self.plistArray objectAtIndex:self.currentPage] objectForKey:@"fields" ];
    self.xPoint = 80;
    
    for (int i = 0; i < currentPageFieldsArray.count; i++) {
    
        if (self.currentPage >=2 && self.currentPage <= 5) {
            for (int j = 0; j < [[self.model valueForKey:@"stonesCount" ] intValue]; j++) {
                [self addCustomElementFromDictionary:[currentPageFieldsArray objectAtIndex:i]];
            }
        } else {
            [self addCustomElementFromDictionary:[currentPageFieldsArray objectAtIndex:i]];

        }
    }
}





#pragma mark - OKProcedureTextFieldDelegate
-(void)updateField:(NSString*)name withValue:(NSString*)newValue
{

    [self.model setValue:newValue forKey:name];

}
#pragma mark - OKProcedureSwitcherDelegate
-(void)updateField:(NSString*)name withBoolValue:(BOOL)newValue{
    NSString *boolToString = @"";
    if (newValue) {
        boolToString = @"YES";
    } else {
        boolToString = @"NO";
    }
    
    if ([name isEqualToString:@"pausePerformed"]) {
       [self.model setValue:boolToString forKey:name];
    } else if ([name isEqualToString:@"complications?"]) {
        NSArray *elementsArray = [self.interactionItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name == complications" ]];
        OKProcedureTextField *complicationsTF = [elementsArray objectAtIndex:0];
        if (newValue) {
            complicationsTF.customTextField.enabled = NO;
        } else {
            complicationsTF.customTextField.enabled = YES;
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
