//
//  OKPenileProsthesisModel.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/7/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKPenileProsthesisModel.h"

@implementation OKPenileProsthesisModel
-(void) setModelWithDictionary:(NSDictionary *)dictionary
{
//id: "1",
//procedureID: "9",
//surgeonID: "286",
    _var_age= [dictionary valueForKey:@"age"];

    //_var_sex = [dictionary valueForKey:@"Patient_Name"];
    //_var_surgeon = [dictionary valueForKey:@"Patient_Name"];
//_var_age = [dictionary valueForKey:@"Patient_Name"];

    _DetailID= [dictionary valueForKey:@"id"];
    _Surgeon_ID= [dictionary valueForKey:@"surgeonID"];

    _var_patientName = [dictionary valueForKey:@"patientName"];
    _var_patientDOB = [dictionary valueForKey:@"patientDob"];

    _var_MRNumber = [dictionary valueForKey:@"mrNumber"];
    _var_DOS = [dictionary valueForKey:@"dateOfService"];

    _var_procedureName = [dictionary valueForKey:@"PROCEDURE_ID"];
    
    _var_anastesia = [dictionary valueForKey:@"anastesia"];
    _var_diagnosis = [dictionary valueForKey:@"diagnosis"];
    _var_deviceimplaned = [dictionary valueForKey:@"deviceimplaned"];
    _var_dilatorsused = [dictionary valueForKey:@"dilatorsused"];
    _var_dilatedto = [dictionary valueForKey:@"dilatedto"];
    _var_dilationwas = [dictionary valueForKey:@"dilationwas"];
    
    _var_rightproximal = [dictionary valueForKey:@"rightproximal"];
    _var_rightdistal = [dictionary valueForKey:@"rightdistal"];
    _var_leftproximal = [dictionary valueForKey:@"leftproximal"];
    _var_leftdistal = [dictionary valueForKey:@"leftdistal"];
    _var_devicelength = [dictionary valueForKey:@"devicelength"];
    _var_reartips = [dictionary valueForKey:@"reartips"];
    
    _var_reservoirplacement = [dictionary valueForKey:@"reservoirplacement"];
    _var_reservoirside = [dictionary valueForKey:@"reservoirside"];
    _var_reservoirtype = [dictionary valueForKey:@"reservoirtype"];
    _var_reservoirfilled = [dictionary valueForKey:@"reservoirfilled"];
    _var_drainplaced = [dictionary valueForKey:@"drainplaced"];
    _var_volumeofirrigation = [dictionary valueForKey:@"volumeofirrigation"];
    
    
    _var_irrigationantibiotics = [dictionary valueForKey:@"irrigationantibiotics"];
    _var_complications = [dictionary valueForKey:@"complications"];
    _var_followup = [dictionary valueForKey:@"followup"];
    
}
@end
