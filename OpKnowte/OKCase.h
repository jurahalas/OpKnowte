//
//  OKCase.h
//  OpKnowte
//
//  Created by Eugene on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseModel.h"

@interface OKCase : OKBaseModel

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

-(NSString*)dateOfServiceString;

@end
