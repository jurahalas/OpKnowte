//
//  OKProcedureDatePicker.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/27/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"


@protocol OKProcedureDatePickerDelegate <NSObject>

-(void)updateField:(NSString*)name withValue:(NSString*)newValue;

@end
@interface OKProcedureDatePicker : UIControl
@property (nonatomic, weak) id<OKProcedureDatePickerDelegate>delegate;
@property (strong, nonatomic) IBOutlet OKCustomTextField *customTextField;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic, strong) NSString *fieldName;



-(void)setFieldName:(NSString*)name;
-(void)setPlaceHolder:(NSString*)placeHolder;
@end
