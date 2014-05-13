//
//  UCUserModel.m
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/7/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "BusinessClass.h"

@implementation UCStatusResponseModel
@synthesize status, message;
@end

@implementation UCRegisterModel
@synthesize userID, firstName, lastName, email, pswd;
@synthesize repeatPswd, title;
@end

@implementation UCLoginModel
@synthesize userName, pswd;
@end

@implementation UCProcdureModel
@synthesize procedureID, procedureText, procedureShortName;
@end

@implementation UCContactInfoModel
@synthesize contactID, contactRoleID, contactName, contactEmail, contactNumber, contactCity, contactCountry, contactFax, contactState, contactStreetAddress, contactZip;
@end

@implementation UCTemplateResponseModel
@synthesize status, templateID, procedureID, caseData, procedureText, indicationText, message;
@end

@implementation UCTemplateVariablesModel
@synthesize ID, key, value;
@end

@implementation ESWLModel
@synthesize var_age, var_DOS, var_MRNumber, var_patientDOB, var_patientName, var_procedureName, var_sex, var_stonesCount, var_anesthesiaLocation, var_anesthesiaPerformed, var_complications, var_followUp, var_fragmentations, var_KVWaves, var_pausePerformed, var_rateOfWaves, var_stonesLocations, var_stonesSizes, var_surgeon, var_totalShocks;

@end


