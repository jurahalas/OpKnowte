//
//  OKOngoingData.h
//  OpKnowte
//
//  Created by Eugene on 21.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseModel.h"

enum OKProcedureSummaryDetailPeriod {
    OKProcedureSummaryDetailTwoWeeks = 0,
    OKProcedureSummaryDetailSixWeeks
};

@interface OKOngoingData : OKBaseModel

@property (nonatomic, strong) NSString *caseID;

//2 weeks
@property (nonatomic, strong) NSString *tStage;
@property (nonatomic, strong) NSString *nStage;
@property (nonatomic, strong) NSString *mStage;
@property (nonatomic, strong) NSString *tumorChar;
@property (nonatomic, strong) NSString *fuhrmanGrade;
@property (nonatomic, strong) NSString *margins;
@property (nonatomic, strong) NSString *deepMargin;
@property (nonatomic, strong) NSString *lengthOfStay;
@property (nonatomic, strong) NSString *complications;
@property (nonatomic, strong) NSString *preOperativeBun;
@property (nonatomic, strong) NSString *preOperativeCreatinine;
@property (nonatomic, strong) NSString *postOperativeBun;
@property (nonatomic, strong) NSString *postOperativeCreatinine;
@property (nonatomic, strong) NSString *additionalDiagnosis;

//6 WEEKS
@property (nonatomic, strong) NSString *chestXray;
//@property (nonatomic, strong) NSString *BunCreatinine;
@property (nonatomic, strong) NSString *liverEnzymes;
@property (nonatomic, strong) NSString *portSiteHemia;
@property (nonatomic, strong) NSString *other;
@property (nonatomic, strong) NSString *CtScan;
@property (nonatomic, strong) NSString *Bun;
@property (nonatomic, strong ) NSString *Creatinine;

-(NSOrderedDictionary*)twoWeeksItems;
-(NSOrderedDictionary*)sixWeeksItems;

//used to check if all of the needed data is filled
-(BOOL)checkTwoWeeksData;
-(BOOL)checkSixWeeksData;

//used to create add data request
-(NSDictionary*)twoWeeksDictionaryForSending;
-(NSDictionary*)sixWeeksDictionaryForSending;

@end
