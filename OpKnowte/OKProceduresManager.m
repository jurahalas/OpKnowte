//
//  OKProceduresManager.m
//  OpKnowte
//
//  Created by Apple on 15.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProceduresManager.h"
#import "OKProcedureModel.h"
#import "OKProcedureTemplateVariablesModel.h"

@implementation OKProceduresManager


+ (OKProceduresManager *)instance
{
    static dispatch_once_t pred;
    static OKProceduresManager *manager = nil;
    dispatch_once(&pred, ^{ manager = [[self alloc] init]; });
    return manager;
}


- (void)getAllProceduresWithHandler:(void(^)(NSString *errorMsg, NSMutableArray *proceduresArray))handler
{
    NSDictionary *params = @{};

    [self requestWithMethod:@"GET" path:@"getAllProc" params:params handler:^(NSError *error, id json) {
        NSLog(@"%@",json);
       
        NSMutableArray *proceduresArray = [[NSMutableArray alloc] init];
        for (NSDictionary *procedure in json) {
            OKProcedureModel *procModel = [[OKProcedureModel alloc] init];
            [procModel setModelWithDictionary:procedure];
            [proceduresArray addObject:procModel];
        }
        handler([self getErrorMessageFromJSON:json error:error], proceduresArray);
    }];
}
- (void) getProcedureTemplateByUserID:(NSString*)userID ProcedureID:(NSString*)procedureID handler:(void(^)(NSString *errorMsg, NSDictionary *template))handler
{
    NSDictionary *params = @{};

    NSString *url = [NSString stringWithFormat:@"getTemplateBySurgeonIDAndProcedureID?procedureID=%@&surgeonID=%@",  procedureID, userID];


    [self requestWithMethod:@"GET" path:url params:params handler:^(NSError *error, id json) {
        NSLog(@"%@",json);

        handler([self getErrorMessageFromJSON:json error:error], json);
    }];



}
-(void) getProcedureTemplateVariablesByProcedureID:(NSString *)procedureID handler:(void (^)(NSString *errorMsg, NSMutableArray *templateVariables))handler{
    
    NSDictionary *params = @{};
    
    NSString *url = [NSString stringWithFormat:@"getTemplateVariablesByProcedureID?procedureID=%@", procedureID];
    
    
    [self requestWithMethod:@"GET" path:url params:params handler:^(NSError *error, id json) {
        NSLog(@"%@",json);
        
        NSMutableArray *variablesArray = [[NSMutableArray alloc] init];
        for (NSDictionary *variable in json) {
            OKProcedureTemplateVariablesModel *model = [[OKProcedureTemplateVariablesModel alloc] init];
            [model setModelWithDictionary:variable];
            [variablesArray addObject:model];
        }
        handler([self getErrorMessageFromJSON:json error:error], variablesArray);
    }];
    
    
}

