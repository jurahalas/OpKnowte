//
//  OKPostOpDataGraphsVC.m
//  OpKnowte
//
//  Created by Apple on 21.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKPostOpDataGraphsVC.h"
#import "OKProceduresManager.h"
#define IS_IPHONE_5                     ([[UIScreen mainScreen] bounds].size.height == 568)

@interface OKPostOpDataGraphsVC ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIView *nationalDataView;
@property (strong, nonatomic) IBOutlet UIButton *compareButton;
@property (strong, nonatomic) IBOutlet UIButton *removeButton;

@property (strong, nonatomic) IBOutlet UIButton *comp_compareButton;
@property (strong, nonatomic) IBOutlet UIButton *comp_removeButton;
@property (strong, nonatomic) IBOutlet UIView *comp_nationalDataView;

@property (strong, nonatomic) IBOutlet UIView *comp_view;
@property (strong, nonatomic) IBOutlet UILabel *s_comp_sampleSize;
@property (strong, nonatomic) IBOutlet UILabel *s_comp_none;
@property (strong, nonatomic) IBOutlet UILabel *s_comp_open;
@property (strong, nonatomic) IBOutlet UILabel *s_comp_bowel;
@property (strong, nonatomic) IBOutlet UILabel *s_comp_rectal;
@property (strong, nonatomic) IBOutlet UILabel *s_comp_transfusion;

@property (strong, nonatomic) IBOutlet UILabel *comp_sampleSize;
@property (strong, nonatomic) IBOutlet UILabel *comp_none;
@property (strong, nonatomic) IBOutlet UILabel *comp_open;
@property (strong, nonatomic) IBOutlet UILabel *comp_bowel;
@property (strong, nonatomic) IBOutlet UILabel *comp_rectal;
@property (strong, nonatomic) IBOutlet UILabel *comp_transfusion;

//===============================================================================================
//Irrigation antibiotics used (Neomycin, Bacitracin, Gentamicin, Vancomycin, Amphotericin B, Rifampin), multiple choices can be selected
@property (strong, nonatomic) IBOutlet UIButton *irri_compareButton;
@property (strong, nonatomic) IBOutlet UIButton *irri_removeButton;
@property (strong, nonatomic) IBOutlet UIView *irri_nationalDataView;

@property (strong, nonatomic) IBOutlet UIView *irri_view;
@property (strong, nonatomic) IBOutlet UILabel *s_irri_sampleSize;
@property (strong, nonatomic) IBOutlet UILabel *s_irri_Neomycin;
@property (strong, nonatomic) IBOutlet UILabel *s_irri_Bacitracin;
@property (strong, nonatomic) IBOutlet UILabel *s_irri_Gentamicin;
@property (strong, nonatomic) IBOutlet UILabel *s_irri_Vancomycin;
@property (strong, nonatomic) IBOutlet UILabel *s_irri_AmphotericinB;
@property (strong, nonatomic) IBOutlet UILabel *s_irri_Rifampin;


@property (strong, nonatomic) IBOutlet UILabel *irri_sampleSize;
@property (strong, nonatomic) IBOutlet UILabel *irri_Neomycin;
@property (strong, nonatomic) IBOutlet UILabel *irri_Bacitracin;
@property (strong, nonatomic) IBOutlet UILabel *irri_Gentamicin;
@property (strong, nonatomic) IBOutlet UILabel *irri_Vancomycin;
@property (strong, nonatomic) IBOutlet UILabel *irri_AmphotericinB;
@property (strong, nonatomic) IBOutlet UILabel *irri_Rifampin;
//===============================================================================================
//Diagnosis (Erectile Dysfunction, Peyronie’s Disease, Prostate Cancer, Hypertension, Dyslipidemia, Coronary Artery Disease, Diabetes Mellitus, Spinal Cord Injury, Pelvic Trauma, Penile Trauma), multiple may be chosen

@property (strong, nonatomic) IBOutlet UIButton *diag_compareButton;
@property (strong, nonatomic) IBOutlet UIButton *diag_removeButton;
@property (strong, nonatomic) IBOutlet UIView *diag_nationalDataView;

@property (strong, nonatomic) IBOutlet UIView *diag_view;
@property (strong, nonatomic) IBOutlet UILabel *s_diag_sampleSize;
@property (strong, nonatomic) IBOutlet UILabel *s_diag_ErectileDysfunction;
@property (strong, nonatomic) IBOutlet UILabel *s_diag_PeyroniesDisease;
@property (strong, nonatomic) IBOutlet UILabel *s_diag_ProstateCancer;
@property (strong, nonatomic) IBOutlet UILabel *s_diag_Hypertension;
@property (strong, nonatomic) IBOutlet UILabel *s_diag_Dyslipidemia;
@property (strong, nonatomic) IBOutlet UILabel *s_diag_CoronaryArteryDisease;
@property (strong, nonatomic) IBOutlet UILabel *s_diag_DiabetesMellitus;
@property (strong, nonatomic) IBOutlet UILabel *s_diag_SpinalCordInjury;
@property (strong, nonatomic) IBOutlet UILabel *s_diag_PelvicTrauma;
@property (strong, nonatomic) IBOutlet UILabel *s_diag_PenileTrauma;


@property (strong, nonatomic) IBOutlet UILabel *diag_sampleSize;
@property (strong, nonatomic) IBOutlet UILabel *diag_ErectileDysfunction;
@property (strong, nonatomic) IBOutlet UILabel *diag_PeyroniesDisease;
@property (strong, nonatomic) IBOutlet UILabel *diag_ProstateCancer;
@property (strong, nonatomic) IBOutlet UILabel *diag_Hypertension;
@property (strong, nonatomic) IBOutlet UILabel *diag_Dyslipidemia;
@property (strong, nonatomic) IBOutlet UILabel *diag_CoronaryArteryDisease;
@property (strong, nonatomic) IBOutlet UILabel *diag_DiabetesMellitus;
@property (strong, nonatomic) IBOutlet UILabel *diag_SpinalCordInjury;
@property (strong, nonatomic) IBOutlet UILabel *diag_PelvicTrauma;
@property (strong, nonatomic) IBOutlet UILabel *diag_PenileTrauma;
//===============================================================================================
//5 = Device Implanted (AMS 700 CX, AMS 700 CXR, AMS 700 LGX, Coloplast Titan), choose one


@property (strong, nonatomic) IBOutlet UIButton *devimp_compareButton;
@property (strong, nonatomic) IBOutlet UIButton *devimp_removeButton;
@property (strong, nonatomic) IBOutlet UIView *devimp_nationalDataView;
@property (strong, nonatomic) IBOutlet UILabel *devimp_headerLabel;

@property (strong, nonatomic) IBOutlet UIView *devimp_view;
@property (strong, nonatomic) IBOutlet UILabel *s_devimp_sampleSize;
@property (strong, nonatomic) IBOutlet UILabel *s_devimp_AMS700CX;
@property (strong, nonatomic) IBOutlet UILabel *s_devimp_AMS700CXR;
@property (strong, nonatomic) IBOutlet UILabel *s_devimp_AMS700LGX;
@property (strong, nonatomic) IBOutlet UILabel *s_devimp_ColoplastTitan;

@property (strong, nonatomic) IBOutlet UILabel *devimp_sampleSize;
@property (strong, nonatomic) IBOutlet UILabel *devimp_AMS700CX;
@property (strong, nonatomic) IBOutlet UILabel *devimp_AMS700CXR;
@property (strong, nonatomic) IBOutlet UILabel *devimp_AMS700LGX;
@property (strong, nonatomic) IBOutlet UILabel *devimp_ColoplastTitan;
//===============================================================================================
//Dilated to: (9mm, 10mm, 11mm, 12mm, 13mm, 14mm, n/a)


