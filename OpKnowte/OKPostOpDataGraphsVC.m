//
//  OKPostOpDataGraphsVC.m
//  OpKnowte
//
//  Created by Apple on 21.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKPostOpDataGraphsVC.h"
#define IS_IPHONE_5                     ([[UIScreen mainScreen] bounds].size.height == 568)

@interface OKPostOpDataGraphsVC ()

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //averageAge = 70;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)drawAverageAgeGraph{
    
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
    //    averageTitleLabel.text = @"Average Age";
    //    unitLabel.text = @"Years";
    //    xLabel.text = @"Age";
    //    if (IS_IPHONE_5) {
    //
    //        CGRect frame = self.averageAgeGraph.frame;
    //        frame.origin.y = 57;
    //        [self.averageAgeGraph setFrame:frame];
    //
    //    }else{
    //        CGRect frame = self.averageAgeGraph.frame;
    //        frame.origin.y = 45;
    //        [self.averageAgeGraph setFrame:frame];
    //    }
    //    CGRect tFrame = self.ageView.frame;
    //    if(averageAge>100)
    //        averageAge=100;
    //    if (averageAge > 0) {
    //        tFrame.origin.y = tFrame.origin.y - (averageAge * 3);
    //        tFrame.size.height = tFrame.size.height + (averageAge * 3);
    //    }
    //    self.ageView.frame = tFrame;
    //
    //    [self.view addSubview:averageAgeGraph];
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
    
    //    averageTitleLabel.text = @"Average Console Time";
    //    unitLabel.text = @"Mins";
    //    xLabel.text = @"Time";
    //    if (IS_IPHONE_5) {
    //
    //        CGRect frame = self.averageAgeGraph.frame;
    //        frame.origin.y = 57;
    //        [self.averageAgeGraph setFrame:frame];
    //
    //    }else{
    //        CGRect frame = self.averageAgeGraph.frame;
    //        frame.origin.y = 45;
    //        [self.averageAgeGraph setFrame:frame];
    //    }
    //    CGRect tFrame = self.ageView.frame;
    //    if(consolePercentage>100)
    //        consolePercentage=100;
    //    if (consolePercentage > 0) {
    //        tFrame.origin.y = tFrame.origin.y - (consolePercentage * 3);
    //        tFrame.size.height = tFrame.size.height + (consolePercentage * 3);
    //    }
    //    self.ageView.frame = tFrame;
    //
    //    [self.view addSubview:averageAgeGraph];
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
    //    averageTitleLabel.text = @"Average Room Time";
    //    unitLabel.text = @"Mins";
    //    xLabel.text = @"Time";
    //    if (IS_IPHONE_5) {
    //
    //        CGRect frame = self.averageAgeGraph.frame;
    //        frame.origin.y = 57;
    //        [self.averageAgeGraph setFrame:frame];
    //
    //    }else{
    //        CGRect frame = self.averageAgeGraph.frame;
    //        frame.origin.y = 45;
    //        [self.averageAgeGraph setFrame:frame];
    //    }
    //    CGRect tFrame = self.ageView.frame;
    //    if(roomTimePercentage>100)
    //        roomTimePercentage=100;
    //    if (roomTimePercentage > 0) {
    //        tFrame.origin.y = tFrame.origin.y - (roomTimePercentage * 3);
    //        tFrame.size.height = tFrame.size.height + (roomTimePercentage * 3);
    //    }
    //    self.ageView.frame = tFrame;
    //
    //    [self.view addSubview:averageAgeGraph];
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
    
    
    //    averageTitleLabel.text = @"Average Clamp Time";
    //    unitLabel.text = @"Mins";
    //    xLabel.text = @"Time";
    //    if (IS_IPHONE_5) {
    //
    //        CGRect frame = self.averageAgeGraph.frame;
    //        frame.origin.y = 57;
    //        [self.averageAgeGraph setFrame:frame];
    //
    //    }else{
    //        CGRect frame = self.averageAgeGraph.frame;
    //        frame.origin.y = 45;
    //        [self.averageAgeGraph setFrame:frame];
    //    }
    //    CGRect tFrame = self.ageView.frame;
    //    if(clampTimePercentage>100)
    //        clampTimePercentage=100;
    //    if (clampTimePercentage > 0) {
    //        tFrame.origin.y = tFrame.origin.y - (clampTimePercentage * 3);
    //        tFrame.size.height = tFrame.size.height + (clampTimePercentage * 3);
    //    }
    //    self.ageView.frame = tFrame;
    //
    //    [self.view addSubview:averageAgeGraph];
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
    
    //    averageTitleLabel.text = @"Average BMI";
    //    unitLabel.text = @"Units";
    //    xLabel.text = @"BMI";
    //    if (IS_IPHONE_5) {
    //
    //        CGRect frame = self.averageAgeGraph.frame;
    //        frame.origin.y = 57;
    //        [self.averageAgeGraph setFrame:frame];
    //
    //    }else{
    //        CGRect frame = self.averageAgeGraph.frame;
    //        frame.origin.y = 45;
    //        [self.averageAgeGraph setFrame:frame];
    //    }
    //    CGRect tFrame = self.ageView.frame;
    //    if(bmiPercentage>100)
    //        bmiPercentage=100;
    //    if (bmiPercentage > 0) {
    //        tFrame.origin.y = tFrame.origin.y - (bmiPercentage * 3);
    //        tFrame.size.height = tFrame.size.height + (bmiPercentage * 3);
    //    }
    //    self.ageView.frame = tFrame;
    //    
    //    [self.view addSubview:averageAgeGraph];
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
    
    //    if (IS_IPHONE_5) {
    //
    //        CGRect frame = self.bloodLossView.frame;
    //        frame.origin.y = 57;
    //        [self.bloodLossView setFrame:frame];
    //
    //    }else{
    //        CGRect frame = self.bloodLossView.frame;
    //        frame.origin.y = 45;
    //        [self.bloodLossView setFrame:frame];
    //    }
    //    CGRect tFrame = self.bloodView.frame;
    //    if(bloodLossPercentage>5000)
    //        bloodLossPercentage=5000;
    //    if (bloodLossPercentage > 0) {
    //        tFrame.origin.y = tFrame.origin.y - (bloodLossPercentage * .06f);
    //        tFrame.size.height = tFrame.size.height + (bloodLossPercentage * .06f);
    //    }
    //    self.bloodView.frame = tFrame;
    //
    //    [self.view addSubview:bloodLossView];
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
    
    //    if (IS_IPHONE_5) {
    //
    //        CGRect frame = self.tumorSizeView.frame;
    //        frame.origin.y = 57;
    //        [self.tumorSizeView setFrame:frame];
    //
    //    }else{
    //        CGRect frame = self.tumorSizeView.frame;
    //        frame.origin.y = 45;
    //        [self.tumorSizeView setFrame:frame];
    //    }
    //    CGRect tFrame = self.tumorView.frame;
    //    if(tumorSizePercentage>50)
    //        tumorSizePercentage =50;
    //    if (tumorSizePercentage > 0) {
    //        tFrame.origin.y = tFrame.origin.y - (tumorSizePercentage * 6);
    //        tFrame.size.height = tFrame.size.height + (tumorSizePercentage * 6);
    //    }
    //    self.tumorView.frame = tFrame;
    //
    //    [self.view addSubview:tumorSizeView];
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
    //        tFrame.origin.y = tFrame.origin.y - (dmPositive * 3);
    //        tFrame.size.height = tFrame.size.height + (dmPositive * 3);
    //    }
    //    self.dmPositiveView.frame = tFrame;
    //    int dmNegative = 100-dmPositive;
    //    tFrame = self.dmNegativeView.frame;
    //    if (dmNegative > 0) {
    //        tFrame.origin.y = tFrame.origin.y - (dmNegative * 3);
    //        tFrame.size.height = tFrame.size.height + (dmNegative * 3);
    //    }
    //    self.dmNegativeView.frame = tFrame;
    //
    //    [self.view addSubview:self.DMarginView];
}
-(void)drawMaleFemaleGraph{
    
    averageViewTitleLabel.text = @"Male vs. Female";
    
    oneLabel.text = [NSString stringWithFormat:@"%i %% Female",(100-malePercentage)];
    twoLabel.text = [NSString stringWithFormat:@"%i %% Male",malePercentage];
    
    self.oneSurLabel.text = [NSString stringWithFormat:@"%i %% Female",(100-sur_malePercentage)];
    self.twoSurLabel.text = [NSString stringWithFormat:@"%i %% Male",sur_malePercentage];
    
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
    
    //    if (IS_IPHONE_5) {
    //
    //        CGRect frame = self.maleFemaleView.frame;
    //        frame.origin.y = 57;
    //        [self.maleFemaleView setFrame:frame];
    //
    //    }else{
    //        CGRect frame = self.maleFemaleView.frame;
    //        frame.origin.y = 45;
    //        [self.maleFemaleView setFrame:frame];
    //    }
    //
    //    CGRect tFrame = self.maleView.frame;
    //    if (malePercentage > 0) {
    //        tFrame.origin.y = tFrame.origin.y - (malePercentage * 3);
    //        tFrame.size.height = tFrame.size.height + (malePercentage * 3);
    //    }
    //    self.maleView.frame = tFrame;
    //    int femalePercentage = 100-malePercentage;
    //    tFrame = self.femaleView.frame;
    //    if (femalePercentage > 0) {
    //        tFrame.origin.y = tFrame.origin.y - (femalePercentage * 3);
    //        tFrame.size.height = tFrame.size.height + (femalePercentage * 3);
    //    }
    //    self.femaleView.frame = tFrame;
    //
    //    [self.view addSubview:self.maleFemaleView];
    
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
    
    //    if (IS_IPHONE_5) {
    //
    //        CGRect frame = self.leftRightRenalView.frame;
    //        frame.origin.y = 57;
    //        [self.leftRightRenalView setFrame:frame];
    //
    //    }else{
    //        CGRect frame = self.leftRightRenalView.frame;
    //        frame.origin.y = 45;
    //        [self.leftRightRenalView setFrame:frame];
    //    }
    //
    //    CGRect tFrame = self.leftRenalView.frame;
    //    if (LRMPercentage > 0) {
    //        tFrame.origin.y = tFrame.origin.y - (LRMPercentage * 3);
    //        tFrame.size.height = tFrame.size.height + (LRMPercentage * 3);
    //    }
    //    self.leftRenalView.frame = tFrame;
    //    int rightRenalPercentage = 100-LRMPercentage;
    //    tFrame = self.rightRenalView.frame;
    //    if (rightRenalPercentage > 0) {
    //        tFrame.origin.y = tFrame.origin.y - (rightRenalPercentage * 3);
    //        tFrame.size.height = tFrame.size.height + (rightRenalPercentage * 3);
    //    }
    //    self.rightRenalView.frame = tFrame;
    //
    //    [self.view addSubview:self.leftRightRenalView];
    
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
    
    //    if (IS_IPHONE_5) {
    //
    //        CGRect frame = self.cytoStentView.frame;
    //        frame.origin.y = 57;
    //        [self.cytoStentView setFrame:frame];
    //
    //    }else{
    //        CGRect frame = self.cytoStentView.frame;
    //        frame.origin.y = 45;
    //        [self.cytoStentView setFrame:frame];
    //    }
    //
    //    CGRect tFrame = self.cytoYesView.frame;
    //    if (cytoStentPercentage > 0) {
    //        tFrame.origin.y = tFrame.origin.y - (cytoStentPercentage * 3);
    //        tFrame.size.height = tFrame.size.height + (cytoStentPercentage * 3);
    //    }
    //    self.cytoYesView.frame = tFrame;
    //    int cytoNoPercentage = 100-cytoStentPercentage;
    //    tFrame = self.cytoNoView.frame;
    //    if (cytoNoPercentage > 0) {
    //        tFrame.origin.y = tFrame.origin.y - (cytoNoPercentage * 3);
    //        tFrame.size.height = tFrame.size.height + (cytoNoPercentage * 3);
    //    }
    //    self.cytoNoView.frame = tFrame;
    //
    //    [self.view addSubview:self.cytoStentView];
    
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
    
    //    titleLabel.text = @"Adhesiolysis Required";
    //
    //    if (IS_IPHONE_5) {
    //
    //        CGRect frame = self.renalRSView.frame;
    //        frame.origin.y = 57;
    //        [self.renalRSView setFrame:frame];
    //
    //    }else{
    //        CGRect frame = self.renalRSView.frame;
    //        frame.origin.y = 45;
    //        [self.renalRSView setFrame:frame];
    //    }
    //
    //    CGRect tFrame = self.renalRSYesView.frame;
    //    if ( requiredPercentage> 0) {
    //        tFrame.origin.y = tFrame.origin.y - (requiredPercentage * 3);
    //        tFrame.size.height = tFrame.size.height + (requiredPercentage * 3);
    //    }
    //    self.renalRSYesView.frame = tFrame;
    //    [self.view addSubview:self.renalRSView];
    
    
    
}

