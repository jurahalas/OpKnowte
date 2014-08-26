//
//  OKFollowUpDataCompareVC.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/19/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKFollowUpDataCompareVC.h"
#import "OKProceduresManager.h"


@interface OKFollowUpDataCompareVC ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *marginsNationalView;
@property (strong, nonatomic) IBOutlet UIView *changeInBunNationalView;
@property (strong, nonatomic) IBOutlet UIView *deepMarginsNationalView;
@property (strong, nonatomic) IBOutlet UIView *xrayNationalView;
@property (strong, nonatomic) IBOutlet UIView *averageCreatinineNationalView;
@property (strong, nonatomic) IBOutlet UIView *liverNationalView;
@property (strong, nonatomic) IBOutlet UIView *herniaNationalView;
@property (strong, nonatomic) IBOutlet UIView *tumorChNationalView;
@property (strong, nonatomic) IBOutlet UIView *ctScanNationalView;
@property (strong, nonatomic) IBOutlet UIView *lengthStayNationalView;
@property (strong, nonatomic) IBOutlet UIView *complicationsNationalView;
@property (strong, nonatomic) IBOutlet UIView *gradeNationalView;
@property (strong, nonatomic) IBOutlet UIView *tmnNationalView;
@property (strong, nonatomic) IBOutlet UILabel *complicationsLabel;
@property (strong, nonatomic) IBOutlet UILabel *marginsLabel;
@property (strong, nonatomic) IBOutlet UILabel *dMarginsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *complicationsLine;
@property (strong, nonatomic) IBOutlet UIImageView *complicationsBottomLine;
@property (strong, nonatomic) IBOutlet UIImageView *fuhrmanBottomLine;


//buttons
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *compareButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *removeButtons;



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


- (IBAction)compareButtonTapped:(id)sender {
    _marginsNationalView.hidden = !_marginsNationalView.hidden;
    _changeInBunNationalView.hidden = !_changeInBunNationalView.hidden;
    _deepMarginsNationalView.hidden = !_deepMarginsNationalView.hidden;
    _xrayNationalView.hidden = !_xrayNationalView.hidden;
    _averageCreatinineNationalView.hidden = !_averageCreatinineNationalView.hidden;
    _liverNationalView.hidden = !_liverNationalView.hidden;
    _herniaNationalView.hidden = !_herniaNationalView.hidden;
    _tumorChNationalView.hidden = !_tumorChNationalView.hidden;
    _ctScanNationalView.hidden = !_ctScanNationalView.hidden;
    _lengthStayNationalView.hidden = !_lengthStayNationalView.hidden;
    _complicationsNationalView.hidden = !_complicationsNationalView.hidden;
    _gradeNationalView.hidden = !_gradeNationalView.hidden;
    _tmnNationalView.hidden = !_tmnNationalView.hidden;
    for (UIButton *button in self.compareButtons) {
        button.hidden = !button.hidden;
    }
}


- (IBAction)removeButtonTapped:(id)sender {
    _marginsNationalView.hidden = !_marginsNationalView.hidden;
    _changeInBunNationalView.hidden = !_changeInBunNationalView.hidden;
    _deepMarginsNationalView.hidden = !_deepMarginsNationalView.hidden;
    _xrayNationalView.hidden = !_xrayNationalView.hidden;
    _averageCreatinineNationalView.hidden = !_averageCreatinineNationalView.hidden;
    _liverNationalView.hidden = !_liverNationalView.hidden;
    _herniaNationalView.hidden = !_herniaNationalView.hidden;
    _tumorChNationalView.hidden = !_tumorChNationalView.hidden;
    _ctScanNationalView.hidden = !_ctScanNationalView.hidden;
    _lengthStayNationalView.hidden = !_lengthStayNationalView.hidden;
    _complicationsNationalView.hidden = !_complicationsNationalView.hidden;
    _gradeNationalView.hidden = !_gradeNationalView.hidden;
    _tmnNationalView.hidden = !_tmnNationalView.hidden;
    for (UIButton *button in self.compareButtons) {
        button.hidden = !button.hidden;
    }
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


- (void)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"Summary";
    [self addLeftButtonToNavbar];
    [self addBottomTabBar];

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
    _marginsNationalView.hidden = _showNationalData;
    _changeInBunNationalView.hidden = _showNationalData;
    _deepMarginsNationalView.hidden = _showNationalData;
    _xrayNationalView.hidden = _showNationalData;
    _averageCreatinineNationalView.hidden = _showNationalData;
    _liverNationalView.hidden = _showNationalData;
    _herniaNationalView.hidden = _showNationalData;
    _tumorChNationalView.hidden = _showNationalData;
    _ctScanNationalView.hidden = _showNationalData;
    _lengthStayNationalView.hidden = _showNationalData;
    _complicationsNationalView.hidden = _showNationalData;
    _gradeNationalView.hidden = _showNationalData;
    _tmnNationalView.hidden = _showNationalData;
}