@property (strong, nonatomic) IBOutlet UIButton *dilto_compareButton;
@property (strong, nonatomic) IBOutlet UIButton *dilto_removeButton;
@property (strong, nonatomic) IBOutlet UIView *dilto_nationalDataView;

@property (strong, nonatomic) IBOutlet UIView *dilto_view;
@property (strong, nonatomic) IBOutlet UILabel *s_dilto_sampleSize;
@property (strong, nonatomic) IBOutlet UILabel *s_dilto_9mm;
@property (strong, nonatomic) IBOutlet UILabel *s_dilto_10mm;
@property (strong, nonatomic) IBOutlet UILabel *s_dilto_11mm;
@property (strong, nonatomic) IBOutlet UILabel *s_dilto_12mm;
@property (strong, nonatomic) IBOutlet UILabel *s_dilto_13mm;
@property (strong, nonatomic) IBOutlet UILabel *s_dilto_14mm;
@property (strong, nonatomic) IBOutlet UILabel *s_dilto_na;

@property (strong, nonatomic) IBOutlet UILabel *dilto_sampleSize;
@property (strong, nonatomic) IBOutlet UILabel *dilto_9mm;
@property (strong, nonatomic) IBOutlet UILabel *dilto_10mm;
@property (strong, nonatomic) IBOutlet UILabel *dilto_11mm;
@property (strong, nonatomic) IBOutlet UILabel *dilto_12mm;
@property (strong, nonatomic) IBOutlet UILabel *dilto_13mm;
@property (strong, nonatomic) IBOutlet UILabel *dilto_14mm;
@property (strong, nonatomic) IBOutlet UILabel *dilto_na;


@end

@implementation OKPostOpDataGraphsVC

@synthesize ageView, averageAgeGraph, averageAge, graphToDraw;

@synthesize dmPositive, DMarginView, dmNegativeView, dmPositiveView;
@synthesize maleFemaleView,malePercentage,maleView,femaleView;
@synthesize LRMPercentage, leftRightRenalView, leftRenalView, rightRenalView;
@synthesize cytoStentView,cytoNoView,cytoYesView,cytoStentPercentage;
@synthesize maxAge,minAge,maxBmi,minBmi,minClampTime,maxClampTime,minConsoleTime,maxConsoleTime,minRoomTime,maxRoomTime,maxBloodLoss,minBloodLoss,minTumorSize,maxTumorSize;

@synthesize requiredPercentage,adhesiolysisView,requiredView;
@synthesize vasAnomoliesView,anomoliesYesView,anomoliesPercentage;
@synthesize iousPercentage,iousView,iousYesView;
@synthesize renalRSPercentage,renalRSView,renalRSYesView;
@synthesize coagulantPercentage,titleLabel,averageTitleLabel,unitLabel,xLabel;
@synthesize transfusionPercentage,consolePercentage,roomTimePercentage,clampTimePercentage;
@synthesize bloodLossPercentage,bloodLossView,bloodView;
@synthesize tumorSizePercentage,tumorSizeView,tumorView;
@synthesize bmiPercentage;
@synthesize averageView,averageViewTitleLabel,oneLabel,twoLabel;
@synthesize National, Surgeon, oneSurLabel, twoSurLabel;
@synthesize NationalSampleSize, SurgeonSampleSize;

@synthesize sur_minTumorSize, sur_minRoomTime, sur_minConsoleTime, sur_minClampTime, sur_minBmi, sur_minBloodLoss, sur_minAge, sur_maxTumorSize, sur_maxRoomTime, sur_maxConsoleTime, sur_maxClampTime, sur_maxBmi, sur_maxBloodLoss, sur_maxAge, sur_anomoliesPercentage, sur_averageAge, sur_bloodLossPercentage, sur_bmiPercentage, sur_clampTimePercentage, sur_coagulantPercentage, sur_consolePercentage, sur_cytoStentPercentage, sur_dmPositive, sur_iousPercentage, sur_LRMPercentage, sur_malePercentage, sur_renalRSPercentage, sur_requiredPercentage, sur_roomTimePercentage, sur_transfusionPercentage, sur_tumorSizePercentage;

@synthesize isNationalData;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.isNationalData = YES;
    }
    return self;
}
- (IBAction)compareButtonTapped:(id)sender {
    _nationalDataView.hidden = !_nationalDataView.hidden;
    _compareButton.hidden = !_compareButton.hidden;
    _comp_nationalDataView.hidden = !_comp_nationalDataView.hidden;
    _comp_compareButton.hidden = !_comp_compareButton.hidden;
    _irri_nationalDataView.hidden = !_comp_nationalDataView.hidden;
    _irri_compareButton.hidden = !_comp_compareButton.hidden;
    _diag_nationalDataView.hidden = !_comp_nationalDataView.hidden;
    _diag_compareButton.hidden = !_comp_compareButton.hidden;
    _devimp_nationalDataView.hidden = !_comp_nationalDataView.hidden;
    _devimp_compareButton.hidden = !_comp_compareButton.hidden;
    _dilto_nationalDataView.hidden = !_comp_nationalDataView.hidden;
    _dilto_compareButton.hidden = !_comp_compareButton.hidden;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //averageAge = 70;
    self.scrollview.hidden = YES;
    self.navigationItem.title = @"Post-Op Data";
    _nationalDataView.hidden = YES;
    _comp_nationalDataView.hidden = YES;
    _irri_nationalDataView.hidden = YES;
    _diag_nationalDataView.hidden = YES;
    _devimp_nationalDataView.hidden = YES;
    _dilto_nationalDataView.hidden = YES;
    
    if([self.graphToDraw isEqualToString:@"AverageAge"]){
        [self drawAverageAgeGraph];
    }else if([self.graphToDraw isEqualToString:@"DeepMargins"]){
        [self drawDMarginGraph];
    }else if([self.graphToDraw isEqualToString:@"MaleFemale"]){
        [self drawMaleFemaleGraph];
    }else if([self.graphToDraw isEqualToString:@"LeftRightRenal"]){
        [self drawLeftRightRenalGraph];
    }else if([self.graphToDraw isEqualToString:@"CytoStent"]){
        [self drawCytoStentGraph];
    }else if([self.graphToDraw isEqualToString:@"Adhesiolysis"]){
        [self drawAdhesiolysisGraph];
    }else if([self.graphToDraw isEqualToString:@"VasAnomoly"]){
        [self drawAnomoliesGraph];
    }else if([self.graphToDraw isEqualToString:@"IOUS"]){
        [self drawIOUSGraph];
    }else if([self.graphToDraw isEqualToString:@"RenalSR"]){
        [self drawRenalRSGraph];
    }else if([self.graphToDraw isEqualToString:@"Coagulant"]){
        [self drawCoagulantGraph];
    }else if([self.graphToDraw isEqualToString:@"Transfusion"]){
        [self drawTransfusionGraph];
    }else if([self.graphToDraw isEqualToString:@"ConsoleTime"]){
        [self drawConsoleTimeGraph];
    }else if([self.graphToDraw isEqualToString:@"RoomTime"]){
        [self drawRoomTimeGraph];
    }else if([self.graphToDraw isEqualToString:@"ClampTime"]){
        [self drawClampTimeGraph];
    }else if([self.graphToDraw isEqualToString:@"BloodLoss"]){
        [self drawBloodLossGraph];
    }else if([self.graphToDraw isEqualToString:@"TumorSize"]){
        [self drawTumorSizeGraph];
    }else if([self.graphToDraw isEqualToString:@"BMI"]){
        [self drawBMIGraph];
    }else if([self.graphToDraw isEqualToString:@"Complications"]){
        [self drawComplications];
    }else if([self.graphToDraw isEqualToString:@"Irrigation"]){
        [self drawIrrigation];
    }else if([self.graphToDraw isEqualToString:@"Diagnosis"]){
        [self drawDiagnosis];
    }else if([self.graphToDraw isEqualToString:@"DeviceImplanted"]){
        [self drawDeviceImplanted];
    }else if([self.graphToDraw isEqualToString:@"DilatorsUsed"]){
        [self drawDilatorsUsed];
    }else if([self.graphToDraw isEqualToString:@"DilationWas"]){
        [self drawDilationWas];
    }else if([self.graphToDraw isEqualToString:@"ReservoirType"]){
        [self drawReservoirType];
    }else if([self.graphToDraw isEqualToString:@"Dilatedto"]){
        [self drawDilatedTo];
    }
    
    [self.NationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.SurgeonSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    [self addLeftButtonToNavbar];

    if (self.isNationalData) {
        [self.SurgeonSampleSize setHidden:NO];
        [self.NationalSampleSize setHidden:NO];
        
    }else{
        [self.SurgeonSampleSize setHidden:YES];
        [self.NationalSampleSize setHidden:NO];
        [self.NationalSampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
        [self.National setText:@"Surgeon Data"];
    }
    
}

-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    
    if (IS_IOS7) {
        right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width, [UIImage imageNamed:@"back"].size.height );
    } else {
        right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width +27, [UIImage imageNamed:@"back"].size.height );}
    
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
}

