//
//  OKProcedureMultiselectVC.h
//  OpKnowte
//
//  Created by Eugene on 05.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"

@protocol OKProcedureMultiselectVCDelegate <NSObject>

-(void)updateField:(NSString*)field WithData:(NSArray*)data;

@end

@interface OKProcedureMultiselectVC : OKBaseViewController

@property (nonatomic, weak) id<OKProcedureMultiselectVCDelegate>delegate;
@property (nonatomic, strong) NSArray *tableData;

+(void)showInViewController:(UIViewController*)vc fieldName:(NSString*)fieldName data:(NSArray*)data delegate:(id<OKProcedureMultiselectVCDelegate>)delegate;

@end