-(void)showTMGGraph{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {

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
        _TMNStagingLabel.text = @"TN Staging";
        [self.Tx setText:[NSString stringWithFormat:@"T2a = %.0f %%",self.T2aAge]];
        [self.T0 setText:[NSString stringWithFormat:@"T2b = %.0f %%",self.T2bAge]];
        [self.T1 setText:[NSString stringWithFormat:@"T2c = %.0f %%",self.T3Age]];
        [self.T1a setText:[NSString stringWithFormat:@"T3a = %.0f %%",self.T3aAge]];
        [self.T1b setText:[NSString stringWithFormat:@"T3b = %.0f %%",self.T3bAge]];
        [self.T2 setText:[NSString stringWithFormat:@"T4 = %.0f %%",self.T4Age]];
        [self.T2a setText:[NSString stringWithFormat:@"Nx = %.0f %%",self.NxAge]];
        [self.T2b setText:[NSString stringWithFormat:@"N0 = %.0f %%",self.N0Age]];
        [self.T3 setText:[NSString stringWithFormat:@"N1 = %.0f %%",self.N1Age]];
        self.T3a.hidden = YES;
        self.T3b.hidden = YES;
        self.T3c.hidden = YES;
        self.T4.hidden = YES;
        self.N.hidden = YES;
        self.Nx.hidden = YES;
        self.N0.hidden = YES;
        self.N1.hidden = YES;
        self.M.hidden = YES;
        self.M0.hidden = YES;
        self.M1.hidden = YES;
        
    
        
        [self.s_Tx setText:[NSString stringWithFormat:@"T2a = %.0f %%",self.s_T2aAge]];
        [self.s_T0 setText:[NSString stringWithFormat:@"T2b = %.0f %%",self.s_T2bAge]];
        [self.s_T1 setText:[NSString stringWithFormat:@"T2c = %.0f %%",self.s_T3Age]];
        [self.s_T1a setText:[NSString stringWithFormat:@"T3a = %.0f %%",self.s_T3aAge]];
        [self.s_T1b setText:[NSString stringWithFormat:@"T3b = %.0f %%",self.s_T3bAge]];
        [self.s_T2 setText:[NSString stringWithFormat:@"T4 = %.0f %%",self.s_T4Age]];
        [self.s_T2a setText:[NSString stringWithFormat:@"Nx = %.0f %%",self.s_NxAge]];
        [self.s_T2b setText:[NSString stringWithFormat:@"N0 = %.0f %%",self.s_N0Age]];
        [self.s_T3 setText:[NSString stringWithFormat:@"N1 = %.0f %%",self.s_N1Age]];
        self.s_T3a.hidden = YES;
        self.s_T3b.hidden = YES;
        self.s_T3c.hidden = YES;
        self.s_T4.hidden = YES;
        self.s_N.hidden = YES;
        self.s_Nx.hidden = YES;
        self.s_N0.hidden = YES;
        self.s_N1.hidden = YES;
        self.s_M.hidden = YES;
        self.s_M0.hidden = YES;
        self.s_M1.hidden = YES;
        
        for (UIButton *button in self.compareButtons) {
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y-110, button.frame.size.width, button.frame.size.height);
        }
        for (UIButton *button in self.removeButtons) {
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y-110, button.frame.size.width, button.frame.size.height);
        }
        _TNMStagingLine.frame = CGRectMake(_TNMStagingLine.frame.origin.x, _TNMStagingLine.frame.origin.y-110, _TNMStagingLine.frame.size.width, _TNMStagingLine.frame.size.height);
        
        _TNMStagingBottomLine.frame = CGRectMake(_TNMStagingBottomLine.frame.origin.x, _TNMStagingBottomLine.frame.origin.y-110, _TNMStagingBottomLine.frame.size.width, _TNMStagingBottomLine.frame.size.height);
        _tmnNationalView.frame = CGRectMake(_tmnNationalView.frame.origin.x, _tmnNationalView.frame.origin.y-110, _tmnNationalView.frame.size.width, _tmnNationalView.frame.size.height-110);
        _scrollView.contentSize = self.TNMStagingView.bounds.size;
        self.TNMStagingView.frame = CGRectMake(self.TNMStagingView.frame.origin.x, self.TNMStagingView.frame.origin.y-64, self.TNMStagingView.frame.size.width, self.TNMStagingView.frame.size.height);
        [_scrollView addSubview:self.TNMStagingView];
        
    } else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
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
        
        _scrollView.contentSize = self.TNMStagingView.bounds.size;
        self.TNMStagingView.frame = CGRectMake(self.TNMStagingView.frame.origin.x, self.TNMStagingView.frame.origin.y-64, self.TNMStagingView.frame.size.width, self.TNMStagingView.frame.size.height);
        [_scrollView addSubview:self.TNMStagingView];
    }
}


-(void)showTumorChGraph
{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
    } else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
    }
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
    
    //[self.view addSubview:self.tumorChView];
    
    _scrollView.contentSize = self.tumorChView.bounds.size;
    self.tumorChView.frame = CGRectMake(self.tumorChView.frame.origin.x, self.tumorChView.frame.origin.y-64, self.tumorChView.frame.size.width, self.tumorChView.frame.size.height);
    [_scrollView addSubview:self.tumorChView];
}