- (void)backButton {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) drawDilatedTo{
    //===============================================================================================
    // Dilated to: (9mm, 10mm, 11mm, 12mm, 13mm, 14mm, n/a),
    
    
    self.scrollview.hidden = NO;
    
    [self.dilto_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.s_dilto_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    NSNumber *getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_9mm"];
    int none = [getNumberFromDictionary integerValue] ;
    [self.s_dilto_9mm setText:[NSString stringWithFormat:@"9mm - %i %%",none]];
    getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_10mm"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_dilto_10mm setText:[NSString stringWithFormat:@"10mm - %i %%",none]];
    
    getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_11mm"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_dilto_11mm setText:[NSString stringWithFormat:@"11mm - %i %%",none]];
    getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_12mm"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_dilto_12mm setText:[NSString stringWithFormat:@"12mm - %i %%",none]];
    
    getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_13mm"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_dilto_13mm setText:[NSString stringWithFormat:@"13mm - %i %%",none]];
    getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_14mm"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_dilto_14mm setText:[NSString stringWithFormat:@"14mm - %i %%",none]];
    
    getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"s_dilto_na"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_dilto_na setText:[NSString stringWithFormat:@"n/a - %i %%",none]];
    
    
    
    
    
    
    getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_9mm"];
    none = [getNumberFromDictionary integerValue] ;
    [self.dilto_9mm setText:[NSString stringWithFormat:@"9mm - %i %%",none]];
    getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_10mm"];
    none = [getNumberFromDictionary integerValue] ;
    [self.dilto_10mm setText:[NSString stringWithFormat:@"10mm - %i %%",none]];
    
    getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_11mm"];
    none = [getNumberFromDictionary integerValue] ;
    [self.dilto_11mm setText:[NSString stringWithFormat:@"11mm - %i %%",none]];
    getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_12mm"];
    none = [getNumberFromDictionary integerValue] ;
    [self.dilto_12mm setText:[NSString stringWithFormat:@"12mm - %i %%",none]];
    
    getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_13mm"];
    none = [getNumberFromDictionary integerValue] ;
    [self.dilto_13mm setText:[NSString stringWithFormat:@"13mm - %i %%",none]];
    getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_14mm"];
    none = [getNumberFromDictionary integerValue] ;
    [self.dilto_14mm setText:[NSString stringWithFormat:@"14mm - %i %%",none]];
    
    getNumberFromDictionary = [self.dilto_dictionary valueForKey:@"dilto_na"];
    none = [getNumberFromDictionary integerValue] ;
    [self.dilto_na setText:[NSString stringWithFormat:@"n/a - %i %%",none]];
    
    
    
    
    
    
    
    
    [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
    [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
    
    if (IS_IPHONE_5) {
        CGRect frame = self.dilto_view.frame;
        frame.origin.y = 57;
        [self.dilto_view setFrame:frame];
        
    }else{
        CGRect frame = self.dilto_view.frame;
        frame.origin.y = 45;
        [self.dilto_view setFrame:frame];
    }
    self.scrollview.contentSize = self.dilto_view.bounds.size;
    self.dilto_view.frame = CGRectMake(self.dilto_view.frame.origin.x, self.dilto_view.frame.origin.y-64, self.dilto_view.frame.size.width, self.dilto_view.frame.size.height);
    
    [self.scrollview addSubview:self.dilto_view];
}


-(void) drawReservoirType{
    //===============================================================================================
    // Reservoir type (Conceal, Spherical, Cloverleaf)
    
    
    [self.devimp_headerLabel setText:@"Reservoir Type"];
    self.scrollview.hidden = NO;
    
    [self.devimp_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.s_devimp_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    NSNumber *getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"s_restyp_Conceal"];
    int none = [getNumberFromDictionary integerValue] ;
    [self.s_devimp_AMS700CX setText:[NSString stringWithFormat:@"Conceal - %i %%",none]];
    getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"s_restyp_Spherical"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_devimp_AMS700CXR setText:[NSString stringWithFormat:@"Spherical - %i %%",none]];
    getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"s_restyp_Cloverleaf"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_devimp_AMS700LGX setText:[NSString stringWithFormat:@"Cloverleaf - %i %%",none]];
    //    getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"s_devimp_ColoplastTitan"];
    //    none = [getNumberFromDictionary integerValue] ;
    //    [self.s_devimp_ColoplastTitan setText:[NSString stringWithFormat:@"Coloplast Titan - %i %%",none]];
    self.s_devimp_ColoplastTitan.hidden = YES;
    
    getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"restyp_Conceal"];
    none = [getNumberFromDictionary integerValue] ;
    [self.devimp_AMS700CX setText:[NSString stringWithFormat:@"Conceal - %i %%",none]];
    getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"restyp_Spherical"];
    none = [getNumberFromDictionary integerValue] ;
    [self.devimp_AMS700CXR setText:[NSString stringWithFormat:@"Spherical - %i %%",none]];
    getNumberFromDictionary = [self.restyp_dictionary valueForKey:@"restyp_Cloverleaf"];
    none = [getNumberFromDictionary integerValue] ;
    [self.devimp_AMS700LGX setText:[NSString stringWithFormat:@"Cloverleaf - %i %%",none]];
    //    getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"devimp_ColoplastTitan"];
    //    none = [getNumberFromDictionary integerValue] ;
    //    [self.devimp_ColoplastTitan setText:[NSString stringWithFormat:@"Coloplast Titan - %i %%",none]];
    self.devimp_ColoplastTitan.hidden = YES;
    
    [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
    [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
    
    if (IS_IPHONE_5) {
        CGRect frame = self.devimp_view.frame;
        frame.origin.y = 57;
        [self.devimp_view setFrame:frame];
        
    }else{
        CGRect frame = self.devimp_view.frame;
        frame.origin.y = 45;
        [self.devimp_view setFrame:frame];
    }
    self.scrollview.contentSize = self.devimp_view.bounds.size;
    self.devimp_view.frame = CGRectMake(self.devimp_view.frame.origin.x, self.devimp_view.frame.origin.y-64, self.devimp_view.frame.size.width, self.devimp_view.frame.size.height);
    
    [self.scrollview addSubview:self.devimp_view];
}




-(void) drawDilationWas{
    //===============================================================================================
    //(straightforward, difficult due to scarring, difficult due to anatomy)
    
    
    [self.devimp_headerLabel setText:@"Dilation Was"];
    self.scrollview.hidden = NO;
    
    [self.devimp_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.s_devimp_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    NSNumber *getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"s_dilwas_straightforward"];
    int none = [getNumberFromDictionary integerValue] ;
    [self.s_devimp_AMS700CX setText:[NSString stringWithFormat:@"Straightforward - %i %%",none]];
    getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"s_dilwas_difficultduetoscarring"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_devimp_AMS700CXR setText:[NSString stringWithFormat:@"Difficult due to scarring - %i %%",none]];
    getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"s_dilwas_difficultduetoanatomy"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_devimp_AMS700LGX setText:[NSString stringWithFormat:@"Difficult due to anatomy - %i %%",none]];
    //    getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"s_devimp_ColoplastTitan"];
    //    none = [getNumberFromDictionary integerValue] ;
    //    [self.s_devimp_ColoplastTitan setText:[NSString stringWithFormat:@"Coloplast Titan - %i %%",none]];
    self.s_devimp_ColoplastTitan.hidden = YES;
    
    getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"dilwas_straightforward"];
    none = [getNumberFromDictionary integerValue] ;
    [self.devimp_AMS700CX setText:[NSString stringWithFormat:@"Straightforward - %i %%",none]];
    getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"dilwas_difficultduetoscarring"];
    none = [getNumberFromDictionary integerValue] ;
    [self.devimp_AMS700CXR setText:[NSString stringWithFormat:@"Difficult due to scarring - %i %%",none]];
    getNumberFromDictionary = [self.dilwas_dictionary valueForKey:@"dilwas_difficultduetoanatomy"];
    none = [getNumberFromDictionary integerValue] ;
    [self.devimp_AMS700LGX setText:[NSString stringWithFormat:@"Difficult due to anatomy - %i %%",none]];
    //    getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"devimp_ColoplastTitan"];
    //    none = [getNumberFromDictionary integerValue] ;
    //    [self.devimp_ColoplastTitan setText:[NSString stringWithFormat:@"Coloplast Titan - %i %%",none]];
    self.devimp_ColoplastTitan.hidden = YES;
    
    [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
    [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
    
    if (IS_IPHONE_5) {
        CGRect frame = self.devimp_view.frame;
        frame.origin.y = 57;
        [self.devimp_view setFrame:frame];
        
    }else{
        CGRect frame = self.devimp_view.frame;
        frame.origin.y = 45;
        [self.devimp_view setFrame:frame];
    }
    self.scrollview.contentSize = self.devimp_view.bounds.size;
    self.devimp_view.frame = CGRectMake(self.devimp_view.frame.origin.x, self.devimp_view.frame.origin.y-64, self.devimp_view.frame.size.width, self.devimp_view.frame.size.height);
    
    [self.scrollview addSubview:self.devimp_view];
}



-(void) drawDilatorsUsed{
    //===============================================================================================
    //6 = Dilators used (Brooks, Hegar, Furlow)
    

    [self.devimp_headerLabel setText:@"Dilators Used"];
    self.scrollview.hidden = NO;
    
    [self.devimp_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.s_devimp_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    NSNumber *getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"s_diluse_Brooks"];
    int none = [getNumberFromDictionary integerValue] ;
    [self.s_devimp_AMS700CX setText:[NSString stringWithFormat:@"Brooks - %i %%",none]];
    getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"s_diluse_Hegar"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_devimp_AMS700CXR setText:[NSString stringWithFormat:@"Hegar - %i %%",none]];
    getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"s_diluse_Furlow"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_devimp_AMS700LGX setText:[NSString stringWithFormat:@"Furlow - %i %%",none]];
