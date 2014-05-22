//
//  OKProcedureTemplateModel.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/5/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseModel.h"

@interface OKProcedureTemplateModel : OKBaseModel
@property (strong,nonatomic) NSString* status;
@property (strong,nonatomic) NSString* message;
@property (strong,nonatomic) NSString* templateID;
@property (strong,nonatomic) NSString* procedureID;
@property (strong,nonatomic) NSString* caseData;
@property (strong,nonatomic) NSString* procedureText;
@property (strong,nonatomic) NSString* indicationText;
@end
