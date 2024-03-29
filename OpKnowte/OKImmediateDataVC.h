//
//  OKImmediateDataVC.h
//  OpKnowte
//
//  Created by Apple on 16.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"
#import "OKImmediateDataCell.h"

@interface OKImmediateDataVC : OKBaseViewController <UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) NSString *procID;

@property (nonatomic) int totalSurgeonCount;
@property (nonatomic) int totalNationalCount;


@property (nonatomic) NSMutableDictionary * comp_dictionary;
@property (nonatomic) NSMutableDictionary * irri_dictionary;
@property (nonatomic) NSMutableDictionary * diag_dictionary;
@property (nonatomic) NSMutableDictionary * devimp_dictionary;
@property (nonatomic) NSMutableDictionary * diluse_dictionary;
@property (nonatomic) NSMutableDictionary * dilwas_dictionary;
@property (nonatomic) NSMutableDictionary * restyp_dictionary;
@property (nonatomic) NSMutableDictionary * dilto_dictionary;



@property (nonatomic, retain) NSMutableArray *selectedCases;
@property (nonatomic, retain) NSMutableArray *surgeonCases;
@property (nonatomic) int sumOfAges;
@property (nonatomic) float positiveDMargins;
@property (nonatomic) float maleCount;
@property (nonatomic) float LRMCount;
@property (nonatomic) float cytoStentCount;
@property (nonatomic) float adhesiolysisCount;
@property (nonatomic) float vasAnomolyCount;
@property (nonatomic) float intraOpUSCount;
@property (nonatomic) float renalSRCount;
@property (nonatomic) float coagulantCount;
@property (nonatomic) float transfusionCount;
@property (nonatomic) float consoleTimeCount;
@property (nonatomic) float roomTimeCount;
@property (nonatomic) float clampTimeCount;
@property (nonatomic) float bloodLossCount;
@property (nonatomic) float tumorSizeCount;
@property (nonatomic) float bmiCount;
@property (nonatomic) float maxAge;
@property (nonatomic) float minAge;
@property (nonatomic) float maxBmi;
@property (nonatomic) float minBmi;
@property (nonatomic) float maxClampTime;
@property (nonatomic) float minClampTime;
@property (nonatomic) float maxConsoleTime;
@property (nonatomic) float minConsoleTime;
@property (nonatomic) float maxRoomTime;
@property (nonatomic) float minRoomTime;
@property (nonatomic) float maxBloodLoss;
@property (nonatomic) float minBloodLoss;
@property (nonatomic) float maxTumorSize;
@property (nonatomic) float minTumorSize;

@property (nonatomic) int sur_sumOfAges;
@property (nonatomic) float sur_positiveDMargins;
@property (nonatomic) float sur_maleCount;
@property (nonatomic) float sur_LRMCount;
@property (nonatomic) float sur_cytoStentCount;
@property (nonatomic) float sur_adhesiolysisCount;
@property (nonatomic) float sur_vasAnomolyCount;
@property (nonatomic) float sur_intraOpUSCount;
@property (nonatomic) float sur_renalSRCount;
@property (nonatomic) float sur_coagulantCount;
@property (nonatomic) float sur_transfusionCount;
@property (nonatomic) float sur_consoleTimeCount;
@property (nonatomic) float sur_roomTimeCount;
@property (nonatomic) float sur_clampTimeCount;
@property (nonatomic) float sur_bloodLossCount;
@property (nonatomic) float sur_tumorSizeCount;
@property (nonatomic) float sur_bmiCount;
@property (nonatomic) float sur_maxAge;
@property (nonatomic) float sur_minAge;
@property (nonatomic) float sur_maxBmi;
@property (nonatomic) float sur_minBmi;
@property (nonatomic) float sur_maxClampTime;
@property (nonatomic) float sur_minClampTime;
@property (nonatomic) float sur_maxConsoleTime;
@property (nonatomic) float sur_minConsoleTime;
@property (nonatomic) float sur_maxRoomTime;
@property (nonatomic) float sur_minRoomTime;
@property (nonatomic) float sur_maxBloodLoss;
@property (nonatomic) float sur_minBloodLoss;
@property (nonatomic) float sur_maxTumorSize;
@property (nonatomic) float sur_minTumorSize;

@property (nonatomic) BOOL isCalculated;
@property (nonatomic) BOOL isNationalData;

-(int)CalculateAge:(NSString *)DateOfBirth;
-(void)AverageAgeOfPatient;
-(void)MaleFemale;
-(void)BMI;
-(void)LeftRightRenalMass;
-(void)CytoStent;
-(void)TumorSize;
-(void)TumorCharacteristics;
-(void)AdhesiolysisRequired;
-(void)VascularAnomoly;
-(void)IntraOpUltraSound;
-(void)DeepMargins;
-(void)Margins;
-(void)RenalSystemRepair;
-(void)AverageClampTime;
-(void)Coagulants;
-(void)BloodLoss;
-(void)ConsoleTime;
-(void)RoomTime;
-(void)Complications;
-(void)TransfusionRequired;
//-(IBAction)advancedOptions:(id)sender;
-(IBAction)back:(id)sender;

@end
