//
//  OKProcedureTextField.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/24/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKBaseProcedureElement.h"

enum OKProcedureTextFieldType {
    OKProcedureSymbolicTF = 0,
    OKProcedureNumericTF
};
@protocol OKProcedureTextFieldDelegate <OKBaseProcedureElementDelegate>

-(void)openBMICalc:(NSString*)currentFieldName withSelf:(id)tappedTF;
@end
@interface OKProcedureTextField : OKBaseProcedureElement <UITextFieldDelegate>
-(void) becomeCustomTextFieldFirstResponder;

@property (strong, nonatomic) IBOutlet OKCustomTextField *customTextField;
@property (nonatomic, weak) id<OKProcedureTextFieldDelegate>delegate;
@property (nonatomic) NSInteger tagOfTextField;
@property (nonatomic, assign) BOOL isTheLastTF;

-(void)setType:(enum OKProcedureTextFieldType)type;
-(void) setTagOfTextField:(NSInteger)tagOfTextField;
-(void) setupWithValue:(NSString*)value;
-(void) resignCustomTextFieldFirstResponder;
@end
