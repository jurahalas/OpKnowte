//
//  OKShockwaveLithotripsyModel.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/28/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKShockwaveLithotripsyModel.h"

@implementation OKShockwaveLithotripsyModel
-(void) setModelWithDictionary:(NSDictionary *)dictionary
{
    _var_patientName= [dictionary valueForKey:@"Patient_Name"];
    _var_patientDOB= [dictionary valueForKey:@"Patient_Dob"];
    _var_MRNumber= [dictionary valueForKey:@"MRNumber"];
    _var_DOS= [dictionary valueForKey:@"DateOfService"];
    _var_surgeon= [dictionary valueForKey:@"SurgeonName"];
    _var_sex= [dictionary valueForKey:@"Gender"];
    _var_procedureName = [dictionary valueForKey:@"PROCEDURE_ID"];

    _var_age= [dictionary valueForKey:@"age"];

    _var_anesthesiaPerformed = [dictionary valueForKey:@"Anesthesia_Performed"];
    _var_anesthesiaLocation= [dictionary valueForKey:@"Anesthesia_Location"];
    _var_stonesCount= [dictionary valueForKey:@"Stones_Count"];
    _var_stonesSizes= [dictionary valueForKey:@"Stones_Sizes"];
    _var_stonesLocations= [dictionary valueForKey:@"Stones_Locations"];
    _var_totalShocks= [dictionary valueForKey:@"Stones_Shocks"];
    _var_fragmentations= [dictionary valueForKey:@"DegreeOfFragmentation"];
    _var_rateOfWaves= [dictionary valueForKey:@"RateOfWaves"];
    _var_KVWaves= [dictionary valueForKey:@"KVOfWaves"];
    _var_followUp= [dictionary valueForKey:@"FollowUp"];
    _var_complications= [dictionary valueForKey:@"Complication"];
    _var_pausePerformed= [dictionary valueForKey:@"PausePerformed"];
    
    
    
    //_twoWeeksEmail= [dictionary valueForKey:@"twoWeeksEmail"];
    //_sixMonthsEmail= [dictionary valueForKey:@"sixMonthsEmail"];
    _DetailID= [dictionary valueForKey:@"DetailID"];
    _Surgeon_ID= [dictionary valueForKey:@"Surgeon_ID"];
}
@end
