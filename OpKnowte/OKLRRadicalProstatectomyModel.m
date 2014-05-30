//
//  OKLRRadicalProstatectomyModel.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/7/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKLRRadicalProstatectomyModel.h"

@implementation OKLRRadicalProstatectomyModel
-(void) setModelWithDictionary:(NSDictionary *)dictionary
{
    
    

    _var_patientName= [dictionary valueForKey:@"Patient_Name"];
    _DetailID= [dictionary valueForKey:@"DetailID"];
    _Surgeon_ID= [dictionary valueForKey:@"Surgeon_ID"];
    _var_procedureName = [dictionary valueForKey:@"PROCEDURE_ID"];
    _var_patientDOB= [dictionary valueForKey:@"Patient_Dob"];
    _var_MRNumber= [dictionary valueForKey:@"Medical_Record"];
    _var_DOS= [dictionary valueForKey:@"DateOfService"];
//    _var_sex= [dictionary valueForKey:@"Gender"];
   /// _var_age
    _var_preOpDX = [dictionary valueForKey:@"Pre_Op_dx"];
    _var_postOp = [dictionary valueForKey:@"Post_Op_dx"];
    
    _var_nervesparing = [dictionary valueForKey:@"Nerve_Sparing"];
    _var_surgeon = [dictionary valueForKey:@"surgeonName"];
    _var_assistant = [dictionary valueForKey:@"Assistants"];
    _var_anesthesia = [dictionary valueForKey:@"Anestesia"];
    
    
    _var_pelvicDisection = [dictionary valueForKey:@"PelvicLymphNodeDissection"];
    _var_bladderNeckReconstruction = [dictionary valueForKey:@"BladderNeckReconstruction"];
    _var_sling = [dictionary valueForKey:@"Sling"];
    _var_lysisOfAdhesions = [dictionary valueForKey:@"LysisOfAdhesions"];
    _var_ethnicity = [dictionary valueForKey:@"Ethnicity"];
    _var_stage = [dictionary valueForKey:@"ClinicalStage"];
     _var_grade = [dictionary valueForKey:@"GleasonGrade"];
     _var_numberOfCores = [dictionary valueForKey:@"NumberOfCores"];
    
     _var_greatestPercentage = [dictionary valueForKey:@"GreatestPercentageOfCore"];
     _var_prostateVolume = [dictionary valueForKey:@"Pre_bx_PSA"];
     _var_BMI = [dictionary valueForKey:@"BMI"];
     _var_technique = [dictionary valueForKey:@"TechniqueTaken"];
     _var_factors = [dictionary valueForKey:@"ComplicatingFactors"];
     _var_roomTime = [dictionary valueForKey:@"RoomTime"];
    
    _var_operativeTime = [dictionary valueForKey:@"OperativeTime"];
    _var_consulTime = [dictionary valueForKey:@"ConsulTime"];
    _var_EBL = [dictionary valueForKey:@"EBL"];
    _var_fluids = [dictionary valueForKey:@"Fluids"];
    _var_preOpSHIM = [dictionary valueForKey:@"Pre_op_SHIM"];
    _var_preOpAUA = [dictionary valueForKey:@"Pre_op_AUA"];
    _var_physicans= [dictionary valueForKey:@"ReferringPhysicians"];

    
    
}
@end
