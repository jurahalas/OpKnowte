//
//  OKProcedureDatePicker.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/27/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKBaseProcedureElement.h"

@protocol OKProcedureDatePickerDelegate <OKBaseProcedureElementDelegate>

-(void)showDatePickerWithDate:(NSDate*)date picker:(id)datePickerObject;

@end

@interface OKProcedureDatePicker : OKBaseProcedureElement

@property (nonatomic, weak) id<OKProcedureDatePickerDelegate>delegate;
@property (strong, nonatomic) IBOutlet OKCustomTextField *customTextField;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (nonatomic) NSInteger tagOfTextField;
@property (nonatomic) BOOL buttonTapped;
@property (nonatomic, strong) NSDate *startDate;

-(void) setTagOfTextField:(NSInteger)tagOfTextField;



@end