-(void) saveProcedureWithSurgeonID:(NSString *)surgeonID ProcedureID:(NSString *)procedureID AndProcedureModel: (id) procModel handler:(void (^)(NSString *errorMsg))handler{
    NSDictionary *params;
    if ([procedureID isEqualToString:@"10"]) {
        params = @{@"surgeonID":              surgeonID,
                   @"procedureID":            procedureID,
                   @"patientName":            [procModel valueForKey:@"var_patientName"],
                   @"patientDob":             [procModel valueForKey:@"var_patientDOB"],
                   @"mrNumber":               [procModel valueForKey:@"var_MRNumber"],
                   @"gender":                 [procModel valueForKey:@"var_sex"],
                   @"dateOfService":          [procModel valueForKey:@"var_DOS"],
                   @"anesthesiaPerformed":    [procModel valueForKey:@"var_anesthesiaPerformed"],
                   @"anesthesiaLocation":     [procModel valueForKey:@"var_anesthesiaLocation"],
                   @"stonesCount":            [procModel valueForKey:@"var_stonesCount"],
                   
                   @"stonesLocations":        [[procModel valueForKey:@"var_stonesLocations"]componentsJoinedByString:@"; "],
                   @"stonesSizes":            [[procModel valueForKey:@"var_stonesSizes"]componentsJoinedByString:@"; "],
                   @"totalShocks":            [[procModel valueForKey:@"var_totalShocks"]componentsJoinedByString:@"; "],
                   @"degreeOfFragmentation":  [[procModel valueForKey:@"var_fragmentations"]componentsJoinedByString:@"; "],
                   
                   @"rateOfWaves":            [procModel valueForKey:@"var_rateOfWaves"],
                   @"kvOfWaves":              [procModel valueForKey:@"var_KVWaves"],
                   @"pausePerformed":         [procModel valueForKey:@"var_pausePerformed"],
                   @"followUp":               [procModel valueForKey:@"var_followUp"],
                   @"complications":          [procModel valueForKey:@"var_complications"]
                   };
    } else if ([procedureID isEqualToString:@"2"]){
        params = @{@"surgeonID":                surgeonID,
                   @"procedureID":              procedureID,
                   @"patientName":              [procModel valueForKey:@"var_patientName"],
                   @"patientDob":               [procModel valueForKey:@"var_patientDOB"],
                   @"mrNumber":                 [procModel valueForKey:@"var_MRNumber"],
                   @"gender":                   [procModel valueForKey:@"var_sex"],
                   @"dateOfService":            [procModel valueForKey:@"var_DOS"],
                   
                   @"preOp":                    [procModel valueForKey:@"var_preOp"],
                   @"preOp2":                   @"",                //-------------------------------------
                   @"postOp":                   [procModel valueForKey:@"var_postOp"],
                   @"cytoStent":                [procModel valueForKey:@"var_cysto"],
                   @"surgeonName":              [procModel valueForKey:@"var_surgeon"],
                   @"assistants":               [[procModel valueForKey:@"var_assistant"] valueForKey:@"contactID"],
                   @"anesthesiologist":         [[procModel valueForKey:@"var_anesthesiologist"]valueForKey:@"contactID"],
                   
                   @"tumorSizeCm":              [procModel valueForKey:@"var_tumorSize"],
                   @"location":                 [procModel valueForKey:@"var_location"],
                   @"tumorChar":                [procModel valueForKey:@"var_tumorChar"],
                  @"previousAbdominalSurgeries":[procModel valueForKey:@"var_history"],
                   @"BMI":                      [procModel valueForKey:@"var_bmi"],
                   
                   @"intraAbdominalAdhesions":  [procModel valueForKey:@"var_adhesions"],
          @"descriptionIntraAbdominalAdhesions":[procModel valueForKey:@"var_adhTook"],
                   @"adhesiolyst":              @"",               //-------------------------------------
                   @"vascularAnomalies":        @"",              //-------------------------------------
                @"descriptionVascularAnomalies":[procModel valueForKey:@"var_vasAnomolies"],
                   
                   @"renalUltrasound":          [procModel valueForKey:@"var_renalUltraSound"],
                   @"deepMargin":               [procModel valueForKey:@"var_margin"],
                   @"renalCollSR":              [procModel valueForKey:@"var_RCSRepair"],
                   @"clampTime":                [procModel valueForKey:@"var_clamp"],
                   @"useOfCoagulants":          [procModel valueForKey:@"var_coagulant"],
                   @"bloodLoss":                [procModel valueForKey:@"var_bloodLoss"],
                   
                   @"counselTime":              [procModel valueForKey:@"var_counselTime"],
                   @"roomTime":                 [procModel valueForKey:@"var_roomTime"],
                   @"complations":              [procModel valueForKey:@"var_complation"],
                   @"transfusion":              [procModel valueForKey:@"var_transfusion"],
                   @"noOfUnits":                @"",                //-------------------------------------
                   @"cc":                       [procModel valueForKey:@"var_cc"],
                   @"faxNumber":                @"",  //[procModel valueForKey:@"var_Fax"]
                   
                   };
    } else if ([procedureID isEqualToString:@"9"]){
        params = @{@"surgeonID":              surgeonID,
                   @"procedureID":            procedureID,
                   @"patientName":            [procModel valueForKey:@"var_patientName"],
                   @"patientDob":             [procModel valueForKey:@"var_patientDOB"],
                   @"mrNumber":               [procModel valueForKey:@"var_MRNumber"],
                   @"gender":                 [procModel valueForKey:@"var_sex"],
                   @"dateOfService":          [procModel valueForKey:@"var_DOS"],

                   };
    } else if ([procedureID isEqualToString:@"1"] ){
        params = @{@"surgeonID":              surgeonID,
                   @"procedureID":            procedureID,
                   @"patientName":            [procModel valueForKey:@"var_patientName"],
                   @"patientDob":             [procModel valueForKey:@"var_patientDOB"],
                   @"mrNumber":               [procModel valueForKey:@"var_MRNumber"],
                   @"gender":                 [procModel valueForKey:@"var_sex"],
                   @"dateOfService":          [procModel valueForKey:@"var_DOS"],

                   };
    }


    [self requestWithMethod:@"POST" path:@"addProcedureDetail" params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error]);
        NSLog(@"%@",json);

    }];

    
}


@end