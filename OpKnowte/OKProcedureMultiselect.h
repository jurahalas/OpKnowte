//
//  OKProcedureMultiselect.h
//  OpKnowte
//
//  Created by Eugene on 05.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKBaseProcedureElement.h"

@protocol OKProcedureMultiselectDelegate <OKBaseProcedureElementDelegate>

-(void)showMultiselectVCForFieldWithName:(NSString*)fieldName withData:(NSArray*)data sender:(id)sender;

@end

@interface OKProcedureMultiselect : OKBaseProcedureElement

@property (nonatomic, weak) id<OKProcedureMultiselectDelegate>delegate;
@property (nonatomic, strong) NSArray *dataArray;

- (IBAction)buttonTapped:(id)sender;
-(void) setDataArray:(NSArray *)dataArray;
-(void) setupWithValue:(NSString*)value;


@end