-(void)showFGGraph{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
        
        if (IS_IPHONE_5) {
            
            CGRect frame = self.FGradeView.frame;
            frame.origin.y = 57;
            [self.FGradeView setFrame:frame];
            
        }else{
            CGRect frame = self.FGradeView.frame;
            frame.origin.y = 45;
            [self.FGradeView setFrame:frame];
        }
        _fuhrmanLabel.text = @"Continence";
        [self.FGNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
        [self.FGSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
        
        [self.FGoneByFourView setText:[NSString stringWithFormat:@"1 pad = %.0f %%",self.FGoneByFour]];
        [self.FGtwoByFourView setText:[NSString stringWithFormat:@"Safety pad = %.0f %%",self.FGtwoByFour]];
        [self.FGthreeByFourView setText:[NSString stringWithFormat:@">3 pad = %.0f %%",self.FGthreeByFour]];
        self.FGfourByFourView.hidden = YES;
        
        [self.s_FGoneByFourView setText:[NSString stringWithFormat:@"1 pad = %.0f %%",self.s_FGoneByFour]];
        [self.s_FGtwoByFourView setText:[NSString stringWithFormat:@"Safety pad = %.0f %%",self.s_FGtwoByFour]];
        [self.s_FGthreeByFourView setText:[NSString stringWithFormat:@">3 pad = %.0f %%",self.s_FGthreeByFour]];
        self.s_FGfourByFourView.hidden = YES;
        
        //[self.view addSubview:self.FGradeView];
        _scrollView.contentSize = self.FGradeView.bounds.size;
        self.FGradeView.frame = CGRectMake(self.FGradeView.frame.origin.x, self.FGradeView.frame.origin.y-64, self.FGradeView.frame.size.width, self.FGradeView.frame.size.height);
        [_scrollView addSubview:self.FGradeView];
        
    } else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
        
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
        
        //[self.view addSubview:self.FGradeView];
        _scrollView.contentSize = self.FGradeView.bounds.size;
        self.FGradeView.frame = CGRectMake(self.FGradeView.frame.origin.x, self.FGradeView.frame.origin.y-64, self.FGradeView.frame.size.width, self.FGradeView.frame.size.height);
        [_scrollView addSubview:self.FGradeView];
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10){
        _fuhrmanLabel.text = @"2 minute pause was delivered (complications)";
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
        
        [self.FGoneByFourView setText:[NSString stringWithFormat:@" NO = %.0f %%",self.FGoneByFour]];
        [self.FGtwoByFourView setText:[NSString stringWithFormat:@" YES = %.0f %%",self.FGtwoByFour]];
        self.FGthreeByFourView.hidden = YES;
        self.FGfourByFourView.hidden = YES;
        
        [self.s_FGoneByFourView setText:[NSString stringWithFormat:@" NO = %.0f %%",self.s_FGoneByFour]];
        [self.s_FGtwoByFourView setText:[NSString stringWithFormat:@" YES = %.0f %%",self.s_FGtwoByFour]];
        self.s_FGthreeByFourView.hidden = YES;
        self.s_FGfourByFourView.hidden = YES;
        
        //[self.view addSubview:self.FGradeView];
        
        
        for (UIButton *button in self.compareButtons) {
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y-50, button.frame.size.width, button.frame.size.height);
        }
        for (UIButton *button in self.removeButtons) {
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y-50, button.frame.size.width, button.frame.size.height);
        }
        
        
        _fuhrmanBottomLine.frame = CGRectMake(_fuhrmanBottomLine.frame.origin.x, _fuhrmanBottomLine.frame.origin.y-50, _fuhrmanBottomLine.frame.size.width, _fuhrmanBottomLine.frame.size.height);
        
        _gradeNationalView.frame = CGRectMake(_gradeNationalView.frame.origin.x, _gradeNationalView.frame.origin.y-50, _gradeNationalView.frame.size.width, _gradeNationalView.frame.size.height-50);
        
        _scrollView.contentSize = self.FGradeView.bounds.size;
        self.FGradeView.frame = CGRectMake(self.FGradeView.frame.origin.x, self.FGradeView.frame.origin.y-64, self.FGradeView.frame.size.width, self.FGradeView.frame.size.height);
        [_scrollView addSubview:self.FGradeView];
    }

}


-(void)showMarginsGraph{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10) {
        _marginsLabel.text = @"Stone location (complications)";
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
        
        [self.mPositiveView setText:[NSString stringWithFormat:@" YES = %.0f %%",self.mPositive]];
        [self.mNegativeView setText:[NSString stringWithFormat:@" NO = %.0f %%",self.mNegative]];
        [self.s_mPositiveView setText:[NSString stringWithFormat:@" YES = %.0f %%",self.s_mPositive]];
        [self.s_mNegativeView setText:[NSString stringWithFormat:@" NO = %.0f %%",self.s_mNegative]];
        
        //[self.view addSubview:self.marginsView];
        _scrollView.contentSize = self.marginsView.bounds.size;
        self.marginsView.frame = CGRectMake(self.marginsView.frame.origin.x, self.marginsView.frame.origin.y-64, self.marginsView.frame.size.width, self.marginsView.frame.size.height);
        
        [_scrollView addSubview:self.marginsView];

    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
        _marginsLabel.text = @"Mortality";
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
        
        [self.mPositiveView setText:[NSString stringWithFormat:@" YES = %.0f %%",self.mPositive]];
        [self.mNegativeView setText:[NSString stringWithFormat:@" NO = %.0f %%",self.mNegative]];
        [self.s_mPositiveView setText:[NSString stringWithFormat:@" YES = %.0f %%",self.s_mPositive]];
        [self.s_mNegativeView setText:[NSString stringWithFormat:@" NO = %.0f %%",self.s_mNegative]];
        
        //[self.view addSubview:self.marginsView];
        _scrollView.contentSize = self.marginsView.bounds.size;
        self.marginsView.frame = CGRectMake(self.marginsView.frame.origin.x, self.marginsView.frame.origin.y-64, self.marginsView.frame.size.width, self.marginsView.frame.size.height);
        
        [_scrollView addSubview:self.marginsView];
    }else{
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
        
        //[self.view addSubview:self.marginsView];
        _scrollView.contentSize = self.marginsView.bounds.size;
        self.marginsView.frame = CGRectMake(self.marginsView.frame.origin.x, self.marginsView.frame.origin.y-64, self.marginsView.frame.size.width, self.marginsView.frame.size.height);

        [_scrollView addSubview:self.marginsView];
    }
}