-(void)drawAnomoliesGraph{
    
    averageViewTitleLabel.text = @"Vascular Anomolies";
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
    
    //    titleLabel.text = @"Vascular Anomolies";
    //
    //    if (IS_IPHONE_5) {
    //
    //        CGRect frame = self.renalRSView.frame;
    //        frame.origin.y = 57;
    //        [self.renalRSView setFrame:frame];
    //
    //    }else{
    //        CGRect frame = self.renalRSView.frame;
    //        frame.origin.y = 45;
    //        [self.renalRSView setFrame:frame];
    //    }
    //
    //    CGRect tFrame = self.renalRSYesView.frame;
    //    if ( anomoliesPercentage> 0) {
    //        tFrame.origin.y = tFrame.origin.y - (anomoliesPercentage * 3);
    //        tFrame.size.height = tFrame.size.height + (anomoliesPercentage * 3);
    //    }
    //    self.renalRSYesView.frame = tFrame;
    //    [self.view addSubview:self.renalRSView];
    
    
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
    
    //    titleLabel.text = @"Intra Operative Ultra Sound";
    //
    //    if (IS_IPHONE_5) {
    //
    //        CGRect frame = self.renalRSView.frame;
    //        frame.origin.y = 57;
    //        [self.renalRSView setFrame:frame];
    //
    //    }else{
    //        CGRect frame = self.renalRSView.frame;
    //        frame.origin.y = 45;
    //        [self.renalRSView setFrame:frame];
    //    }
    //
    //    CGRect tFrame = self.renalRSYesView.frame;
    //    if ( iousPercentage> 0) {
    //        tFrame.origin.y = tFrame.origin.y - (iousPercentage * 3);
    //        tFrame.size.height = tFrame.size.height + (iousPercentage * 3);
    //    }
    //    self.renalRSYesView.frame = tFrame;
    //    [self.view addSubview:self.renalRSView];
    
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
    
    //    titleLabel.text = @"Renal Collecting Repair System";
    //
    //    if (IS_IPHONE_5) {
    //
    //        CGRect frame = self.renalRSView.frame;
    //        frame.origin.y = 57;
    //        [self.renalRSView setFrame:frame];
    //
    //    }else{
    //        CGRect frame = self.renalRSView.frame;
    //        frame.origin.y = 45;
    //        [self.renalRSView setFrame:frame];
    //    }
    //
    //    CGRect tFrame = self.renalRSYesView.frame;
    //    if ( renalRSPercentage> 0) {
    //        tFrame.origin.y = tFrame.origin.y - (renalRSPercentage * 3);
    //        tFrame.size.height = tFrame.size.height + (renalRSPercentage * 3);
    //    }
    //    self.renalRSYesView.frame = tFrame;
    //    //    int cytoNoPercentage = 100-cytoStentPercentage;
    //    //    tFrame = self.cytoNoView.frame;
    //    //    if (cytoNoPercentage > 0) {
    //    //        tFrame.origin.y = tFrame.origin.y - (cytoNoPercentage * 3);
    //    //        tFrame.size.height = tFrame.size.height + (cytoNoPercentage * 3);
    //    //    }
    //    //    self.cytoNoView.frame = tFrame;
    //
    //    [self.view addSubview:self.renalRSView];
    
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
    
    //    titleLabel.text = @"Coagulants Used";
    //
    //    if (IS_IPHONE_5) {
    //
    //        CGRect frame = self.renalRSView.frame;
    //        frame.origin.y = 57;
    //        [self.renalRSView setFrame:frame];
    //
    //    }else{
    //        CGRect frame = self.renalRSView.frame;
    //        frame.origin.y = 45;
    //        [self.renalRSView setFrame:frame];
    //    }
    //
    //    CGRect tFrame = self.renalRSYesView.frame;
    //    if ( coagulantPercentage> 0) {
    //        tFrame.origin.y = tFrame.origin.y - (coagulantPercentage * 3);
    //        tFrame.size.height = tFrame.size.height + (coagulantPercentage * 3);
    //    }
    //    self.renalRSYesView.frame = tFrame;
    //    //    int cytoNoPercentage = 100-cytoStentPercentage;
    //    //    tFrame = self.cytoNoView.frame;
    //    //    if (cytoNoPercentage > 0) {
    //    //        tFrame.origin.y = tFrame.origin.y - (cytoNoPercentage * 3);
    //    //        tFrame.size.height = tFrame.size.height + (cytoNoPercentage * 3);
    //    //    }
    //    //    self.cytoNoView.frame = tFrame;
    //
    //    [self.view addSubview:self.renalRSView];
    
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
    
    //    titleLabel.text = @"Transfusion Required";
    //
    //    if (IS_IPHONE_5) {
    //
    //        CGRect frame = self.renalRSView.frame;
    //        frame.origin.y = 57;
    //        [self.renalRSView setFrame:frame];
    //
    //    }else{
    //        CGRect frame = self.renalRSView.frame;
    //        frame.origin.y = 45;
    //        [self.renalRSView setFrame:frame];
    //    }
    //
    //    CGRect tFrame = self.renalRSYesView.frame;
    //    if ( transfusionPercentage> 0) {
    //        tFrame.origin.y = tFrame.origin.y - (transfusionPercentage * 3);
    //        tFrame.size.height = tFrame.size.height + (transfusionPercentage * 3);
    //    }
    //    self.renalRSYesView.frame = tFrame;
    //    //    int cytoNoPercentage = 100-cytoStentPercentage;
    //    //    tFrame = self.cytoNoView.frame;
    //    //    if (cytoNoPercentage > 0) {
    //    //        tFrame.origin.y = tFrame.origin.y - (cytoNoPercentage * 3);
    //    //        tFrame.size.height = tFrame.size.height + (cytoNoPercentage * 3);
    //    //    }
    //    //    self.cytoNoView.frame = tFrame;
    //
    //    [self.view addSubview:self.renalRSView];
    
}


@end
