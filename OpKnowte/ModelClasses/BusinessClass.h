//
//  UCUserModel.h
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/7/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCLoginModel : NSObject
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *pswd;
@end

@interface UCStatusResponseModel : NSObject
@property (strong,nonatomic) NSString *status;
@property (strong,nonatomic) NSString *message;
@end

@interface UCRegisterModel : NSObject
@property (strong,nonatomic) NSString* userID;
@property (strong,nonatomic) NSString* firstName;
@property (strong,nonatomic) NSString* lastName;
@property (strong,nonatomic) NSString* email;
@property (strong,nonatomic) NSString* pswd;
@property (strong,nonatomic) NSString* repeatPswd;
@property (strong,nonatomic) NSString* title;
@end

@interface UCProcdureModel : NSObject
@property (strong,nonatomic) NSString* procedureID;
@property (strong,nonatomic) NSString* procedureText;
@property (strong,nonatomic) NSString* procedureShortName;
@end

@interface UCContactInfoModel : NSObject
@property (strong,nonatomic) NSString* contactID;
@property (strong,nonatomic) NSString* contactRoleID;
@property (strong,nonatomic) NSString* contactName;
@property (strong,nonatomic) NSString* contactEmail;
@property (strong,nonatomic) NSString* contactNumber;
@property (strong,nonatomic) NSString* contactStreetAddress;
@property (strong,nonatomic) NSString* contactCity;
@property (strong,nonatomic) NSString* contactState;
@property (strong,nonatomic) NSString* contactZip;
@property (strong,nonatomic) NSString* contactCountry;
@property (strong,nonatomic) NSString* contactFax;
@end

@interface UCTemplateResponseModel : NSObject
@property (strong,nonatomic) NSString* status;
@property (strong,nonatomic) NSString* message;
@property (strong,nonatomic) NSString* templateID;
@property (strong,nonatomic) NSString* procedureID;
@property (strong,nonatomic) NSString* caseData;
@property (strong,nonatomic) NSString* procedureText;
@property (strong,nonatomic) NSString* indicationText;
@end

@interface UCTemplateVariablesModel : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
@end



//(var_patientName) (var_patientDOB) (var_age) (var_sex) (var_MRNumber) (var_DOS) (var_surgeon) (var_anesthesiaPerformed) (var_anesthesiaLocation) (var_stonesCount) (var_stonesSizes) (var_stonesLocations) (var_totalShocks) (var_rateOfWaves) (var_KVWaves) (var_fragmentations) (var_followUp) (var_complications) (var_pausePerformed)

@interface ESWLModel : NSObject
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
@property (strong,nonatomic) NSString *var_stonesSizes;
@property (strong,nonatomic) NSString *var_stonesLocations;
@property (strong,nonatomic) NSString *var_totalShocks;
@property (strong,nonatomic) NSString *var_rateOfWaves;
@property (strong,nonatomic) NSString *var_KVWaves;
@property (strong,nonatomic) NSString *var_fragmentations;
@property (strong,nonatomic) NSString *var_followUp;
@property (strong,nonatomic) NSString *var_complications;
@property (strong,nonatomic) NSString *var_pausePerformed;
@end
