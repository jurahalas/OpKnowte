//
//  UCLRPNModel.m
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/28/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCLRPNModel.h"

@implementation UCLRPNModel

@synthesize var_patientName, var_patientDOB, var_age, var_DOS, var_MRNumber, var_sex, var_cysto, var_postOp, var_surgeon, var_anesthesiologist, var_assistant, var_history, var_bmi, var_tumorChar, var_location, var_tumorSize, var_adhTook, var_adhesions, var_vasAnomolies, var_cc, var_clamp, var_complation, var_coagulant, var_counselTime, var_bloodLoss, var_margin, var_renalUltraSound, var_transfusion, var_RCSRepair, var_roomTime, var_preOp, var_preSide, var_procedureName, var_Fax;

- (NSString *)patientAge {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MM-YYY"];
    NSDate *date = [dateFormatter dateFromString:self.var_patientDOB];
    NSDateComponents *diff = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date toDate:[NSDate date] options:0];
    dateFormatter = nil;
    
    return [NSString stringWithFormat:@"%i years old",[diff year]];
}

@end
