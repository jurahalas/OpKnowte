//
//  OKLRRadicalProstatectomyModel.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/7/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseModel.h"
#import "OKContactModel.h"

@interface OKLRRadicalProstatectomyModel : OKBaseModel
@property (strong,nonatomic) NSString *var_patientName;
@property (strong,nonatomic) NSString *var_patientDOB;
@property (strong,nonatomic) NSString *var_age;
@property (strong,nonatomic) NSString *var_MRNumber;
@property (strong,nonatomic) NSString *var_DOS;
@property (strong,nonatomic) NSString *var_sex;


@property (strong,nonatomic) NSString *var_preOpDX;
@property (strong,nonatomic) NSString *var_postOp;
@property (strong,nonatomic) NSString *var_procedureName;
@property (strong, nonatomic) NSString *var_nervesparing;

@property (strong,nonatomic) NSString *var_surgeon;
//------------
@property (strong,nonatomic) NSString *var_assistant_names;
//------------
@property (strong,nonatomic) NSString *var_assistant;
@property (strong,nonatomic) NSString *var_anesthesia;


@property (strong,nonatomic) NSString *var_pelvicDisection;
@property (strong,nonatomic) NSString *var_bladderNeckReconstruction;
@property (strong,nonatomic) NSString *var_sling;
@property (strong,nonatomic) NSString *var_lysisOfAdhesions;
@property (strong,nonatomic) NSString *var_ethnicity;


@property (strong,nonatomic) NSString *var_stage;
@property (strong,nonatomic) NSString *var_grade;
@property (strong,nonatomic) NSString *var_numberOfCores;


@property (strong,nonatomic) NSString *var_greatestPercentage;
@property (strong,nonatomic) NSString *var_preBX;
@property (strong,nonatomic) NSString *var_prostateVolume;
@property (strong,nonatomic) NSString *var_BMI;
@property (strong,nonatomic) NSString *var_technique;
@property (strong,nonatomic) NSString *var_factors;


@property (strong,nonatomic) NSString *var_roomTime;
@property (strong,nonatomic) NSString *var_operativeTime;
@property (strong,nonatomic) NSString *var_consulTime;

@property (strong,nonatomic) NSString *var_EBL;
@property (strong,nonatomic) NSArray *var_fluids;
@property (strong,nonatomic) NSString *var_preOpSHIM;
@property (strong,nonatomic) NSString *var_preOpAUA;

//---------
@property (strong,nonatomic) NSString *var_physicans_names;
//---------
@property (strong,nonatomic) NSString *var_physicans;





@property (strong,nonatomic) NSString *twoWeeksEmail;
@property (strong,nonatomic) NSString *sixMonthsEmail;
@property (strong,nonatomic) NSString *Adhesiolyst;
@property (strong,nonatomic) NSString *Vascular_Anomalies;
@property (strong,nonatomic) NSString *Pre_Op_2;
@property (strong,nonatomic) NSString *DetailID;
@property (strong,nonatomic) NSString *Surgeon_ID;
@end