//    getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"s_devimp_ColoplastTitan"];
//    none = [getNumberFromDictionary integerValue] ;
//    [self.s_devimp_ColoplastTitan setText:[NSString stringWithFormat:@"Coloplast Titan - %i %%",none]];
    self.s_devimp_ColoplastTitan.hidden = YES;
    
    getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"diluse_Brooks"];
    none = [getNumberFromDictionary integerValue] ;
    [self.devimp_AMS700CX setText:[NSString stringWithFormat:@"Brooks - %i %%",none]];
    getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"diluse_Hegar"];
    none = [getNumberFromDictionary integerValue] ;
    [self.devimp_AMS700CXR setText:[NSString stringWithFormat:@"Hegar - %i %%",none]];
    getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"diluse_Furlow"];
    none = [getNumberFromDictionary integerValue] ;
    [self.devimp_AMS700LGX setText:[NSString stringWithFormat:@"Furlow - %i %%",none]];
//    getNumberFromDictionary = [self.diluse_dictionary valueForKey:@"devimp_ColoplastTitan"];
//    none = [getNumberFromDictionary integerValue] ;
//    [self.devimp_ColoplastTitan setText:[NSString stringWithFormat:@"Coloplast Titan - %i %%",none]];
    self.devimp_ColoplastTitan.hidden = YES;
    
    [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
    [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
    
    if (IS_IPHONE_5) {
        CGRect frame = self.devimp_view.frame;
        frame.origin.y = 57;
        [self.devimp_view setFrame:frame];
        
    }else{
        CGRect frame = self.devimp_view.frame;
        frame.origin.y = 45;
        [self.devimp_view setFrame:frame];
    }
    self.scrollview.contentSize = self.devimp_view.bounds.size;
    self.devimp_view.frame = CGRectMake(self.devimp_view.frame.origin.x, self.devimp_view.frame.origin.y-64, self.devimp_view.frame.size.width, self.devimp_view.frame.size.height);
    
    [self.scrollview addSubview:self.devimp_view];
}





-(void) drawDeviceImplanted{
//===============================================================================================
//5 = Device Implanted (AMS 700 CX, AMS 700 CXR, AMS 700 LGX, Coloplast Titan), choose one    self.scrollview.hidden = NO;

//    s_devimp_AMS700CX;
//    s_devimp_AMS700CXR;
//    s_devimp_AMS700LGX;
//    s_devimp_ColoplastTitan;
    //[self.devimp_headerLabel setText:@""];
    self.scrollview.hidden = NO;

    [self.devimp_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.s_devimp_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    NSNumber *getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"s_devimp_AMS700CX"];
    int none = [getNumberFromDictionary integerValue] ;
    [self.s_devimp_AMS700CX setText:[NSString stringWithFormat:@"AMS 700 CX - %i %%",none]];
    getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"s_devimp_AMS700CXR"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_devimp_AMS700CXR setText:[NSString stringWithFormat:@"AMS 700 CXR - %i %%",none]];
    getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"s_devimp_AMS700LGX"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_devimp_AMS700LGX setText:[NSString stringWithFormat:@"AMS 700 LGX - %i %%",none]];
    getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"s_devimp_ColoplastTitan"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_devimp_ColoplastTitan setText:[NSString stringWithFormat:@"Coloplast Titan - %i %%",none]];
    
    
    
    
    
    getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"devimp_AMS700CX"];
    none = [getNumberFromDictionary integerValue] ;
    [self.devimp_AMS700CX setText:[NSString stringWithFormat:@"AMS 700 CX - %i %%",none]];
    getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"devimp_AMS700CXR"];
    none = [getNumberFromDictionary integerValue] ;
    [self.devimp_AMS700CXR setText:[NSString stringWithFormat:@"AMS 700 CXR - %i %%",none]];
    getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"devimp_AMS700LGX"];
    none = [getNumberFromDictionary integerValue] ;
    [self.devimp_AMS700LGX setText:[NSString stringWithFormat:@"AMS 700 LGX - %i %%",none]];
    getNumberFromDictionary = [self.devimp_dictionary valueForKey:@"devimp_ColoplastTitan"];
    none = [getNumberFromDictionary integerValue] ;
    [self.devimp_ColoplastTitan setText:[NSString stringWithFormat:@"Coloplast Titan - %i %%",none]];
    
    [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
    [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
    
    if (IS_IPHONE_5) {
        CGRect frame = self.devimp_view.frame;
        frame.origin.y = 57;
        [self.devimp_view setFrame:frame];
        
    }else{
        CGRect frame = self.devimp_view.frame;
        frame.origin.y = 45;
        [self.devimp_view setFrame:frame];
    }
    self.scrollview.contentSize = self.devimp_view.bounds.size;
    self.devimp_view.frame = CGRectMake(self.devimp_view.frame.origin.x, self.devimp_view.frame.origin.y-64, self.devimp_view.frame.size.width, self.devimp_view.frame.size.height);
    
    [self.scrollview addSubview:self.devimp_view];

}




-(void) drawDiagnosis{
//===============================================================================================
//Diagnosis (Erectile Dysfunction, Peyronie’s Disease, Prostate Cancer, Hypertension, Dyslipidemia, Coronary Artery Disease, Diabetes Mellitus, Spinal Cord Injury, Pelvic Trauma, Penile Trauma), multiple may be chosen
    self.scrollview.hidden = NO;
//    s_diag_ErectileDysfunction;
//    s_diag_PeyroniesDisease;
//   s_diag_ProstateCancer;
//    
//    s_diag_Hypertension;
//    s_diag_Dyslipidemia;
//    s_diag_CoronaryArteryDisease;
//    
//    s_diag_DiabetesMellitus;
//    s_diag_SpinalCordInjury;
//    s_diag_PelvicTrauma;
//    s_diag_PenileTrauma;

    [self.diag_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.s_diag_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    
    NSNumber *getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_ErectileDysfunction"];
    int none = [getNumberFromDictionary integerValue] ;
    [self.s_diag_ErectileDysfunction setText:[NSString stringWithFormat:@"Erectile Dysfunction - %i %%",none]];
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_PeyroniesDisease"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_diag_PeyroniesDisease setText:[NSString stringWithFormat:@"Peyronie’s Disease - %i %%",none]];
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_ProstateCancer"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_diag_ProstateCancer setText:[NSString stringWithFormat:@"Prostate Cancer - %i %%",none]];
    
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_Hypertension"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_diag_Hypertension setText:[NSString stringWithFormat:@"Hypertension - %i %%",none]];
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_Dyslipidemia"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_diag_Dyslipidemia setText:[NSString stringWithFormat:@"Dyslipidemia - %i %%",none]];
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_CoronaryArteryDisease"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_diag_CoronaryArteryDisease setText:[NSString stringWithFormat:@"Coronary Artery Disease - %i %%",none]];
    
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_DiabetesMellitus"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_diag_DiabetesMellitus setText:[NSString stringWithFormat:@"Diabetes Mellitus - %i %%",none]];
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_SpinalCordInjury"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_diag_SpinalCordInjury setText:[NSString stringWithFormat:@"Spinal Cord Injury - %i %%",none]];
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_PelvicTrauma"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_diag_PelvicTrauma setText:[NSString stringWithFormat:@"Pelvic Trauma - %i %%",none]];
    
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"s_diag_PenileTrauma"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_diag_PenileTrauma setText:[NSString stringWithFormat:@"Penile Trauma - %i %%",none]];
    
    
    
    
    
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_ErectileDysfunction"];
    none = [getNumberFromDictionary integerValue] ;
    [self.diag_ErectileDysfunction setText:[NSString stringWithFormat:@"Erectile Dysfunction - %i %%",none]];
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_PeyroniesDisease"];
    none = [getNumberFromDictionary integerValue] ;
    [self.diag_PeyroniesDisease setText:[NSString stringWithFormat:@"Peyronie’s Disease - %i %%",none]];
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_ProstateCancer"];
    none = [getNumberFromDictionary integerValue] ;
    [self.diag_ProstateCancer setText:[NSString stringWithFormat:@"Prostate Cancer - %i %%",none]];
    
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_Hypertension"];
    none = [getNumberFromDictionary integerValue] ;
    [self.diag_Hypertension setText:[NSString stringWithFormat:@"Hypertension - %i %%",none]];
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_Dyslipidemia"];
    none = [getNumberFromDictionary integerValue] ;
    [self.diag_Dyslipidemia setText:[NSString stringWithFormat:@"Dyslipidemia - %i %%",none]];
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_CoronaryArteryDisease"];
    none = [getNumberFromDictionary integerValue] ;
    [self.diag_CoronaryArteryDisease setText:[NSString stringWithFormat:@"Coronary Artery Disease - %i %%",none]];
    
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_DiabetesMellitus"];
    none = [getNumberFromDictionary integerValue] ;
    [self.diag_DiabetesMellitus setText:[NSString stringWithFormat:@"Diabetes Mellitus - %i %%",none]];
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_SpinalCordInjury"];
    none = [getNumberFromDictionary integerValue] ;
    [self.diag_SpinalCordInjury setText:[NSString stringWithFormat:@"Spinal Cord Injury - %i %%",none]];
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_PelvicTrauma"];
    none = [getNumberFromDictionary integerValue] ;
    [self.diag_PelvicTrauma setText:[NSString stringWithFormat:@"Pelvic Trauma - %i %%",none]];
    
    getNumberFromDictionary = [self.diag_dictionary valueForKey:@"diag_PenileTrauma"];
    none = [getNumberFromDictionary integerValue] ;
    [self.diag_PenileTrauma setText:[NSString stringWithFormat:@"Penile Trauma - %i %%",none]];
    
    
    
    
    [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
    [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
    
    if (IS_IPHONE_5) {
        CGRect frame = self.diag_view.frame;
        frame.origin.y = 57;
        [self.diag_view setFrame:frame];
        
    }else{
        CGRect frame = self.diag_view.frame;
        frame.origin.y = 45;
        [self.diag_view setFrame:frame];
    }
    self.scrollview.contentSize = self.diag_view.bounds.size;
    self.diag_view.frame = CGRectMake(self.diag_view.frame.origin.x, self.diag_view.frame.origin.y-64, self.diag_view.frame.size.width, self.diag_view.frame.size.height);
    
    [self.scrollview addSubview:self.diag_view];
    
}

-(void) drawIrrigation{
//===============================================================================================
//Irrigation antibiotics used (Neomycin, Bacitracin, Gentamicin, Vancomycin, Amphotericin B, Rifampin), multiple choices can be selected
    self.scrollview.hidden = NO;
    //irri_Neomycin
    //irri_Bacitracin
    //irri_Gentamicin
    //irri_Vancomycin
    //irri_AmphotericinB
    //irri_Rifampin
    [self.irri_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.s_irri_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    NSNumber *getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_Neomycin"];
    int none = [getNumberFromDictionary integerValue] ;
    [self.s_irri_Neomycin setText:[NSString stringWithFormat:@"Neomycin - %i %%",none]];
    getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_Bacitracin"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_irri_Bacitracin setText:[NSString stringWithFormat:@"Bacitracin - %i %%",none]];
    getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_Gentamicin"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_irri_Gentamicin setText:[NSString stringWithFormat:@"Gentamicin - %i %%",none]];
    getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_Vancomycin"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_irri_Vancomycin setText:[NSString stringWithFormat:@"Vancomycin - %i %%",none]];
    getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_AmphotericinB"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_irri_AmphotericinB setText:[NSString stringWithFormat:@"Amphotericin B - %i %%",none]];
    getNumberFromDictionary = [self.irri_dictionary valueForKey:@"s_irri_Rifampin"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_irri_Rifampin setText:[NSString stringWithFormat:@"Rifampin - %i %%",none]];
    
    getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_Neomycin"];
    none = [getNumberFromDictionary integerValue] ;
    [self.irri_Neomycin setText:[NSString stringWithFormat:@"Neomycin - %i %%",none]];
    getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_Bacitracin"];
    none = [getNumberFromDictionary integerValue] ;
    [self.irri_Bacitracin setText:[NSString stringWithFormat:@"Bacitracin - %i %%",none]];
    getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_Gentamicin"];
    none = [getNumberFromDictionary integerValue] ;
    [self.irri_Gentamicin setText:[NSString stringWithFormat:@"Gentamicin - %i %%",none]];
    getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_Vancomycin"];
    none = [getNumberFromDictionary integerValue] ;
    [self.irri_Vancomycin setText:[NSString stringWithFormat:@"Vancomycin - %i %%",none]];
    getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_AmphotericinB"];
    none = [getNumberFromDictionary integerValue] ;
    [self.irri_AmphotericinB setText:[NSString stringWithFormat:@"Amphotericin B - %i %%",none]];
    getNumberFromDictionary = [self.irri_dictionary valueForKey:@"irri_Rifampin"];
    none = [getNumberFromDictionary integerValue] ;
    [self.irri_Rifampin setText:[NSString stringWithFormat:@"Rifampin - %i %%",none]];
    
    

    
    [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
    [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];

    if (IS_IPHONE_5) {
        CGRect frame = self.irri_view.frame;
        frame.origin.y = 57;
        [self.irri_view setFrame:frame];
        
    }else{
        CGRect frame = self.irri_view.frame;
        frame.origin.y = 45;
        [self.irri_view setFrame:frame];
    }
    self.scrollview.contentSize = self.irri_view.bounds.size;
    self.irri_view.frame = CGRectMake(self.irri_view.frame.origin.x, self.irri_view.frame.origin.y-64, self.irri_view.frame.size.width, self.irri_view.frame.size.height);
    
    [self.scrollview addSubview:self.irri_view];

}
-(void) drawComplications {
 //   averageViewTitleLabel.text = @"Average Age";
//    oneLabel.text = [NSString stringWithFormat:@"Average Age of Patient = %i (%i to %i years old )",averageAge,minAge,maxAge];
    
//    oneSurLabel.text = [NSString stringWithFormat:@"Average Age of Patient = %i (%i to %i years old )",sur_averageAge,sur_minAge,sur_maxAge];
    self.scrollview.hidden = NO;
    [self.comp_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.s_comp_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    NSNumber *getNumberFromDictionary = [self.comp_dictionary valueForKey:@"s_comp_none"];
    int none = [getNumberFromDictionary integerValue] ;
    [self.s_comp_none setText:[NSString stringWithFormat:@"None - %i %%",none]];
    getNumberFromDictionary = [self.comp_dictionary valueForKey:@"s_comp_open"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_comp_open setText:[NSString stringWithFormat:@"Converted to open - %i %%",none]];
    getNumberFromDictionary = [self.comp_dictionary valueForKey:@"s_comp_bowel"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_comp_bowel setText:[NSString stringWithFormat:@"Bowel injury - %i %%",none]];
    getNumberFromDictionary = [self.comp_dictionary valueForKey:@"s_comp_rectal"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_comp_rectal setText:[NSString stringWithFormat:@"Rectal injury - %i %%",none]];
    getNumberFromDictionary = [self.comp_dictionary valueForKey:@"s_comp_transfusion"];
    none = [getNumberFromDictionary integerValue] ;
    [self.s_comp_transfusion setText:[NSString stringWithFormat:@"Transfusion - %i %%",none]];
    
    
    getNumberFromDictionary = [self.comp_dictionary valueForKey:@"comp_none"];
    none = [getNumberFromDictionary integerValue] ;
    [self.comp_none setText:[NSString stringWithFormat:@"None - %i %%",none]];
    getNumberFromDictionary = [self.comp_dictionary valueForKey:@"comp_open"];
    none = [getNumberFromDictionary integerValue] ;
    [self.comp_open setText:[NSString stringWithFormat:@"Converted to open - %i %%",none]];
    getNumberFromDictionary = [self.comp_dictionary valueForKey:@"comp_bowel"];
    none = [getNumberFromDictionary integerValue] ;
    [self.comp_bowel setText:[NSString stringWithFormat:@"Bowel injury - %i %%",none]];
    getNumberFromDictionary = [self.comp_dictionary valueForKey:@"comp_rectal"];
    none = [getNumberFromDictionary integerValue] ;
    [self.comp_rectal setText:[NSString stringWithFormat:@"Rectal injury - %i %%",none]];
    getNumberFromDictionary = [self.comp_dictionary valueForKey:@"comp_transfusion"];
    none = [getNumberFromDictionary integerValue] ;
    [self.comp_transfusion setText:[NSString stringWithFormat:@"Transfusion - %i %%",none]];


    
//    [twoLabel setHidden:YES];
//    [twoSurLabel setHidden:YES];
    
    [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
    [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
//    
//    if (!self.isNationalData) {
//        [self.oneSurLabel setHidden:YES];
//        [self.twoSurLabel setHidden:YES];
//        [self.Surgeon setHidden:YES];
//    }
//    
    if (IS_IPHONE_5) {
        CGRect frame = self.comp_view.frame;
        frame.origin.y = 57;
        [self.comp_view setFrame:frame];
        
    }else{
        CGRect frame = self.comp_view.frame;
        frame.origin.y = 45;
        [self.comp_view setFrame:frame];
    }
    self.scrollview.contentSize = self.comp_view.bounds.size;
    self.comp_view.frame = CGRectMake(self.comp_view.frame.origin.x, self.comp_view.frame.origin.y-64, self.comp_view.frame.size.width, self.comp_view.frame.size.height);
    
    [self.scrollview addSubview:self.comp_view];
    //[self.view addSubview:self.comp_view];
    
}




-(void)drawAverageAgeGraph {
    
    averageViewTitleLabel.text = @"Average Age";
    oneLabel.text = [NSString stringWithFormat:@"Average Age of Patient = %i (%i to %i years old )",averageAge,minAge,maxAge];

    oneSurLabel.text = [NSString stringWithFormat:@"Average Age of Patient = %i (%i to %i years old )",sur_averageAge,sur_minAge,sur_maxAge];
    
    [twoLabel setHidden:YES];
    [twoSurLabel setHidden:YES];
    
    [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
    [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
    
    if (!self.isNationalData) {
        [self.oneSurLabel setHidden:YES];
        [self.twoSurLabel setHidden:YES];
        [self.Surgeon setHidden:YES];
    }
    
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
   
}


-(void)drawConsoleTimeGraph{
    
    averageViewTitleLabel.text = @"Average Console Time";
    oneLabel.text = [NSString stringWithFormat:@"Average Console Time = %i (%.0f to %.0f mins )",consolePercentage,minConsoleTime,maxConsoleTime];
    self.oneSurLabel.text = [NSString stringWithFormat:@"Average Console Time = %i (%.0f to %.0f mins )",sur_consolePercentage,sur_minConsoleTime,sur_maxConsoleTime];
    
    [twoLabel setHidden:YES];
    [twoSurLabel setHidden:YES];
    
    [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
    [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
    
    if (!self.isNationalData) {
        [self.oneSurLabel setHidden:YES];
        [self.twoSurLabel setHidden:YES];
        [self.Surgeon setHidden:YES];
    }
    
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
    
}


-(void)drawRoomTimeGraph{
    
    averageViewTitleLabel.text = @"Average Room Time";
    oneLabel.text = [NSString stringWithFormat:@"Average Room Time = %i (%.0f to %.0f mins )",roomTimePercentage,minRoomTime,maxRoomTime];
    
    self.oneSurLabel.text = [NSString stringWithFormat:@"Average Room Time = %i (%.0f to %.0f mins )",sur_roomTimePercentage,sur_minRoomTime,sur_maxRoomTime];
    
    [twoLabel setHidden:YES];
    [twoSurLabel setHidden:YES];
    
    [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
    [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
    
    if (!self.isNationalData) {
        [self.oneSurLabel setHidden:YES];
        [self.twoSurLabel setHidden:YES];
        [self.Surgeon setHidden:YES];
    }
    
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
    
}


-(void)drawClampTimeGraph{
    
    averageViewTitleLabel.text = @"Average Clamp Time";
    oneLabel.text = [NSString stringWithFormat:@"Average Clamp Time = %i (%.0f to %.0f mins )",clampTimePercentage,minClampTime,maxClampTime];
    
    self.oneSurLabel.text = [NSString stringWithFormat:@"Average Clamp Time = %i (%.0f to %.0f mins )",sur_clampTimePercentage,sur_minClampTime,sur_maxClampTime];
    
    [twoLabel setHidden:YES];
    [twoSurLabel setHidden:YES];
    
    [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
    [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
    
    if (!self.isNationalData) {
        [self.oneSurLabel setHidden:YES];
        [self.twoSurLabel setHidden:YES];
        [self.Surgeon setHidden:YES];
    }
    
    
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
    
}


-(void)drawBMIGraph{
  if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9) {
    averageViewTitleLabel.text = @"Average Device Length";
    oneLabel.text = [NSString stringWithFormat:@"Average Device Length of Patient = %.1f (%.1f to %.1f Units)",bmiPercentage,minBmi,maxBmi];
    
    self.oneSurLabel.text = [NSString stringWithFormat:@"Average Device Length of Patient = %.1f (%.1f to %.1f Units)",sur_bmiPercentage,sur_minBmi,sur_maxBmi];
    NSLog(@"perce %f", sur_bmiPercentage);
    
    [twoLabel setHidden:YES];
    [twoSurLabel setHidden:YES];
    
    [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
    [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
    
    if (!self.isNationalData) {
        [self.oneSurLabel setHidden:YES];
        [self.twoSurLabel setHidden:YES];
        [self.Surgeon setHidden:YES];
    }
    
    
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
  } else {
      averageViewTitleLabel.text = @"Average BMI";
      oneLabel.text = [NSString stringWithFormat:@"Average BMI of Patient = %.1f (%.1f to %.1f Units)",bmiPercentage,minBmi,maxBmi];
      
      self.oneSurLabel.text = [NSString stringWithFormat:@"Average BMI of Patient = %.1f (%.1f to %.1f Units)",sur_bmiPercentage,sur_minBmi,sur_maxBmi];
      NSLog(@"perce %f", sur_bmiPercentage);
      
      [twoLabel setHidden:YES];
      [twoSurLabel setHidden:YES];
      
      [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
      [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
      
      if (!self.isNationalData) {
          [self.oneSurLabel setHidden:YES];
          [self.twoSurLabel setHidden:YES];
          [self.Surgeon setHidden:YES];
      }
      
      
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
  }
}


-(void)drawBloodLossGraph{
    
    averageViewTitleLabel.text = @"Average Blood Loss";
    oneLabel.text = [NSString stringWithFormat:@"Average Blood Loss = %.1f (%.1f to %.1f ml)",bloodLossPercentage,minBloodLoss,maxBloodLoss];
    
    self.oneSurLabel.text = [NSString stringWithFormat:@"Average Blood Loss = %.1f (%.1f to %.1f ml)",sur_bloodLossPercentage,sur_minBloodLoss,sur_maxBloodLoss];
    
    [twoLabel setHidden:YES];
    [twoSurLabel setHidden:YES];
    
    [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
    [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
    
    if (!self.isNationalData) {
        [self.oneSurLabel setHidden:YES];
        [self.twoSurLabel setHidden:YES];
        [self.Surgeon setHidden:YES];
    }
    
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
    
}


-(void)drawTumorSizeGraph{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9) {
        averageViewTitleLabel.text = @"Average Reservoir filling";
        oneLabel.text = [NSString stringWithFormat:@"Average Reservoir filling = %.1f (%.1f to %.1f cm)",tumorSizePercentage,minTumorSize,maxTumorSize];
        
        self.oneSurLabel.text = [NSString stringWithFormat:@"Average Reservoir filling = %.1f (%.1f to %.1f cm)",sur_tumorSizePercentage,sur_minTumorSize,sur_maxTumorSize];
        
        [twoLabel setHidden:YES];
        [twoSurLabel setHidden:YES];
        
        [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
        [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
        
        if (!self.isNationalData) {
            [self.oneSurLabel setHidden:YES];
            [self.twoSurLabel setHidden:YES];
            [self.Surgeon setHidden:YES];
        }
        
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
    } else {
        averageViewTitleLabel.text = @"Average Tumor Size";
        oneLabel.text = [NSString stringWithFormat:@"Average Tumor Size = %.1f (%.1f to %.1f cm)",tumorSizePercentage,minTumorSize,maxTumorSize];
        
        self.oneSurLabel.text = [NSString stringWithFormat:@"Average Tumor Size = %.1f (%.1f to %.1f cm)",sur_tumorSizePercentage,sur_minTumorSize,sur_maxTumorSize];
        
        [twoLabel setHidden:YES];
        [twoSurLabel setHidden:YES];
        
        [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
        [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
        
        if (!self.isNationalData) {
            [self.oneSurLabel setHidden:YES];
            [self.twoSurLabel setHidden:YES];
            [self.Surgeon setHidden:YES];
        }
        
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
    }
    
   
}


-(void)drawDMarginGraph{
    
    averageViewTitleLabel.text = @"Deep Margins";
    oneLabel.text = [NSString stringWithFormat:@"%i %% Negative",(100-dmPositive)];
    twoLabel.text = [NSString stringWithFormat:@"%i %% Positive",dmPositive];
    
    self.oneSurLabel.text = [NSString stringWithFormat:@"%i %% Negative",(100-sur_dmPositive)];
    self.twoSurLabel.text = [NSString stringWithFormat:@"%i %% Positive",sur_dmPositive];
    
    [twoLabel setHidden:NO];
    if (!self.isNationalData) {
        [self.oneSurLabel setHidden:YES];
        [self.twoSurLabel setHidden:YES];
        [self.Surgeon setHidden:YES];
    }
    
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
    
}


-(void)drawMaleFemaleGraph{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9) {
        averageViewTitleLabel.text = @"Drain placed";
        
        oneLabel.text = [NSString stringWithFormat:@"%i %% Yes",malePercentage];
        twoLabel.text = [NSString stringWithFormat:@"%i %% No", (100-malePercentage)];
        
        self.oneSurLabel.text = [NSString stringWithFormat:@"%i %% Yes",sur_malePercentage];
        self.twoSurLabel.text = [NSString stringWithFormat:@"%i %% No",(100-sur_malePercentage)];
        
        [twoLabel setHidden:NO];
        if (!self.isNationalData) {
            [self.oneSurLabel setHidden:YES];
            [self.twoSurLabel setHidden:YES];
            [self.Surgeon setHidden:YES];
        }
        
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
 
    }else{
        averageViewTitleLabel.text = @"Male vs. Female";
        
        oneLabel.text = [NSString stringWithFormat:@"%i %% Female",malePercentage];
        twoLabel.text = [NSString stringWithFormat:@"%i %% Male", (100-malePercentage)];
        
        self.oneSurLabel.text = [NSString stringWithFormat:@"%i %% Female",sur_malePercentage];
        self.twoSurLabel.text = [NSString stringWithFormat:@"%i %% Male",(100-sur_malePercentage)];
        
        [twoLabel setHidden:NO];
        if (!self.isNationalData) {
            [self.oneSurLabel setHidden:YES];
            [self.twoSurLabel setHidden:YES];
            [self.Surgeon setHidden:YES];
        }
        
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
 
    }
    
}


-(void)drawLeftRightRenalGraph{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9) {
        averageViewTitleLabel.text = @"Reservoir side";
        oneLabel.text = [NSString stringWithFormat:@"%i %% Right",(100-LRMPercentage)];
        twoLabel.text = [NSString stringWithFormat:@"%i %% Left",LRMPercentage];
        
        self.oneSurLabel.text = [NSString stringWithFormat:@"%i %% Right",(100-sur_LRMPercentage)];
        self.twoSurLabel.text = [NSString stringWithFormat:@"%i %% Left",sur_LRMPercentage];
        
        [twoLabel setHidden:NO];
        if (!self.isNationalData) {
            [self.oneSurLabel setHidden:YES];
            [self.twoSurLabel setHidden:YES];
            [self.Surgeon setHidden:YES];
        }
        
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
    }else{
        averageViewTitleLabel.text = @"Left vs. Right Renal Mass";
        oneLabel.text = [NSString stringWithFormat:@"%i %% Right",(100-LRMPercentage)];
        twoLabel.text = [NSString stringWithFormat:@"%i %% Left",LRMPercentage];
        
        self.oneSurLabel.text = [NSString stringWithFormat:@"%i %% Right",(100-sur_LRMPercentage)];
        self.twoSurLabel.text = [NSString stringWithFormat:@"%i %% Left",sur_LRMPercentage];
        
        [twoLabel setHidden:NO];
        if (!self.isNationalData) {
            [self.oneSurLabel setHidden:YES];
            [self.twoSurLabel setHidden:YES];
            [self.Surgeon setHidden:YES];
        }
        
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
    }
    
    
}


-(void)drawCytoStentGraph{
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9) {
        averageViewTitleLabel.text = @"Complications";
        oneLabel.text = [NSString stringWithFormat:@"%i %% No",(100-cytoStentPercentage)];
        twoLabel.text = [NSString stringWithFormat:@"%i %% Yes",cytoStentPercentage];
        
        self.oneSurLabel.text = [NSString stringWithFormat:@"%i %% No",(100-sur_cytoStentPercentage)];
        self.twoSurLabel.text = [NSString stringWithFormat:@"%i %% Yes",sur_cytoStentPercentage];
        
        [twoLabel setHidden:NO];
        if (!self.isNationalData) {
            [self.oneSurLabel setHidden:YES];
            [self.twoSurLabel setHidden:YES];
            [self.Surgeon setHidden:YES];
        }
        
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
    }else{
        averageViewTitleLabel.text = @"Cyto/Stent";
        oneLabel.text = [NSString stringWithFormat:@"%i %% No",(100-cytoStentPercentage)];
        twoLabel.text = [NSString stringWithFormat:@"%i %% Yes",cytoStentPercentage];
        
        self.oneSurLabel.text = [NSString stringWithFormat:@"%i %% No",(100-sur_cytoStentPercentage)];
        self.twoSurLabel.text = [NSString stringWithFormat:@"%i %% Yes",sur_cytoStentPercentage];
        
        [twoLabel setHidden:NO];
        if (!self.isNationalData) {
            [self.oneSurLabel setHidden:YES];
            [self.twoSurLabel setHidden:YES];
            [self.Surgeon setHidden:YES];
        }
        
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
    }
    
    
}


-(void)drawAdhesiolysisGraph{
    
    averageViewTitleLabel.text = @"Adhesiolysis Required";
    oneLabel.text = [NSString stringWithFormat:@"%i %% No",(100-requiredPercentage)];
    twoLabel.text = [NSString stringWithFormat:@"%i %% Yes",requiredPercentage];
    
    self.oneSurLabel.text = [NSString stringWithFormat:@"%i %% No",(100-sur_requiredPercentage)];
    self.twoSurLabel.text = [NSString stringWithFormat:@"%i %% Yes",sur_requiredPercentage];
    
    [twoLabel setHidden:NO];
    if (!self.isNationalData) {
        [self.oneSurLabel setHidden:YES];
        [self.twoSurLabel setHidden:YES];
        [self.Surgeon setHidden:YES];
    }
    
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
    
}


-(void)drawAnomoliesGraph{
    NSString *procId = [OKProceduresManager instance].selectedProcedure.identifier;
    if ([[NSString stringWithFormat:@"%@",procId] isEqualToString:@"1"]) {
        averageViewTitleLabel.text = @"Bladder Neck Recon";
    }else{
        averageViewTitleLabel.text = @"Vascular Anomolies";
    }
    oneLabel.text = [NSString stringWithFormat:@"%i %% No",(100-anomoliesPercentage)];
    twoLabel.text = [NSString stringWithFormat:@"%i %% Yes",anomoliesPercentage];
    
    self.oneSurLabel.text = [NSString stringWithFormat:@"%i %% No",(100-sur_anomoliesPercentage)];
    self.twoSurLabel.text = [NSString stringWithFormat:@"%i %% Yes",sur_anomoliesPercentage];
    
    [twoLabel setHidden:NO];
    if (!self.isNationalData) {
        [self.oneSurLabel setHidden:YES];
        [self.twoSurLabel setHidden:YES];
        [self.Surgeon setHidden:YES];
    }
    
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
    
}


-(void)drawIOUSGraph{
    
    averageViewTitleLabel.text = @"Intra Operative Ultra Sound";
    oneLabel.text = [NSString stringWithFormat:@"%i %% No",(100-iousPercentage)];
    twoLabel.text = [NSString stringWithFormat:@"%i %% Yes",iousPercentage];
    
    self.oneSurLabel.text = [NSString stringWithFormat:@"%i %% No",(100-sur_iousPercentage)];
    self.twoSurLabel.text = [NSString stringWithFormat:@"%i %% Yes",sur_iousPercentage];
    
    [twoLabel setHidden:NO];
    if (!self.isNationalData) {
        [self.oneSurLabel setHidden:YES];
        [self.twoSurLabel setHidden:YES];
        [self.Surgeon setHidden:YES];
    }
    
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
    
}


-(void)drawRenalRSGraph{
    
    averageViewTitleLabel.text = @"Renal Collecting Repair System";
    oneLabel.text = [NSString stringWithFormat:@"%i %% No",(100-renalRSPercentage)];
    twoLabel.text = [NSString stringWithFormat:@"%i %% Yes",renalRSPercentage];
    
    self.oneSurLabel.text = [NSString stringWithFormat:@"%i %% No",(100-sur_renalRSPercentage)];
    self.twoSurLabel.text = [NSString stringWithFormat:@"%i %% Yes",sur_renalRSPercentage];
    
    [twoLabel setHidden:NO];
    if (!self.isNationalData) {
        [self.oneSurLabel setHidden:YES];
        [self.twoSurLabel setHidden:YES];
        [self.Surgeon setHidden:YES];
    }
    
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
    
}


-(void)drawCoagulantGraph{
    
    averageViewTitleLabel.text = @"Coagulants Used";
    oneLabel.text = [NSString stringWithFormat:@"%i %% No",(100-coagulantPercentage)];
    twoLabel.text = [NSString stringWithFormat:@"%i %% Yes",coagulantPercentage];
    
    self.oneSurLabel.text = [NSString stringWithFormat:@"%i %% No",(100-sur_coagulantPercentage)];
    self.twoSurLabel.text = [NSString stringWithFormat:@"%i %% Yes",sur_coagulantPercentage];
    
    [twoLabel setHidden:NO];
    if (!self.isNationalData) {
        [self.oneSurLabel setHidden:YES];
        [self.twoSurLabel setHidden:YES];
        [self.Surgeon setHidden:YES];
    }
    
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
    
}


-(void)drawTransfusionGraph{
    
    averageViewTitleLabel.text = @"Transfusion Required";
    oneLabel.text = [NSString stringWithFormat:@"%i %% No",(100-transfusionPercentage)];
    twoLabel.text = [NSString stringWithFormat:@"%i %% Yes",transfusionPercentage];
    
    self.oneSurLabel.text = [NSString stringWithFormat:@"%i %% No",(100-sur_transfusionPercentage)];
    self.twoSurLabel.text = [NSString stringWithFormat:@"%i %% Yes",sur_transfusionPercentage];
    
    [twoLabel setHidden:NO];
    if (!self.isNationalData) {
        [self.oneSurLabel setHidden:YES];
        [self.twoSurLabel setHidden:YES];
        [self.Surgeon setHidden:YES];
    }
    
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
    
}



@end