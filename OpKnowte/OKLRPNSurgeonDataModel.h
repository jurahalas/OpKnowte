//
//  OKLRPNSurgeonDataModel.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/12/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseModel.h"

@interface OKLRPNSurgeonDataModel : OKBaseModel
@property (strong,nonatomic) NSString *DetailID;
@property (strong,nonatomic) NSString *PROCEDURE_ID;
@property (strong,nonatomic) NSString *Surgeon_ID;
@property (strong,nonatomic) NSString *Patient_Name;
@property (strong,nonatomic) NSString *Patient_Dob;
@property (strong,nonatomic) NSString *MRNumber;
@property (strong,nonatomic) NSString *DateOfService;
@property (strong,nonatomic) NSString *Pre_Op_1;
@property (strong,nonatomic) NSString *Pre_Op_2;
@property (strong,nonatomic) NSString *Post_Op;
@property (strong,nonatomic) NSString *CytoStent;
@property (strong,nonatomic) NSString *SurgeonName;
@property (strong,nonatomic) NSString *Assistants;
@property (strong,nonatomic) NSString *Anesthesiologist;
@property (strong,nonatomic) NSString *Gender;
@property (strong,nonatomic) NSString *TumorSize_cm;
@property (strong,nonatomic) NSString *Location;
@property (strong,nonatomic) NSString *Tumor_Char;
@property (strong,nonatomic) NSString *Previous_AS;
@property (strong,nonatomic) NSString *BMI;
@property (strong,nonatomic) NSString *Intra_AA;
@property (strong,nonatomic) NSString *Description_intraAA;
@property (strong,nonatomic) NSString *Adhesiolyst;
@property (strong,nonatomic) NSString *Vascular_Anomalies;
@property (strong,nonatomic) NSString *Description_VA;
@property (strong,nonatomic) NSString *Renal_Ultrasound;
@property (strong,nonatomic) NSString *Deep_Margin;
@property (strong,nonatomic) NSString *Renal_Coll_SR;
@property (strong,nonatomic) NSString *Clamp_Tim;
@property (strong,nonatomic) NSString *Use_Coagulants;
@property (strong,nonatomic) NSString *Blood_loss;
@property (strong,nonatomic) NSString *Counsel_Time;
@property (strong,nonatomic) NSString *Room_Time;
@property (strong,nonatomic) NSString *Complations;
@property (strong,nonatomic) NSString *Transustion;
@property (strong,nonatomic) NSString *NoOf_units;
@property (strong,nonatomic) NSString *Carbon_Copy;
@property (strong,nonatomic) NSString *FaxNumber;
@property (strong,nonatomic) NSString *twoWeeksEmail;
@property (strong,nonatomic) NSString *sixMonthsEmail;
@end