-(void)showDMarginsGraph{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10) {
        _dMarginsLabel.text = @"Stone size (complications)";
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
        
        [self.dmPositiveView setText:[NSString stringWithFormat:@" YES = %.0f %%",self.dmPositive]];
        [self.dmNegativeView setText:[NSString stringWithFormat:@" NO = %.0f %%",self.dmNegative]];
        [self.s_dmPositiveView setText:[NSString stringWithFormat:@" YES = %.0f %%",self.s_dmPositive]];
        [self.s_dmNegativeView setText:[NSString stringWithFormat:@" NO = %.0f %%",self.s_dmNegative]];
        
        //[self.view addSubview:self.DMarginView];
        _scrollView.contentSize = self.DMarginView.bounds.size;
        self.DMarginView.frame = CGRectMake(self.DMarginView.frame.origin.x, self.DMarginView.frame.origin.y-64, self.DMarginView.frame.size.width, self.DMarginView.frame.size.height);
        
        [_scrollView addSubview:self.DMarginView];

    }
    
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
    
    //[self.view addSubview:self.DMarginView];
    _scrollView.contentSize = self.DMarginView.bounds.size;
    self.DMarginView.frame = CGRectMake(self.DMarginView.frame.origin.x, self.DMarginView.frame.origin.y-64, self.DMarginView.frame.size.width, self.DMarginView.frame.size.height);

    [_scrollView addSubview:self.DMarginView];
}


-(void)showNights{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
        
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
        //[self.view addSubview:self.nightsGraph];
        
        
        _scrollView.contentSize = self.nightsGraph.bounds.size;
        self.nightsGraph.frame = CGRectMake(self.nightsGraph.frame.origin.x, self.nightsGraph.frame.origin.y-64, self.nightsGraph.frame.size.width, self.nightsGraph.frame.size.height);
        
        [_scrollView addSubview:self.nightsGraph];
        
    } else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
        
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
        //[self.view addSubview:self.nightsGraph];
        
        
        _scrollView.contentSize = self.nightsGraph.bounds.size;
        self.nightsGraph.frame = CGRectMake(self.nightsGraph.frame.origin.x, self.nightsGraph.frame.origin.y-64, self.nightsGraph.frame.size.width, self.nightsGraph.frame.size.height);
        
        [_scrollView addSubview:self.nightsGraph];
    }
}


-(void)showComplicationsGraph{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
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
        [self.InfectionView setText:[NSString stringWithFormat:@"Wound Infection = %.0f %%",self.Infection]];
        [self.UrineLeakView setText:[NSString stringWithFormat:@"Urine Leak = %.0f %%",self.UrineLeak]];
        [self.DVTView setText:[NSString stringWithFormat:@"DVT = %.0f %%",self.DVT]];
        [self.PEView setText:[NSString stringWithFormat:@"PE = %.0f %%",self.PE]];
        [self.CardiacEventView setText:[NSString stringWithFormat:@"Re-admission within 30 days = %.0f %%",self.CardiacEvent]];
        [self.HerniaView setText:[NSString stringWithFormat:@"Return to OR within 30 days = %.0f %%",self.Hernia]];
        [self.TransfusionView setText:[NSString stringWithFormat:@"Transfusion = %.0f %%",self.Transfusion]];
        [self.DeathView setText:[NSString stringWithFormat:@"Death = %.0f %%",self.Death]];
        self.OtherCompView.hidden = YES;
        
        [self.s_IleusView setText:[NSString stringWithFormat:@"Ileus = %.0f %%",self.s_Ileus]];
        [self.s_BowelInjuryView setText:[NSString stringWithFormat:@"Bowel Injury = %.0f %%",self.s_BowelInjury]];
        [self.s_InfectionView setText:[NSString stringWithFormat:@"Wound Infection = %.0f %%",self.s_Infection]];
        [self.s_UrineLeakView setText:[NSString stringWithFormat:@"Urine Leak = %.0f %%",self.s_UrineLeak]];
        [self.s_DVTView setText:[NSString stringWithFormat:@"DVT = %.0f %%",self.s_DVT]];
        [self.s_PEView setText:[NSString stringWithFormat:@"PE = %.0f %%",self.s_PE]];
        [self.s_CardiacEventView setText:[NSString stringWithFormat:@"Re-admission within 30 days = %.0f %%",self.s_CardiacEvent]];
        [self.s_HerniaView setText:[NSString stringWithFormat:@"Return to OR within 30 days = %.0f %%",self.s_Hernia]];
        [self.s_TransfusionView setText:[NSString stringWithFormat:@"Transfusion = %.0f %%",self.s_Transfusion]];
        [self.s_DeathView setText:[NSString stringWithFormat:@"Death = %.0f %%",self.s_Death]];
        self.s_OtherCompView.hidden = YES;
        
        //[self.view addSubview:self.complicationsGraph];
        
        _scrollView.contentSize = self.complicationsGraph.bounds.size;
        self.complicationsGraph.frame = CGRectMake(self.complicationsGraph.frame.origin.x, self.complicationsGraph.frame.origin.y-64, self.complicationsGraph.frame.size.width, self.complicationsGraph.frame.size.height);
        
        [_scrollView addSubview:self.complicationsGraph];
    } else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
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
        
        //[self.view addSubview:self.complicationsGraph];
        
        _scrollView.contentSize = self.complicationsGraph.bounds.size;
        self.complicationsGraph.frame = CGRectMake(self.complicationsGraph.frame.origin.x, self.complicationsGraph.frame.origin.y-64, self.complicationsGraph.frame.size.width, self.complicationsGraph.frame.size.height);
        
        [_scrollView addSubview:self.complicationsGraph];
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10){
        _complicationsLabel.text =@"Stone location";
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
        
        [self.IleusView setText:[NSString stringWithFormat:@"Upper pole, renal = %.0f %%",self.Ileus]];
        [self.BowelInjuryView setText:[NSString stringWithFormat:@"Mid-renal = %.0f %%",self.BowelInjury]];
        [self.InfectionView setText:[NSString stringWithFormat:@"Lower pole, renal = %.0f %%",self.Infection]];
        [self.UrineLeakView setText:[NSString stringWithFormat:@"Renal pelvis = %.0f %%",self.UrineLeak]];
        [self.DVTView setText:[NSString stringWithFormat:@"Ureteropelvic Junction = %.0f %%",self.DVT]];
        [self.PEView setText:[NSString stringWithFormat:@"Proximal ureter = %.0f %%",self.PE]];
        [self.CardiacEventView setText:[NSString stringWithFormat:@"Mid ureter = %.0f %%",self.CardiacEvent]];
        [self.HerniaView setText:[NSString stringWithFormat:@"Distal ureter = %.0f %%",self.Hernia]];
        self.TransfusionView.hidden = YES;
        self.DeathView.hidden = YES;
        self.OtherCompView.hidden = YES;

        
        [self.s_IleusView setText:[NSString stringWithFormat:@"Upper pole, renal = %.0f %%",self.s_Ileus]];
        [self.s_BowelInjuryView setText:[NSString stringWithFormat:@"Mid-renal = %.0f %%",self.s_BowelInjury]];
        [self.s_InfectionView setText:[NSString stringWithFormat:@"Lower pole, renal = %.0f %%",self.s_Infection]];
        [self.s_UrineLeakView setText:[NSString stringWithFormat:@"Renal pelvis = %.0f %%",self.s_UrineLeak]];
        [self.s_DVTView setText:[NSString stringWithFormat:@"Ureteropelvic Junction = %.0f %%",self.s_DVT]];
        [self.s_PEView setText:[NSString stringWithFormat:@"Proximal ureter = %.0f %%",self.s_PE]];
        [self.s_CardiacEventView setText:[NSString stringWithFormat:@"Mid ureter = %.0f %%",self.s_CardiacEvent]];
        
        [self.s_HerniaView setText:[NSString stringWithFormat:@"Distal ureter = %.0f %%",self.s_Hernia]];
        self.s_TransfusionView.hidden = YES;
        self.s_DeathView.hidden = YES;
        self.s_OtherCompView.hidden = YES;
        //[self.view addSubview:self.complicationsGraph];
        
        for (UIButton *button in self.compareButtons) {
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y-80, button.frame.size.width, button.frame.size.height);
        }
        for (UIButton *button in self.removeButtons) {
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y-80, button.frame.size.width, button.frame.size.height);
        }
       
        
        _complicationsBottomLine.frame = CGRectMake(_complicationsBottomLine.frame.origin.x, _complicationsBottomLine.frame.origin.y-80, _complicationsBottomLine.frame.size.width, _complicationsBottomLine.frame.size.height);
        
        _complicationsNationalView.frame = CGRectMake(_complicationsNationalView.frame.origin.x, _complicationsNationalView.frame.origin.y-80, _complicationsNationalView.frame.size.width, _complicationsNationalView.frame.size.height-80);
        
        _scrollView.contentSize = self.complicationsGraph.bounds.size;
        self.complicationsGraph.frame = CGRectMake(self.complicationsGraph.frame.origin.x, self.complicationsGraph.frame.origin.y-64, self.complicationsGraph.frame.size.width, self.complicationsGraph.frame.size.height);
        
        [_scrollView addSubview:self.complicationsGraph];
    }

}


