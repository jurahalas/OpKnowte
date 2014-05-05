//
//  OKProcedureDatePicker.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/27/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

@class OKProcedureDatePicker;
@protocol OKProcedureDatePickerDelegate <NSObject>

-(void)updateField:(NSString*)name withValue:(NSString*)newValue andTag:(NSInteger) tag;
-(void)showDatePickerWithDate:(NSDate*)date picker:( OKProcedureDatePicker * )datePickerObject;

@end
@interface OKProcedureDatePicker : UIControl
@property (nonatomic, weak) id<OKProcedureDatePickerDelegate>delegate;
@property (strong, nonatomic) IBOutlet OKCustomTextField *customTextField;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic, strong) NSString *fieldName;
@property (nonatomic) NSInteger tagOfTextField;
@property (nonatomic) BOOL buttonTapped;

-(void) setup;
-(void)setFieldName:(NSString*)name;
-(void)setPlaceHolder:(NSString*)placeHolder;
-(void) setTagOfTextField:(NSInteger)tagOfTextField;

@end
