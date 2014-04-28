//
//  OKProcedureSwitcher.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/27/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

@protocol OKProcedureSwitcherDelegate <NSObject>

-(void)updateField:(NSString*)name withBoolValue:(BOOL)newValue;

@end
@interface OKProcedureSwitcher : UIControl

@property (strong, nonatomic) IBOutlet UILabel *customLabel;
@property (strong, nonatomic) IBOutlet UISwitch *customSwitcher;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic, strong) NSString *fieldName;
@property (nonatomic, weak) id<OKProcedureSwitcherDelegate>delegate;

-(void)setFieldName:(NSString*)name;
-(void)setPlaceHolder:(NSString*)placeHolder;
@end
