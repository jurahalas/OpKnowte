//
//  UCSurgeonPerformanceGraphs.m
//  MZUroCapture
//
//  Created by Atif Joyia on 21/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSurgeonPerformanceGraphs.h"
#import "UCSettingsViewController.h"
#import "UCHomeScreenViewController.h"
@interface UCSurgeonPerformanceGraphs ()

@end

@implementation UCSurgeonPerformanceGraphs

@synthesize graphView;
@synthesize TNMStagingView, T0, T1, T1a,T1b, T4, T3c, T3b, T3a, T3, Tx, T2b, T2, T2a, N, N0, N1, Nx, M, M0, M1, TxAge, T4Age, T3cAge, T0Age, T1aAge, T1Age, T1bAge,T2aAge,T2Age,T2bAge,T3aAge,T3Age,T3bAge,N0Age,N1Age,NAge,NxAge, MAge, M0Age,M1Age;
@synthesize Chromophobe,ClearAll,Papillary,Sarcomatoid,angiomyolipoma,other,oncocytoma;
@synthesize FGoneByFour, FGfourByFour, FGthreeByFour, FGtwoByFour, FGradeView, FGfourByFourView, FGoneByFourView, FGthreeByFourView, FGtwoByFourView;
@synthesize mPositive, mNegative, dmPositive, dmNegative, mPositiveView, mNegativeView, dmNegativeView, dmPositiveView, marginsView, DMarginView;

@synthesize averageStay,minStay,maxStay;

@synthesize Ileus, IleusView, Transfusion, TransfusionView, BowelInjury, BowelInjuryView, Infection, InfectionView, UrineLeak, UrineLeakView, Death, DeathView, DVT, DVTView, PE, PEView, OtherComp, OtherCompView, Hernia, HerniaView, CardiacEvent, CardiacEventView, complicationsGraph;

@synthesize xrayNegative, xrayPositive, xrayNegativeView, xrayPositiveView, xrayGraph;
@synthesize liverAbNormal, liverAbNormalView, liverNormal, liverNormalView, liverGraph;
@synthesize herniaGraph, herniaNO, herniaNOView, herniaYES, herniaYESView;
@synthesize CtScanGraph, LiverMetastasis, LiverMetastasisView, LocalRecurrence, LocalRecurrenceView, Lymphadenopathy,LymphadenopathyView, BoneMetastasis, BoneMetastasisView, BrainMetastasis, BrainMetastasisView, metastaticDisease, metastaticDiseaseView;

@synthesize bunSum,minBun,maxBun,minCreatinine,maxCreatinine,creatinineSum,bunView,changeBUNView,changeTitleLabel,unitLabel,xLabel;
@synthesize averageBun,averageCreatinine;

@synthesize averageView,averageViewTitleLabel,oneLabel,twoLabel;
@synthesize maxSampleSize;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (IS_IPHONE_5) {
        l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    
    [sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.maxSampleSize]];
    
    if ([self.graphView isEqualToString:@"TNM"]) {
        [self showTMGGraph];
    }else if ([self.graphView isEqualToString:@"tumorCh"]){
        [self showTumorChGraph];
    }else if ([self.graphView isEqualToString:@"FGrade"]){
        [self showFGGraph];
    }else if ([self.graphView isEqualToString:@"margins"]){
        [self showMarginsGraph];
    }else if ([self.graphView isEqualToString:@"dMargin"]){
        [self showDMarginGraph];
    }else if ([self.graphView isEqualToString:@"nights"]){
        [self showNights];
    }else if ([self.graphView isEqualToString:@"complications"]){
        [self showComplications];
    }else if ([self.graphView isEqualToString:@"xray"]){
        [self showXrayGraph];
    }else if ([self.graphView isEqualToString:@"liver"]){
        [self showLiverGraph];
    }else if ([self.graphView isEqualToString:@"hernia"]){
        [self showHerniaGraph];
    }else if ([self.graphView isEqualToString:@"CTScan"]){
        [self showCTScanGraph];
    }else if ([self.graphView isEqualToString:@"BUN"]){
        [self showBUNGraph];
    }else if ([self.graphView isEqualToString:@"Creatinine"]){
        [self showCreatinineGraph];
    }else if ([self.graphView isEqualToString:@"AverageCreatinine"]){
        [self showAverageCreatinineGraph];
    }else if ([self.graphView isEqualToString:@"AverageBUN"]){
        [self showAverageBUNGraph];
    }
    
    
}


