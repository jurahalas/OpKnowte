//
//  OKProcedureSwitcher.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/27/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKBaseProcedureElement.h"

@interface OKProcedureSwitcher : OKBaseProcedureElement

@property (nonatomic, weak) id<OKBaseProcedureElementDelegate>delegate;
@property (nonatomic, strong) IBOutlet UILabel *customLabel;
@property (nonatomic, strong) IBOutlet UISwitch *customSwitcher;

@end
