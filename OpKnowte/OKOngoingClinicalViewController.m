//
//  OKOngoingClinicalViewController.m
//  OpKnowte
//
//  Created by Olegek on 28.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKOngoingClinicalViewController.h"
#import "OKProcedurePicker.h"
#import "OKProcedureTextField.h"
#import "OKOngoingData.h"
#import "OKCaseManager.h"
#import "OKTimePointsManager.h"
#import "OKProceduresManager.h"

@interface OKOngoingClinicalViewController ()<OKProcedurePickerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *updateButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPickerView *MDPiker;
@property (strong, nonatomic) IBOutlet UIView *PikerView;
@property (nonatomic) BOOL animatedKeyboard;
@property (nonatomic) int currentTextFieldTag;
@property (strong, nonatomic) IBOutlet UIView *bottonTabBarButton;

@property (nonatomic, strong) OKProcedurePicker *pickerObject;
@property (nonatomic, strong) NSArray *pickerData;
@property (nonatomic, strong) NSMutableDictionary *activeFieldsDict;

@property (strong, nonatomic) NSMutableArray *interactionItems;

- (IBAction)updateTapped:(id)sender;

@end

@implementation OKOngoingClinicalViewController

@synthesize animatedKeyboard,updateButton,MDPiker,currentTextFieldTag,PikerView,bottonTabBarButton,scrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    
    if(!self.ongoingData)
        self.ongoingData = [OKOngoingData new];
    self.interactionItems = [NSMutableArray new];
    self.activeFieldsDict = [NSMutableDictionary new];
    
    bottonTabBarButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradientBG"]];
    
    updateButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    updateButton.layer.cornerRadius = 14;
    
    MDPiker.hidden = NO;
    PikerView.hidden = YES;
    
    PikerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
    if(self.detailPeriod == OKProcedureSummaryDetailTwoWeeks){
        [self setupTwoWeeksElements];
    }else if(self.detailPeriod == OKProcedureSummaryDetailSixWeeks){
        [self setupSixWeeksElements];
    }else if(self.detailPeriod == OKProcedureSummaryDetailRobotic){
        [self setupRoboticElements];
    }else if(self.detailPeriod == OKProcedureSummaryDetailShockwave){
        [self setupShockwaveElements];
    }else{
        [self setupPenileElements];
    }
    [self setupKeyboardNotifications];
    if (IS_IOS6) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
}


