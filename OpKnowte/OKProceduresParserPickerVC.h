//
//  OKProceduresParserPickerVC.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/23/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

@protocol OKProceduresParserPickerVCDelegate <NSObject>

-(void)updateField:(NSString*)name withValue:(NSString*)newValue;

@end

@interface OKProceduresParserPickerVC : UIViewController

@property (nonatomic, weak) id<OKProceduresParserPickerVCDelegate>delegate;
-(void)setFieldName:(NSString*)name;
-(void)setPlaceHolder:(NSString*)placeHolder;

@end