-(void)showChangeBUNGraph{
        if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
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
            //[self.view addSubview:self.changeBUNView];
            
            _scrollView.contentSize = self.changeBUNView.bounds.size;
            self.changeBUNView.frame = CGRectMake(self.changeBUNView.frame.origin.x, self.changeBUNView.frame.origin.y-64, self.changeBUNView.frame.size.width, self.changeBUNView.frame.size.height);
            
            [_scrollView addSubview:self.changeBUNView];
        
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9){
    
        changeTitle.text = @"Occurrence of infection";
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
        
        [self.bunView setText:[NSString stringWithFormat:@"Average occurance  = %.1f ",self.bunSum]];
        [self.s_bunView setText:[NSString stringWithFormat:@"Average occurance  = %.1f ",self.s_bunSum]];
        //[self.view addSubview:self.changeBUNView];
        
        _scrollView.contentSize = self.changeBUNView.bounds.size;
        self.changeBUNView.frame = CGRectMake(self.changeBUNView.frame.origin.x, self.changeBUNView.frame.origin.y-64, self.changeBUNView.frame.size.width, self.changeBUNView.frame.size.height);
        
        [_scrollView addSubview:self.changeBUNView];
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10){
        
        changeTitle.text = @"Shockwave Rate";
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
        
        [self.bunView setText:[NSString stringWithFormat:@"Average rate  = %.1f ",self.bunSum]];
        [self.s_bunView setText:[NSString stringWithFormat:@"Average rate  = %.1f ",self.s_bunSum]];
        //[self.view addSubview:self.changeBUNView];
        
        _scrollView.contentSize = self.changeBUNView.bounds.size;
        self.changeBUNView.frame = CGRectMake(self.changeBUNView.frame.origin.x, self.changeBUNView.frame.origin.y-64, self.changeBUNView.frame.size.width, self.changeBUNView.frame.size.height);
        
        [_scrollView addSubview:self.changeBUNView];
    }

}


