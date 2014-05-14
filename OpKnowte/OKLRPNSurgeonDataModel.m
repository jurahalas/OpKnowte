//
//  OKLRPNSurgeonDataModel.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/12/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKLRPNSurgeonDataModel.h"

@implementation OKLRPNSurgeonDataModel
-(void)setModelWithDictionary:(NSDictionary *)dictionary{
    _DetailID= [dictionary valueForKey:@"DetailID"];
    _PROCEDURE_ID = [dictionary valueForKey:@"PROCEDURE_ID"];
    _Surgeon_ID= [dictionary valueForKey:@"Surgeon_ID"];
    _Patient_Name= [dictionary valueForKey:@"Patient_Name"];
    _Patient_Dob= [dictionary valueForKey:@"Patient_Dob"];
    _MRNumber= [dictionary valueForKey:@"MRNumber"];
    _DateOfService= [dictionary valueForKey:@"DateOfService"];
    _Pre_Op_1= [dictionary valueForKey:@"Pre_Op_1"];
    _Pre_Op_2= [dictionary valueForKey:@"Pre_Op_2"];
    _Post_Op= [dictionary valueForKey:@"Post_Op"];
    _CytoStent= [dictionary valueForKey:@"CytoStent"];
    _SurgeonName= [dictionary valueForKey:@"SurgeonName"];
    _Assistants= [dictionary valueForKey:@"Assistants"];
    _Anesthesiologist= [dictionary valueForKey:@"Anesthesiologist"];
    _Gender= [dictionary valueForKey:@"Gender"];
    _TumorSize_cm= [dictionary valueForKey:@"TumorSize_cm"];
    _Location= [dictionary valueForKey:@"Location"];
    _Tumor_Char= [dictionary valueForKey:@"Tumor_Char"];
    _Previous_AS= [dictionary valueForKey:@"Previous_AS"];
    _BMI= [dictionary valueForKey:@"BMI"];
    _Intra_AA= [dictionary valueForKey:@"Intra_AA"];
    _Description_intraAA= [dictionary valueForKey:@"Description_intraAA"];
    _Adhesiolyst= [dictionary valueForKey:@"Adhesiolyst"];
    _Vascular_Anomalies= [dictionary valueForKey:@"Vascular_Anomalies"];
    _Description_VA= [dictionary valueForKey:@"Description_VA"];
    _Renal_Ultrasound= [dictionary valueForKey:@"Renal_Ultrasound"];
    _Deep_Margin= [dictionary valueForKey:@"Deep_Margin"];
    _Renal_Coll_SR= [dictionary valueForKey:@"Renal_Coll_SR"];
    _Clamp_Tim= [dictionary valueForKey:@"Clamp_Tim"];
    _Use_Coagulants= [dictionary valueForKey:@"Use_Coagulants"];
    _Blood_loss= [dictionary valueForKey:@"Blood_loss"];
    _Counsel_Time= [dictionary valueForKey:@"Counsel_Time"];
    _Room_Time= [dictionary valueForKey:@"Room_Time"];
    _Complations= [dictionary valueForKey:@"Complations"];
    _Transustion= [dictionary valueForKey:@"Transustion"];
    _NoOf_units= [dictionary valueForKey:@"NoOf_units"];
    _Carbon_Copy= [dictionary valueForKey:@"Carbon_Copy"];
    _FaxNumber= [dictionary valueForKey:@"FaxNumber"];
    _twoWeeksEmail= [dictionary valueForKey:@"twoWeeksEmail"];
    _sixMonthsEmail= [dictionary valueForKey:@"sixMonthsEmail"];
    
}
@end
