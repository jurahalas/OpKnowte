//
//  OKPostOpDataGraphsVC.h
//  OpKnowte
//
//  Created by Apple on 21.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"

@interface OKPostOpDataGraphsVC : OKBaseViewController

{}

@property (nonatomic) NSMutableDictionary * comp_dictionary;








@property (nonatomic)int averageAge;
@property (nonatomic)int dmPositive;
@property (nonatomic)int malePercentage;
@property (nonatomic)int LRMPercentage;
@property (nonatomic)int cytoStentPercentage;
@property (nonatomic)int requiredPercentage;
@property (nonatomic)int anomoliesPercentage;
@property (nonatomic)int iousPercentage;
@property (nonatomic)int renalRSPercentage;
@property (nonatomic)int coagulantPercentage;
@property (nonatomic)int transfusionPercentage;
@property (nonatomic)int consolePercentage;
@property (nonatomic)int roomTimePercentage;
@property (nonatomic)int clampTimePercentage;
@property (nonatomic)int maxAge;
@property (nonatomic)int minAge;
@property (nonatomic)float maxBmi;
@property (nonatomic)float minBmi;
@property (nonatomic)float maxClampTime;
@property (nonatomic)float minClampTime;
@property (nonatomic)float maxConsoleTime;
@property (nonatomic)float minConsoleTime;
@property (nonatomic)float maxRoomTime;
@property (nonatomic)float minRoomTime;
@property (nonatomic)float maxBloodLoss;
@property (nonatomic)float minBloodLoss;
@property (nonatomic)float maxTumorSize;
@property (nonatomic)float minTumorSize;
@property (nonatomic)float bloodLossPercentage;
@property (nonatomic)float tumorSizePercentage;
@property (nonatomic)float bmiPercentage;

@property (nonatomic)int sur_averageAge;
@property (nonatomic)int sur_dmPositive;
@property (nonatomic)int sur_malePercentage;
@property (nonatomic)int sur_LRMPercentage;
@property (nonatomic)int sur_cytoStentPercentage;
@property (nonatomic)int sur_requiredPercentage;
@property (nonatomic)int sur_anomoliesPercentage;
@property (nonatomic)int sur_iousPercentage;
@property (nonatomic)int sur_renalRSPercentage;
@property (nonatomic)int sur_coagulantPercentage;
@property (nonatomic)int sur_transfusionPercentage;
@property (nonatomic)int sur_consolePercentage;
@property (nonatomic)int sur_roomTimePercentage;
@property (nonatomic)int sur_clampTimePercentage;
@property (nonatomic)int sur_maxAge;
@property (nonatomic)int sur_minAge;
@property (nonatomic)float sur_maxBmi;
@property (nonatomic)float sur_minBmi;
@property (nonatomic)float sur_maxClampTime;
@property (nonatomic)float sur_minClampTime;
@property (nonatomic)float sur_maxConsoleTime;
@property (nonatomic)float sur_minConsoleTime;
@property (nonatomic)float sur_maxRoomTime;
@property (nonatomic)float sur_minRoomTime;
@property (nonatomic)float sur_maxBloodLoss;
@property (nonatomic)float sur_minBloodLoss;
@property (nonatomic)float sur_maxTumorSize;
@property (nonatomic)float sur_minTumorSize;
@property (nonatomic)float sur_bloodLossPercentage;
@property (nonatomic)float sur_tumorSizePercentage;
@property (nonatomic)float sur_bmiPercentage;



@property (nonatomic, retain)NSString *graphToDraw;

@property (nonatomic, retain) IBOutlet UIView *averageAgeGraph;
@property (nonatomic, retain) IBOutlet UIView *ageView;


@property (nonatomic, retain) IBOutlet UIView *maleFemaleView;
@property (nonatomic, retain) IBOutlet UIView *maleView;
@property (nonatomic, retain) IBOutlet UIView *femaleView;

@property (nonatomic, retain) IBOutlet UIView *leftRightRenalView;
@property (nonatomic, retain) IBOutlet UIView *leftRenalView;
@property (nonatomic, retain) IBOutlet UIView *rightRenalView;

@property (nonatomic, retain) IBOutlet UIView *cytoStentView;
@property (nonatomic, retain) IBOutlet UIView *cytoYesView;
@property (nonatomic, retain) IBOutlet UIView *cytoNoView;

@property (nonatomic, retain) IBOutlet UIView *adhesiolysisView;
@property (nonatomic, retain) IBOutlet UIView *requiredView;

@property (nonatomic, retain) IBOutlet UIView *vasAnomoliesView;
@property (nonatomic, retain) IBOutlet UIView *anomoliesYesView;

@property (nonatomic, retain) IBOutlet UIView *iousView;
@property (nonatomic, retain) IBOutlet UIView *iousYesView;

@property (nonatomic, retain) IBOutlet UIView *renalRSView;
@property (nonatomic, retain) IBOutlet UIView *renalRSYesView;

@property (nonatomic, retain) IBOutlet UIView *DMarginView;
@property (nonatomic, retain) IBOutlet UIView *dmPositiveView;
@property (nonatomic, retain) IBOutlet UIView *dmNegativeView;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *averageTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *unitLabel;
@property (nonatomic, retain) IBOutlet UILabel *xLabel;


@property (nonatomic, retain) IBOutlet UIView *bloodLossView;
@property (nonatomic, retain) IBOutlet UIView *bloodView;

@property (nonatomic, retain) IBOutlet UIView *tumorSizeView;
@property (nonatomic, retain) IBOutlet UIView *tumorView;

@property (nonatomic, retain) IBOutlet UIView *averageView;
@property (nonatomic, retain) IBOutlet UILabel *averageViewTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *oneLabel;
@property (nonatomic, retain) IBOutlet UILabel *twoLabel;
@property (nonatomic, retain) IBOutlet UILabel *oneSurLabel;
@property (nonatomic, retain) IBOutlet UILabel *twoSurLabel;

@property (nonatomic, retain) IBOutlet UILabel *National;
@property (nonatomic, retain) IBOutlet UILabel *Surgeon;

@property (nonatomic, retain) IBOutlet UILabel *NationalSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *SurgeonSampleSize;

@property (nonatomic)int NationalSize;
@property (nonatomic)int SurgeonSize;

@property (nonatomic) BOOL isNationalData;

- (IBAction)compareButtonTapped:(id)sender;

@end