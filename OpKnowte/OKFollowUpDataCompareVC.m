//
//  OKFollowUpDataCompareVC.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/19/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKFollowUpDataCompareVC.h"

@interface OKFollowUpDataCompareVC ()

@end

@implementation OKFollowUpDataCompareVC
@synthesize TNMStagingView, graphView, T0, T1, T1a,T1b, T4, T3c, T3b, T3a, T3, Tx, T2b, T2, T2a, N, N0, N1, Nx, M, M0, M1, TxAge, T4Age, T3cAge, T0Age, T1aAge, T1Age, T1bAge,T2aAge,T2Age,T2bAge,T3aAge,T3Age,T3bAge,N0Age,N1Age,NAge,NxAge, MAge, M0Age,M1Age;
@synthesize s_T0, s_T1, s_T1a, s_T1b, s_T4, s_T3c, s_T3b, s_T3a, s_T3, s_Tx, s_T2b, s_T2, s_T2a, s_N, s_N0, s_N1, s_Nx, s_M, s_M0, s_M1, s_TxAge, s_T4Age, s_T3cAge, s_T0Age, s_T1aAge, s_T1Age, s_T1bAge, s_T2aAge, s_T2Age, s_T2bAge, s_T3aAge, s_T3Age, s_T3bAge, s_N0Age, s_N1Age, s_NAge, s_NxAge, s_MAge, s_M0Age, s_M1Age;

@synthesize Chromophobe,ClearAll,Papillary,Sarcomatoid,angiomyolipoma,other,oncocytoma;
@synthesize ChromophobeView,ClearAllView,PapillaryView,SarcomatoidView,angiomyolipomaView,otherView,oncocytomaView;
@synthesize s_ChromophobeView,s_ClearAllView,s_PapillaryView,s_SarcomatoidView,s_angiomyolipomaView,s_otherView,s_oncocytomaView;

@synthesize FGoneByFour, FGfourByFour, FGthreeByFour, FGtwoByFour, FGradeView, FGfourByFourView, FGoneByFourView, FGthreeByFourView, FGtwoByFourView;
@synthesize s_FGoneByFour, s_FGfourByFour, s_FGthreeByFour, s_FGtwoByFour, s_FGfourByFourView, s_FGoneByFourView, s_FGthreeByFourView, s_FGtwoByFourView;

@synthesize mPositive, mNegative, dmPositive, dmNegative, mPositiveView, mNegativeView, dmNegativeView, dmPositiveView, marginsView, DMarginView;
@synthesize s_mPositive, s_mNegative, s_dmPositive, s_dmNegative, s_mPositiveView, s_mNegativeView, s_dmNegativeView, s_dmPositiveView;

@synthesize averageStay,minStay,maxStay,s_averageStay,s_minStay,s_maxStay,stayView,s_stayView;

@synthesize Ileus, IleusView, Transfusion, TransfusionView, BowelInjury, BowelInjuryView, Infection, InfectionView, UrineLeak, UrineLeakView, Death, DeathView, DVT, DVTView, PE, PEView, OtherComp, OtherCompView, Hernia, HerniaView, CardiacEvent, CardiacEventView, complicationsGraph;
@synthesize s_Ileus, s_IleusView, s_Transfusion, s_TransfusionView, s_BowelInjury, s_BowelInjuryView, s_Infection, s_InfectionView, s_UrineLeak, s_UrineLeakView, s_Death, s_DeathView, s_DVT, s_DVTView, s_PE, s_PEView, s_OtherComp, s_OtherCompView, s_Hernia, s_HerniaView, s_CardiacEvent, s_CardiacEventView;

@synthesize changeBUNView,bunView,s_bunView,bunSum,s_bunSum,creatinineSum,s_creatinineSum,changeTitle, FGNationalSampleSize, FGSurgeonSampleSize;

@synthesize xrayNegative, xrayPositive, xrayNegativeView, xrayPositiveView, xrayGraph;
@synthesize s_xrayNegative, s_xrayPositive, s_xrayNegativeView, s_xrayPositiveView;

