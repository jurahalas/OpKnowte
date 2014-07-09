//
//  OKOngoingData.h
//  OpKnowte
//
//  Created by Eugene on 21.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseModel.h"

enum OKProcedureSummaryDetailPeriod
{
    OKProcedureSummaryDetailTwoWeeks = 1,
    OKProcedureSummaryDetailSixWeeks = 2,
    OKProcedureSummaryDetailPenile = 3,
    OKProcedureSummaryDetailRobotic = 4,
    OKProcedureSummaryDetailShockwave = 5,
    OKProcedureSummaryFollowPenile = 5

};

@interface OKOngoingData : OKBaseModel

//shockwave
@property (nonatomic, strong) NSString *stoneFragmentation1;
@property (nonatomic, strong) NSString *stoneFragmentation2;
@property (nonatomic, strong) NSString *stoneFragmentation3;
@property (nonatomic, strong) NSString *stoneFragmentation4;
@property (nonatomic, strong) NSString *stoneFragmentation5;
@property (nonatomic, strong) NSString *postprocedureComplications;

//radical
@property (nonatomic, strong) NSString *T;
@property (nonatomic, strong) NSString *N;
@property (nonatomic, strong) NSString *gleason;
@property (nonatomic, strong) NSString *positiveMargin;
@property (nonatomic, strong) NSString *cystogram;
@property (nonatomic, strong) NSString *Ileus;
@property (nonatomic, strong) NSString *transfusion;
@property (nonatomic, strong) NSString *woundInfection;
@property (nonatomic, strong) NSString *urineLeak;
@property (nonatomic, strong) NSString *bowelInjury;
@property (nonatomic, strong) NSString *DVT;
@property (nonatomic, strong) NSString *PE;
@property (nonatomic, strong) NSString *reAdmission;
@property (nonatomic, strong) NSString *returnToORWithin;
@property (nonatomic, strong) NSString *death;
@property (nonatomic, strong) NSString *lengthOfStay;

//penile
@property (nonatomic, strong) NSString *averageCyclingTime;
@property (nonatomic, strong) NSString *percentOfErosion;
@property (nonatomic, strong) NSString *percentOfInfection;
@property (nonatomic, strong) NSString *percentOfMechnicalFailure;
@property (nonatomic, strong) NSString *caseID;

//2 weeks
@property (nonatomic, strong) NSString *tStage;
@property (nonatomic, strong) NSString *nStage;
@property (nonatomic, strong) NSString *mStage;
@property (nonatomic, strong) NSString *tumorChar;
@property (nonatomic, strong) NSString *fuhrmanGrade;
@property (nonatomic, strong) NSString *margins;
@property (nonatomic, strong) NSString *deepMargin;
@property (nonatomic, strong) NSString *preOperativeBun;
@property (nonatomic, strong) NSString *preOperativeCreatinine;
@property (nonatomic, strong) NSString *postOperativeBun;
@property (nonatomic, strong) NSString *postOperativeCreatinine;
@property (nonatomic, strong) NSString *additionalDiagnosis;
@property (nonatomic, strong) NSString *complications;

//6 WEEKS
@property (nonatomic, strong) NSString *chestXray;
//@property (nonatomic, strong) NSString *BunCreatinine;
@property (nonatomic, strong) NSString *liverEnzymes;
@property (nonatomic, strong) NSString *portSiteHemia;
@property (nonatomic, strong) NSString *other;
@property (nonatomic, strong) NSString *CtScan;
@property (nonatomic, strong) NSString *Bun;
@property (nonatomic, strong ) NSString *Creatinine;

//follow up

//penile
@property (nonatomic, strong) NSString *beginCyclingDevice;
@property (nonatomic, strong) NSString *infection;
@property (nonatomic, strong) NSString *mechanicalFailure;
@property (nonatomic, strong) NSString *erosion;
@property (nonatomic, strong) NSString *discontinue;

-(NSOrderedDictionary*)shockwaveItems;
-(NSOrderedDictionary*)roboticItems;
-(NSOrderedDictionary*)penileItems;
-(NSOrderedDictionary*)twoWeeksItems;
-(NSOrderedDictionary*)sixWeeksItems;
//follow up
-(NSOrderedDictionary*)penileFollowItems;

//used to check if all of the needed data is filled
-(BOOL)checkPenileData;
-(BOOL)checkTwoWeeksData;
-(BOOL)checkSixWeeksData;

//used to create add data request
-(NSDictionary*)shockwaveDictionaryForSending;
-(NSDictionary*)roboticDictionaryForSending;
-(NSDictionary*)penileDictionaryForSending;
-(NSDictionary*)twoWeeksDictionaryForSending;
-(NSDictionary*)sixWeeksDictionaryForSending;

//follow up
-(NSDictionary*)penileFollowDictionaryForSending;



@end
