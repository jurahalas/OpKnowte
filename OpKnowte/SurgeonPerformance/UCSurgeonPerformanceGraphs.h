//
//  UCSurgeonPerformanceGraphs.h
//  MZUroCapture
//
//  Created by Atif Joyia on 21/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCSurgeonPerformanceGraphs : UIViewController
{
    IBOutlet UILabel * l_Header;
    IBOutlet UILabel * sampleSize;
}
@property (nonatomic, retain) IBOutlet UIView *TNMStagingView;
@property (nonatomic, retain) IBOutlet UIView *tumorChView;
@property (nonatomic, retain) IBOutlet UIView *FGradeView;
@property (nonatomic, retain) IBOutlet UIView *marginsView;
@property (nonatomic, retain) IBOutlet UIView *DMarginView;
@property (nonatomic, retain) IBOutlet UIView *nightsGraph;
@property (nonatomic, retain) IBOutlet UIView *complicationsGraph;
@property (nonatomic, retain) IBOutlet UIView *xrayGraph;
@property (nonatomic, retain) IBOutlet UIView *liverGraph;
@property (nonatomic, retain) IBOutlet UIView *herniaGraph;
@property (nonatomic, retain) IBOutlet UIView *CtScanGraph;

@property (nonatomic, retain) NSString *graphView;

@property (nonatomic, retain) IBOutlet UIView *Tx;
@property (nonatomic, retain) IBOutlet UIView *T0;
@property (nonatomic, retain) IBOutlet UIView *T1;
@property (nonatomic, retain) IBOutlet UIView *T1a;
@property (nonatomic, retain) IBOutlet UIView *T1b;
@property (nonatomic, retain) IBOutlet UIView *T2;
@property (nonatomic, retain) IBOutlet UIView *T2a;
@property (nonatomic, retain) IBOutlet UIView *T2b;
@property (nonatomic, retain) IBOutlet UIView *T3;
@property (nonatomic, retain) IBOutlet UIView *T3a;
@property (nonatomic, retain) IBOutlet UIView *T3b;
@property (nonatomic, retain) IBOutlet UIView *T3c;
@property (nonatomic, retain) IBOutlet UIView *T4;


@property (nonatomic, retain) IBOutlet UIView *N;
@property (nonatomic, retain) IBOutlet UIView *Nx;
@property (nonatomic, retain) IBOutlet UIView *N0;
@property (nonatomic, retain) IBOutlet UIView *N1;

@property (nonatomic, retain) IBOutlet UIView *M;
@property (nonatomic, retain) IBOutlet UIView *M0;
@property (nonatomic, retain) IBOutlet UIView *M1;

@property (nonatomic) float TxAge;
@property (nonatomic) float T0Age;
@property (nonatomic) float T1Age;
@property (nonatomic) float T1aAge;
@property (nonatomic) float T1bAge;
@property (nonatomic) float T2Age;
@property (nonatomic) float T2aAge;
@property (nonatomic) float T2bAge;
@property (nonatomic) float T3Age;
@property (nonatomic) float T3aAge;
@property (nonatomic) float T3bAge;
@property (nonatomic) float T3cAge;
@property (nonatomic) float T4Age;
@property (nonatomic) float NAge;
@property (nonatomic) float NxAge;
@property (nonatomic) float N0Age;
@property (nonatomic) float N1Age;
@property (nonatomic) float MAge;
@property (nonatomic) float M0Age;
@property (nonatomic) float M1Age;

@property (nonatomic) float ClearAll;
@property (nonatomic) float Papillary;
@property (nonatomic) float Chromophobe;
@property (nonatomic) float Sarcomatoid;
@property (nonatomic) float angiomyolipoma;
@property (nonatomic) float oncocytoma;
@property (nonatomic) float other;

@property (nonatomic, retain) IBOutlet UIView *ClearAllView;
@property (nonatomic, retain) IBOutlet UIView *PapillaryView;
@property (nonatomic, retain) IBOutlet UIView *ChromophobeView;
@property (nonatomic, retain) IBOutlet UIView *SarcomatoidView;
@property (nonatomic, retain) IBOutlet UIView *angiomyolipomaView;
@property (nonatomic, retain) IBOutlet UIView *oncocytomaView;
@property (nonatomic, retain) IBOutlet UIView *otherView;

@property (nonatomic) float FGoneByFour;
@property (nonatomic) float FGtwoByFour;
@property (nonatomic) float FGthreeByFour;
@property (nonatomic) float FGfourByFour;

@property (nonatomic, retain) IBOutlet UIView *FGoneByFourView;
@property (nonatomic, retain) IBOutlet UIView *FGtwoByFourView;
@property (nonatomic, retain) IBOutlet UIView *FGthreeByFourView;
@property (nonatomic, retain) IBOutlet UIView *FGfourByFourView;

@property (nonatomic) float mPositive;
@property (nonatomic) float mNegative;
@property (nonatomic) float dmPositive;
@property (nonatomic) float dmNegative;

@property (nonatomic, retain) IBOutlet UIView *mPositiveView;
@property (nonatomic, retain) IBOutlet UIView *mNegativeView;
@property (nonatomic, retain) IBOutlet UIView *dmPositiveView;
@property (nonatomic, retain) IBOutlet UIView *dmNegativeView;

@property (nonatomic) float averageStay;
@property (nonatomic) int minStay;
@property (nonatomic) int maxStay;

