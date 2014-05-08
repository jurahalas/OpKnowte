//
//  OKShockwaveLithotripsyModel.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/28/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseModel.h"

@interface OKShockwaveLithotripsyModel : OKBaseModel
@property (strong,nonatomic) NSString *var_patientName;
@property (strong,nonatomic) NSString *var_patientDOB;
@property (strong,nonatomic) NSString *var_age;
@property (strong,nonatomic) NSString *var_MRNumber;
@property (strong,nonatomic) NSString *var_DOS;
@property (strong,nonatomic) NSString *var_surgeon;
@property (strong,nonatomic) NSString *var_procedureName;
@property (strong,nonatomic) NSString *var_sex;


@property (strong,nonatomic) NSString *var_anesthesiaPerformed;
@property (strong,nonatomic) NSString *var_anesthesiaLocation;
@property (strong,nonatomic) NSString *var_stonesCount;
@property (strong,nonatomic) NSMutableArray *var_stonesSizes;
@property (strong,nonatomic) NSMutableArray *var_stonesLocations;
@property (strong,nonatomic) NSMutableArray *var_totalShocks;
@property (strong,nonatomic) NSMutableArray *var_fragmentations;
@property (strong,nonatomic) NSString *var_rateOfWaves;
@property (strong,nonatomic) NSString *var_KVWaves;
@property (strong,nonatomic) NSString *var_followUp;
@property (strong,nonatomic) NSString *var_complications;
@property (strong,nonatomic) NSString *var_pausePerformed;





@end
