//
//  OKProcedureLabel.h
//  OpKnowte
//
//  Created by Artem Frolow on 9/10/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseProcedureElement.h"

@interface OKProcedureLabel : OKBaseProcedureElement

@property (strong, nonatomic) IBOutlet UILabel *label;

-(void)setLabelText:(NSString*)text;

@end