-(void)showChangeCreatinineGraph{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
        
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
        //[self.view addSubview:self.changeBUNView];
        
        
        _scrollView.contentSize = self.changeBUNView.bounds.size;
        self.changeBUNView.frame = CGRectMake(self.changeBUNView.frame.origin.x, self.changeBUNView.frame.origin.y-64, self.changeBUNView.frame.size.width, self.changeBUNView.frame.size.height);
        
        [_scrollView addSubview:self.changeBUNView];
        
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9){
    
        changeTitle.text = @"Occurrence of mechanical failure";
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
        
        [self.bunView setText:[NSString stringWithFormat:@"Average occurance = %.1f ",self.creatinineSum]];
        [self.s_bunView setText:[NSString stringWithFormat:@"Average occurance = %.1f ",self.s_creatinineSum]];
        //[self.view addSubview:self.changeBUNView];
        
        
        _scrollView.contentSize = self.changeBUNView.bounds.size;
        self.changeBUNView.frame = CGRectMake(self.changeBUNView.frame.origin.x, self.changeBUNView.frame.origin.y-64, self.changeBUNView.frame.size.width, self.changeBUNView.frame.size.height);
        
        [_scrollView addSubview:self.changeBUNView];
    }
}


-(void)showXrayGraph{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
        
        if (IS_IPHONE_5) {
            
            CGRect frame = self.xrayGraph.frame;
            frame.origin.y = 57;
            [self.xrayGraph setFrame:frame];
            
        }else{
            CGRect frame = self.xrayGraph.frame;
            frame.origin.y = 45;
            [self.xrayGraph setFrame:frame];
        }
        _XRayLabel.text = @"Positive Margin";
        [self.XRNationalSampleSize setText:[NSString stringWithFormat:@"(N = %i)",self.NationalSize]];
        [self.XRSurgeonSampleSize setText:[NSString stringWithFormat:@"(N = %i)",self.SurgeonSize]];
        
        [self.xrayNegativeView setText:[NSString stringWithFormat:@"NO = %.0f %%",self.xrayNegative]];
        [self.xrayPositiveView setText:[NSString stringWithFormat:@"YES = %.0f %%",self.xrayPositive]];
        [self.s_xrayNegativeView setText:[NSString stringWithFormat:@"NO = %.0f %%",self.s_xrayNegative]];
        [self.s_xrayPositiveView setText:[NSString stringWithFormat:@"YES = %.0f %%",self.s_xrayPositive]];
        //[self.view addSubview:self.xrayGraph];
        
        _scrollView.contentSize = self.xrayGraph.bounds.size;
        self.xrayGraph.frame = CGRectMake(self.xrayGraph.frame.origin.x, self.xrayGraph.frame.origin.y-64, self.xrayGraph.frame.size.width, self.xrayGraph.frame.size.height);
        
        [_scrollView addSubview:self.xrayGraph];
    } else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
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
        //[self.view addSubview:self.xrayGraph];
        
        _scrollView.contentSize = self.xrayGraph.bounds.size;
        self.xrayGraph.frame = CGRectMake(self.xrayGraph.frame.origin.x, self.xrayGraph.frame.origin.y-64, self.xrayGraph.frame.size.width, self.xrayGraph.frame.size.height);
        
        [_scrollView addSubview:self.xrayGraph];
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10){
        _XRayLabel.text = @"Number of shockwaves (complications)";

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
        
        [self.xrayNegativeView setText:[NSString stringWithFormat:@"NO = %.0f %%",self.xrayNegative]];
        [self.xrayPositiveView setText:[NSString stringWithFormat:@"YES = %.0f %%",self.xrayPositive]];
        [self.s_xrayNegativeView setText:[NSString stringWithFormat:@"NO = %.0f %%",self.s_xrayNegative]];
        [self.s_xrayPositiveView setText:[NSString stringWithFormat:@"YES = %.0f %%",self.s_xrayPositive]];
        //[self.view addSubview:self.xrayGraph];
        
        _scrollView.contentSize = self.xrayGraph.bounds.size;
        self.xrayGraph.frame = CGRectMake(self.xrayGraph.frame.origin.x, self.xrayGraph.frame.origin.y-64, self.xrayGraph.frame.size.width, self.xrayGraph.frame.size.height);
        
        [_scrollView addSubview:self.xrayGraph];
    }

 }


-(void)showLiverGraph{
    
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
        
        if (IS_IPHONE_5) {
            
            CGRect frame = self.liverGraph.frame;
            frame.origin.y = 57;
            [self.liverGraph setFrame:frame];
            
        }else{
            CGRect frame = self.liverGraph.frame;
            frame.origin.y = 45;
            [self.liverGraph setFrame:frame];
        }
        _liverLabel.text = @"Cystogram";
        [self.LNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
        [self.LSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
        
        [self.liverAbNormalView setText:[NSString stringWithFormat:@"No extravasation = %.0f %%",self.liverAbNormal]];
        [self.liverNormalView setText:[NSString stringWithFormat:@"extravasation = %.0f %%",self.liverNormal]];
        [self.s_liverAbNormalView setText:[NSString stringWithFormat:@"extravasation = %.0f %%",self.s_liverAbNormal]];
        [self.s_liverNormalView setText:[NSString stringWithFormat:@"No extravasation = %.0f %%",self.s_liverNormal]];
        //[self.view addSubview:self.liverGraph];
        
        _scrollView.contentSize = self.liverGraph.bounds.size;
        self.liverGraph.frame = CGRectMake(self.liverGraph.frame.origin.x, self.liverGraph.frame.origin.y-64, self.liverGraph.frame.size.width, self.liverGraph.frame.size.height);
        
        [_scrollView addSubview:self.liverGraph];
        
    } else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
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
        //[self.view addSubview:self.liverGraph];
        
        _scrollView.contentSize = self.liverGraph.bounds.size;
        self.liverGraph.frame = CGRectMake(self.liverGraph.frame.origin.x, self.liverGraph.frame.origin.y-64, self.liverGraph.frame.size.width, self.liverGraph.frame.size.height);
        
        [_scrollView addSubview:self.liverGraph];
    } else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10){
       _liverLabel.text = @"Shockwave rate (complications)";
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
        
        [self.liverAbNormalView setText:[NSString stringWithFormat:@"NO = %.0f %%",self.liverAbNormal]];
        [self.liverNormalView setText:[NSString stringWithFormat:@"YES = %.0f %%",self.liverNormal]];
        [self.s_liverAbNormalView setText:[NSString stringWithFormat:@"NO = %.0f %%",self.s_liverAbNormal]];
        [self.s_liverNormalView setText:[NSString stringWithFormat:@"YES = %.0f %%",self.s_liverNormal]];
        //[self.view addSubview:self.liverGraph];
        
        _scrollView.contentSize = self.liverGraph.bounds.size;
        self.liverGraph.frame = CGRectMake(self.liverGraph.frame.origin.x, self.liverGraph.frame.origin.y-64, self.liverGraph.frame.size.width, self.liverGraph.frame.size.height);
        
        [_scrollView addSubview:self.liverGraph];
    }

}


