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
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //averageAge = 70;
    
    self.navigationItem.title = @"Post-Op Data";
    _nationalDataView.hidden = YES;
    _comp_nationalDataView.hidden = YES;
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


-(void) drawComplications {
 //   averageViewTitleLabel.text = @"Average Age";
//    oneLabel.text = [NSString stringWithFormat:@"Average Age of Patient = %i (%i to %i years old )",averageAge,minAge,maxAge];
    
//    oneSurLabel.text = [NSString stringWithFormat:@"Average Age of Patient = %i (%i to %i years old )",sur_averageAge,sur_minAge,sur_maxAge];
    [self.comp_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.NationalSize]];
    [self.s_comp_sampleSize setText:[NSString stringWithFormat:@"Sample size (N = %i)",self.SurgeonSize]];
    
    [self.s_comp_none setText:[NSString stringWithFormat:@"None - %i %%",(int)[self.comp_dictionary objectForKey:@"s_comp_none"]]];
    [self.s_comp_open setText:[NSString stringWithFormat:@"Converted to open - %i %%",(int)[self.comp_dictionary objectForKey:@"s_comp_open"]]];
    [self.s_comp_bowel setText:[NSString stringWithFormat:@"Bowel injury - %i %%",(int)[self.comp_dictionary objectForKey:@"s_comp_bowel"]]];
    [self.s_comp_rectal setText:[NSString stringWithFormat:@"Rectal injury - %i %%",(int)[self.comp_dictionary objectForKey:@"s_comp_rectal"]]];
    [self.s_comp_transfusion setText:[NSString stringWithFormat:@"Transfusion - %i %%",(int)[self.comp_dictionary objectForKey:@"s_comp_transfusion"]]];

    [self.comp_none setText:[NSString stringWithFormat:@"None - %i %%",(int)[self.comp_dictionary objectForKey:@"comp_none"]]];
    [self.comp_open setText:[NSString stringWithFormat:@"Converted to open - %i %%",(int)[self.comp_dictionary objectForKey:@"comp_open"]]];
    [self.comp_bowel setText:[NSString stringWithFormat:@"Bowel injury - %i %%",(int)[self.comp_dictionary objectForKey:@"comp_bowel"]]];
    [self.comp_rectal setText:[NSString stringWithFormat:@"Rectal injury - %i %%",(int)[self.comp_dictionary objectForKey:@"comp_rectal"]]];
    [self.comp_transfusion setText:[NSString stringWithFormat:@"Transfusion - %i %%",(int)[self.comp_dictionary objectForKey:@"comp_transfusion"]]];

    
//    [twoLabel setHidden:YES];
//    [twoSurLabel setHidden:YES];
    
//    [self.NationalSampleSize setFrame:CGRectMake(self.NationalSampleSize.frame.origin.x, self.NationalSampleSize.frame.origin.y-27, self.NationalSampleSize.frame.size.width, self.NationalSampleSize.frame.size.height)];
//    [self.SurgeonSampleSize setFrame:CGRectMake(self.SurgeonSampleSize.frame.origin.x, self.SurgeonSampleSize.frame.origin.y-27, self.SurgeonSampleSize.frame.size.width, self.SurgeonSampleSize.frame.size.height)];
//    
//    if (!self.isNationalData) {
//        [self.oneSurLabel setHidden:YES];
//        [self.twoSurLabel setHidden:YES];
//        [self.Surgeon setHidden:YES];
//    }
//    
//    if (IS_IPHONE_5) {
//        
//        CGRect frame = self.averageView.frame;
//        frame.origin.y = 57;
//        [self.averageView setFrame:frame];
//        
//    }else{
//        CGRect frame = self.averageView.frame;
//        frame.origin.y = 45;
//        [self.averageView setFrame:frame];
//    }
    [self.view addSubview:self.comp_view];
    
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


-(void)drawLeftRightRenalGraph{
    
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


-(void)drawCytoStentGraph{
    
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