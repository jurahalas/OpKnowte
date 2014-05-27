//
//  OKPenileProsthesisModel.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/7/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseModel.h"

@interface OKPenileProsthesisModel : OKBaseModel

@property (strong,nonatomic) NSString *var_patientName;
@property (strong,nonatomic) NSString *var_patientDOB;
@property (strong,nonatomic) NSString *var_age;
@property (strong,nonatomic) NSString *var_MRNumber;
@property (strong,nonatomic) NSString *var_DOS;
@property (strong,nonatomic) NSString *var_sex;
@property (strong,nonatomic) NSString *var_surgeon;
@property (strong,nonatomic) NSString *var_procedureName;

@property (strong,nonatomic) NSString *var_anastesia;
@property (strong,nonatomic) NSString *var_diagnosis;
@property (strong,nonatomic) NSString *var_deviceimplaned;
@property (strong,nonatomic) NSString *var_dilatorsused;
@property (strong,nonatomic) NSString *var_dilatedto;
@property (strong,nonatomic) NSString *var_dilationwas;

@property (strong,nonatomic) NSString *var_rightproximal;
@property (strong,nonatomic) NSString *var_rightdistal;
@property (strong,nonatomic) NSString *var_leftproximal;
@property (strong,nonatomic) NSString *var_leftdistal;
@property (strong,nonatomic) NSString *var_devicelength;
@property (strong,nonatomic) NSString *var_reartips;

@property (strong,nonatomic) NSString *var_reservoirplacement;
@property (strong,nonatomic) NSString *var_reservoirside;
@property (strong,nonatomic) NSString *var_reservoirtype;
@property (strong,nonatomic) NSString *var_reservoirfilled;
@property (strong,nonatomic) NSString *var_drainplaced;
@property (strong,nonatomic) NSString *var_volumeofirrigation;


@property (strong,nonatomic) NSString *var_irrigationantibiotics;
@property (strong,nonatomic) NSString *var_complications;
@property (strong,nonatomic) NSString *var_followup;


@end