-(void)showHerniaGraph{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
        
        if (IS_IPHONE_5) {
            
            CGRect frame = self.herniaGraph.frame;
            frame.origin.y = 57;
            [self.herniaGraph setFrame:frame];
            
        }else{
            CGRect frame = self.herniaGraph.frame;
            frame.origin.y = 45;
            [self.herniaGraph setFrame:frame];
        }
        _herniaLabel.text = @"PSA";
        [self.HNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
        [self.HSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
        
        [self.herniaYESView setText:[NSString stringWithFormat:@"Undetectable = %.0f %%",self.herniaYES]];
        [self.herniaNOView setText:[NSString stringWithFormat:@"Biochemical Rescurrence = %.0f %%",self.herniaNO]];
        [self.s_herniaYESView setText:[NSString stringWithFormat:@"Undetectable = %.0f %%",self.s_herniaYES]];
        [self.s_herniaNOView setText:[NSString stringWithFormat:@"Biochemical Rescurrence = %.0f %%",self.s_herniaNO]];
        //[self.view addSubview:self.herniaGraph];
        
        _scrollView.contentSize = self.herniaGraph.bounds.size;
        self.herniaGraph.frame = CGRectMake(self.herniaGraph.frame.origin.x, self.herniaGraph.frame.origin.y-64, self.herniaGraph.frame.size.width, self.herniaGraph.frame.size.height);
        
        [_scrollView addSubview:self.herniaGraph];

    } else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
        
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
        //[self.view addSubview:self.herniaGraph];
        
        _scrollView.contentSize = self.herniaGraph.bounds.size;
        self.herniaGraph.frame = CGRectMake(self.herniaGraph.frame.origin.x, self.herniaGraph.frame.origin.y-64, self.herniaGraph.frame.size.width, self.herniaGraph.frame.size.height);
        
        [_scrollView addSubview:self.herniaGraph];
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10){
        _herniaLabel.text = @"2 minutes pause was performed";

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
        //[self.view addSubview:self.herniaGraph];
        
        _scrollView.contentSize = self.herniaGraph.bounds.size;
        self.herniaGraph.frame = CGRectMake(self.herniaGraph.frame.origin.x, self.herniaGraph.frame.origin.y-64, self.herniaGraph.frame.size.width, self.herniaGraph.frame.size.height);
        
        [_scrollView addSubview:self.herniaGraph];
    } else {
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
        //[self.view addSubview:self.herniaGraph];
        
        _scrollView.contentSize = self.herniaGraph.bounds.size;
        self.herniaGraph.frame = CGRectMake(self.herniaGraph.frame.origin.x, self.herniaGraph.frame.origin.y-64, self.herniaGraph.frame.size.width, self.herniaGraph.frame.size.height);
        
        [_scrollView addSubview:self.herniaGraph];
    }
    
   
}