-(void)setupShockwaveElements
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if ([_stonesCount isEqualToString:@"1"]) {
       
        [dict setObject:@"stoneFragmentation1_on" forKey:@"name"];
        [dict setObject:@"picker" forKey:@"type"];
        [dict setObject:@[@"Negative", @"Residual fragmentation"] forKey:@"items"];
        [dict setObject:@"Stone Fragmentation 1" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation1" forKey:@"name"];
        [dict setObject:@"numericTextField" forKey:@"type"];
        [dict setObject:@"Stone Fragmentation 1, mm" forKey:@"placeholder"];
        [dict setObject:@"yes" forKey:@"depends"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"postprocedureComplications" forKey:@"name"];
        [dict setObject:@"symbolicTextField" forKey:@"type"];
        [dict setObject:@"Postprocedure Complications" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
    }else if ([_stonesCount isEqualToString:@"2"]){
    
        [dict setObject:@"stoneFragmentation1_on" forKey:@"name"];
        [dict setObject:@"picker" forKey:@"type"];
        [dict setObject:@[@"Negative", @"Residual fragmentation"] forKey:@"items"];
        [dict setObject:@"Stone Fragmentation 1" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation1" forKey:@"name"];
        [dict setObject:@"numericTextField" forKey:@"type"];
        [dict setObject:@"Stone Fragmentation 1, mm" forKey:@"placeholder"];
        [dict setObject:@"yes" forKey:@"depends"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation2_on" forKey:@"name"];
        [dict setObject:@"picker" forKey:@"type"];
        [dict setObject:@[@"Negative", @"Residual fragmentation"] forKey:@"items"];
        [dict setObject:@"Stone Fragmentation 2" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation2" forKey:@"name"];
        [dict setObject:@"numericTextField" forKey:@"type"];
        [dict setObject:@"Stone Fragmentation 2, mm" forKey:@"placeholder"];
        [dict setObject:@"yes" forKey:@"depends"];
        [self addCustomElement:dict];
        [dict removeAllObjects];

        
        [dict setObject:@"postprocedureComplications" forKey:@"name"];
        [dict setObject:@"symbolicTextField" forKey:@"type"];
        [dict setObject:@"Postprocedure Complications" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
    }else if ([_stonesCount isEqualToString:@"3"]){
    
        [dict setObject:@"stoneFragmentation1_on" forKey:@"name"];
        [dict setObject:@"picker" forKey:@"type"];
        [dict setObject:@[@"Negative", @"Residual fragmentation"] forKey:@"items"];
        [dict setObject:@"Stone Fragmentation 1" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation1" forKey:@"name"];
        [dict setObject:@"numericTextField" forKey:@"type"];
        [dict setObject:@"Stone Fragmentation 1, mm" forKey:@"placeholder"];
        [dict setObject:@"yes" forKey:@"depends"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation2_on" forKey:@"name"];
        [dict setObject:@"picker" forKey:@"type"];
        [dict setObject:@[@"Negative", @"Residual fragmentation"] forKey:@"items"];
        [dict setObject:@"Stone Fragmentation 2" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation2" forKey:@"name"];
        [dict setObject:@"numericTextField" forKey:@"type"];
        [dict setObject:@"Stone Fragmentation 2, mm" forKey:@"placeholder"];
        [dict setObject:@"yes" forKey:@"depends"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
       
        [dict setObject:@"stoneFragmentation3_on" forKey:@"name"];
        [dict setObject:@"picker" forKey:@"type"];
        [dict setObject:@[@"Negative", @"Residual fragmentation"] forKey:@"items"];
        [dict setObject:@"Stone Fragmentation 3" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation3" forKey:@"name"];
        [dict setObject:@"numericTextField" forKey:@"type"];
        [dict setObject:@"Stone Fragmentation 3, mm" forKey:@"placeholder"];
        [dict setObject:@"yes" forKey:@"depends"];
        [self addCustomElement:dict];
        [dict removeAllObjects];

        
        
        [dict setObject:@"postprocedureComplications" forKey:@"name"];
        [dict setObject:@"symbolicTextField" forKey:@"type"];
        [dict setObject:@"Postprocedure Complications" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
    
    }else if ([_stonesCount isEqualToString:@"4"]){
    
        [dict setObject:@"stoneFragmentation1_on" forKey:@"name"];
        [dict setObject:@"picker" forKey:@"type"];
        [dict setObject:@[@"Negative", @"Residual fragmentation"] forKey:@"items"];
        [dict setObject:@"Stone Fragmentation 1" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation1" forKey:@"name"];
        [dict setObject:@"numericTextField" forKey:@"type"];
        [dict setObject:@"Stone Fragmentation 1, mm" forKey:@"placeholder"];
        [dict setObject:@"yes" forKey:@"depends"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation2_on" forKey:@"name"];
        [dict setObject:@"picker" forKey:@"type"];
        [dict setObject:@[@"Negative", @"Residual fragmentation"] forKey:@"items"];
        [dict setObject:@"Stone Fragmentation 2" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation2" forKey:@"name"];
        [dict setObject:@"numericTextField" forKey:@"type"];
        [dict setObject:@"Stone Fragmentation 2, mm" forKey:@"placeholder"];
        [dict setObject:@"yes" forKey:@"depends"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation3_on" forKey:@"name"];
        [dict setObject:@"picker" forKey:@"type"];
        [dict setObject:@[@"Negative", @"Residual fragmentation"] forKey:@"items"];
        [dict setObject:@"Stone Fragmentation 3" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation3" forKey:@"name"];
        [dict setObject:@"numericTextField" forKey:@"type"];
        [dict setObject:@"Stone Fragmentation 3, mm" forKey:@"placeholder"];
        [dict setObject:@"yes" forKey:@"depends"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation4_on" forKey:@"name"];
        [dict setObject:@"picker" forKey:@"type"];
        [dict setObject:@[@"Negative", @"Residual fragmentation"] forKey:@"items"];
        [dict setObject:@"Stone Fragmentation 4" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation4" forKey:@"name"];
        [dict setObject:@"numericTextField" forKey:@"type"];
        [dict setObject:@"Stone Fragmentation 4, mm" forKey:@"placeholder"];
        [dict setObject:@"yes" forKey:@"depends"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"postprocedureComplications" forKey:@"name"];
        [dict setObject:@"symbolicTextField" forKey:@"type"];
        [dict setObject:@"Postprocedure Complications" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
    
    }else if ([_stonesCount isEqualToString:@"5"]){
    
        [dict setObject:@"stoneFragmentation1_on" forKey:@"name"];
        [dict setObject:@"picker" forKey:@"type"];
        [dict setObject:@[@"Negative", @"Residual fragmentation"] forKey:@"items"];
        [dict setObject:@"Stone Fragmentation 1" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation1" forKey:@"name"];
        [dict setObject:@"numericTextField" forKey:@"type"];
        [dict setObject:@"Stone Fragmentation 1, mm" forKey:@"placeholder"];
        [dict setObject:@"yes" forKey:@"depends"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation2_on" forKey:@"name"];
        [dict setObject:@"picker" forKey:@"type"];
        [dict setObject:@[@"Negative", @"Residual fragmentation"] forKey:@"items"];
        [dict setObject:@"Stone Fragmentation 2" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation2" forKey:@"name"];
        [dict setObject:@"numericTextField" forKey:@"type"];
        [dict setObject:@"Stone Fragmentation 2, mm" forKey:@"placeholder"];
        [dict setObject:@"yes" forKey:@"depends"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation3_on" forKey:@"name"];
        [dict setObject:@"picker" forKey:@"type"];
        [dict setObject:@[@"Negative", @"Residual fragmentation"] forKey:@"items"];
        [dict setObject:@"Stone Fragmentation 3" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation3" forKey:@"name"];
        [dict setObject:@"numericTextField" forKey:@"type"];
        [dict setObject:@"Stone Fragmentation 3, mm" forKey:@"placeholder"];
        [dict setObject:@"yes" forKey:@"depends"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation4_on" forKey:@"name"];
        [dict setObject:@"picker" forKey:@"type"];
        [dict setObject:@[@"Negative", @"Residual fragmentation"] forKey:@"items"];
        [dict setObject:@"Stone Fragmentation 4" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation4" forKey:@"name"];
        [dict setObject:@"numericTextField" forKey:@"type"];
        [dict setObject:@"Stone Fragmentation 4, mm" forKey:@"placeholder"];
        [dict setObject:@"yes" forKey:@"depends"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation5_on" forKey:@"name"];
        [dict setObject:@"picker" forKey:@"type"];
        [dict setObject:@[@"Negative", @"Residual fragmentation"] forKey:@"items"];
        [dict setObject:@"Stone Fragmentation 5" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"stoneFragmentation5" forKey:@"name"];
        [dict setObject:@"numericTextField" forKey:@"type"];
        [dict setObject:@"Stone Fragmentation 5, mm" forKey:@"placeholder"];
        [dict setObject:@"yes" forKey:@"depends"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
        
        [dict setObject:@"postprocedureComplications" forKey:@"name"];
        [dict setObject:@"symbolicTextField" forKey:@"type"];
        [dict setObject:@"Postprocedure Complications" forKey:@"placeholder"];
        [self addCustomElement:dict];
        [dict removeAllObjects];
    }        
}


-(void)setupRoboticElements
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@"T" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"T2a", @"T2b", @"T2c", @"T3a", @"T3b", @"T4"] forKey:@"items"];
    [dict setObject:@"T" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];

    [dict setObject:@"N" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"N", @"NX", @"N0", @"N1"] forKey:@"items"];
    [dict setObject:@"N" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];

    [dict setObject:@"gleason" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"(3+3)", @"(3+4)", @"(4+3)", @"(4+4)", @"(4+5)", @"(5+5)"] forKey:@"items"];
    [dict setObject:@"Gleason" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"positiveMargin" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"YES", @"NO"] forKey:@"items"];
    [dict setObject:@"Positive Margin" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    
    [dict setObject:@"cystogram" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"YES", @"NO"] forKey:@"items"];
    [dict setObject:@"Cystogram" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    
    [dict setObject:@"lengthOfStay" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:[self postOpHospitalStayItems] forKey:@"items"];
    [dict setObject:@"Post-Op Hospital Stay" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];

    [dict setObject:@"complications" forKey:@"name"];
    [dict setObject:@"symbolicTextField" forKey:@"type"];
    [dict setObject:@"Complications" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"Ileus" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Ileus, %" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    
    [dict setObject:@"transfusion" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Transfusion, %" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];

    [dict setObject:@"woundInfection" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Wound Infection, %" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];

    [dict setObject:@"urineLeak" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Urine leak, %" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"bowelInjury" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Bowel Injury, %" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"DVT" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"DVT, %" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"PE" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"PE, %" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"reAdmission" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Re-admission within 30 days, %" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];
   
    [dict setObject:@"returnToORWithin" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Return to the OR within 30 days, %" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"death" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Death, %" forKey:@"placeholder"];
    [self addCustomElement:dict];
    [dict removeAllObjects];
}


-(void)setupPenileElements
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@"averageCyclingTime" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Average time to begin cycling of device" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"percentOfErosion" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Occurrence of erosion, %" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"percentOfInfection" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Occurrence of infection, %" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"percentOfMechnicalFailure" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Occurrence of mechanical failure, %" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];

}

-(void)setupSixWeeksElements
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@"chestXray_on" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"Negative", @"Positive"] forKey:@"items"];
    [dict setObject:@"Chest X-Ray" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"chestXray" forKey:@"name"];
    [dict setObject:@"symbolicTextField" forKey:@"type"];
    [dict setObject:@"Chest X-Ray" forKey:@"placeholder"];
    [dict setObject:@"yes" forKey:@"depends"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"Bun" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Bun" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"Creatinine" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Creatinine" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"liverEnzymes_on" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"Normal", @"Abnormal"] forKey:@"items"];
    [dict setObject:@"Liver Enzymes" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"liverEnzymes" forKey:@"name"];
    [dict setObject:@"symbolicTextField" forKey:@"type"];
    [dict setObject:@"Liver Enzymes" forKey:@"placeholder"];
    [dict setObject:@"yes" forKey:@"depends"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"portSiteHemia" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"Yes", @"No"] forKey:@"items"];
    [dict setObject:@"Port Site Hernia" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"CtScan" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"No evidence of metastatic...", @"Local recurrence", @"Lymphodenopathy", @"Liver metastasis", @"Bone metastasis", @"Brain metastasis", @"Not performed"] forKey:@"items"];
    [dict setObject:@"CT-Scan" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"other" forKey:@"name"];
    [dict setObject:@"symbolicTextField" forKey:@"type"];
    [dict setObject:@"Other" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
}

-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width+27, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
    _cameFromVC = @"ongoing";
}

-(void)backButton{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupTwoWeeksElements
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@"tStage" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"TX", @"T0", @"T1", @"T1a", @"T1b", @"T2", @"T2a", @"T2b", @"T3", @"T3a", @"T3b", @"T3c", @"T4"] forKey:@"items"];
    [dict setObject:@"T" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"nStage" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"N", @"NX", @"N0", @"N1"] forKey:@"items"];
    [dict setObject:@"N" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"mStage" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"M", @"M0", @"M1"] forKey:@"items"];
    [dict setObject:@"M" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"tumorChar" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"Clear Cell", @"Papillary", @"Chromophobe", @"Sarcomatoid", @"Angiomyolipoma", @"Oncocytoma", @"Other"] forKey:@"items"];
    [dict setObject:@"Tumor Characteristics" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"fuhrmanGrade" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"1/4", @"2/4", @"3/4", @"4/4"] forKey:@"items"];
    [dict setObject:@"Fuhrman Grade" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"margins" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"Negative", @"Positive"] forKey:@"items"];
    [dict setObject:@"Margins" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"deepMargin" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"Negative", @"Positive"] forKey:@"items"];
    [dict setObject:@"Deep Margin" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"lengthOfStay" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:[self postOpHospitalStayItems] forKey:@"items"];
    [dict setObject:@"Post-Op Hospital Stay" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"complications" forKey:@"name"];
    [dict setObject:@"picker" forKey:@"type"];
    [dict setObject:@[@"Ileus", @"Bowel injury", @"Infection", @"Urine leak", @"DVT", @"PE", @"Cardiac event", @"Hernia", @"Transfusion", @"Death", @"Other"] forKey:@"items"];
    [dict setObject:@"Complications" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"preOperativeBun" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Pre-Operative Bun" forKey:@"placeholder"];

    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"preOperativeCreatinine" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Pre-Operative Creatine" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"postOperativeBun" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Post-Operative Bun" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"postOperativeCreatinine" forKey:@"name"];
    [dict setObject:@"numericTextField" forKey:@"type"];
    [dict setObject:@"Post-Operative Creatine" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
    
    [dict setObject:@"additionalDiagnosis" forKey:@"name"];
    [dict setObject:@"symbolicTextField" forKey:@"type"];
    [dict setObject:@"Additional Diagnosis" forKey:@"placeholder"];
    
    [self addCustomElement:dict];
    [dict removeAllObjects];
}


-(void)setupKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter]addObserverForName:UIKeyboardWillShowNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSDictionary* keyboardInfo = [note userInfo];
        NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
        CGRect keyboardRect = [keyboardFrameBegin CGRectValue];
        self.scrollView.contentInset = UIEdgeInsetsMake(64, 0, keyboardRect.size.height, 0);
        self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, keyboardRect.size.height, 0);
    }];
    [[NSNotificationCenter defaultCenter]addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
        [UIView animateWithDuration:.3 animations:^{
            self.scrollView.contentOffset = CGPointMake(0, -64);
        }];
    }];
}

#pragma mark - IBAction


-(void)addCustomElement:(NSDictionary*)elementDict
{
    int yPoint = 0;
    UIControl *lastElement = nil;
    
    NSString *fieldName = [elementDict objectForKey:@"name"];
    
    if(self.interactionItems.count > 0){
        id previousItem = [self.interactionItems objectAtIndex:self.interactionItems.count-1];
        UIView *view = [previousItem valueForKey:@"view"];
        yPoint = view.frame.origin.y + view.frame.size.height;
        yPoint *= self.interactionItems.count;
    }
    if([[elementDict valueForKey:@"type"] isEqualToString:@"picker"]){
        OKProcedurePicker *picker = [[OKProcedurePicker alloc] initWithFrame:CGRectMake(0, yPoint, 320, 43)];
        picker.customTextField.inputView = self.MDPiker;
        [picker setDataArray:[elementDict objectForKey:@"items"]];
        NSMutableArray *pickerArray = [[NSMutableArray alloc] init];
        if ([[[elementDict objectForKey:@"items"] objectAtIndex:0] isEqualToString:@"0,1"] ){
            pickerArray = [NSMutableArray arrayWithArray:[self stoneSizeArray]];
        } else {
            pickerArray = [elementDict objectForKey:@"items"];
        }
        [picker setDataArray:pickerArray];
        lastElement = picker;
    }else if ([[elementDict valueForKey:@"type"] isEqualToString:@"symbolicTextField"]){
        OKProcedureTextField *symbolicTextField = [[OKProcedureTextField alloc] initWithFrame:CGRectMake(0, yPoint, 320, 43)];
        [symbolicTextField setType:0];
        if ([[elementDict objectForKey:@"name"] isEqualToString:@"var_surgeon"]) {
            symbolicTextField.customTextField.text = [NSString stringWithFormat:@"%@ %@ , %@", [OKUserManager instance].currentUser.firstName, [OKUserManager instance].currentUser.lastName , [OKUserManager instance].currentUser.title];
        }
        lastElement = symbolicTextField;
        
    }else if ([[elementDict valueForKey:@"type"] isEqualToString:@"numericTextField"]){
        
        OKProcedureTextField *numericTextField = [[OKProcedureTextField alloc] initWithFrame:CGRectMake(0, yPoint, 320, 43)];
        [numericTextField setType:OKProcedureNumericTF];
        lastElement = numericTextField;
    }
    
    if([elementDict objectForKey:@"depends"])
        lastElement.enabled = NO;
    if([self.ongoingData respondsToSelector:NSSelectorFromString(fieldName)]){
        id value = [self.ongoingData valueForKey:fieldName];
        if(value)
            [lastElement setValue:value forKey:@"value"];
    }
    
    [lastElement setValue:self forKey:@"delegate"];
    [lastElement setValue:[elementDict objectForKey:@"placeholder"] forKey:@"placeHolder"];
    [lastElement setValue:fieldName forKey:@"fieldName"];
    
    [self.scrollView addSubview:lastElement];
    [self.interactionItems addObject:lastElement];

    CGSize newContSize = CGSizeMake(320, lastElement.frame.origin.y+lastElement.frame.size.height);
    
    self.scrollView.contentSize = newContSize;
}


-(void)showPickerWithData:(NSArray*)pickerData picker:(OKProcedurePicker*)pickerObject
{
    if (self.PikerView.hidden) {
        self.pickerObject = pickerObject;
        self.pickerData = pickerData;
        self.PikerView.hidden = NO;
        self.MDPiker.hidden = NO;
        [self.MDPiker reloadAllComponents];
        
    } else {
        [self hidePicker];
    }
    [self.view endEditing:YES];
}


-(NSArray*)stoneSizeArray
{
    NSMutableArray * array = [NSMutableArray array];
    
    for(float i = .1; i<= 25.1 ; i+=.1){
        NSString *fltString = [NSString stringWithFormat:@"%.1f", i];
        
        [array addObject:fltString];
    }
    return array;
}


- (void)goToNextElementFrom:(id)sender
{
    OKProcedureTextField *nextItem = nil;
    int rangeStart = (int)[self.interactionItems indexOfObject:sender];
    for (int index = rangeStart; index < self.interactionItems.count; index++){
        id item = self.interactionItems[index];
        if([[item class]isSubclassOfClass:[OKProcedureTextField class]] && item != sender && [[item valueForKey:@"enabled"] boolValue]){
            nextItem = (OKProcedureTextField*)item;
            break;
        }
    }
    if(nextItem)
        [nextItem.customTextField becomeFirstResponder];
    else
        [sender resignFirstResponder];
}


-(void)updateField:(NSString*)name withValue:(NSString*)newValue  andTag:(NSInteger) tag
{
    NSRange onRange = [name rangeOfString:@"_on"];

    if (([name isEqualToString:@"Ileus"] || [name isEqualToString:@"transfusion"] ||
         [name isEqualToString:@"woundInfection"] || [name isEqualToString:@"urineLeak"] ||
         [name isEqualToString:@"bowelInjury"] || [name isEqualToString:@"DVT"] ||
         [name isEqualToString:@"PE"] || [name isEqualToString:@"reAdmission"] ||
         [name isEqualToString:@"returnToORWithin"] || [name isEqualToString:@"death"] ||
         [name isEqualToString:@"percentOfErosion"] || [name isEqualToString:@"percentOfInfection"] ||
         [name isEqualToString:@"percentOfMechnicalFailure"]) && ([newValue intValue]>100)) {
        
        NSArray *neededElements = [self.interactionItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"fieldName == %@", name]];
        if(neededElements.count>0){
            OKProcedureTextField *tf = neededElements[0];
            [tf setValue:@"100"];
        }
        newValue = @"100";
    }
    
    if(onRange.location != NSNotFound){
        NSString *fieldName = [name substringToIndex:onRange.location];

        NSArray *neededItems = [self.interactionItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"fieldName == %@", fieldName]];
      
        if(neededItems.count > 0){
            id interactionItem = neededItems[0];
            
            if([newValue isEqualToString:@"Abnormal"] || [newValue isEqualToString:@"Yes"] || [newValue isEqualToString:@"Positive"] || [newValue isEqualToString:@"Residual fragmentation"]){
                [interactionItem setEnabled:YES];
            }else if ([newValue isEqualToString:@"Negative"]){
                [self.ongoingData setValue:newValue forKey:fieldName];
            }else if ([newValue isEqualToString:@"Normal"]){
                [self.ongoingData setValue:newValue forKey:fieldName];
            }else{
                [interactionItem setEnabled:NO];
                [self.ongoingData setValue:@"" forKey:fieldName];
            }
        }
    }
    if([self.ongoingData respondsToSelector:NSSelectorFromString(name)])
        [self.ongoingData setValue:newValue forKey:name];
}


-(void)hidePickersWhenTextFieldBeginsEditing
{
    if (!self.MDPiker.hidden)
        [self hidePicker];
}


-(void)hidePicker
{
    self.pickerObject.customTextField.text = self.pickerData[[self.MDPiker selectedRowInComponent:0]];
    self.pickerObject = nil;
    self.PikerView.hidden = YES;
    self.pickerData = nil;
}

#pragma mark - picker data source

-(NSAttributedString*) pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    UIColor *color = [UIColor whiteColor];
    if (IS_IOS6) {
        color = [UIColor blackColor];
    }
    
    NSString *pickerString = [NSString stringWithFormat:@"%@", self.pickerData[row]];
    NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: color }];
    return pickerAttributedString;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.pickerObject.customTextField.text = self.pickerData[row];
    [self.pickerObject.delegate updateField:self.pickerObject.fieldName withValue:self.pickerObject.customTextField.text andTag:self.pickerObject.tagOfTextField];

    if (!self.PikerView.hidden) {
        [self hidePicker];
    }
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


- (IBAction)updateTapped:(id)sender
{
    NSString *forProcedure = [[NSString alloc] init];
    
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2 && self.detailPeriod==OKProcedureSummaryDetailTwoWeeks) {
        forProcedure = @"1";
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 2 && self.detailPeriod==OKProcedureSummaryDetailSixWeeks){
        forProcedure = @"2";
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9){
        forProcedure = @"3";
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 1){
        forProcedure = @"4";
    }else if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10){
        forProcedure = @"5";
    }
    
        [[OKLoadingViewController instance]showWithText:@"Sending data..."];
        NSString *caseNumber1 = [[NSString alloc] init];
        if ([_procID isEqualToString:@"9"]) {
            caseNumber1 = _caseNumber;
        }else{
            caseNumber1 = [OKCaseManager instance].selectedCase.identifier;
        }
        self.ongoingData.caseID = _caseNumber;

        [[OKCaseManager instance]addOngoingClinicalDetailsForCaseID:_caseNumber timePointID:[OKTimePointsManager instance].selectedTimePoint.identifier procedureID:[OKProceduresManager instance].selectedProcedure.identifier ongoingData:self.ongoingData forProcedure:forProcedure handler:^(NSString *errorMsg) {
            [[OKLoadingViewController instance]hide];
            [self.navigationController popViewControllerAnimated:YES];
        }];
}


-(NSArray*)postOpHospitalStayItems
{
    NSMutableArray *items = [NSMutableArray array];
    for (int index = 1; index <= 30; index++) {
        NSString *item = [NSString stringWithFormat:@"%d Night(s)", index];
        [items addObject:item];
    }
    return items;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end