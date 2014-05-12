//
//  OKProceduresManager.h
//  OpKnowte
//
//  Created by Apple on 15.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"
#import "OKProcedureModel.h"
#import "OKProcedureTemplateVariablesModel.h"
#import "OKProcedureTemplateModel.h"
#import "OKUserManager.h"
#import "OKCase.h"

@interface OKProceduresManager : OKBaseManager

+ (OKProceduresManager *)instance;

- (void)getAllProceduresWithHandler:(void(^)(NSString *errorMsg, NSMutableArray *proceduresDict ) )handler;
- (void) getProcedureTemplateByUserID:(NSString*)userID ProcedureID:(NSString*)procedureID handler:(void(^)(NSString *errorMsg, NSDictionary *template))handler;
-(void) getProcedureTemplateVariablesByProcedureID:(NSString *)procedureID handler:(void (^)(NSString *errorMsg, NSMutableArray *templateVariables))handler;
-(void) updateProcedureTemplateWithUserID:(NSString*) userID AndProcedureTemplate:(OKProcedureTemplateModel*) template handler:(void (^)(NSString *errorMsg, NSDictionary *json))handler;

-(void) saveProcedureWithSurgeonID:(NSString *)surgeonID ProcedureID:(NSString *)procedureID AndProcedureModel: (id) procModel handler:(void (^)(NSString *errorMsg))handler;

-(void)getCasesListWithProcedureID:(NSString*)procedureID andSurgeonID:(NSString*)surgeonID handler:(void (^)(NSString *errorMsg, NSMutableArray *cases))handler;

@end