@synthesize liverAbNormal, liverAbNormalView, liverNormal, liverNormalView, liverGraph;
@synthesize s_liverAbNormal, s_liverAbNormalView, s_liverNormal, s_liverNormalView;

@synthesize herniaGraph, herniaNO, herniaNOView, herniaYES, herniaYESView;
@synthesize s_herniaNO, s_herniaNOView, s_herniaYES, s_herniaYESView;

@synthesize CtScanGraph, LiverMetastasis, LiverMetastasisView, LocalRecurrence, LocalRecurrenceView, Lymphadenopathy,LymphadenopathyView, BoneMetastasis, BoneMetastasisView, BrainMetastasis, BrainMetastasisView, metastaticDisease, metastaticDiseaseView;
@synthesize s_LiverMetastasis, s_LiverMetastasisView, s_LocalRecurrence, s_LocalRecurrenceView, s_Lymphadenopathy,s_LymphadenopathyView, s_BoneMetastasis, s_BoneMetastasisView, s_BrainMetastasis, s_BrainMetastasisView, s_metastaticDisease, s_metastaticDiseaseView;

@synthesize averageBun,averageCreatinine,averageView,averageLabel,averageViewTitleLabel,s_averageBun,s_averageCreatinine,s_averageLabel,minBun,minCreatinine,s_minBun,s_minCreatinine,maxBun,maxCreatinine,s_maxBun,s_maxCreatinine;

