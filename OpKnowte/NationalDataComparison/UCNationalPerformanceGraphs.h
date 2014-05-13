//
//  UCNationalPerformanceGraphs.h
//  MZUroCapture
//
//  Created by Omer on 7/15/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCNationalPerformanceGraphs : UIViewController
{
    IBOutlet UILabel * l_Header;
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
@property (nonatomic, retain) IBOutlet UIView *averageView;

@property (nonatomic, retain) NSString *graphView;

@property (nonatomic, retain) IBOutlet UILabel *Tx;
@property (nonatomic, retain) IBOutlet UILabel *s_Tx;

@property (nonatomic, retain) IBOutlet UILabel *T0;
@property (nonatomic, retain) IBOutlet UILabel *s_T0;

@property (nonatomic, retain) IBOutlet UILabel *T1;
@property (nonatomic, retain) IBOutlet UILabel *s_T1;

@property (nonatomic, retain) IBOutlet UILabel *T1a;
@property (nonatomic, retain) IBOutlet UILabel *s_T1a;

@property (nonatomic, retain) IBOutlet UILabel *T1b;
@property (nonatomic, retain) IBOutlet UILabel *s_T1b;

@property (nonatomic, retain) IBOutlet UILabel *T2;
@property (nonatomic, retain) IBOutlet UILabel *s_T2;

@property (nonatomic, retain) IBOutlet UILabel *T2a;
@property (nonatomic, retain) IBOutlet UILabel *s_T2a;

@property (nonatomic, retain) IBOutlet UILabel *T2b;
@property (nonatomic, retain) IBOutlet UILabel *s_T2b;

@property (nonatomic, retain) IBOutlet UILabel *T3;
@property (nonatomic, retain) IBOutlet UILabel *s_T3;

@property (nonatomic, retain) IBOutlet UILabel *T3a;
@property (nonatomic, retain) IBOutlet UILabel *s_T3a;

@property (nonatomic, retain) IBOutlet UILabel *T3b;
@property (nonatomic, retain) IBOutlet UILabel *s_T3b;

@property (nonatomic, retain) IBOutlet UILabel *T3c;
@property (nonatomic, retain) IBOutlet UILabel *s_T3c;

@property (nonatomic, retain) IBOutlet UILabel *T4;
@property (nonatomic, retain) IBOutlet UILabel *s_T4;



@property (nonatomic, retain) IBOutlet UILabel *N;
@property (nonatomic, retain) IBOutlet UILabel *s_N;

@property (nonatomic, retain) IBOutlet UILabel *Nx;
@property (nonatomic, retain) IBOutlet UILabel *s_Nx;

@property (nonatomic, retain) IBOutlet UILabel *N0;
@property (nonatomic, retain) IBOutlet UILabel *s_N0;

@property (nonatomic, retain) IBOutlet UILabel *N1;
@property (nonatomic, retain) IBOutlet UILabel *s_N1;


@property (nonatomic, retain) IBOutlet UILabel *M;
@property (nonatomic, retain) IBOutlet UILabel *s_M;

@property (nonatomic, retain) IBOutlet UILabel *M0;
@property (nonatomic, retain) IBOutlet UILabel *s_M0;

@property (nonatomic, retain) IBOutlet UILabel *M1;
@property (nonatomic, retain) IBOutlet UILabel *s_M1;

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

@property (nonatomic) float s_TxAge;
@property (nonatomic) float s_T0Age;
@property (nonatomic) float s_T1Age;
@property (nonatomic) float s_T1aAge;
@property (nonatomic) float s_T1bAge;
@property (nonatomic) float s_T2Age;
@property (nonatomic) float s_T2aAge;
@property (nonatomic) float s_T2bAge;
@property (nonatomic) float s_T3Age;
@property (nonatomic) float s_T3aAge;
@property (nonatomic) float s_T3bAge;
@property (nonatomic) float s_T3cAge;
@property (nonatomic) float s_T4Age;
@property (nonatomic) float s_NAge;
@property (nonatomic) float s_NxAge;
@property (nonatomic) float s_N0Age;
@property (nonatomic) float s_N1Age;
@property (nonatomic) float s_MAge;
@property (nonatomic) float s_M0Age;
@property (nonatomic) float s_M1Age;

@property (nonatomic) float ClearAll;
@property (nonatomic) float Papillary;
@property (nonatomic) float Chromophobe;
@property (nonatomic) float Sarcomatoid;
@property (nonatomic) float angiomyolipoma;
@property (nonatomic) float oncocytoma;
@property (nonatomic) float other;

@property (nonatomic) float s_ClearAll;
@property (nonatomic) float s_Papillary;
@property (nonatomic) float s_Chromophobe;
@property (nonatomic) float s_Sarcomatoid;
@property (nonatomic) float s_angiomyolipoma;
@property (nonatomic) float s_oncocytoma;
@property (nonatomic) float s_other;

@property (nonatomic, retain) IBOutlet UILabel *ClearAllView;
@property (nonatomic, retain) IBOutlet UILabel *PapillaryView;
@property (nonatomic, retain) IBOutlet UILabel *ChromophobeView;
@property (nonatomic, retain) IBOutlet UILabel *SarcomatoidView;
@property (nonatomic, retain) IBOutlet UILabel *angiomyolipomaView;
@property (nonatomic, retain) IBOutlet UILabel *oncocytomaView;
@property (nonatomic, retain) IBOutlet UILabel *otherView;

@property (nonatomic, retain) IBOutlet UILabel *s_ClearAllView;
@property (nonatomic, retain) IBOutlet UILabel *s_PapillaryView;
@property (nonatomic, retain) IBOutlet UILabel *s_ChromophobeView;
@property (nonatomic, retain) IBOutlet UILabel *s_SarcomatoidView;
@property (nonatomic, retain) IBOutlet UILabel *s_angiomyolipomaView;
@property (nonatomic, retain) IBOutlet UILabel *s_oncocytomaView;
@property (nonatomic, retain) IBOutlet UILabel *s_otherView;


@property (nonatomic) float FGoneByFour;
@property (nonatomic) float FGtwoByFour;
@property (nonatomic) float FGthreeByFour;
@property (nonatomic) float FGfourByFour;

@property (nonatomic) float s_FGoneByFour;
@property (nonatomic) float s_FGtwoByFour;
@property (nonatomic) float s_FGthreeByFour;
@property (nonatomic) float s_FGfourByFour;


@property (nonatomic, retain) IBOutlet UILabel *FGoneByFourView;
@property (nonatomic, retain) IBOutlet UILabel *FGtwoByFourView;
@property (nonatomic, retain) IBOutlet UILabel *FGthreeByFourView;
@property (nonatomic, retain) IBOutlet UILabel *FGfourByFourView;
@property (nonatomic, retain) IBOutlet UILabel *s_FGoneByFourView;
@property (nonatomic, retain) IBOutlet UILabel *s_FGtwoByFourView;
@property (nonatomic, retain) IBOutlet UILabel *s_FGthreeByFourView;
@property (nonatomic, retain) IBOutlet UILabel *s_FGfourByFourView;

@property (nonatomic) float mPositive;
@property (nonatomic) float mNegative;
@property (nonatomic) float dmPositive;
@property (nonatomic) float dmNegative;
@property (nonatomic) float s_mPositive;
@property (nonatomic) float s_mNegative;
@property (nonatomic) float s_dmPositive;
@property (nonatomic) float s_dmNegative;
@property (nonatomic, retain) IBOutlet UILabel *mPositiveView;
@property (nonatomic, retain) IBOutlet UILabel *mNegativeView;
@property (nonatomic, retain) IBOutlet UILabel *dmPositiveView;
@property (nonatomic, retain) IBOutlet UILabel *dmNegativeView;
@property (nonatomic, retain) IBOutlet UILabel *s_mPositiveView;
@property (nonatomic, retain) IBOutlet UILabel *s_mNegativeView;
@property (nonatomic, retain) IBOutlet UILabel *s_dmPositiveView;
@property (nonatomic, retain) IBOutlet UILabel *s_dmNegativeView;


@property (nonatomic) float averageStay;
@property (nonatomic) int minStay;
@property (nonatomic) int maxStay;
@property (nonatomic) float s_averageStay;
@property (nonatomic) int s_minStay;
@property (nonatomic) int s_maxStay;

@property (nonatomic, retain) IBOutlet UILabel *stayView;
@property (nonatomic, retain) IBOutlet UILabel *s_stayView;

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
@property (nonatomic) float s_Ileus;
@property (nonatomic) float s_BowelInjury;
@property (nonatomic) float s_Infection;
@property (nonatomic) float s_UrineLeak;
@property (nonatomic) float s_DVT;
@property (nonatomic) float s_PE;
@property (nonatomic) float s_CardiacEvent;
@property (nonatomic) float s_Hernia;
@property (nonatomic) float s_Transfusion;
@property (nonatomic) float s_Death;
@property (nonatomic) float s_OtherComp;

@property (nonatomic, retain) IBOutlet UILabel *IleusView;
@property (nonatomic, retain) IBOutlet UILabel *BowelInjuryView;
@property (nonatomic, retain) IBOutlet UILabel *InfectionView;
@property (nonatomic, retain) IBOutlet UILabel *UrineLeakView;
@property (nonatomic, retain) IBOutlet UILabel *DVTView;
@property (nonatomic, retain) IBOutlet UILabel *PEView;
@property (nonatomic, retain) IBOutlet UILabel *CardiacEventView;
@property (nonatomic, retain) IBOutlet UILabel *HerniaView;
@property (nonatomic, retain) IBOutlet UILabel *TransfusionView;
@property (nonatomic, retain) IBOutlet UILabel *DeathView;
@property (nonatomic, retain) IBOutlet UILabel *OtherCompView;
@property (nonatomic, retain) IBOutlet UILabel *s_IleusView;
@property (nonatomic, retain) IBOutlet UILabel *s_BowelInjuryView;
@property (nonatomic, retain) IBOutlet UILabel *s_InfectionView;
@property (nonatomic, retain) IBOutlet UILabel *s_UrineLeakView;
@property (nonatomic, retain) IBOutlet UILabel *s_DVTView;
@property (nonatomic, retain) IBOutlet UILabel *s_PEView;
@property (nonatomic, retain) IBOutlet UILabel *s_CardiacEventView;
@property (nonatomic, retain) IBOutlet UILabel *s_HerniaView;
@property (nonatomic, retain) IBOutlet UILabel *s_TransfusionView;
@property (nonatomic, retain) IBOutlet UILabel *s_DeathView;
@property (nonatomic, retain) IBOutlet UILabel *s_OtherCompView;

@property (nonatomic, retain) IBOutlet UIView *changeBUNView;
@property (nonatomic, retain) IBOutlet UILabel *changeTitle;
@property (nonatomic, retain) IBOutlet UILabel *bunView;
@property (nonatomic, retain) IBOutlet UILabel *s_bunView;

@property (nonatomic) float bunSum;
@property (nonatomic) float s_bunSum;
@property (nonatomic) float creatinineSum;
@property (nonatomic) float s_creatinineSum;

@property (nonatomic) float xrayPositive;
@property (nonatomic) float xrayNegative;
@property (nonatomic) float s_xrayPositive;
@property (nonatomic) float s_xrayNegative;

@property (nonatomic, retain) IBOutlet UILabel *xrayPositiveView;
@property (nonatomic, retain) IBOutlet UILabel *xrayNegativeView;
@property (nonatomic, retain) IBOutlet UILabel *s_xrayPositiveView;
@property (nonatomic, retain) IBOutlet UILabel *s_xrayNegativeView;

@property (nonatomic) float liverNormal;
@property (nonatomic) float liverAbNormal;
@property (nonatomic) float s_liverNormal;
@property (nonatomic) float s_liverAbNormal;

@property (nonatomic, retain) IBOutlet UILabel *liverNormalView;
@property (nonatomic, retain) IBOutlet UILabel *liverAbNormalView;
@property (nonatomic, retain) IBOutlet UILabel *s_liverNormalView;
@property (nonatomic, retain) IBOutlet UILabel *s_liverAbNormalView;

@property (nonatomic) float herniaYES;
@property (nonatomic) float herniaNO;
@property (nonatomic) float s_herniaYES;
@property (nonatomic) float s_herniaNO;

@property (nonatomic, retain) IBOutlet UILabel *herniaYESView;
@property (nonatomic, retain) IBOutlet UILabel *herniaNOView;
@property (nonatomic, retain) IBOutlet UILabel *s_herniaYESView;
@property (nonatomic, retain) IBOutlet UILabel *s_herniaNOView;

@property (nonatomic) float metastaticDisease;
@property (nonatomic) float LocalRecurrence;
@property (nonatomic) float Lymphadenopathy;
@property (nonatomic) float LiverMetastasis;
@property (nonatomic) float BoneMetastasis;
@property (nonatomic) float BrainMetastasis;

@property (nonatomic) float s_metastaticDisease;
@property (nonatomic) float s_LocalRecurrence;
@property (nonatomic) float s_Lymphadenopathy;
@property (nonatomic) float s_LiverMetastasis;
@property (nonatomic) float s_BoneMetastasis;
@property (nonatomic) float s_BrainMetastasis;

@property (nonatomic, retain) IBOutlet UILabel *metastaticDiseaseView;
@property (nonatomic, retain) IBOutlet UILabel *LocalRecurrenceView;
@property (nonatomic, retain) IBOutlet UILabel *LymphadenopathyView;
@property (nonatomic, retain) IBOutlet UILabel *LiverMetastasisView;
@property (nonatomic, retain) IBOutlet UILabel *BoneMetastasisView;
@property (nonatomic, retain) IBOutlet UILabel *BrainMetastasisView;

@property (nonatomic, retain) IBOutlet UILabel *s_metastaticDiseaseView;
@property (nonatomic, retain) IBOutlet UILabel *s_LocalRecurrenceView;
@property (nonatomic, retain) IBOutlet UILabel *s_LymphadenopathyView;
@property (nonatomic, retain) IBOutlet UILabel *s_LiverMetastasisView;
@property (nonatomic, retain) IBOutlet UILabel *s_BoneMetastasisView;
@property (nonatomic, retain) IBOutlet UILabel *s_BrainMetastasisView;

@property (nonatomic) float averageBun;
@property (nonatomic) float averageCreatinine;
@property (nonatomic) float s_averageBun;
@property (nonatomic) float s_averageCreatinine;
@property (nonatomic) float minCreatinine;
@property (nonatomic) float maxCreatinine;
@property (nonatomic) float minBun;
@property (nonatomic) float maxBun;
@property (nonatomic) float s_minCreatinine;
@property (nonatomic) float s_maxCreatinine;
@property (nonatomic) float s_minBun;
@property (nonatomic) float s_maxBun;

@property (nonatomic, retain) IBOutlet UILabel *averageLabel;
@property (nonatomic, retain) IBOutlet UILabel *s_averageLabel;
@property (nonatomic, retain) IBOutlet UILabel *averageViewTitleLabel;

@property (nonatomic, retain) IBOutlet UILabel *TNMNationalSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *TNMSurgeonSampleSize;

@property (nonatomic, retain) IBOutlet UILabel *TCNationalSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *TCSurgeonSampleSize;

@property (nonatomic, retain) IBOutlet UILabel *XRNationalSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *XRSurgeonSampleSize;

@property (nonatomic, retain) IBOutlet UILabel *FGNationalSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *FGSurgeonSampleSize;

@property (nonatomic, retain) IBOutlet UILabel *MNationalSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *MSurgeonSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *DMNationalSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *DMSurgeonSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *NNationalSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *NSurgeonSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *CNationalSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *CSurgeonSampleSize;

@property (nonatomic, retain) IBOutlet UILabel *BUNNationalSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *BUNSurgeonSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *LNationalSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *LSurgeonSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *HNationalSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *HSurgeonSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *CTNationalSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *CTSurgeonSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *AVNationalSampleSize;
@property (nonatomic, retain) IBOutlet UILabel *AVSurgeonSampleSize;

@property (nonatomic)int NationalSize;
@property (nonatomic)int SurgeonSize;

@end
