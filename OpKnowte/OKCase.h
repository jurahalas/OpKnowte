//
//  OKCase.h
//  OpKnowte
//
//  Created by Eugene on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseModel.h"

@interface OKCase : OKBaseModel

@property (nonatomic,strong) NSString *patientNameNineProc;
@property (nonatomic, strong) NSString *patientName;
@property (nonatomic, strong) NSString *patientDOB;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *MRNumber;
@property (nonatomic, strong) NSDate *DOS;
@property (nonatomic, strong) NSString *preOp;
@property (nonatomic, strong) NSString *postOp;
@property (nonatomic, strong) NSString *procedureName;
@property (nonatomic, strong) NSString *cysto;
@property (nonatomic, strong) NSString *surgeon;
@property (nonatomic, strong) NSString *assistant;
@property (nonatomic, strong) NSString *anesthesiologist;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *tumorSize;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *tumorChar;
@property (nonatomic, strong) NSString *bmi;
@property (nonatomic, strong) NSString *history;
@property (nonatomic, strong) NSString *adhesions;
@property (nonatomic, strong) NSString *adhTook;
@property (nonatomic, strong) NSString *vasAnomolies;
@property (nonatomic, strong) NSString *renalUltraSound;
@property (nonatomic, strong) NSString *margin;
@property (nonatomic, strong) NSString *RCSRepair;
@property (nonatomic, strong) NSString *clamp;
@property (nonatomic, strong) NSString *coagulant;
@property (nonatomic, strong) NSString *bloodLoss;
@property (nonatomic, strong) NSString *counselTime;
@property (nonatomic, strong) NSString *roomTime;
@property (nonatomic, strong) NSString *complation;
@property (nonatomic, strong) NSString *transfusion;
@property (nonatomic, strong) NSArray *cc;
@property (nonatomic, strong) NSString *preSide;
@property (nonatomic, strong) NSString *Fax;
@property (nonatomic, strong) NSString *irrigationantibiotics;

@property (nonatomic, strong) NSString *anastesia;
@property (nonatomic, strong) NSString *complications;
@property (nonatomic, strong) NSString *dateOfService;
@property (nonatomic, strong) NSString *deviceimplaned;
@property (nonatomic, strong) NSString *devicelength;
@property (nonatomic, strong) NSString *diagnosis;
@property (nonatomic, strong) NSString *dilatedto;
@property (nonatomic, strong) NSString *dilationwas;
@property (nonatomic, strong) NSString *dilatorsused;
@property (nonatomic, strong) NSString *drainplaced;
@property (nonatomic, strong) NSString *followup;
@property (nonatomic, strong) NSString *stonesCount;


@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *caseID;
@property (nonatomic, strong) NSString *leftdistal;
@property (nonatomic, strong) NSString *leftproximal;
@property (nonatomic, strong) NSString *mrNumber;
@property (nonatomic, strong) NSString *patientDob;
@property (nonatomic, strong) NSString *procedureID;
@property (nonatomic, strong) NSString *reservoirfilled;
@property (nonatomic, strong) NSString *reservoirplacement;

@property (nonatomic, strong) NSString *reservoirside;
@property (nonatomic, strong) NSString *reservoirtype;
@property (nonatomic, strong) NSString *rightdistal;
@property (nonatomic, strong) NSString *rightproximal;
@property (nonatomic, strong) NSString *surgeonID;
@property (nonatomic, strong) NSString *volumeofirrigation;

-(NSString*)dateOfServiceString;

@end