@synthesize TNMNationalSampleSize, TNMSurgeonSampleSize, TCNationalSampleSize, TCSurgeonSampleSize, XRNationalSampleSize, XRSurgeonSampleSize, MNationalSampleSize, MSurgeonSampleSize, DMNationalSampleSize, DMSurgeonSampleSize, NNationalSampleSize,NSurgeonSampleSize, CNationalSampleSize,CSurgeonSampleSize, BUNNationalSampleSize,BUNSurgeonSampleSize, LNationalSampleSize,LSurgeonSampleSize, HNationalSampleSize,HSurgeonSampleSize, CTNationalSampleSize,CTSurgeonSampleSize, AVNationalSampleSize,AVSurgeonSampleSize;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
}
- (void)backButton {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"Follow Up Data";
    [self addLeftButtonToNavbar];

    if ([self.graphView isEqualToString:@"TNM"]) {
        [self showTMGGraph];
    }else if ([self.graphView isEqualToString:@"tumorCh"]){
        [self showTumorChGraph];
    }else if ([self.graphView isEqualToString:@"FGrade"]){
        [self showFGGraph];
    }else if ([self.graphView isEqualToString:@"margins"]){
        [self showMarginsGraph];
    }else if ([self.graphView isEqualToString:@"dMargin"]){
        [self showDMarginsGraph];
    }else if([self.graphView isEqualToString:@"nights"]){
        [self showNights];
    }else if([self.graphView isEqualToString:@"complications"]){
        [self showComplicationsGraph];
    }else if([self.graphView isEqualToString:@"BUN"]){
        [self showChangeBUNGraph];
    }else if([self.graphView isEqualToString:@"Creatinine"]){
        [self showChangeCreatinineGraph];
    }else if([self.graphView isEqualToString:@"xray"]){
        [self showXrayGraph];
    }else if([self.graphView isEqualToString:@"liver"]){
        [self showLiverGraph];
    }else if([self.graphView isEqualToString:@"hernia"]){
        [self showHerniaGraph];
    }else if([self.graphView isEqualToString:@"CTScan"]){
        [self showCTScanGraph];
    }else if([self.graphView isEqualToString:@"AverageCreatinine"]){
        [self showAverageCreatinineGraph];
    }else if([self.graphView isEqualToString:@"AverageBUN"]){
        [self showAverageBUNGraph];
    }
}
-(void)showTMGGraph{
    
    if (IS_IPHONE_5) {
        
        CGRect frame = self.TNMStagingView.frame;
        frame.origin.y = 57;
        [self.TNMStagingView setFrame:frame];
        
    }else{
        CGRect frame = self.TNMStagingView.frame;
        frame.origin.y = 45;
        [self.TNMStagingView setFrame:frame];
    }
    
    NSLog(@"%i",self.NationalSize);
    NSLog(@"%i",self.SurgeonSize);
    
    [self.TNMNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.TNMSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    [self.Tx setText:[NSString stringWithFormat:@"Tx = %.0f %%",self.TxAge]];
    [self.T0 setText:[NSString stringWithFormat:@"T0 = %.0f %%",self.T0Age]];
    [self.T1 setText:[NSString stringWithFormat:@"T1 = %.0f %%",self.T1Age]];
    [self.T1a setText:[NSString stringWithFormat:@"T1a = %.0f %%",self.T1aAge]];
    [self.T1b setText:[NSString stringWithFormat:@"T1b = %.0f %%",self.T1bAge]];
    [self.T2 setText:[NSString stringWithFormat:@"T2 = %.0f %%",self.T2Age]];
    [self.T2a setText:[NSString stringWithFormat:@"T2a = %.0f %%",self.T2aAge]];
    [self.T2b setText:[NSString stringWithFormat:@"T2b = %.0f %%",self.T2bAge]];
    [self.T3 setText:[NSString stringWithFormat:@"T3 = %.0f %%",self.T3Age]];
    [self.T3a setText:[NSString stringWithFormat:@"T3a = %.0f %%",self.T3aAge]];
    [self.T3b setText:[NSString stringWithFormat:@"T3b = %.0f %%",self.T3bAge]];
    [self.T3c setText:[NSString stringWithFormat:@"T3c = %.0f %%",self.T3cAge]];
    [self.T4 setText:[NSString stringWithFormat:@"T4 = %.0f %%",self.T4Age]];
    [self.N setText:[NSString stringWithFormat:@"N = %.0f %%",self.NAge]];
    [self.Nx setText:[NSString stringWithFormat:@"Nx = %.0f %%",self.NxAge]];
    [self.N0 setText:[NSString stringWithFormat:@"N0 = %.0f %%",self.N0Age]];
    [self.N1 setText:[NSString stringWithFormat:@"N1 = %.0f %%",self.N1Age]];
    [self.M setText:[NSString stringWithFormat:@"M = %.0f %%",self.MAge]];
    [self.M0 setText:[NSString stringWithFormat:@"M0 = %.0f %%",self.M0Age]];
    [self.M1 setText:[NSString stringWithFormat:@"M1 = %.0f %%",self.M1Age]];
    
    [self.s_Tx setText:[NSString stringWithFormat:@"Tx = %.0f %%",self.s_TxAge]];
    [self.s_T0 setText:[NSString stringWithFormat:@"T0 = %.0f %%",self.s_T0Age]];
    [self.s_T1 setText:[NSString stringWithFormat:@"T1 = %.0f %%",self.s_T1Age]];
    [self.s_T1a setText:[NSString stringWithFormat:@"T1a = %.0f %%",self.s_T1aAge]];
    [self.s_T1b setText:[NSString stringWithFormat:@"T1b = %.0f %%",self.s_T1bAge]];
    [self.s_T2 setText:[NSString stringWithFormat:@"T2 = %.0f %%",self.s_T2Age]];
    [self.s_T2a setText:[NSString stringWithFormat:@"T2a = %.0f %%",self.s_T2aAge]];
    [self.s_T2b setText:[NSString stringWithFormat:@"T2b = %.0f %%",self.s_T2bAge]];
    [self.s_T3 setText:[NSString stringWithFormat:@"T3 = %.0f %%",self.s_T3Age]];
    [self.s_T3a setText:[NSString stringWithFormat:@"T3a = %.0f %%",self.s_T3aAge]];
    [self.s_T3b setText:[NSString stringWithFormat:@"T3b = %.0f %%",self.s_T3bAge]];
    [self.s_T3c setText:[NSString stringWithFormat:@"T3c = %.0f %%",self.s_T3cAge]];
    [self.s_T4 setText:[NSString stringWithFormat:@"T4 = %.0f %%",self.s_T4Age]];
    [self.s_N setText:[NSString stringWithFormat:@"N = %.0f %%",self.s_NAge]];
    [self.s_Nx setText:[NSString stringWithFormat:@"Nx = %.0f %%",self.s_NxAge]];
    [self.s_N0 setText:[NSString stringWithFormat:@"N0 = %.0f %%",self.s_N0Age]];
    [self.s_N1 setText:[NSString stringWithFormat:@"N1 = %.0f %%",self.s_N1Age]];
    [self.s_M setText:[NSString stringWithFormat:@"M = %.0f %%",self.s_MAge]];
    [self.s_M0 setText:[NSString stringWithFormat:@"M0 = %.0f %%",self.s_M0Age]];
    [self.s_M1 setText:[NSString stringWithFormat:@"M1 = %.0f %%",self.s_M1Age]];
    [self.view addSubview:self.TNMStagingView];
    
}

-(void)showTumorChGraph{
    if (IS_IPHONE_5) {
        
        CGRect frame = self.tumorChView.frame;
        frame.origin.y = 57;
        [self.tumorChView setFrame:frame];
        
    }else{
        CGRect frame = self.tumorChView.frame;
        frame.origin.y = 45;
        [self.tumorChView setFrame:frame];
    }
    
    [self.TCNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.TCSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    [self.ClearAllView setText:[NSString stringWithFormat:@"Clear Cell = %.0f %%",self.ClearAll]];
    [self.PapillaryView setText:[NSString stringWithFormat:@"Papillary = %.0f %%",self.Papillary]];
    [self.ChromophobeView setText:[NSString stringWithFormat:@"Chromophobe = %.0f %%",self.Chromophobe]];
    [self.SarcomatoidView setText:[NSString stringWithFormat:@"Sarcomatoid = %.0f %%",self.Sarcomatoid]];
    [self.angiomyolipomaView setText:[NSString stringWithFormat:@"Angiomyolipoma = %.0f %%",self.angiomyolipoma]];
    [self.oncocytomaView setText:[NSString stringWithFormat:@"Oncocytoma = %.0f %%",self.oncocytoma]];
    [self.otherView setText:[NSString stringWithFormat:@"Other = %.0f %%",self.other]];
    
    [self.s_ClearAllView setText:[NSString stringWithFormat:@"Clear Cell = %.0f %%",self.s_ClearAll]];
    [self.s_PapillaryView setText:[NSString stringWithFormat:@"Papillary = %.0f %%",self.s_Papillary]];
    [self.s_ChromophobeView setText:[NSString stringWithFormat:@"Chromophobe = %.0f %%",self.s_Chromophobe]];
    [self.s_SarcomatoidView setText:[NSString stringWithFormat:@"Sarcomatoid = %.0f %%",self.s_Sarcomatoid]];
    [self.s_angiomyolipomaView setText:[NSString stringWithFormat:@"Angiomyolipoma = %.0f %%",self.s_angiomyolipoma]];
    [self.s_oncocytomaView setText:[NSString stringWithFormat:@"Oncocytoma = %.0f %%",self.s_oncocytoma]];
    [self.s_otherView setText:[NSString stringWithFormat:@"Other = %.0f %%",self.s_other]];
    
    [self.view addSubview:self.tumorChView];
}

-(void)showFGGraph{
    if (IS_IPHONE_5) {
        
        CGRect frame = self.FGradeView.frame;
        frame.origin.y = 57;
        [self.FGradeView setFrame:frame];
        
    }else{
        CGRect frame = self.FGradeView.frame;
        frame.origin.y = 45;
        [self.FGradeView setFrame:frame];
    }
    
    [self.FGNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.FGSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    [self.FGoneByFourView setText:[NSString stringWithFormat:@" 1/4 = %.0f %%",self.FGoneByFour]];
    [self.FGtwoByFourView setText:[NSString stringWithFormat:@" 2/4 = %.0f %%",self.FGtwoByFour]];
    [self.FGthreeByFourView setText:[NSString stringWithFormat:@" 3/4 = %.0f %%",self.FGthreeByFour]];
    [self.FGfourByFourView setText:[NSString stringWithFormat:@" 4/4 = %.0f %%",self.FGfourByFour]];
    [self.s_FGoneByFourView setText:[NSString stringWithFormat:@" 1/4 = %.0f %%",self.s_FGoneByFour]];
    [self.s_FGtwoByFourView setText:[NSString stringWithFormat:@" 2/4 = %.0f %%",self.s_FGtwoByFour]];
    [self.s_FGthreeByFourView setText:[NSString stringWithFormat:@" 3/4 = %.0f %%",self.s_FGthreeByFour]];
    [self.s_FGfourByFourView setText:[NSString stringWithFormat:@" 4/4 = %.0f %%",self.s_FGfourByFour]];
    
    [self.view addSubview:self.FGradeView];
}

-(void)showMarginsGraph{
    
    if (IS_IPHONE_5) {
        
        CGRect frame = self.marginsView.frame;
        frame.origin.y = 57;
        [self.marginsView setFrame:frame];
        
    }else{
        CGRect frame = self.marginsView.frame;
        frame.origin.y = 45;
        [self.marginsView setFrame:frame];
    }
    
    [self.MNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.MSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    [self.mPositiveView setText:[NSString stringWithFormat:@" Positive = %.0f %%",self.mPositive]];
    [self.mNegativeView setText:[NSString stringWithFormat:@" Negative = %.0f %%",self.mNegative]];
    [self.s_mPositiveView setText:[NSString stringWithFormat:@" Positive = %.0f %%",self.s_mPositive]];
    [self.s_mNegativeView setText:[NSString stringWithFormat:@" Negative = %.0f %%",self.s_mNegative]];
    
    [self.view addSubview:self.marginsView];
}

-(void)showDMarginsGraph{
    
    if (IS_IPHONE_5) {
        
        CGRect frame = self.DMarginView.frame;
        frame.origin.y = 57;
        [self.DMarginView setFrame:frame];
        
    }else{
        CGRect frame = self.DMarginView.frame;
        frame.origin.y = 45;
        [self.DMarginView setFrame:frame];
    }
    
    [self.DMNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.DMSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    
    [self.dmPositiveView setText:[NSString stringWithFormat:@" Positive = %.0f %%",self.dmPositive]];
    [self.dmNegativeView setText:[NSString stringWithFormat:@" Negative = %.0f %%",self.dmNegative]];
    [self.s_dmPositiveView setText:[NSString stringWithFormat:@" Positive = %.0f %%",self.s_dmPositive]];
    [self.s_dmNegativeView setText:[NSString stringWithFormat:@" Negative = %.0f %%",self.s_dmNegative]];
    
    [self.view addSubview:self.DMarginView];
}

-(void)showNights{
    
    if (IS_IPHONE_5) {
        
        CGRect frame = self.nightsGraph.frame;
        frame.origin.y = 57;
        [self.nightsGraph setFrame:frame];
        
    }else{
        CGRect frame = self.nightsGraph.frame;
        frame.origin.y = 45;
        [self.nightsGraph setFrame:frame];
    }
    
    [self.NNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.NSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    [self.stayView setText:[NSString stringWithFormat:@" Average Stay = %.1f ( %i to %i)",self.averageStay,minStay,maxStay]];
    [self.s_stayView setText:[NSString stringWithFormat:@" Average Stay = %.1f ( %i to %i)",self.s_averageStay,s_minStay,s_maxStay]];
    [self.view addSubview:self.nightsGraph];
}

-(void)showComplicationsGraph{
    if (IS_IPHONE_5) {
        
        CGRect frame = self.complicationsGraph.frame;
        frame.origin.y = 57;
        [self.complicationsGraph setFrame:frame];
        
    }else{
        CGRect frame = self.complicationsGraph.frame;
        frame.origin.y = 45;
        [self.complicationsGraph setFrame:frame];
    }
    
    [self.CNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.CSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    [self.IleusView setText:[NSString stringWithFormat:@"Ileus = %.0f %%",self.Ileus]];
    [self.BowelInjuryView setText:[NSString stringWithFormat:@"Bowel Injury = %.0f %%",self.BowelInjury]];
    [self.InfectionView setText:[NSString stringWithFormat:@"Infection = %.0f %%",self.Infection]];
    [self.UrineLeakView setText:[NSString stringWithFormat:@"Urine Leak = %.0f %%",self.UrineLeak]];
    [self.DVTView setText:[NSString stringWithFormat:@"DVT = %.0f %%",self.DVT]];
    [self.PEView setText:[NSString stringWithFormat:@"PE = %.0f %%",self.PE]];
    [self.CardiacEventView setText:[NSString stringWithFormat:@"Cardiac Event = %.0f %%",self.CardiacEvent]];
    
    [self.HerniaView setText:[NSString stringWithFormat:@"Hernia = %.0f %%",self.Hernia]];
    [self.TransfusionView setText:[NSString stringWithFormat:@"Transfusion = %.0f %%",self.Transfusion]];
    [self.DeathView setText:[NSString stringWithFormat:@"Death = %.0f %%",self.Death]];
    [self.OtherCompView setText:[NSString stringWithFormat:@"Other = %.0f %%",self.OtherComp]];
    
    [self.s_IleusView setText:[NSString stringWithFormat:@"Ileus = %.0f %%",self.s_Ileus]];
    [self.s_BowelInjuryView setText:[NSString stringWithFormat:@"Bowel Injury = %.0f %%",self.s_BowelInjury]];
    [self.s_InfectionView setText:[NSString stringWithFormat:@"Infection = %.0f %%",self.s_Infection]];
    [self.s_UrineLeakView setText:[NSString stringWithFormat:@"Urine Leak = %.0f %%",self.s_UrineLeak]];
    [self.s_DVTView setText:[NSString stringWithFormat:@"DVT = %.0f %%",self.s_DVT]];
    [self.s_PEView setText:[NSString stringWithFormat:@"PE = %.0f %%",self.s_PE]];
    [self.s_CardiacEventView setText:[NSString stringWithFormat:@"Cardiac Event = %.0f %%",self.s_CardiacEvent]];
    
    [self.s_HerniaView setText:[NSString stringWithFormat:@"Hernia = %.0f %%",self.s_Hernia]];
    [self.s_TransfusionView setText:[NSString stringWithFormat:@"Transfusion = %.0f %%",self.s_Transfusion]];
    [self.s_DeathView setText:[NSString stringWithFormat:@"Death = %.0f %%",self.s_Death]];
    [self.s_OtherCompView setText:[NSString stringWithFormat:@"Other = %.0f %%",self.s_OtherComp]];
    
    [self.view addSubview:self.complicationsGraph];
}

-(void)showChangeBUNGraph{
    changeTitle.text = @"Change in BUN";
    if (IS_IPHONE_5) {
        
        CGRect frame = self.changeBUNView.frame;
        frame.origin.y = 57;
        [self.changeBUNView setFrame:frame];
        
    }else{
        CGRect frame = self.changeBUNView.frame;
        frame.origin.y = 45;
        [self.changeBUNView setFrame:frame];
    }
    
    [self.BUNNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.BUNSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    [self.bunView setText:[NSString stringWithFormat:@"Average Change = %.1f ",self.bunSum]];
    [self.s_bunView setText:[NSString stringWithFormat:@"Average Change = %.1f ",self.s_bunSum]];
    [self.view addSubview:self.changeBUNView];
}

-(void)showChangeCreatinineGraph{
    changeTitle.text = @"Change in Creatinine";
    if (IS_IPHONE_5) {
        
        CGRect frame = self.changeBUNView.frame;
        frame.origin.y = 57;
        [self.changeBUNView setFrame:frame];
        
    }else{
        CGRect frame = self.changeBUNView.frame;
        frame.origin.y = 45;
        [self.changeBUNView setFrame:frame];
    }
    
    [self.BUNNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.BUNSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    [self.bunView setText:[NSString stringWithFormat:@"Average Change = %.1f ",self.creatinineSum]];
    [self.s_bunView setText:[NSString stringWithFormat:@"Average Change = %.1f ",self.s_creatinineSum]];
    [self.view addSubview:self.changeBUNView];
}
-(void)showXrayGraph{
    if (IS_IPHONE_5) {
        
        CGRect frame = self.xrayGraph.frame;
        frame.origin.y = 57;
        [self.xrayGraph setFrame:frame];
        
    }else{
        CGRect frame = self.xrayGraph.frame;
        frame.origin.y = 45;
        [self.xrayGraph setFrame:frame];
    }
    
    [self.XRNationalSampleSize setText:[NSString stringWithFormat:@"(N = %i)",self.NationalSize]];
    [self.XRSurgeonSampleSize setText:[NSString stringWithFormat:@"(N = %i)",self.SurgeonSize]];
    
    [self.xrayNegativeView setText:[NSString stringWithFormat:@"Negative = %.0f %%",self.xrayNegative]];
    [self.xrayPositiveView setText:[NSString stringWithFormat:@"Positive = %.0f %%",self.xrayPositive]];
    [self.s_xrayNegativeView setText:[NSString stringWithFormat:@"Negative = %.0f %%",self.s_xrayNegative]];
    [self.s_xrayPositiveView setText:[NSString stringWithFormat:@"Positive = %.0f %%",self.s_xrayPositive]];
    [self.view addSubview:self.xrayGraph];
}

-(void)showLiverGraph{
    if (IS_IPHONE_5) {
        
        CGRect frame = self.liverGraph.frame;
        frame.origin.y = 57;
        [self.liverGraph setFrame:frame];
        
    }else{
        CGRect frame = self.liverGraph.frame;
        frame.origin.y = 45;
        [self.liverGraph setFrame:frame];
    }
    
    [self.LNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.LSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    [self.liverAbNormalView setText:[NSString stringWithFormat:@"Abnormal = %.0f %%",self.liverAbNormal]];
    [self.liverNormalView setText:[NSString stringWithFormat:@"Normal = %.0f %%",self.liverNormal]];
    [self.s_liverAbNormalView setText:[NSString stringWithFormat:@"Abnormal = %.0f %%",self.s_liverAbNormal]];
    [self.s_liverNormalView setText:[NSString stringWithFormat:@"Normal = %.0f %%",self.s_liverNormal]];
    [self.view addSubview:self.liverGraph];
}

-(void)showHerniaGraph{
    if (IS_IPHONE_5) {
        
        CGRect frame = self.herniaGraph.frame;
        frame.origin.y = 57;
        [self.herniaGraph setFrame:frame];
        
    }else{
        CGRect frame = self.herniaGraph.frame;
        frame.origin.y = 45;
        [self.herniaGraph setFrame:frame];
    }
    
    [self.HNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.HSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    [self.herniaYESView setText:[NSString stringWithFormat:@"YES = %.0f %%",self.herniaYES]];
    [self.herniaNOView setText:[NSString stringWithFormat:@"NO = %.0f %%",self.herniaNO]];
    [self.s_herniaYESView setText:[NSString stringWithFormat:@"YES = %.0f %%",self.s_herniaYES]];
    [self.s_herniaNOView setText:[NSString stringWithFormat:@"NO = %.0f %%",self.s_herniaNO]];
    [self.view addSubview:self.herniaGraph];
}

-(void)showCTScanGraph{
    if (IS_IPHONE_5) {
        
        CGRect frame = self.CtScanGraph.frame;
        frame.origin.y = 57;
        [self.CtScanGraph setFrame:frame];
        
    }else{
        CGRect frame = self.CtScanGraph.frame;
        frame.origin.y = 45;
        [self.CtScanGraph setFrame:frame];
    }
    
    [self.CTNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.CTSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    [self.metastaticDiseaseView setText:[NSString stringWithFormat:@"Metastatic Disease = %.0f %%",self.metastaticDisease]];
    [self.LocalRecurrenceView setText:[NSString stringWithFormat:@"Local Recurrence = %.0f %%",self.LocalRecurrence]];
    [self.LymphadenopathyView setText:[NSString stringWithFormat:@"Lymphadenopathy = %.0f %%",self.Lymphadenopathy]];
    [self.LiverMetastasisView setText:[NSString stringWithFormat:@"Liver Matastasis = %.0f %%",self.LiverMetastasis]];
    [self.BoneMetastasisView setText:[NSString stringWithFormat:@"Bone Matastasis = %.0f %%",self.BoneMetastasis]];
    [self.BrainMetastasisView setText:[NSString stringWithFormat:@"Brain Matastasis = %.0f %%",self.BrainMetastasis]];
    
    [self.s_metastaticDiseaseView setText:[NSString stringWithFormat:@"Metastatic Disease = %.0f %%",self.s_metastaticDisease]];
    [self.s_LocalRecurrenceView setText:[NSString stringWithFormat:@"Local Recurrence = %.0f %%",self.s_LocalRecurrence]];
    [self.s_LymphadenopathyView setText:[NSString stringWithFormat:@"Lymphadenopathy = %.0f %%",self.s_Lymphadenopathy]];
    [self.s_LiverMetastasisView setText:[NSString stringWithFormat:@"Liver Matastasis = %.0f %%",self.s_LiverMetastasis]];
    [self.s_BoneMetastasisView setText:[NSString stringWithFormat:@"Bone Matastasis = %.0f %%",self.s_BoneMetastasis]];
    [self.s_BrainMetastasisView setText:[NSString stringWithFormat:@"Brain Matastasis = %.0f %%",self.s_BrainMetastasis]];
    
    [self.view addSubview:self.CtScanGraph];
}

-(void)showAverageCreatinineGraph{
    averageViewTitleLabel.text = @"Average Creatinine";
    
    if (IS_IPHONE_5) {
        
        CGRect frame = self.averageView.frame;
        frame.origin.y = 57;
        [self.averageView setFrame:frame];
        
    }else{
        CGRect frame = self.averageView.frame;
        frame.origin.y = 45;
        [self.averageView setFrame:frame];
    }
    
    [self.AVNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.AVSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    [self.averageLabel setText:[NSString stringWithFormat:@"Average Creatinine = %.1f",self.averageCreatinine]];
    [self.s_averageLabel setText:[NSString stringWithFormat:@"Average Creatinine = %.1f",self.s_averageCreatinine]];
    
    [self.view addSubview:self.averageView];
}

-(void)showAverageBUNGraph{
    averageViewTitleLabel.text = @"Average BUN";
    if (IS_IPHONE_5) {
        
        CGRect frame = self.averageView.frame;
        frame.origin.y = 57;
        [self.averageView setFrame:frame];
        
    }else{
        CGRect frame = self.averageView.frame;
        frame.origin.y = 45;
        [self.averageView setFrame:frame];
    }
    
    [self.AVNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.AVSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    [self.averageLabel setText:[NSString stringWithFormat:@"Average BUN = %.1f",self.averageBun]];
    [self.s_averageLabel setText:[NSString stringWithFormat:@"Average BUN = %.1f",self.s_averageBun]];
    
    [self.view addSubview:self.averageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
