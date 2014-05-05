//
//  OKLRPartialNephrectomyModel.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/3/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseModel.h"

@interface OKLRPartialNephrectomyModel : OKBaseModel


@property (nonatomic, retain) NSString *patientName;
@property (nonatomic, retain) NSString *patientDOB;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString *mrNumber;
@property (nonatomic, retain) NSString *dateOfService;
@property (nonatomic, retain) NSString *surgeonID;

@property (nonatomic, retain) NSString *preOp;
@property (nonatomic, retain) NSString *postOp;
@property (nonatomic, retain) NSString *cytoStent;
@property (nonatomic, retain) NSString *surgeonName;
@property (nonatomic, retain) NSString *assistants;
@property (nonatomic, retain) NSString *anesthesiologist;
@property (nonatomic, retain) NSString *tumorSizeCm;
@property (nonatomic, retain) NSString *location;

@property (nonatomic, retain) NSString *tumorChar;
@property (nonatomic, retain) NSString *previousAbdominalSurgeries;
@property (nonatomic, retain) NSString *BMI;
@property (nonatomic, retain) NSString *intraAbdominalAdhesions;
@property (nonatomic, retain) NSString *descriptionIntraAbdominalAdhesions;

@property (nonatomic, retain) NSString *vascularAnomalies;
@property (nonatomic, retain) NSString *descriptionVascularAnomalies;


@property (nonatomic, retain) NSString *renalUltrasound;
@property (nonatomic, retain) NSString *deepMargin;
@property (nonatomic, retain) NSString *renalCollSR;
@property (nonatomic, retain) NSString *clampTime;

@property (nonatomic, retain) NSString *useOfCoagulants;
@property (nonatomic, retain) NSString *bloodLoss;
@property (nonatomic, retain) NSString *counselTime;
@property (nonatomic, retain) NSString *roomTime;

@property (nonatomic, retain) NSString *complations;
@property (nonatomic, retain) NSString *transfusion;
@property (nonatomic, retain) NSString *cc;


@end
