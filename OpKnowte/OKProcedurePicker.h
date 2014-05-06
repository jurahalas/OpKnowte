//
//  OKProcedurePicker.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/27/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKBaseProcedureElement.h"

@protocol OKProcedurePickerDelegate <OKBaseProcedureElementDelegate>

-(void)showPickerWithData:(NSArray*)pickerData picker: (id)pickerObject;

@end

@interface OKProcedurePicker : OKBaseProcedureElement

@property (nonatomic, weak) id<OKProcedurePickerDelegate>delegate;
@property (strong, nonatomic) IBOutlet OKCustomTextField *customTextField;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic) NSInteger tagOfTextField;

-(void) setDataArray:(NSMutableArray *)dataArray;

@end
