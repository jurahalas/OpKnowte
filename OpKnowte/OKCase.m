//
//  OKCase.m
//  OpKnowte
//
//  Created by Eugene on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKCase.h"

@implementation OKCase

-(void)setModelWithDictionary:(NSDictionary *)dictionary
{
    self.identifier = [dictionary objectForKey:@"DetailID"];
    self.patientNameNineProc = [dictionary objectForKey:@"patientName"];
    self.patientName = [dictionary objectForKey:@"Patient_Name"];
    self.patientDOB = [dictionary objectForKey:@"Patient_Dob"];
    [self updateAge:[dictionary objectForKey:@"Patient_Dob"]];
    [self updateDOS:[dictionary objectForKey:@"DateOfService"]];
    self.MRNumber = [dictionary objectForKey:@"MRNumber"];
    self.sex = [dictionary objectForKey:@"Gender"];
    self.cysto = [dictionary objectForKey:@"CytoStent"];
    self.postOp = [dictionary objectForKey:@"Post_Op"];
    self.surgeon = [dictionary objectForKey:@"SurgeonName"];
    self.anesthesiologist = [dictionary objectForKey:@"Anesthesiologist"];
    self.assistant = [dictionary objectForKey:@"Assistants"];
    self.history = [dictionary objectForKey:@"Previous_AS"];
    self.bmi = [dictionary objectForKey:@"BMI"];
    self.tumorChar = [dictionary objectForKey:@"Tumor_Char"];
    self.location = [dictionary objectForKey:@"Location"];
    self.tumorSize = [dictionary objectForKey:@"TumorSize_cm"];
    self.adhTook = [dictionary objectForKey:@"Adhesiolyst"];
    self.adhesions = [dictionary objectForKey:@"Intra_AA"];
    self.vasAnomolies = [dictionary objectForKey:@"Vascular_Anomalies"];
    self.cc = [dictionary objectForKey:@"Carbon_Copy"];
    self.clamp = [dictionary objectForKey:@"Clamp_Tim"];
    self.complation = [dictionary objectForKey:@"Complations"];
    self.coagulant = [dictionary objectForKey:@"Use_Coagulants"];
    self.counselTime = [dictionary objectForKey:@"Counsel_Time"];
    self.bloodLoss = [dictionary objectForKey:@"Blood_loss"];
    self.margin = [dictionary objectForKey:@"Deep_Margin"];
    self.renalUltraSound = [dictionary objectForKey:@"Renal_Ultrasound"];
    self.transfusion = [dictionary objectForKey:@"Transustion"];
    self.RCSRepair = [dictionary objectForKey:@"Renal_Coll_SR"];
    self.roomTime = [dictionary objectForKey:@"Room_Time"];
    self.preOp = [dictionary objectForKey:@"Pre_Op_1"];
    self.preSide = [dictionary objectForKey:@"Pre_Op_2"];
    self.procedureName = [dictionary objectForKey:@"PROCEDURE_ID"];
    self.anastesia = [dictionary objectForKey:@"anastesia"];
    self.complications = [dictionary objectForKey:@"complications"];
    self.dateOfService = [dictionary objectForKey:@"dateOfService"];
    self.deviceimplaned = [dictionary objectForKey:@"deviceimplaned"];
    self.devicelength = [dictionary objectForKey:@"devicelength"];
    self.diagnosis = [dictionary objectForKey:@"diagnosis"];
    self.dilatedto = [dictionary objectForKey:@"dilatedto"];
    self.dilationwas = [dictionary objectForKey:@"dilationwas"];
    self.dilatorsused = [dictionary objectForKey:@"dilatorsused"];
    self.drainplaced = [dictionary objectForKey:@"drainplaced"];
    self.followup = [dictionary objectForKey:@"followup"];
    self.gender = [dictionary objectForKey:@"gender"];
    self.caseID = [dictionary objectForKey:@"id"];
    self.leftdistal = [dictionary objectForKey:@"leftdistal"];
    self.leftproximal = [dictionary objectForKey:@"leftproximal"];
    self.mrNumber = [dictionary objectForKey:@"mrNumber"];
    self.patientDob = [dictionary objectForKey:@"patientDob"];
    self.procedureID = [dictionary objectForKey:@"procedureID"];
    self.reservoirfilled = [dictionary objectForKey:@"reservoirfilled"];
    self.reservoirplacement = [dictionary objectForKey:@"reservoirplacement"];
    self.reservoirside = [dictionary objectForKey:@"reservoirside"];
    self.reservoirtype = [dictionary objectForKey:@"reservoirtype"];
    self.rightdistal = [dictionary objectForKey:@"rightdistal"];
    self.rightproximal = [dictionary objectForKey:@"rightproximal"];
    self.surgeonID = [dictionary objectForKey:@"surgeonID"];
    self.volumeofirrigation = [dictionary objectForKey:@"volumeofirrigation"];
}


- (void)updateAge:(NSString *)DOB
{
    NSDate *date = [DOB dateWithFormat:@"MM-dd-yyyy"];
    if(!date)
        date =[DOB dateWithFormat:@"MM/dd/yyyy"];
    if(date){
        NSDateComponents *diff = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date toDate:[NSDate date] options:0];
        self.age = [NSString stringWithFormat:@"%i years old",[diff year]];
    }
}


-(void)updateDOS:(NSString*)DOS
{
    self.DOS = [DOS dateWithFormat:@"MM-dd-yyyy"];
}


-(NSString*)dateOfServiceString
{
    return [self.DOS stringWithFormat:@"MM-dd-yyyy"];
}


-(NSArray*)sixMonthSummary
{
    NSMutableArray *objects = [NSMutableArray new];
    [objects addObject:[OKSimpleTableItem itemWithTitle:@"Other" value:self.patientDOB]];
    [objects addObject:[OKSimpleTableItem itemWithTitle:@"Bun" value:self.patientDOB]];

    return objects;
}





@end
