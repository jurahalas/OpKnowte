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

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;

@property (strong, nonatomic) id model;
@property (nonatomic,strong) NSArray *plistArray;
@property (nonatomic) int xPoint;

-(void)updateField:(NSString*)name withValue:(NSString*)newValue;
-(void)updateField:(NSString*)name withBoolValue:(BOOL)newValue;
-(void) addCustomElementFromDictionary: (NSDictionary *) customElementDictionary;
@end
