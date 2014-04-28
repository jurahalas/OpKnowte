//
//  OKShockwaveLithotripsyModel.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/28/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseModel.h"

@interface OKShockwaveLithotripsyModel : OKBaseModel

@property (nonatomic, retain) NSString *patientName;
@property (nonatomic, retain) NSString *patientDOB;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString *mrNumber;
@property (nonatomic, retain) NSString *dateOfService;
@property (nonatomic, retain) NSString *surgeonID;
@property (nonatomic, retain) NSString *anesthesiaPerformed;
@property (nonatomic, retain) NSString *anesthesiaLocation;
@property (nonatomic, retain) NSString *stonesCount;
@property (nonatomic, retain) NSMutableArray *stonesLocations;
@property (nonatomic, retain) NSMutableArray *stonesSizes;
@property (nonatomic, retain) NSMutableArray *totalShocks;
@property (nonatomic, retain) NSMutableArray *degreeOfFragmentation;
@property (nonatomic, retain) NSString *rateOfWaves;
@property (nonatomic, retain) NSString *kvOfWaves;
@property (nonatomic, retain) NSString *pausePerformed;
@property (nonatomic, retain) NSString *followUp;
@property (nonatomic, retain) NSString *complications;





@end
