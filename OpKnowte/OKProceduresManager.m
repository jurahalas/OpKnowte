//
//  OKProceduresManager.m
//  OpKnowte
//
//  Created by Apple on 15.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProceduresManager.h"
#import "OKProcedureModel.h"


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
    [self requestWithMethod:@"GET" path:@"getAllProc" params:nil handler:^(NSError *error, id json) {
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

-(void)getCasesListWithProcedureID:(NSString*)procedureID andSurgeonID:(NSString*)surgeonID handler:(void (^)(NSString *errorMsg, NSMutableArray *cases))handler
{
    NSDictionary *params = @{
                             @"procedureID":procedureID,
                             @"surgeonID":surgeonID,
                             };
    
    NSString *url = [NSString stringWithFormat:@"getCaseByProcIDSurgeonID"];
    
    
    [self requestWithMethod:@"GET" path:url params:params handler:^(NSError *error, id json) {
        NSLog(@"%@",json);
        
        NSMutableArray *cases = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in json) {
            OKCase *caseModel = [[OKCase alloc] init];
            [caseModel setModelWithDictionary:dict];
            [cases addObject:caseModel];
        }
        handler([self getErrorMessageFromJSON:json error:error], cases);
    }];
    
}

-(void)getReminderSettingsWithUserID:(NSString*)userID andProcedureID:(NSString*)procID handler:(void (^)(NSString *errorMsg, NSMutableArray *reminderSettings))handler
{
    NSDictionary *params = @{
                             @"procedureID":procID,
                             @"userID": userID,
                             };
    NSString *url = [NSString stringWithFormat:@"getReminderSetting"];
    
    [self requestWithMethod:@"GET" path:url params:params handler:^(NSError *error, id json){
        NSLog(@"%@",json);
        
        NSString *errorMsg = [self getErrorMessageFromJSON:json error:error];
        if(!errorMsg){
            
        }
        handler(errorMsg, json);
    }];
}

-(void)updateReminderSettingsWithProcedureID:(NSString*)procedureID patientID:(NSString*)patientID userID:(NSString*)userID days:(NSString*)days andList:(NSString*)list handler:(void (^)(NSString *errorMsg, NSDictionary *json))handler;
{
    NSDictionary *params = @{@"procedureID": procedureID,
                             @"patientID": patientID,
                             @"userID": userID,
                             @"noOfDays": days,
                             @"contactIds": list};
    
    [self requestWithMethod:@"POST" path:@"updateReminderSetting" params:params handler:^(NSError *error, id json){
        
        NSLog(@"%@",json);
        
        NSString *errorMsg = [self getErrorMessageFromJSON:json error:error];
        if(!errorMsg){
            
        }
        handler(errorMsg, json);
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
            if (![[variable valueForKey:@"order"] isEqualToString:@"0"]) {
                OKProcedureTemplateVariablesModel *model = [[OKProcedureTemplateVariablesModel alloc] init];
                [model setModelWithDictionary:variable];
                if (![model.value isEqualToString:@"(var_preSide)"]) {
                    [variablesArray addObject:model];
                }
            }
        }
        handler([self getErrorMessageFromJSON:json error:error], variablesArray);
    }];
    
    
}

-(void) updateProcedureTemplateWithUserID:(NSString*) userID AndProcedureTemplate:(OKProcedureTemplateModel*) template handler:(void (^)(NSString *errorMsg, NSDictionary *json))handler{
    NSDictionary *params = @{@"indicationsText": template.indicationText,
                             @"procedureText": template.procedureText,
                             @"caseData": template.caseData,
                             @"procedureID": template.procedureID,
                             @"surgeonID": [OKUserManager instance].currentUser.identifier
                             };
    
    
    [self requestWithMethod:@"POST" path:@"updateTemplate" params:params handler:^(NSError *error, id json) {
        NSLog(@"%@",json);
        
        handler([self getErrorMessageFromJSON:json error:error], json);
    }];
}


