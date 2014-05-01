//
//  OKProcedureTextField.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/24/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

enum OKProcedureTextFieldType {
    OKProcedureSymbolicTF = 0,
    OKProcedureNumericTF
};

@protocol OKProcedureTextFieldDelegate <NSObject>

-(void)updateField:(NSString*)name withValue:(NSString*)newValue andTag:(NSInteger) tag;

@end
@interface OKProcedureTextField : UIControl

@property (strong, nonatomic) IBOutlet OKCustomTextField *customTextField;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic, strong) NSString *fieldName;
@property (nonatomic, weak) id<OKProcedureTextFieldDelegate>delegate;
@property (nonatomic) NSInteger tagOfTextField;

-(void)setFieldName:(NSString*)name;
-(void)setPlaceHolder:(NSString*)placeHolder;
-(void)setType:(enum OKProcedureTextFieldType)type;
-(void) setTagOfTextField:(NSInteger)tagOfTextField;

@end