-(float)barStart:(int)percentage{
    NSLog(@"%i",percentage);
    float y;
    y = 24 - ((100 - percentage) * 2.66);
    return y;
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
    
    CGRect tFrame = self.Tx.frame;
    if (TxAge > 0) {
        tFrame.origin.y = tFrame.origin.y - (TxAge * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (TxAge * 2.66) + 20;
    }
    self.Tx.frame = tFrame;
    
    tFrame = self.T0.frame;
    if (T0Age > 0) {
        tFrame.origin.y = tFrame.origin.y - (T0Age * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (T0Age * 2.66) + 20;
    }
    self.T0.frame = tFrame;
    
    tFrame = self.T1.frame;
    if (T1Age > 0) {
        tFrame.origin.y = tFrame.origin.y - (T1Age * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (T1Age * 2.66) + 20;
    }
    self.T1.frame = tFrame;
    
    tFrame = self.T1a.frame;
    if (T1aAge > 0) {
        tFrame.origin.y = tFrame.origin.y - (T1aAge * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (T1aAge * 2.66) + 20;
    }
    self.T1a.frame = tFrame;
    
    tFrame = self.T1b.frame;
    if (T1bAge > 0) {
        tFrame.origin.y = tFrame.origin.y - (T1bAge * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (T1bAge * 2.66) + 20;
    }
    
    self.T1b.frame = tFrame;
    
    tFrame = self.T2.frame;
    if (T2Age > 0) {
        tFrame.origin.y = tFrame.origin.y - (T2Age * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (T2Age * 2.66) + 20;
    }
    
    self.T2.frame = tFrame;
    
    tFrame = self.T2a.frame;
    if (T2aAge > 0) {
        tFrame.origin.y = tFrame.origin.y - (T2aAge * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (T2aAge * 2.66) + 20;
    }
    
    self.T2a.frame = tFrame;
    
    tFrame = self.T2b.frame;
    if (T2bAge > 0) {
        tFrame.origin.y = tFrame.origin.y - (T2bAge * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (T2bAge * 2.66) + 20;
    }
    
    self.T2b.frame = tFrame;
    
    tFrame = self.T3.frame;
    if (T3Age > 0) {
        tFrame.origin.y = tFrame.origin.y - (T3Age * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (T3Age * 2.66) + 20;
    }
    
    self.T3.frame = tFrame;
    
    tFrame = self.T3a.frame;
    if (T3aAge > 0) {
        tFrame.origin.y = tFrame.origin.y - (T3aAge * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (T3aAge * 2.66) + 20;
    }
    
    self.T3a.frame = tFrame;
    
    tFrame = self.T3b.frame;
    if (T3bAge > 0) {
        tFrame.origin.y = tFrame.origin.y - (T3bAge * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (T3bAge * 2.66) + 20;
    }
    
    self.T3b.frame = tFrame;
    
    tFrame = self.T3c.frame;
    if (T3cAge > 0) {
        tFrame.origin.y = tFrame.origin.y - (T3cAge * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (T3cAge * 2.66) + 20;
    }
    
    self.T3c.frame = tFrame;
    
    tFrame = self.T4.frame;
    if (T4Age > 0) {
        tFrame.origin.y = tFrame.origin.y - (T4Age * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (T4Age * 2.66) + 20;
    }
    
    self.T4.frame = tFrame;
    
    tFrame = self.N.frame;
    if (NAge > 0) {
        tFrame.origin.y = tFrame.origin.y - (NAge * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (NAge * 2.66) + 20;
    }
    
    self.N.frame = tFrame;
    
    tFrame = self.Nx.frame;
    if (NxAge > 0) {
        tFrame.origin.y = tFrame.origin.y - (NxAge * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (NxAge * 2.66) + 20;
    }
    
    self.Nx.frame = tFrame;
    
    tFrame = self.N0.frame;
    if (N0Age > 0) {
        tFrame.origin.y = tFrame.origin.y - (N0Age * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (N0Age * 2.66) + 20;
    }
    
    self.N0.frame = tFrame;
    
    tFrame = self.N1.frame;
    if (N1Age > 0) {
        tFrame.origin.y = tFrame.origin.y - (N1Age * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (N1Age * 2.66) + 20;
    }
    
    self.N1.frame = tFrame;
    
    tFrame = self.M.frame;
    if (MAge > 0) {
        tFrame.origin.y = tFrame.origin.y - (MAge * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (MAge * 2.66) + 20;
    }
    
    self.M.frame = tFrame;
    
    tFrame = self.M0.frame;
    if (M0Age > 0) {
        tFrame.origin.y = tFrame.origin.y - (M0Age * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (M0Age * 2.66) + 20;
    }
    
    self.M0.frame = tFrame;
    
    tFrame = self.M1.frame;
    if (M1Age > 0) {
        tFrame.origin.y = tFrame.origin.y - (M1Age * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (M1Age * 2.66) + 20;
    }
    
    self.M1.frame = tFrame;
    
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
    
    CGRect tFrame = self.ClearAllView.frame;
    if (ClearAll > 0) {
        tFrame.origin.y = tFrame.origin.y - (ClearAll * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (ClearAll * 2.66) + 20;
    }
    self.ClearAllView.frame = tFrame;
    
    tFrame = self.PapillaryView.frame;
    if (Papillary > 0) {
        tFrame.origin.y = tFrame.origin.y - (Papillary * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (Papillary * 2.66) + 20;
    }
    self.PapillaryView.frame = tFrame;
    
    tFrame = self.ChromophobeView.frame;
    if (Chromophobe > 0) {
        tFrame.origin.y = tFrame.origin.y - (Chromophobe * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (Chromophobe * 2.66) + 20;
    }
    self.ChromophobeView.frame = tFrame;
    
    tFrame = self.SarcomatoidView.frame;
    if (Sarcomatoid > 0) {
        tFrame.origin.y = tFrame.origin.y - (Sarcomatoid * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (Sarcomatoid * 2.66) + 20;
    }
    self.SarcomatoidView.frame = tFrame;
    
    tFrame = self.angiomyolipomaView.frame;
    if (T1bAge > 0) {
        tFrame.origin.y = tFrame.origin.y - (angiomyolipoma * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (angiomyolipoma * 2.66) + 20;
    }
    self.angiomyolipomaView.frame = tFrame;
    
    tFrame = self.oncocytomaView.frame;
    if (oncocytoma > 0) {
        tFrame.origin.y = tFrame.origin.y - (oncocytoma * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (oncocytoma * 2.66) + 20;
    }
    self.oncocytomaView.frame = tFrame;
    
    tFrame = self.otherView.frame;
    if (other > 0) {
        tFrame.origin.y = tFrame.origin.y - (other * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (other * 2.66) + 20;
    }
    self.otherView.frame = tFrame;
    
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
    
    CGRect tFrame = self.FGoneByFourView.frame;
    if (FGoneByFour > 0) {
        tFrame.origin.y = tFrame.origin.y - (FGoneByFour * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (FGoneByFour * 2.66) + 20;
    }
    self.FGoneByFourView.frame = tFrame;
    
    tFrame = self.FGtwoByFourView.frame;
    if (FGtwoByFour > 0) {
        tFrame.origin.y = tFrame.origin.y - (FGtwoByFour * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (FGtwoByFour * 2.66) + 20;
    }
    self.FGtwoByFourView.frame = tFrame;
    
    tFrame = self.FGthreeByFourView.frame;
    if (FGthreeByFour > 0) {
        tFrame.origin.y = tFrame.origin.y - (FGthreeByFour * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (FGthreeByFour * 2.66) + 20;
    }
    self.FGthreeByFourView.frame = tFrame;
    
    tFrame = self.FGfourByFourView.frame;
    if (FGfourByFour > 0) {
        tFrame.origin.y = tFrame.origin.y - (FGfourByFour * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (FGfourByFour * 2.66) + 20;
    }
    self.FGfourByFourView.frame = tFrame;
    
    [self.view addSubview:self.FGradeView];
}


-(void)showMarginsGraph{
    
    averageViewTitleLabel.text = @"Margins";
    oneLabel.text = [NSString stringWithFormat:@"%.0f %% Negative",mNegative];
    [twoLabel setHidden:NO];
    twoLabel.text = [NSString stringWithFormat:@"%.0f %% Positive",mPositive];
    if (IS_IPHONE_5) {
        
        CGRect frame = self.averageView.frame;
        frame.origin.y = 57;
        [self.averageView setFrame:frame];
        
    }else{
        CGRect frame = self.averageView.frame;
        frame.origin.y = 45;
        [self.averageView setFrame:frame];
    }
    [self.view addSubview:averageView];
    
//    if (IS_IPHONE_5) {
//        
//        CGRect frame = self.marginsView.frame;
//        frame.origin.y = 57;
//        [self.marginsView setFrame:frame];
//        
//    }else{
//        CGRect frame = self.marginsView.frame;
//        frame.origin.y = 45;
//        [self.marginsView setFrame:frame];
//    }
//    
//    CGRect tFrame = self.mPositiveView.frame;
//    if (mPositive > 0) {
//        tFrame.origin.y = tFrame.origin.y - (mPositive * 2.66)-20;
//        tFrame.size.height = tFrame.size.height + (mPositive * 2.66)+20;
//    }
//    self.mPositiveView.frame = tFrame;
//    
//    tFrame = self.mNegativeView.frame;
//    if (mNegative > 0) {
//        tFrame.origin.y = tFrame.origin.y - (mNegative * 2.66)-20;
//        tFrame.size.height = tFrame.size.height + (mNegative * 2.66)+20;
//    }
//    self.mNegativeView.frame = tFrame;
//    
//    [self.view addSubview:self.marginsView];
}


-(void)showDMarginGraph{
    
    averageViewTitleLabel.text = @"Deep Margins";
    oneLabel.text = [NSString stringWithFormat:@"%.0f %% Negative",dmNegative];
    [twoLabel setHidden:NO];
    twoLabel.text = [NSString stringWithFormat:@"%.0f %% Positive",dmPositive];
    if (IS_IPHONE_5) {
        
        CGRect frame = self.averageView.frame;
        frame.origin.y = 57;
        [self.averageView setFrame:frame];
        
    }else{
        CGRect frame = self.averageView.frame;
        frame.origin.y = 45;
        [self.averageView setFrame:frame];
    }
    [self.view addSubview:averageView];
    
//    if (IS_IPHONE_5) {
//        
//        CGRect frame = self.DMarginView.frame;
//        frame.origin.y = 57;
//        [self.DMarginView setFrame:frame];
//        
//    }else{
//        CGRect frame = self.DMarginView.frame;
//        frame.origin.y = 45;
//        [self.DMarginView setFrame:frame];
//    }
//    
//    CGRect tFrame = self.dmPositiveView.frame;
//    if (dmPositive > 0) {
//        tFrame.origin.y = tFrame.origin.y - (dmPositive * 2.66) - 20;
//        tFrame.size.height = tFrame.size.height + (dmPositive * 2.66) + 20;
//    }
//    self.dmPositiveView.frame = tFrame;
//    
//    tFrame = self.dmNegativeView.frame;
//    if (dmNegative > 0) {
//        tFrame.origin.y = tFrame.origin.y - (dmNegative * 2.66) - 20;
//        tFrame.size.height = tFrame.size.height + (dmNegative * 2.66) + 20;
//    }
//    self.dmNegativeView.frame = tFrame;
//    
//    [self.view addSubview:self.DMarginView];
}


-(void)showNights{
    
    averageViewTitleLabel.text = @"Average Length of Stay";
    oneLabel.text = [NSString stringWithFormat:@"Average Stay = %.1f ( %i to %i Nights )",averageStay,minStay,maxStay];
    [twoLabel setHidden:YES];
    if (IS_IPHONE_5) {
        
        CGRect frame = self.averageView.frame;
        frame.origin.y = 57;
        [self.averageView setFrame:frame];
        
    }else{
        CGRect frame = self.averageView.frame;
        frame.origin.y = 45;
        [self.averageView setFrame:frame];
    }
    [self.view addSubview:averageView];
    
//    changeTitleLabel.text = @"Average Lenght Of Stay";
//    unitLabel.text = @"Nights";
//    xLabel.text = @"Stay";
//    if (IS_IPHONE_5) {
//        
//        CGRect frame = self.changeBUNView.frame;
//        frame.origin.y = 57;
//        [self.changeBUNView setFrame:frame];
//        
//    }else{
//        CGRect frame = self.changeBUNView.frame;
//        frame.origin.y = 45;
//        [self.changeBUNView setFrame:frame];
//    }
//    CGRect tFrame = self.bunView.frame;
//    if(averageStay>100)
//        averageStay=100;
//    if (averageStay > 0) {
//        tFrame.origin.y = tFrame.origin.y - (averageStay * 3);
//        tFrame.size.height = tFrame.size.height + (averageStay * 3);
//    }
//    self.bunView.frame = tFrame;
//    
//    [self.view addSubview:changeBUNView];

}


-(void)showComplications{
    
    if (IS_IPHONE_5) {
        
        CGRect frame = self.complicationsGraph.frame;
        frame.origin.y = 57;
        [self.complicationsGraph setFrame:frame];
        
    }else{
        CGRect frame = self.complicationsGraph.frame;
        frame.origin.y = 45;
        [self.complicationsGraph setFrame:frame];
    }
    
    CGRect tFrame = self.IleusView.frame;
    if (Ileus > 0) {
        tFrame.origin.y = tFrame.origin.y - (Ileus * 2.66)-20;
        tFrame.size.height = tFrame.size.height + (Ileus * 2.66)+20;
    }
    self.IleusView.frame = tFrame;
    
    
    tFrame = self.BowelInjuryView.frame;
    if (BowelInjury > 0) {
        tFrame.origin.y = tFrame.origin.y - (BowelInjury * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (BowelInjury * 2.66) + 20;
    }
    self.BowelInjuryView.frame = tFrame;
    
    
    tFrame = self.InfectionView.frame;
    if (Infection > 0) {
        tFrame.origin.y = tFrame.origin.y - (Infection * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (Infection * 2.66) + 20;
    }
    self.InfectionView.frame = tFrame;
    
    tFrame = self.UrineLeakView.frame;
    if (UrineLeak > 0) {
        tFrame.origin.y = tFrame.origin.y - (UrineLeak * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (UrineLeak * 2.66) + 20;
    }
    self.UrineLeakView.frame = tFrame;
    
    tFrame = self.DVTView.frame;
    if (DVT > 0) {
        tFrame.origin.y = tFrame.origin.y - (DVT * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (DVT * 2.66) + 20;
    }
    self.DVTView.frame = tFrame;
    
    
    tFrame = self.PEView.frame;
    if (PE > 0) {
        tFrame.origin.y = tFrame.origin.y - (PE * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (PE * 2.66) + 20;
    }
    self.PEView.frame = tFrame;
    
    tFrame = self.CardiacEventView.frame;
    if (CardiacEvent > 0) {
        tFrame.origin.y = tFrame.origin.y - (CardiacEvent * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (CardiacEvent * 2.66) + 20;
    }
    self.CardiacEventView.frame = tFrame;
    
    tFrame = self.HerniaView.frame;
    if (Hernia > 0) {
        tFrame.origin.y = tFrame.origin.y - (Hernia * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (Hernia * 2.66) + 20;
    }
    self.HerniaView.frame = tFrame;
    
    
    tFrame = self.TransfusionView.frame;
    if (Transfusion > 0) {
        tFrame.origin.y = tFrame.origin.y - (Transfusion * 2.66)-20;
        tFrame.size.height = tFrame.size.height + (Transfusion * 2.66)+20;
    }
    self.TransfusionView.frame = tFrame;
    
    
    tFrame = self.DeathView.frame;
    if (Death > 0) {
        tFrame.origin.y = tFrame.origin.y - (Death * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (Death * 2.66) + 20;
    }
    self.DeathView.frame = tFrame;
    
    
    tFrame = self.OtherCompView.frame;
    if (other > 0) {
        tFrame.origin.y = tFrame.origin.y - (other * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (other * 2.66) + 20;
    }
    self.OtherCompView.frame = tFrame;
    
    [self.view addSubview:self.complicationsGraph];
}

-(void)showXrayGraph{
    
    averageViewTitleLabel.text = @"Chest X-ray";
    oneLabel.text = [NSString stringWithFormat:@"Negative = %.1f",xrayNegative];
    [twoLabel setHidden:NO];
    twoLabel.text = [NSString stringWithFormat:@"Positive = %.1f",xrayPositive];
    if (IS_IPHONE_5) {
        
        CGRect frame = self.averageView.frame;
        frame.origin.y = 57;
        [self.averageView setFrame:frame];
        
    }else{
        CGRect frame = self.averageView.frame;
        frame.origin.y = 45;
        [self.averageView setFrame:frame];
    }
    [self.view addSubview:averageView];
    
//    if (IS_IPHONE_5) {
//        
//        CGRect frame = self.xrayGraph.frame;
//        frame.origin.y = 57;
//        [self.xrayGraph setFrame:frame];
//        
//    }else{
//        CGRect frame = self.xrayGraph.frame;
//        frame.origin.y = 45;
//        [self.xrayGraph setFrame:frame];
//    }
//    
//    NSLog(@"%f",xrayPositive);
//    NSLog(@"%f",xrayNegative);
//    
//    CGRect tFrame = self.xrayPositiveView.frame;
//    if (xrayPositive > 0) {
//        tFrame.origin.y = tFrame.origin.y - (xrayPositive * 2.66) - 20;
//        tFrame.size.height = tFrame.size.height + (xrayPositive * 2.66) + 20;
//    }
//    self.xrayPositiveView.frame = tFrame;
//    
//    tFrame = self.xrayNegativeView.frame;
//    if (xrayNegative > 0) {
//        tFrame.origin.y = tFrame.origin.y - (xrayNegative * 2.66) - 20;
//        tFrame.size.height = tFrame.size.height + (xrayNegative * 2.66) + 20;
//    }
//    
//    self.xrayNegativeView.frame = tFrame;
//    
//    [self.view addSubview:self.xrayGraph];
    
}

-(void)showLiverGraph{
    
    averageViewTitleLabel.text = @"Liver Enzymes";
    oneLabel.text = [NSString stringWithFormat:@"Abnormal = %.0f %%",liverAbNormal];
    [twoLabel setHidden:NO];
    twoLabel.text = [NSString stringWithFormat:@"Normal = %.0f %%",liverNormal];
    if (IS_IPHONE_5) {
        
        CGRect frame = self.averageView.frame;
        frame.origin.y = 57;
        [self.averageView setFrame:frame];
        
    }else{
        CGRect frame = self.averageView.frame;
        frame.origin.y = 45;
        [self.averageView setFrame:frame];
    }
    [self.view addSubview:averageView];

    
//    if (IS_IPHONE_5) {
//        
//        CGRect frame = self.liverGraph.frame;
//        frame.origin.y = 57;
//        [self.liverGraph setFrame:frame];
//        
//    }else{
//        CGRect frame = self.liverGraph.frame;
//        frame.origin.y = 45;
//        [self.liverGraph setFrame:frame];
//    }
//    
//    
//    CGRect tFrame = self.liverNormalView.frame;
//    if (liverNormal > 0) {
//        tFrame.origin.y = tFrame.origin.y - (liverNormal * 2.66) - 20;
//        tFrame.size.height = tFrame.size.height + (liverNormal * 2.66) + 20;
//    }
//    
//    self.liverNormalView.frame = tFrame;
//    
//    tFrame = self.liverAbNormalView.frame;
//    if (liverAbNormal > 0) {
//        tFrame.origin.y = tFrame.origin.y - (liverAbNormal * 2.66) - 20;
//        tFrame.size.height = tFrame.size.height + (liverAbNormal * 2.66) + 20;
//    }
//    self.liverAbNormalView.frame = tFrame;
//    
//    [self.view addSubview:self.liverGraph];
    
}

-(void)showHerniaGraph{
    
    averageViewTitleLabel.text = @"Port Site Hernia";
    oneLabel.text = [NSString stringWithFormat:@"No = %.0f %%",herniaNO];
    [twoLabel setHidden:NO];
    twoLabel.text = [NSString stringWithFormat:@"Yes = %.0f %%",herniaYES];
    if (IS_IPHONE_5) {
        
        CGRect frame = self.averageView.frame;
        frame.origin.y = 57;
        [self.averageView setFrame:frame];
        
    }else{
        CGRect frame = self.averageView.frame;
        frame.origin.y = 45;
        [self.averageView setFrame:frame];
    }
    [self.view addSubview:averageView];
    
//    if (IS_IPHONE_5) {
//        
//        CGRect frame = self.herniaGraph.frame;
//        frame.origin.y = 57;
//        [self.herniaGraph setFrame:frame];
//        
//    }else{
//        CGRect frame = self.herniaGraph.frame;
//        frame.origin.y = 45;
//        [self.herniaGraph setFrame:frame];
//    }
//    
//    CGRect tFrame = self.herniaYESView.frame;
//    if (herniaYES > 0) {
//        tFrame.origin.y = tFrame.origin.y - (herniaYES * 2.66) - 20;
//        tFrame.size.height = tFrame.size.height + (herniaYES * 2.66) + 20;
//    }
//    self.herniaYESView.frame = tFrame;
//    
//    tFrame = self.herniaNOView.frame;
//    if (herniaNO > 0) {
//        tFrame.origin.y = tFrame.origin.y - (herniaNO * 2.66) - 20;
//        tFrame.size.height = tFrame.size.height + (herniaNO * 2.66) + 20;
//    }
//    self.herniaNOView.frame = tFrame;
//    
//    [self.view addSubview:self.herniaGraph];
    
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
    
    
    CGRect tFrame = self.metastaticDiseaseView.frame;
    if (metastaticDisease > 0) {
        tFrame.origin.y = tFrame.origin.y - (metastaticDisease * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (metastaticDisease * 2.66) + 20;
    }
    self.metastaticDiseaseView.frame = tFrame;
    
    tFrame = self.LocalRecurrenceView.frame;
    if (LocalRecurrence > 0) {
        tFrame.origin.y = tFrame.origin.y - (LocalRecurrence * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (LocalRecurrence * 2.66) + 20;
    }
    self.LocalRecurrenceView.frame = tFrame;
    
    
    
    tFrame = self.LymphadenopathyView.frame;
    if (Lymphadenopathy > 0) {
        tFrame.origin.y = tFrame.origin.y - (Lymphadenopathy * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (Lymphadenopathy * 2.66) + 20;
    }
    self.LymphadenopathyView.frame = tFrame;
    
    
    
    tFrame = self.LiverMetastasisView.frame;
    if (LiverMetastasis > 0) {
        tFrame.origin.y = tFrame.origin.y - (LiverMetastasis * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (LiverMetastasis * 2.66) + 20;
    }
    self.LiverMetastasisView.frame = tFrame;
    
    
    tFrame = self.BoneMetastasisView.frame;
    if (BoneMetastasis > 0) {
        tFrame.origin.y = tFrame.origin.y - (BoneMetastasis * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (BoneMetastasis * 2.66) + 20;
    }
    self.BoneMetastasisView.frame = tFrame;
    
    
    tFrame = self.BrainMetastasisView.frame;
    if (BrainMetastasis > 0) {
        tFrame.origin.y = tFrame.origin.y - (BrainMetastasis * 2.66) - 20;
        tFrame.size.height = tFrame.size.height + (BrainMetastasis * 2.66) + 20;
    }
    self.BrainMetastasisView.frame = tFrame;
    
    [self.view addSubview:self.CtScanGraph];
    
}

-(void)showBUNGraph{
    
    averageViewTitleLabel.text = @"Change in BUN";
    oneLabel.text = [NSString stringWithFormat:@"Average Change in BUN = %.1f",bunSum];
    [twoLabel setHidden:YES];
    if (IS_IPHONE_5) {
        
        CGRect frame = self.averageView.frame;
        frame.origin.y = 57;
        [self.averageView setFrame:frame];
        
    }else{
        CGRect frame = self.averageView.frame;
        frame.origin.y = 45;
        [self.averageView setFrame:frame];
    }
    [self.view addSubview:averageView];
    
//    changeTitleLabel.text = @"Change in BUN";
//    unitLabel.text = @"Units";
//    xLabel.text = @"BUN";
//    if (IS_IPHONE_5) {
//        
//        CGRect frame = self.changeBUNView.frame;
//        frame.origin.y = 57;
//        [self.changeBUNView setFrame:frame];
//        
//    }else{
//        CGRect frame = self.changeBUNView.frame;
//        frame.origin.y = 45;
//        [self.changeBUNView setFrame:frame];
//    }
//    CGRect tFrame = self.bunView.frame;
//    if(bunSum>100)
//        bunSum=100;
//    if (bunSum > 0) {
//        tFrame.origin.y = tFrame.origin.y - (bunSum * 3);
//        tFrame.size.height = tFrame.size.height + (bunSum * 3);
//    }
//    self.bunView.frame = tFrame;
//    
//    [self.view addSubview:changeBUNView];
}

-(void)showCreatinineGraph{
    
    averageViewTitleLabel.text = @"Change in Creatinine";
    oneLabel.text = [NSString stringWithFormat:@"Average Change in Creatinine = %.1f",creatinineSum];
    [twoLabel setHidden:YES];
    if (IS_IPHONE_5) {
        
        CGRect frame = self.averageView.frame;
        frame.origin.y = 57;
        [self.averageView setFrame:frame];
        
    }else{
        CGRect frame = self.averageView.frame;
        frame.origin.y = 45;
        [self.averageView setFrame:frame];
    }
    [self.view addSubview:averageView];
    
//    changeTitleLabel.text = @"Change in Creatinine";
//    unitLabel.text = @"Units";
//    xLabel.text = @"Creatinine";
//    if (IS_IPHONE_5) {
//        
//        CGRect frame = self.changeBUNView.frame;
//        frame.origin.y = 57;
//        [self.changeBUNView setFrame:frame];
//        
//    }else{
//        CGRect frame = self.changeBUNView.frame;
//        frame.origin.y = 45;
//        [self.changeBUNView setFrame:frame];
//    }
//    CGRect tFrame = self.bunView.frame;
//    if(creatinineSum>100)
//        creatinineSum=100;
//    if (creatinineSum > 0) {
//        tFrame.origin.y = tFrame.origin.y - (creatinineSum * 3);
//        tFrame.size.height = tFrame.size.height + (creatinineSum * 3);
//    }
//    self.bunView.frame = tFrame;
//    
//    [self.view addSubview:changeBUNView];
}

-(void)showAverageBUNGraph{
    
    averageViewTitleLabel.text = @"Average BUN";
    oneLabel.text = [NSString stringWithFormat:@"Average BUN = %.1f ( %.1f to %.1f )",averageBun,minBun,maxBun];
    [twoLabel setHidden:YES];
    if (IS_IPHONE_5) {
        
        CGRect frame = self.averageView.frame;
        frame.origin.y = 57;
        [self.averageView setFrame:frame];
        
    }else{
        CGRect frame = self.averageView.frame;
        frame.origin.y = 45;
        [self.averageView setFrame:frame];
    }
    [self.view addSubview:averageView];
    
//    changeTitleLabel.text = @"Average BUN";
//    unitLabel.text = @"Units";
//    xLabel.text = @"BUN";
//    if (IS_IPHONE_5) {
//        
//        CGRect frame = self.changeBUNView.frame;
//        frame.origin.y = 57;
//        [self.changeBUNView setFrame:frame];
//        
//    }else{
//        CGRect frame = self.changeBUNView.frame;
//        frame.origin.y = 45;
//        [self.changeBUNView setFrame:frame];
//    }
//    CGRect tFrame = self.bunView.frame;
//    if(averageBun>100)
//        averageBun=100;
//    if (averageBun > 0) {
//        tFrame.origin.y = tFrame.origin.y - (averageBun * 3);
//        tFrame.size.height = tFrame.size.height + (averageBun * 3);
//    }
//    self.bunView.frame = tFrame;
//    
//    [self.view addSubview:changeBUNView];
}

-(void)showAverageCreatinineGraph{
    
    averageViewTitleLabel.text = @"Average Creatinine";
    oneLabel.text = [NSString stringWithFormat:@"Average Creatinine = %.1f ( %.1f to %.1f )",averageCreatinine,minCreatinine,maxCreatinine];
    [twoLabel setHidden:YES];
    if (IS_IPHONE_5) {
        
        CGRect frame = self.averageView.frame;
        frame.origin.y = 57;
        [self.averageView setFrame:frame];
        
    }else{
        CGRect frame = self.averageView.frame;
        frame.origin.y = 45;
        [self.averageView setFrame:frame];
    }
    [self.view addSubview:averageView];
    
//    changeTitleLabel.text = @"Average Creatinine";
//    unitLabel.text = @"Units";
//    xLabel.text = @"Creatinine";
//    if (IS_IPHONE_5) {
//        
//        CGRect frame = self.changeBUNView.frame;
//        frame.origin.y = 57;
//        [self.changeBUNView setFrame:frame];
//        
//    }else{
//        CGRect frame = self.changeBUNView.frame;
//        frame.origin.y = 45;
//        [self.changeBUNView setFrame:frame];
//    }
//    CGRect tFrame = self.bunView.frame;
//    if(averageCreatinine>100)
//        averageCreatinine=100;
//    if (averageCreatinine > 0) {
//        tFrame.origin.y = tFrame.origin.y - (averageCreatinine * 3);
//        tFrame.size.height = tFrame.size.height + (averageCreatinine * 3);
//    }
//    self.bunView.frame = tFrame;
//    
//    [self.view addSubview:changeBUNView];
}

- (IBAction)SettingsView:(id)sender {
    UCSettingsViewController *setting = nil;
    if(IS_IPHONE_5) {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController" bundle:nil];
    }
    else {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController_iphone" bundle:nil];
    }
    //UCSettingsViewController * setting =[[UCSettingsViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}

-(IBAction)home:(id)sender{
    if ([UCAppDelegate sharedObject].isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}
@end