@property (nonatomic, retain) IBOutlet UIView *oneView;
@property (nonatomic, retain) IBOutlet UIView *twoView;
@property (nonatomic, retain) IBOutlet UIView *threeView;
@property (nonatomic, retain) IBOutlet UIView *fourView;
@property (nonatomic, retain) IBOutlet UIView *fiveView;
@property (nonatomic, retain) IBOutlet UIView *sixView;
@property (nonatomic, retain) IBOutlet UIView *sevenView;
@property (nonatomic, retain) IBOutlet UIView *eightView;
@property (nonatomic, retain) IBOutlet UIView *nineView;
@property (nonatomic, retain) IBOutlet UIView *tenView;
@property (nonatomic, retain) IBOutlet UIView *elevenView;
@property (nonatomic, retain) IBOutlet UIView *twelveView;
@property (nonatomic, retain) IBOutlet UIView *thirteenView;
@property (nonatomic, retain) IBOutlet UIView *fourteenView;
@property (nonatomic, retain) IBOutlet UIView *fifteenView;
@property (nonatomic, retain) IBOutlet UIView *sixteenView;
@property (nonatomic, retain) IBOutlet UIView *seventeenView;
@property (nonatomic, retain) IBOutlet UIView *eighteenView;
@property (nonatomic, retain) IBOutlet UIView *nineteenView;
@property (nonatomic, retain) IBOutlet UIView *twentyView;
@property (nonatomic, retain) IBOutlet UIView *twentyOneView;
@property (nonatomic, retain) IBOutlet UIView *TwentyTwoView;
@property (nonatomic, retain) IBOutlet UIView *twentyThreeView;
@property (nonatomic, retain) IBOutlet UIView *twentyFourView;
@property (nonatomic, retain) IBOutlet UIView *twentyFiveView;
@property (nonatomic, retain) IBOutlet UIView *twentySixView;
@property (nonatomic, retain) IBOutlet UIView *twentySevenView;
@property (nonatomic, retain) IBOutlet UIView *twentyEightView;
@property (nonatomic, retain) IBOutlet UIView *twentyNineView;
@property (nonatomic, retain) IBOutlet UIView *thirtyView;


@property (nonatomic) float Ileus;
@property (nonatomic) float BowelInjury;
@property (nonatomic) float Infection;
@property (nonatomic) float UrineLeak;
@property (nonatomic) float DVT;
@property (nonatomic) float PE;
@property (nonatomic) float CardiacEvent;
@property (nonatomic) float Hernia;
@property (nonatomic) float Transfusion;
@property (nonatomic) float Death;
@property (nonatomic) float OtherComp;

@property (nonatomic, retain) IBOutlet UIView *IleusView;
@property (nonatomic, retain) IBOutlet UIView *BowelInjuryView;
@property (nonatomic, retain) IBOutlet UIView *InfectionView;
@property (nonatomic, retain) IBOutlet UIView *UrineLeakView;
@property (nonatomic, retain) IBOutlet UIView *DVTView;
@property (nonatomic, retain) IBOutlet UIView *PEView;
@property (nonatomic, retain) IBOutlet UIView *CardiacEventView;
@property (nonatomic, retain) IBOutlet UIView *HerniaView;
@property (nonatomic, retain) IBOutlet UIView *TransfusionView;
@property (nonatomic, retain) IBOutlet UIView *DeathView;
@property (nonatomic, retain) IBOutlet UIView *OtherCompView;

@property (nonatomic) float xrayPositive;
@property (nonatomic) float xrayNegative;

@property (nonatomic, retain) IBOutlet UIView *xrayPositiveView;
@property (nonatomic, retain) IBOutlet UIView *xrayNegativeView;

@property (nonatomic) float liverNormal;
@property (nonatomic) float liverAbNormal;

@property (nonatomic, retain) IBOutlet UIView *liverNormalView;
@property (nonatomic, retain) IBOutlet UIView *liverAbNormalView;

@property (nonatomic) float herniaYES;
@property (nonatomic) float herniaNO;

@property (nonatomic, retain) IBOutlet UIView *herniaYESView;
@property (nonatomic, retain) IBOutlet UIView *herniaNOView;


@property (nonatomic) float metastaticDisease;
@property (nonatomic) float LocalRecurrence;
@property (nonatomic) float Lymphadenopathy;
@property (nonatomic) float LiverMetastasis;
@property (nonatomic) float BoneMetastasis;
@property (nonatomic) float BrainMetastasis;

@property (nonatomic, retain) IBOutlet UIView *metastaticDiseaseView;
@property (nonatomic, retain) IBOutlet UIView *LocalRecurrenceView;
@property (nonatomic, retain) IBOutlet UIView *LymphadenopathyView;
@property (nonatomic, retain) IBOutlet UIView *LiverMetastasisView;
@property (nonatomic, retain) IBOutlet UIView *BoneMetastasisView;
@property (nonatomic, retain) IBOutlet UIView *BrainMetastasisView;

@property (nonatomic, retain) IBOutlet UIView *changeBUNView;
@property (nonatomic, retain) IBOutlet UIView *bunView;
@property (nonatomic, retain) IBOutlet UILabel *changeTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *unitLabel;
@property (nonatomic, retain) IBOutlet UILabel *xLabel;



@property (nonatomic) float bunSum;
@property (nonatomic) float minBun;
@property (nonatomic) float maxBun;

@property (nonatomic) float creatinineSum;
@property (nonatomic) float minCreatinine;
@property (nonatomic) float maxCreatinine;


@property (nonatomic) int maxSampleSize;


@property (nonatomic) float averageBun;
@property (nonatomic) float averageCreatinine;

@property (nonatomic, retain) IBOutlet UIView *averageView;
@property (nonatomic, retain) IBOutlet UILabel *averageViewTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *oneLabel;
@property (nonatomic, retain) IBOutlet UILabel *twoLabel;


- (IBAction)SettingsView:(id)sender;
- (IBAction)home:(id)sender;
@end