-(void)showCTScanGraph{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
        if (IS_IPHONE_5) {
            
            CGRect frame = self.CtScanGraph.frame;
            frame.origin.y = 57;
            [self.CtScanGraph setFrame:frame];
            
        }else{
            CGRect frame = self.CtScanGraph.frame;
            frame.origin.y = 45;
            [self.CtScanGraph setFrame:frame];
        }
        _CTScanLabel.text = @"Gleason";
        [self.CTNationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
        [self.CTSurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
        
        [self.metastaticDiseaseView setText:[NSString stringWithFormat:@"(3+3) = %.0f %%",self.metastaticDisease]];
        [self.LocalRecurrenceView setText:[NSString stringWithFormat:@"(3+4) = %.0f %%",self.LocalRecurrence]];
        [self.LymphadenopathyView setText:[NSString stringWithFormat:@"(4+3) = %.0f %%",self.Lymphadenopathy]];
        [self.LiverMetastasisView setText:[NSString stringWithFormat:@"(4+4) = %.0f %%",self.LiverMetastasis]];
        [self.BoneMetastasisView setText:[NSString stringWithFormat:@"(4+5) = %.0f %%",self.BoneMetastasis]];
        [self.BrainMetastasisView setText:[NSString stringWithFormat:@"(5+5) = %.0f %%",self.BrainMetastasis]];
        
        [self.s_metastaticDiseaseView setText:[NSString stringWithFormat:@"(3+3) = %.0f %%",self.s_metastaticDisease]];
        [self.s_LocalRecurrenceView setText:[NSString stringWithFormat:@"(3+4) = %.0f %%",self.s_LocalRecurrence]];
        [self.s_LymphadenopathyView setText:[NSString stringWithFormat:@"(4+3) = %.0f %%",self.s_Lymphadenopathy]];
        [self.s_LiverMetastasisView setText:[NSString stringWithFormat:@"(4+4) = %.0f %%",self.s_LiverMetastasis]];
        [self.s_BoneMetastasisView setText:[NSString stringWithFormat:@"(4+5) = %.0f %%",self.s_BoneMetastasis]];
        [self.s_BrainMetastasisView setText:[NSString stringWithFormat:@"(5+5) = %.0f %%",self.s_BrainMetastasis]];
        
        //[self.view addSubview:self.CtScanGraph];
        
        _scrollView.contentSize = self.CtScanGraph.bounds.size;
        self.CtScanGraph.frame = CGRectMake(self.CtScanGraph.frame.origin.x, self.CtScanGraph.frame.origin.y-64, self.CtScanGraph.frame.size.width, self.CtScanGraph.frame.size.height);
        
        [_scrollView addSubview:self.CtScanGraph];
        
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
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
        
        //[self.view addSubview:self.CtScanGraph];
        
        _scrollView.contentSize = self.CtScanGraph.bounds.size;
        self.CtScanGraph.frame = CGRectMake(self.CtScanGraph.frame.origin.x, self.CtScanGraph.frame.origin.y-64, self.CtScanGraph.frame.size.width, self.CtScanGraph.frame.size.height);
        
        [_scrollView addSubview:self.CtScanGraph];
    }
}


-(void)showAverageCreatinineGraph{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1) {
        
        averageViewTitleLabel.text = @"Erectile Function";
        
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
        
        [self.averageLabel setText:[NSString stringWithFormat:@"Average value = %.1f",self.averageCreatinine]];
        [self.s_averageLabel setText:[NSString stringWithFormat:@"Average value = %.1f",self.s_averageCreatinine]];
        
        //[self.view addSubview:self.averageView];
        
        _scrollView.contentSize = self.averageView.bounds.size;
        self.averageView.frame = CGRectMake(self.averageView.frame.origin.x, self.averageView.frame.origin.y-64, self.averageView.frame.size.width, self.averageView.frame.size.height);
        
        [_scrollView addSubview:self.averageView];
    } else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
        
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
        
        //[self.view addSubview:self.averageView];
        
        _scrollView.contentSize = self.averageView.bounds.size;
        self.averageView.frame = CGRectMake(self.averageView.frame.origin.x, self.averageView.frame.origin.y-64, self.averageView.frame.size.width, self.averageView.frame.size.height);
        
        [_scrollView addSubview:self.averageView];
        
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9){
        
        averageViewTitleLabel.text = @"Occurrence of erosion";
        
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
        
        [self.averageLabel setText:[NSString stringWithFormat:@"Average occurrence = %.1f",self.averageCreatinine]];
        [self.s_averageLabel setText:[NSString stringWithFormat:@"Average occurrence = %.1f",self.s_averageCreatinine]];
        
        //[self.view addSubview:self.averageView];
        
        _scrollView.contentSize = self.averageView.bounds.size;
        self.averageView.frame = CGRectMake(self.averageView.frame.origin.x, self.averageView.frame.origin.y-64, self.averageView.frame.size.width, self.averageView.frame.size.height);
        
        [_scrollView addSubview:self.averageView];
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10){
        
        averageViewTitleLabel.text = @"№ of shockwaves";
        
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
        
        [self.averageLabel setText:[NSString stringWithFormat:@"Average number = %.1f",self.averageCreatinine]];
        [self.s_averageLabel setText:[NSString stringWithFormat:@"Average number = %.1f",self.s_averageCreatinine]];
        
        //[self.view addSubview:self.averageView];
        
        _scrollView.contentSize = self.averageView.bounds.size;
        self.averageView.frame = CGRectMake(self.averageView.frame.origin.x, self.averageView.frame.origin.y-64, self.averageView.frame.size.width, self.averageView.frame.size.height);
        
        [_scrollView addSubview:self.averageView];
    }

}


-(void)showAverageBUNGraph{
   if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2){
        
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
        
        //[self.view addSubview:self.averageView];
        
        _scrollView.contentSize = self.averageView.bounds.size;
        self.averageView.frame = CGRectMake(self.averageView.frame.origin.x, self.averageView.frame.origin.y-64, self.averageView.frame.size.width, self.averageView.frame.size.height);
        
        [_scrollView addSubview:self.averageView];
        
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9){
    
        averageViewTitleLabel.text = @"Average time to begin cycling of device";
        
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
        
        [self.averageLabel setText:[NSString stringWithFormat:@"Average time = %.1f",self.averageBun]];
        [self.s_averageLabel setText:[NSString stringWithFormat:@"Average time = %.1f",self.s_averageBun]];
        
        //[self.view addSubview:self.averageView];
        
        _scrollView.contentSize = self.averageView.bounds.size;
        self.averageView.frame = CGRectMake(self.averageView.frame.origin.x, self.averageView.frame.origin.y-64, self.averageView.frame.size.width, self.averageView.frame.size.height);
        
        [_scrollView addSubview:self.averageView];    
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10){
        
        averageViewTitleLabel.text = @"Stone Size";
        
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
        
        [self.averageLabel setText:[NSString stringWithFormat:@"Average size = %.1f",self.averageBun]];
        [self.s_averageLabel setText:[NSString stringWithFormat:@"Average size = %.1f",self.s_averageBun]];
        
        //[self.view addSubview:self.averageView];
        
        _scrollView.contentSize = self.averageView.bounds.size;
        self.averageView.frame = CGRectMake(self.averageView.frame.origin.x, self.averageView.frame.origin.y-64, self.averageView.frame.size.width, self.averageView.frame.size.height);
        
        [_scrollView addSubview:self.averageView];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
