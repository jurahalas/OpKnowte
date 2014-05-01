//
//  OKBaseProcedureVC.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/24/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"



@interface OKBaseProcedureVC : OKBaseViewController
@property (nonatomic, strong) NSMutableArray *interactionItems;
@property (nonatomic, assign) NSInteger currentPage;

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIPickerView *picker;

@property (strong, nonatomic) id model;
@property (nonatomic,strong) NSArray *plistArray;
@property (nonatomic) int xPoint;

-(void)updateField:(NSString*)name withValue:(NSString*)newValue  andTag:(NSInteger) tag;
-(void)updateField:(NSString*)name withBoolValue:(BOOL)newValue;
-(void) addCustomElementFromDictionary: (NSDictionary *) customElementDictionary withTag:(int) tag;
-(id)nextVC;
- (IBAction)backButtonTapped:(id)sender;
- (IBAction)rightButtonTapped:(id)sender;
@end
