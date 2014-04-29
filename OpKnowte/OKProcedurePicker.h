//
//  OKProcedurePicker.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/27/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

@class OKProcedurePicker;
@protocol OKProcedurePickerDelegate <NSObject>

-(void)updateField:(NSString*)name withValue:(NSString*)newValue;
-(void)showPickerWithData:(NSArray*)pickerData picker: (OKProcedurePicker *)pickerObject;

@end
@interface OKProcedurePicker : UIControl
@property (nonatomic, weak) id<OKProcedurePickerDelegate>delegate;
@property (strong, nonatomic) IBOutlet OKCustomTextField *customTextField;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic, strong) NSString *fieldName;
@property (nonatomic, strong) NSMutableArray *dataArray;


-(void)setFieldName:(NSString*)name;
-(void)setPlaceHolder:(NSString*)placeHolder;
-(void) setDataArray:(NSMutableArray *)dataArray;
@end