-(void) saveProcedureWithSurgeonID:(NSString *)surgeonID ProcedureID:(NSString *)procedureID AndProcedureModel: (id) procModel handler:(void (^)(NSString *errorMsg, id json))handler{
    NSDictionary *params;
    
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"MM-dd-yyyy"];
    NSDate *dateOfServiceDate = [dateFormatter1 dateFromString:[procModel valueForKey:@"var_DOS"]];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
    NSString *dateOfServiceString = [NSString stringWithFormat:@"%@", [dateFormatter2 stringFromDate:dateOfServiceDate] ];
    
    
    
    if ([procedureID isEqualToString:@"10"]) {
        params = @{@"surgeonID":              surgeonID,
                   @"procedureID":            procedureID,
                   @"age":                    [procModel valueForKey:@"var_age"],
                   @"patientName":            [procModel valueForKey:@"var_patientName"],
                   @"patientDob":             [procModel valueForKey:@"var_patientDOB"],
                   @"mrNumber":               [procModel valueForKey:@"var_MRNumber"],
                   @"gender":                 [procModel valueForKey:@"var_sex"],
                   @"dateOfService":          dateOfServiceString,
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
                   @"age":                      [procModel valueForKey:@"var_age"],
                   @"patientName":              [procModel valueForKey:@"var_patientName"],
                   @"patientDob":               [procModel valueForKey:@"var_patientDOB"],
                   @"mrNumber":                 [procModel valueForKey:@"var_MRNumber"],
                   @"gender":                   [procModel valueForKey:@"var_sex"],
                   @"dateOfService":            dateOfServiceString,
                   
                   @"preOp":                    [procModel valueForKey:@"var_preOp"],
                   @"preOp2":                   @"",                //-------------------------------------
                   @"postOp":                   [procModel valueForKey:@"var_postOp"],
                   @"cytoStent":                [procModel valueForKey:@"var_cysto"],
                   @"surgeonName":              [procModel valueForKey:@"var_surgeon"],
                   @"assistants":               [procModel valueForKey:@"var_assistant"] ,
                   @"anesthesiologist":         [procModel valueForKey:@"var_anesthesiologist"],

                   //@"assistants":               [[procModel valueForKey:@"var_assistant"] valueForKey:@"contactID"],
                   //@"anesthesiologist":         [[procModel valueForKey:@"var_anesthesiologist"]valueForKey:@"contactID"],
                   
                   @"tumorSizeCm":              [procModel valueForKey:@"var_tumorSize"],
                   @"location":                 [procModel valueForKey:@"var_location"],
                   @"tumorChar":                [procModel valueForKey:@"var_tumorChar"],
//                   @"previousAbdominalSurgeries":[procModel valueForKey:@"var_history"],
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
                                      @"age":                      [procModel valueForKey:@"var_age"],
                   @"patientName":            [procModel valueForKey:@"var_patientName"],
                   @"patientDob":             [procModel valueForKey:@"var_patientDOB"],
                   @"mrNumber":               [procModel valueForKey:@"var_MRNumber"],
                   @"gender":                 [procModel valueForKey:@"var_sex"],
                   @"dateOfService":          dateOfServiceString,
                   
                   @"anesthesia":             [procModel valueForKey:@"var_anastesia"],
                   @"diagnosis":              [procModel valueForKey:@"var_diagnosis"],
                   @"deviceimplaned":         [procModel valueForKey:@"var_deviceimplaned"],
                   @"dilatorsused":           [procModel valueForKey:@"var_dilatorsused"],
                   @"dilatedto":              [procModel valueForKey:@"var_dilatedto"],
                   @"dilationwas":            [procModel valueForKey:@"var_dilationwas"],
                   
                   @"rightproximal":          [procModel valueForKey:@"var_rightproximal"],
                   @"rightdistal":            [procModel valueForKey:@"var_rightdistal"],
                   @"leftproximal":           [procModel valueForKey:@"var_leftproximal"],
                   @"leftdistal":             [procModel valueForKey:@"var_leftdistal"],
                   @"devicelength":           [procModel valueForKey:@"var_devicelength"],
                   @"reartips":               [procModel valueForKey:@"var_reartips"],
                   
                   @"reservoirplacement":     [procModel valueForKey:@"var_reservoirplacement"],
                   @"reservoirside":          [procModel valueForKey:@"var_reservoirside"],
                   @"reservoirtype":          [procModel valueForKey:@"var_reservoirtype"],
                   @"reservoirfilled":        [procModel valueForKey:@"var_reservoirfilled"],
                   @"drainplaced":            [procModel valueForKey:@"var_drainplaced"],
                   @"volumeofirrigation":     [procModel valueForKey:@"var_volumeofirrigation"],
                   
                   @"irrigationantibiotics":  [procModel valueForKey:@"var_irrigationantibiotics"],
                   @"complications":          [procModel valueForKey:@"var_complications"],
                   @"followup":               [procModel valueForKey:@"var_followup"]
                   
                   };
    } else if ([procedureID isEqualToString:@"1"] ){
        params = @{@"surgeonID":                surgeonID,
                   @"procedureID":              procedureID,
                                      @"age":                      [procModel valueForKey:@"var_age"],
                   @"patientName":              [procModel valueForKey:@"var_patientName"],
                   @"patientDob":               [procModel valueForKey:@"var_patientDOB"],
                   @"mrNumber":                 [procModel valueForKey:@"var_MRNumber"],
                   @"gender":                   [procModel valueForKey:@"var_sex"],
                   @"dateOfService":            dateOfServiceString,
                   
                   
                   //var_anesthesiologist
                   @"preOpDx":                  [procModel valueForKey:@"var_preOpDX"],
                   @"postOpDX":                 [procModel valueForKey:@"var_postOp"],
                   @"nerveSparing":             [procModel valueForKey:@"var_nervesparing"],
                   @"surgeonName":              [procModel valueForKey:@"var_surgeon"],
                   @"assistants":               [procModel valueForKey:@"var_assistant"],
                   @"anesthesiologist":         [procModel valueForKey:@"var_anesthesiologist"],
                   
                   @"pelvicLymphNodeDissection":[procModel valueForKey:@"var_pelvicDisection"],
                   @"bladderNeckReconstruction":[procModel valueForKey:@"var_bladderNeckReconstruction"],
                   @"sling":                    [procModel valueForKey:@"var_sling"],
                   @"lysisOfAdhesions":         [procModel valueForKey:@"var_lysisOfAdhesions"],
                   
                   
                   @"anestesia":                [procModel valueForKey:@"var_anesthesia"],
                   @"ethnicity":                [procModel valueForKey:@"var_ethnicity"],
                   
                   @"clinicalStage":            [procModel valueForKey:@"var_stage"],
                   @"gleasonGrade":             [procModel valueForKey:@"var_grade"],
                   @"numberOfCores":            [procModel valueForKey:@"var_numberOfCores"],
                   
                   @"greatestPercentageOfCore": [procModel valueForKey:@"var_greatestPercentage"],
                   @"preBxPSA":                 [procModel valueForKey:@"var_preBX"],
                   
                   @"prostateVolume":           [procModel valueForKey:@"var_prostateVolume"],
                   @"BMI":                      [procModel valueForKey:@"var_BMI"],
                   @"techniqueTaken":           [procModel valueForKey:@"var_technique"],
                   @"complicatingFactors":      [procModel valueForKey:@"var_factors"],
                   
                   @"roomTime":                 [procModel valueForKey:@"var_roomTime"],
                   @"operativeTime":            [procModel valueForKey:@"var_operativeTime"],
                   @"consulTime":               [procModel valueForKey:@"var_consulTime"],
                   
                   @"EBL":                      [procModel valueForKey:@"var_EBL"],
                   @"fluids":                   [procModel valueForKey:@"var_fluids"],
                   @"preOpSHIM":                [procModel valueForKey:@"var_preOpSHIM"],
                   @"preOpAUA":                 [procModel valueForKey:@"var_preOpAUA"],
                   @"referringPhysicians":      [procModel valueForKey:@"var_physicans"]
                   };
    }
    
    
    [self requestWithMethod:@"POST" path:@"addProcedureDetail" params:params handler:^(NSError *error, id json) {
        handler([self getErrorMessageFromJSON:json error:error], json);
        NSLog(@"%@",json);
        
    }];
    
    
}
- (void) checkMRNumberByNumber:(NSString*)MRNumber handler:(void(^)(NSString *errorMsg, NSDictionary *response))handler
{
    NSDictionary *params = @{@"mrNumber": MRNumber};
    

    [self requestWithMethod:@"POST" path:@"checkMRNumber" params:params handler:^(NSError *error, id json) {
        NSLog(@"%@",json);

        handler([self getErrorMessageFromJSON:json error:error], json);
        
    }];
    
    
}

@end