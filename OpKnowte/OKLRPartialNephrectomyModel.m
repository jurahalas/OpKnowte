//
//  OKLRPartialNephrectomyModel.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/3/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKLRPartialNephrectomyModel.h"

@implementation OKLRPartialNephrectomyModel
-(void) setModelWithDictionary:(NSDictionary *)dictionary
{
    _var_patientName= [dictionary valueForKey:@"Patient_Name"];
    _var_patientDOB= [dictionary valueForKey:@"Patient_Dob"];
    _var_MRNumber= [dictionary valueForKey:@"MRNumber"];
    _var_DOS= [dictionary valueForKey:@"DateOfService"];
    _var_preOp= [dictionary valueForKey:@"Pre_Op_1"];
    _var_postOp= [dictionary valueForKey:@"Post_Op"];
    _var_cysto= [dictionary valueForKey:@"CytoStent"];
    _var_surgeon= [dictionary valueForKey:@"SurgeonName"];
    _var_assistant= [dictionary valueForKey:@"Assistants"];
    _var_anesthesiologist= [dictionary valueForKey:@"Anesthesiologist"];
    _var_sex= [dictionary valueForKey:@"Gender"];
    _var_tumorSize= [dictionary valueForKey:@"TumorSize_cm"];
    _var_location= [dictionary valueForKey:@"Location"];
    _var_tumorChar= [dictionary valueForKey:@"Tumor_Char"];
//    _var_history= [dictionary valueForKey:@"Previous_AS"];
    _var_bmi= [dictionary valueForKey:@"BMI"];
    _var_adhesions= [dictionary valueForKey:@"Intra_AA"];
    _var_adhTook= [dictionary valueForKey:@"Description_intraAA"];
    _var_vasAnomolies= [dictionary valueForKey:@"Description_VA"];
    _var_renalUltraSound= [dictionary valueForKey:@"Renal_Ultrasound"];
    _var_margin= [dictionary valueForKey:@"Deep_Margin"];
    _var_RCSRepair= [dictionary valueForKey:@"Renal_Coll_SR"];
    _var_clamp= [dictionary valueForKey:@"Clamp_Tim"];
    _var_coagulant= [dictionary valueForKey:@"Use_Coagulants"];
    _var_bloodLoss= [dictionary valueForKey:@"Blood_loss"];
    _var_counselTime= [dictionary valueForKey:@"Counsel_Time"];
    _var_roomTime= [dictionary valueForKey:@"Room_Time"];
    _var_complation= [dictionary valueForKey:@"Complations"];
    _var_transfusion= [dictionary valueForKey:@"Transustion"];
    //_var_transfusion= [dictionary valueForKey:@"NoOf_units"];
    _var_cc= [dictionary valueForKey:@"Carbon_Copy"];
    _var_Fax= [dictionary valueForKey:@"FaxNumber"];
    _var_procedureName = [dictionary valueForKey:@"PROCEDURE_ID"];
    _twoWeeksEmail= [dictionary valueForKey:@"twoWeeksEmail"];
    _sixMonthsEmail= [dictionary valueForKey:@"sixMonthsEmail"];
    _Adhesiolyst= [dictionary valueForKey:@"Adhesiolyst"];
    _Vascular_Anomalies= [dictionary valueForKey:@"Vascular_Anomalies"];
    _Pre_Op_2= [dictionary valueForKey:@"Pre_Op_2"];
    _DetailID= [dictionary valueForKey:@"DetailID"];
    _Surgeon_ID= [dictionary valueForKey:@"Surgeon_ID"];
    _var_psurgeries = [dictionary valueForKey:@"Previous_AS"];
    //@property (strong,nonatomic) NSString *var_preSide;
    _var_age= [dictionary valueForKey:@"age"];
    //@property (strong,nonatomic) NSString *var_procedureName;
}

@end
