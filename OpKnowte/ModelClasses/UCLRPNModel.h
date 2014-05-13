//
//  UCLRPNModel.h
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/28/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCLRPNModel : NSObject {
    
}

@property (strong,nonatomic) NSString *var_patientName;
@property (strong,nonatomic) NSString *var_patientDOB;
@property (strong,nonatomic) NSString *var_age;
@property (strong,nonatomic) NSString *var_MRNumber;
@property (strong,nonatomic) NSString *var_DOS;
@property (strong,nonatomic) NSString *var_preOp;
@property (strong,nonatomic) NSString *var_postOp;
@property (strong,nonatomic) NSString *var_procedureName;
@property (strong,nonatomic) NSString *var_cysto;
@property (strong,nonatomic) NSString *var_surgeon;
@property (strong,nonatomic) UCContactInfoModel *var_assistant;
@property (strong,nonatomic) UCContactInfoModel *var_anesthesiologist;
@property (strong,nonatomic) NSString *var_sex;
@property (strong,nonatomic) NSString *var_tumorSize;
@property (strong,nonatomic) NSString *var_location;
@property (strong,nonatomic) NSString *var_tumorChar;
@property (strong,nonatomic) NSString *var_bmi;
@property (strong,nonatomic) NSString *var_history;
@property (strong,nonatomic) NSString *var_adhesions;
@property (strong,nonatomic) NSString *var_adhTook;
@property (strong,nonatomic) NSString *var_vasAnomolies;
@property (strong,nonatomic) NSString *var_renalUltraSound;
@property (strong,nonatomic) NSString *var_margin;
@property (strong,nonatomic) NSString *var_RCSRepair;
@property (strong,nonatomic) NSString *var_clamp;
@property (strong,nonatomic) NSString *var_coagulant;
@property (strong,nonatomic) NSString *var_bloodLoss;
@property (strong,nonatomic) NSString *var_counselTime;
@property (strong,nonatomic) NSString *var_roomTime;
@property (strong,nonatomic) NSString *var_complation;
@property (strong,nonatomic) NSString *var_transfusion;
@property (strong,nonatomic) NSArray *var_cc;
@property (strong,nonatomic) NSString *var_preSide;
@property (strong,nonatomic) NSString *var_Fax;

@end
