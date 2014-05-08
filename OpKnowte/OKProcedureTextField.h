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

@interface OKProcedureTextField : OKBaseProcedureElement

@property (strong, nonatomic) IBOutlet OKCustomTextField *customTextField;
@property (nonatomic, weak) id<OKBaseProcedureElementDelegate>delegate;
@property (nonatomic) NSInteger tagOfTextField;
@property (nonatomic, assign) BOOL isTheLastTF;

-(void)setType:(enum OKProcedureTextFieldType)type;
-(void) setTagOfTextField:(NSInteger)tagOfTextField;

@end