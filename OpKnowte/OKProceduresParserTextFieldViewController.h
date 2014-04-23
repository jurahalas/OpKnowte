//
//  OKProceduresParserTextFieldViewController.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/23/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

enum OKProcedureTextFieldType {
    OKProcedureSymbolicTF = 0,
    OKProcedureNumericTF
};

@protocol OKProceduresParserTextFieldViewControllerDelegate <NSObject>

-(void)updateField:(NSString*)name withValue:(NSString*)newValue;

@end

@interface OKProceduresParserTextFieldViewController : UIViewController

@property (nonatomic, weak) id<OKProceduresParserTextFieldViewControllerDelegate>delegate;

-(void)setFieldName:(NSString*)name;
-(void)setPlaceHolder:(NSString*)placeHolder;
-(void)setType:(enum OKProcedureTextFieldType)type;

@end
