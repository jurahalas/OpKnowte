//
//  UCSurgeonPerformanceTwoWeeks.m
//  MZUroCapture
//
//  Created by Atif Joyia on 20/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSurgeonPerformanceTwoWeeks.h"
#import "UCSurgeonPerformanceGraphs.h"
#import "UCSettingsViewController.h"
#import "UCHomeScreenViewController.h"
#import "UCNationalPerformanceGraphs.h"
@interface UCSurgeonPerformanceTwoWeeks ()

@end

float twoWeeks;
float sixMonths;

float bunDiffSum;
float creatinineDiffSum;

float Tx = 0;
float T0 = 0;
float T1 = 0;
float T1a = 0;
float T1b = 0;
float T2 = 0;
float T2a = 0;
float T2b = 0;
float T3 = 0;
float T3a = 0;
float T3b = 0;
float T3c = 0;
float T4 = 0;

float N = 0;
float Nx = 0;
float N0 = 0;
float N1 = 0;

float M = 0;
float M0 = 0;
float M1 = 0;

float ClearAll = 0;
float Papillary = 0;
float Chromophobe = 0;
float Sarcomatoid = 0;
float angiomyolipoma = 0;
float oncocytoma = 0;
float other = 0;

float FGoneByFour = 0;
float FGtwoByFour = 0;
float FGthreeByFour = 0;
float FGfourByFour = 0;

float mPositive = 0;
float mNegative = 0;

float dmPositive = 0;
float dmNegative = 0;

//float one = 0;
//float two = 0;
//float three = 0;
//float four = 0;
//float five = 0;
//float six = 0;
//float seven = 0;
//float eight = 0;
//float nine = 0;
//float ten = 0;
//float eleven = 0;
//float twelve = 0;
//float thirteen = 0;
//float fourten = 0;
//float fifteen = 0;
//float sixteen = 0;
//float seventeen = 0;
//float eighteen = 0;
//float nineteen = 0;
//float twenty = 0;
//float twentyone = 0;
//float twentyTwo = 0;
//float twentyThree = 0;
//float twentyFour = 0;
//float twentyFive = 0;
//float twentySix = 0;
//float twentySeven = 0;
//float twentyEight = 0;
//float twentyNine = 0;
//float thirty = 0;

float stayCount;
int minStay;
int maxStay;


float Ileus = 0;
float BowelInjury = 0;
float Infection = 0;
float UrineLeak = 0;
float DVT = 0;
float PE = 0;
float CardiacEvent = 0;
float Hernia = 0;
float Transfusion = 0;
float Death = 0;
float OtherComp = 0;

float twoWeeks;
float sixMonths;

float bunDiffSum;
float creatinineDiffSum;
// ***************
float s_Tx = 0;
float s_T0 = 0;
float s_T1 = 0;
float s_T1a = 0;
float s_T1b = 0;
float s_T2 = 0;
float s_T2a = 0;
float s_T2b = 0;
float s_T3 = 0;
float s_T3a = 0;
float s_T3b = 0;
float s_T3c = 0;
float s_T4 = 0;

float s_N = 0;
float s_Nx = 0;
float s_N0 = 0;
float s_N1 = 0;

float s_M = 0;
float s_M0 = 0;
float s_M1 = 0;

float s_ClearAll = 0;
float s_Papillary = 0;
float s_Chromophobe = 0;
float s_Sarcomatoid = 0;
float s_angiomyolipoma = 0;
float s_oncocytoma = 0;
float s_other = 0;

float s_FGoneByFour = 0;
float s_FGtwoByFour = 0;
float s_FGthreeByFour = 0;
float s_FGfourByFour = 0;

float s_mPositive = 0;
float s_mNegative = 0;

float s_dmPositive = 0;
float s_dmNegative = 0;

float s_stayCount;
int s_minStay;
int s_maxStay;


float s_Ileus = 0;
float s_BowelInjury = 0;
float s_Infection = 0;
float s_UrineLeak = 0;
float s_DVT = 0;
float s_PE = 0;
float s_CardiacEvent = 0;
float s_Hernia = 0;
float s_Transfusion = 0;
float s_Death = 0;
float s_OtherComp = 0;

float s_twoWeeks;
float s_sixMonths;

float s_bunDiffSum;
float s_creatinineDiffSum;

@implementation UCSurgeonPerformanceTwoWeeks

@synthesize scroller, totalCount, totalNationalCount, totalSurgeonCount;
@synthesize performanceCases;
@synthesize surgeonCases,isNational;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.performanceCases = [[NSMutableArray alloc] init];
        self.surgeonCases = [[NSMutableArray alloc] init];
        isNational = NO;
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
   // [self.scroller setContentSize:CGSizeMake(320, 475)];
    [self.scroller setContentSize:CGSizeMake(320, 320)];
    
    if (IS_IPHONE_5) {
        l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    if (self.isNational) {
        [l_Header setText:@"NATIONAL PERFORMANCE DATA"];
    }
    
}


-(void)resetCounter{
    twoWeeks = 0;
    sixMonths = 0;
    
    bunDiffSum=0;
    creatinineDiffSum=0;
    
    Tx = 0;
    T0 = 0;
    T1 = 0;
    T1a = 0;
    T1b = 0;
    T2 = 0;
    T2a = 0;
    T2b = 0;
    T3 = 0;
    T3a = 0;
    T3b = 0;
    T3c = 0;
    T4 = 0;
    
    N = 0;
    Nx = 0;
    N0 = 0;
    N1 = 0;
    
    M = 0;
    M0 = 0;
    M1 = 0;
    
    ClearAll = 0;
    Papillary = 0;
    Chromophobe = 0;
    Sarcomatoid = 0;
    angiomyolipoma = 0;
    oncocytoma = 0;
    other = 0;
    
    FGoneByFour = 0;
    FGtwoByFour = 0;
    FGthreeByFour = 0;
    FGfourByFour = 0;
    
    mPositive = 0;
    mNegative = 0;
    
    dmPositive = 0;
    dmNegative = 0;
    
    stayCount = 0;
    minStay = 0;
    maxStay = 0;
    
    
    Ileus = 0;
    BowelInjury = 0;
    Infection = 0;
    UrineLeak = 0;
    DVT = 0;
    PE = 0;
    CardiacEvent = 0;
    Hernia = 0;
    Transfusion = 0;
    Death = 0;
    OtherComp = 0;
}

-(void)resetSurgeonCounter{
    
    s_twoWeeks = 0;
    s_sixMonths = 0;
    
    s_bunDiffSum=0;
    s_creatinineDiffSum=0;
    
    s_Tx = 0;
    s_T0 = 0;
    s_T1 = 0;
    s_T1a = 0;
    s_T1b = 0;
    s_T2 = 0;
    s_T2a = 0;
    s_T2b = 0;
    s_T3 = 0;
    s_T3a = 0;
    s_T3b = 0;
    s_T3c = 0;
    s_T4 = 0;
    
    s_N = 0;
    s_Nx = 0;
    s_N0 = 0;
    s_N1 = 0;
    
    s_M = 0;
    s_M0 = 0;
    s_M1 = 0;
    
    s_ClearAll = 0;
    s_Papillary = 0;
    s_Chromophobe = 0;
    s_Sarcomatoid = 0;
    s_angiomyolipoma = 0;
    s_oncocytoma = 0;
    s_other = 0;
    
    s_FGoneByFour = 0;
    s_FGtwoByFour = 0;
    s_FGthreeByFour = 0;
    s_FGfourByFour = 0;
    
    s_mPositive = 0;
    s_mNegative = 0;
    
    s_dmPositive = 0;
    s_dmNegative = 0;
    
    s_stayCount = 0;
    s_minStay = 0;
    s_maxStay = 0;
    //    one = 0;
    //    two = 0;
    //    three = 0;
    //    four = 0;
    //    five = 0;
    //    six = 0;
    //    seven = 0;
    //    eight = 0;
    //    nine = 0;
    //    ten = 0;
    //    eleven = 0;
    //    twelve = 0;
    //    thirteen = 0;
    //    fourten = 0;
    //    fifteen = 0;
    //    sixteen = 0;
    //    seventeen = 0;
    //    eighteen = 0;
    //    nineteen = 0;
    //    twenty = 0;
    //    twentyone = 0;
    //    twentyTwo = 0;
    //    twentyThree = 0;
    //    twentyFour = 0;
    //    twentyFive = 0;
    //    twentySix = 0;
    //    twentySeven = 0;
    //    twentyEight = 0;
    //    twentyNine = 0;
    //    thirty = 0;
    
    
    s_Ileus = 0;
    s_BowelInjury = 0;
    s_Infection = 0;
    s_UrineLeak = 0;
    s_DVT = 0;
    s_PE = 0;
    s_CardiacEvent = 0;
    s_Hernia = 0;
    s_Transfusion = 0;
    s_Death = 0;
    s_OtherComp = 0;
}


-(void)calculate{
    
    [self resetCounter];
    
    for (int i = 0; i < [self.performanceCases count]; i++) {
        NSDictionary *dict = [self.performanceCases objectAtIndex:i];
        //NSLog(@"%@",[dict objectForKey:@"timePointID"]);
        
        if ([[dict objectForKey:@"timePointID"] isEqualToString:@"1"]) {
            twoWeeks++;
            
            NSString *tStage = [dict objectForKey:@"tStage"];
            //NSLog(@"%@", tStage);
            if (tStage.length > 0) {
                if ([tStage isEqualToString:@"TX"]) {
                    Tx++;
                }else if ([tStage isEqualToString:@"T0"]){
                    T0++;
                }else if ([tStage isEqualToString:@"T1"]){
                    T1++;
                }else if ([tStage isEqualToString:@"T1a"]){
                    T1a++;
                }else if ([tStage isEqualToString:@"T1b"]){
                    T1b++;
                }else if ([tStage isEqualToString:@"T2"]){
                    T2++;
                }else if ([tStage isEqualToString:@"T2a"]){
                    T2a++;
                }else if ([tStage isEqualToString:@"T2b"]){
                    T2b++;
                }else if ([tStage isEqualToString:@"T3"]){
                    T3++;
                }else if ([tStage isEqualToString:@"T3a"]){
                    T3a++;
                }else if ([tStage isEqualToString:@"T3b"]){
                    T3b++;
                }else if ([tStage isEqualToString:@"T3c"]){
                    T3c++;
                }else if ([tStage isEqualToString:@"T4"]){
                    T4++;
                }
            }
            
            if([dict objectForKey:@"preOperativeBun"] && [dict objectForKey:@"postOperativeBun"]){
            
                float preob = [[dict objectForKey:@"preOperativeBun"] floatValue];
                float postob = [[dict objectForKey:@"postOperativeBun"] floatValue];
                float result = postob - preob;
                if(result<0)
                    result = result*(-1);
                bunDiffSum+=result;
            }
            
            if([dict objectForKey:@"preOperativeCreatinine"] && [dict objectForKey:@"postOperativeCreatinine"]){
                
                float preob = [[dict objectForKey:@"preOperativeCreatinine"] floatValue];
                float postob = [[dict objectForKey:@"postOperativeCreatinine"] floatValue];
                float result = postob - preob;
                if(result<0)
                    result = result*(-1);
                creatinineDiffSum+=result;
            }
            
            NSString *nStage = [dict objectForKey:@"nStage"];
            //NSLog(@"%@", nStage);
            if (nStage.length > 0) {
                if ([nStage isEqualToString:@"N"]) {
                    N++;
                }else if ([nStage isEqualToString:@"NX"]){
                    Nx++;
                }else if ([nStage isEqualToString:@"N0"]){
                    N0++;
                }else if ([nStage isEqualToString:@"N1"]){
                    N1++;
                }
            }
            
            NSString *mStage = [dict objectForKey:@"mStage"];
            //NSLog(@"%@", mStage);
            if (mStage.length > 0) {
                if ([mStage isEqualToString:@"M"]) {
                    M++;
                }else if ([mStage isEqualToString:@"M0"]){
                    M0++;
                }else if ([mStage isEqualToString:@"M1"]){
                    M1++;
                }
            }
            
            NSString *tumorCh = [dict objectForKey:@"tumorChar"];
            //NSLog(@"%@", tumorCh);
            if (mStage.length > 0) {
                if ([tumorCh isEqualToString:@"Clear Cell"]) {
                    ClearAll++;
                }else if ([tumorCh isEqualToString:@"Papillary"]){
                    Papillary++;
                }else if ([tumorCh isEqualToString:@"Chromophobe"]){
                    Chromophobe++;
                }else if ([tumorCh isEqualToString:@"Sarcomatoid"]){
                    Sarcomatoid++;
                }else if ([tumorCh isEqualToString:@"angiomyolipoma"]){
                    angiomyolipoma++;
                }else if ([tumorCh isEqualToString:@"oncocytoma"]){
                    oncocytoma++;
                }else if ([tumorCh isEqualToString:@"other"]){
                    other++;
                }
            }
            
            
            
            NSString *FGrade = [dict objectForKey:@"fuhrmanGrade"];
            //NSLog(@"%@", FGrade);
            if (FGrade.length > 0) {
                if ([FGrade isEqualToString:@"1/4"]) {
                    FGoneByFour++;
                }else if ([FGrade isEqualToString:@"2/4"]){
                    FGtwoByFour++;
                }else if ([FGrade isEqualToString:@"3/4"]){
                    FGthreeByFour++;
                }else if ([FGrade isEqualToString:@"4/4"]){
                    FGfourByFour++;
                }
            }
            
            NSString *margins = [dict objectForKey:@"margins"];
            //NSLog(@"%@", margins);
            if (margins.length > 0) {
                if ([margins isEqualToString:@"Positive"]) {
                    mPositive++;
                }else if ([margins isEqualToString:@"Negative"]){
                    mNegative++;
                }
            }
            
            
            NSString *dMargins = [dict objectForKey:@"deepMargin"];
            //NSLog(@"%@", dMargins);
            if (dMargins.length > 0) {
                if ([dMargins isEqualToString:@"Positive"]) {
                    dmPositive++;
                }else if ([dMargins isEqualToString:@"Negative"]){
                    dmNegative++;
                }
            }
            
            
            
            if([dict objectForKey:@"lengthOfStay"]){
                NSString *nights = [dict objectForKey:@"lengthOfStay"];
                //NSLog(@"%@", nights);
                NSArray *ary = [nights componentsSeparatedByString:@" "];
                float stay = [[ary objectAtIndex:0] floatValue];
                stayCount+=stay;
                if(twoWeeks == 1){
                    minStay = stay;
                    maxStay = stay;
                }else{
                    if(stay>maxStay){
                        maxStay = stay;
                    }
                    if(stay<minStay){
                        minStay = stay;
                    }
                }
            }
            
            NSString *complication = [dict objectForKey:@"complications"];
            //NSLog(@"%@", complication);
            if (complication.length > 0) {
                if ([complication isEqualToString:@"Ileus"]) {
                    Ileus++;
                }else if ([complication isEqualToString:@"Bowel injury"]){
                    BowelInjury++;
                }else if ([complication isEqualToString:@"Infection"]){
                    Infection++;
                }else if ([complication isEqualToString:@"Urine leak"]){
                    UrineLeak++;
                }else if ([complication isEqualToString:@"DVT"]){
                    DVT++;
                }else if ([complication isEqualToString:@"PE"]){
                    PE++;
                }else if ([complication isEqualToString:@"Cardiac event"]){
                    CardiacEvent++;
                }else if ([complication isEqualToString:@"Hernia"]){
                    Hernia++;
                }else if ([complication isEqualToString:@"Transfusion"]){
                    Transfusion++;
                    NSLog(@"%f",Transfusion);
                }else if ([complication isEqualToString:@"Death"]){
                    Death++;
                }else if ([complication isEqualToString:@"Other"]){
                    OtherComp++;
                }
            }
            
        }else if ([[dict objectForKey:@"timePointID"] isEqualToString:@"2"]){
            
            sixMonths++;
            
        }
        
    }
    
}

-(void)calculateSurgeonData{
    
    [self resetSurgeonCounter];
    
    for (int i = 0; i < [self.surgeonCases count]; i++) {
        NSDictionary *dict = [self.surgeonCases objectAtIndex:i];
        //NSLog(@"%@",[dict objectForKey:@"timePointID"]);
        
        if ([[dict objectForKey:@"timePointID"] isEqualToString:@"1"]) {
            s_twoWeeks++;
            
            NSString *tStage = [dict objectForKey:@"tStage"];
            //NSLog(@"%@", tStage);
            if (tStage.length > 0) {
                if ([tStage isEqualToString:@"TX"]) {
                    s_Tx++;
                }else if ([tStage isEqualToString:@"T0"]){
                    s_T0++;
                }else if ([tStage isEqualToString:@"T1"]){
                    s_T1++;
                }else if ([tStage isEqualToString:@"T1a"]){
                    s_T1a++;
                }else if ([tStage isEqualToString:@"T1b"]){
                    s_T1b++;
                }else if ([tStage isEqualToString:@"T2"]){
                    s_T2++;
                }else if ([tStage isEqualToString:@"T2a"]){
                    s_T2a++;
                }else if ([tStage isEqualToString:@"T2b"]){
                    s_T2b++;
                }else if ([tStage isEqualToString:@"T3"]){
                    s_T3++;
                }else if ([tStage isEqualToString:@"T3a"]){
                    s_T3a++;
                }else if ([tStage isEqualToString:@"T3b"]){
                    s_T3b++;
                }else if ([tStage isEqualToString:@"T3c"]){
                    s_T3c++;
                }else if ([tStage isEqualToString:@"T4"]){
                    s_T4++;
                }
            }
            
            if([dict objectForKey:@"preOperativeBun"] && [dict objectForKey:@"postOperativeBun"]){
                
                float preob = [[dict objectForKey:@"preOperativeBun"] floatValue];
                float postob = [[dict objectForKey:@"postOperativeBun"] floatValue];
                float result = postob - preob;
                if(result<0)
                    result = result*(-1);
                s_bunDiffSum+=result;
            }
            
            if([dict objectForKey:@"preOperativeCreatinine"] && [dict objectForKey:@"postOperativeCreatinine"]){
                
                float preob = [[dict objectForKey:@"preOperativeCreatinine"] floatValue];
                float postob = [[dict objectForKey:@"postOperativeCreatinine"] floatValue];
                float result = postob - preob;
                if(result<0)
                    result = result*(-1);
                s_creatinineDiffSum+=result;
            }
            
            NSString *nStage = [dict objectForKey:@"nStage"];
            //NSLog(@"%@", nStage);
            if (nStage.length > 0) {
                if ([nStage isEqualToString:@"N"]) {
                    s_N++;
                }else if ([nStage isEqualToString:@"NX"]){
                    s_Nx++;
                }else if ([nStage isEqualToString:@"N0"]){
                    s_N0++;
                }else if ([nStage isEqualToString:@"N1"]){
                    s_N1++;
                }
            }
            
            NSString *mStage = [dict objectForKey:@"mStage"];
            //NSLog(@"%@", mStage);
            if (mStage.length > 0) {
                if ([mStage isEqualToString:@"M"]) {
                    s_M++;
                }else if ([mStage isEqualToString:@"M0"]){
                    s_M0++;
                }else if ([mStage isEqualToString:@"M1"]){
                    s_M1++;
                }
            }
            
            NSString *tumorCh = [dict objectForKey:@"tumorChar"];
            //NSLog(@"%@", tumorCh);
            if (mStage.length > 0) {
                if ([tumorCh isEqualToString:@"Clear Cell"]) {
                    s_ClearAll++;
                }else if ([tumorCh isEqualToString:@"Papillary"]){
                    s_Papillary++;
                }else if ([tumorCh isEqualToString:@"Chromophobe"]){
                    s_Chromophobe++;
                }else if ([tumorCh isEqualToString:@"Sarcomatoid"]){
                    s_Sarcomatoid++;
                }else if ([tumorCh isEqualToString:@"angiomyolipoma"]){
                    s_angiomyolipoma++;
                }else if ([tumorCh isEqualToString:@"oncocytoma"]){
                    s_oncocytoma++;
                }else if ([tumorCh isEqualToString:@"other"]){
                    s_other++;
                }
            }
            
            
            
            NSString *FGrade = [dict objectForKey:@"fuhrmanGrade"];
            //NSLog(@"%@", FGrade);
            if (FGrade.length > 0) {
                if ([FGrade isEqualToString:@"1/4"]) {
                    s_FGoneByFour++;
                }else if ([FGrade isEqualToString:@"2/4"]){
                    s_FGtwoByFour++;
                }else if ([FGrade isEqualToString:@"3/4"]){
                    s_FGthreeByFour++;
                }else if ([FGrade isEqualToString:@"4/4"]){
                    s_FGfourByFour++;
                }
            }
            
            NSString *margins = [dict objectForKey:@"margins"];
            //NSLog(@"%@", margins);
            if (margins.length > 0) {
                if ([margins isEqualToString:@"Positive"]) {
                    s_mPositive++;
                }else if ([margins isEqualToString:@"Negative"]){
                    s_mNegative++;
                }
            }
            
            
            NSString *dMargins = [dict objectForKey:@"deepMargin"];
            //NSLog(@"%@", dMargins);
            if (dMargins.length > 0) {
                if ([dMargins isEqualToString:@"Positive"]) {
                    s_dmPositive++;
                }else if ([dMargins isEqualToString:@"Negative"]){
                    s_dmNegative++;
                }
            }
            
            
            
            if([dict objectForKey:@"lengthOfStay"]){
                NSString *nights = [dict objectForKey:@"lengthOfStay"];
                //NSLog(@"%@", nights);
                NSArray *ary = [nights componentsSeparatedByString:@" "];
                float stay = [[ary objectAtIndex:0] floatValue];
                s_stayCount+=stay;
                if(s_twoWeeks == 1){
                    s_minStay = stay;
                    s_maxStay = stay;
                }else{
                    if(stay>s_maxStay){
                        s_maxStay = stay;
                    }
                    if(stay<s_minStay){
                        s_minStay = stay;
                    }
                }
            }
            
            NSString *complication = [dict objectForKey:@"complications"];
            //NSLog(@"%@", complication);
            if (complication.length > 0) {
                if ([complication isEqualToString:@"Ileus"]) {
                    s_Ileus++;
                }else if ([complication isEqualToString:@"Bowel injury"]){
                    s_BowelInjury++;
                }else if ([complication isEqualToString:@"Infection"]){
                    s_Infection++;
                }else if ([complication isEqualToString:@"Urine leak"]){
                    s_UrineLeak++;
                }else if ([complication isEqualToString:@"DVT"]){
                    s_DVT++;
                }else if ([complication isEqualToString:@"PE"]){
                    s_PE++;
                }else if ([complication isEqualToString:@"Cardiac event"]){
                    s_CardiacEvent++;
                }else if ([complication isEqualToString:@"Hernia"]){
                    s_Hernia++;
                }else if ([complication isEqualToString:@"Transfusion"]){
                    s_Transfusion++;
                    NSLog(@"%f",Transfusion);
                }else if ([complication isEqualToString:@"Death"]){
                    s_Death++;
                }else if ([complication isEqualToString:@"Other"]){
                    s_OtherComp++;
                }
            }
            
        }else if ([[dict objectForKey:@"timePointID"] isEqualToString:@"2"]){
            
            s_sixMonths++;
            
        }
        
    }
    
    
}


-(IBAction)TMGstaging:(id)sender{
    
    if(!isNational){
        [self calculate];
        
        UCSurgeonPerformanceGraphs *controller = [[UCSurgeonPerformanceGraphs alloc] initWithNibName:@"UCSurgeonPerformanceGraphs" bundle:nil];
        if(twoWeeks>0){
            controller.TxAge = (Tx/twoWeeks)*100;
            controller.T0Age = (T0/twoWeeks)*100;
            controller.T1Age = (T1/twoWeeks)*100;
            controller.T1aAge = (T1a/twoWeeks)*100;
            controller.T1bAge = (T1b/twoWeeks)*100;
            controller.T2Age = (T2/twoWeeks)*100;
            controller.T2aAge = (T2a/twoWeeks)*100;
            controller.T2bAge = (T2b/twoWeeks)*100;
            controller.T3Age = (T3/twoWeeks)*100;
            controller.T3aAge = (T3/twoWeeks)*100;
            controller.T3bAge = (T3/twoWeeks)*100;
            controller.T3cAge = (T3/twoWeeks)*100;
            controller.T4Age = (T4/twoWeeks)*100;
            controller.NAge = (N/twoWeeks)*100;
            controller.NxAge = (Nx/twoWeeks)*100;
            controller.N0Age = (N0/twoWeeks)*100;
            controller.N1Age = (N1/twoWeeks)*100;
            controller.MAge = (N/twoWeeks)*100;
            controller.M0Age = (M0/twoWeeks)*100;
            controller.M1Age = (M1/twoWeeks)*100;
        }else{
            controller.TxAge = 0;
            controller.T0Age = 0;
            controller.T1Age = 0;
            controller.T1aAge = 0;
            controller.T1bAge = 0;
            controller.T2Age = 0;
            controller.T2aAge = 0;
            controller.T2bAge = 0;
            controller.T3Age = 0;
            controller.T3aAge = 0;
            controller.T3bAge = 0;
            controller.T3cAge = 0;
            controller.T4Age = 0;
            controller.NAge = 0;
            controller.NxAge = 0;
            controller.N0Age = 0;
            controller.N1Age = 0;
            controller.MAge = 0;
            controller.M0Age = 0;
            controller.M1Age = 0;
        }
        
        controller.maxSampleSize = twoWeeks;
        //controller.maxSampleSize = [self.performanceCases count];
        controller.graphView = @"TNM";
        
        [self.navigationController pushViewController:controller animated:YES];

    }else{
        [self calculate];
        [self calculateSurgeonData];
        UCNationalPerformanceGraphs *controller = [[UCNationalPerformanceGraphs alloc] initWithNibName:@"UCNationalPerformanceGraphs" bundle:nil];
        if(twoWeeks>0){
            controller.TxAge = (Tx/twoWeeks)*100;
            controller.T0Age = (T0/twoWeeks)*100;
            controller.T1Age = (T1/twoWeeks)*100;
            controller.T1aAge = (T1a/twoWeeks)*100;
            controller.T1bAge = (T1b/twoWeeks)*100;
            controller.T2Age = (T2/twoWeeks)*100;
            controller.T2aAge = (T2a/twoWeeks)*100;
            controller.T2bAge = (T2b/twoWeeks)*100;
            controller.T3Age = (T3/twoWeeks)*100;
            controller.T3aAge = (T3/twoWeeks)*100;
            controller.T3bAge = (T3/twoWeeks)*100;
            controller.T3cAge = (T3/twoWeeks)*100;
            controller.T4Age = (T4/twoWeeks)*100;
            controller.NAge = (N/twoWeeks)*100;
            controller.NxAge = (Nx/twoWeeks)*100;
            controller.N0Age = (N0/twoWeeks)*100;
            controller.N1Age = (N1/twoWeeks)*100;
            controller.MAge = (N/twoWeeks)*100;
            controller.M0Age = (M0/twoWeeks)*100;
            controller.M1Age = (M1/twoWeeks)*100;
            
            
        }else{
            controller.TxAge = 0;
            controller.T0Age = 0;
            controller.T1Age = 0;
            controller.T1aAge = 0;
            controller.T1bAge = 0;
            controller.T2Age = 0;
            controller.T2aAge = 0;
            controller.T2bAge = 0;
            controller.T3Age = 0;
            controller.T3aAge = 0;
            controller.T3bAge = 0;
            controller.T3cAge = 0;
            controller.T4Age = 0;
            controller.NAge = 0;
            controller.NxAge = 0;
            controller.N0Age = 0;
            controller.N1Age = 0;
            controller.MAge = 0;
            controller.M0Age = 0;
            controller.M1Age = 0;
        }
        if(s_twoWeeks>0){
            controller.s_TxAge = (s_Tx/s_twoWeeks)*100;
            controller.T0Age = (s_T0/s_twoWeeks)*100;
            controller.s_T1Age = (s_T1/s_twoWeeks)*100;
            controller.s_T1aAge = (s_T1a/s_twoWeeks)*100;
            controller.s_T1bAge = (s_T1b/s_twoWeeks)*100;
            controller.s_T2Age = (s_T2/s_twoWeeks)*100;
            controller.s_T2aAge = (s_T2a/s_twoWeeks)*100;
            controller.s_T2bAge = (s_T2b/s_twoWeeks)*100;
            controller.s_T3Age = (s_T3/s_twoWeeks)*100;
            controller.s_T3aAge = (s_T3/s_twoWeeks)*100;
            controller.s_T3bAge = (s_T3/s_twoWeeks)*100;
            controller.s_T3cAge = (s_T3/s_twoWeeks)*100;
            controller.s_T4Age = (s_T4/s_twoWeeks)*100;
            controller.s_NAge = (s_N/s_twoWeeks)*100;
            controller.s_NxAge = (s_Nx/s_twoWeeks)*100;
            controller.s_N0Age = (s_N0/s_twoWeeks)*100;
            controller.s_N1Age = (s_N1/s_twoWeeks)*100;
            controller.s_MAge = (s_N/s_twoWeeks)*100;
            controller.s_M0Age = (s_M0/s_twoWeeks)*100;
            controller.s_M1Age = (s_M1/s_twoWeeks)*100;
        }else{
            controller.s_TxAge = 0;
            controller.s_T0Age = 0;
            controller.s_T1Age = 0;
            controller.s_T1aAge = 0;
            controller.s_T1bAge = 0;
            controller.s_T2Age = 0;
            controller.s_T2aAge = 0;
            controller.s_T2bAge = 0;
            controller.s_T3Age = 0;
            controller.s_T3aAge = 0;
            controller.s_T3bAge = 0;
            controller.s_T3cAge = 0;
            controller.s_T4Age = 0;
            controller.s_NAge = 0;
            controller.s_NxAge = 0;
            controller.s_N0Age = 0;
            controller.s_N1Age = 0;
            controller.s_MAge = 0;
            controller.s_M0Age = 0;
            controller.s_M1Age = 0;
        }
        
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        
        //controller.NationalSize = self.totalNationalCount;
        //controller.SurgeonSize = self.totalSurgeonCount;
       
        //controller.NationalSize = self.totalNationalCount;
        //controller.SurgeonSize = self.totalSurgeonCount;
        controller.graphView = @"TNM";
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

-(IBAction)tumorCh:(id)sender{
    
    if(!isNational){
        [self calculate];
        
        UCSurgeonPerformanceGraphs *controller = [[UCSurgeonPerformanceGraphs alloc] initWithNibName:@"UCSurgeonPerformanceGraphs" bundle:nil];
        if(twoWeeks>0){
            controller.ClearAll = (ClearAll/twoWeeks)*100;
            controller.Papillary = (Papillary/twoWeeks)*100;
            controller.Chromophobe = (Chromophobe/twoWeeks)*100;
            controller.Sarcomatoid = (Sarcomatoid/twoWeeks)*100;
            controller.oncocytoma = (oncocytoma/twoWeeks)*100;
            controller.other = (other/twoWeeks)*100;
            controller.angiomyolipoma = (angiomyolipoma/twoWeeks)*100;
        }else{
            controller.ClearAll = 0;
            controller.Papillary = 0;
            controller.Chromophobe = 0;
            controller.Sarcomatoid = 0;
            controller.oncocytoma = 0;
            controller.other = 0;
            controller.angiomyolipoma = 0;
        }
        controller.maxSampleSize = twoWeeks;
        //controller.maxSampleSize = self.totalCount;
//        controller.maxSampleSize = [self.performanceCases count];
        controller.graphView = @"tumorCh";
        [self.navigationController pushViewController:controller animated:YES];

    }else{
        [self calculate];
        [self calculateSurgeonData];
        UCNationalPerformanceGraphs *controller = [[UCNationalPerformanceGraphs alloc] initWithNibName:@"UCNationalPerformanceGraphs" bundle:nil];
        if(twoWeeks>0){
            controller.ClearAll = (ClearAll/twoWeeks)*100;
            controller.Papillary = (Papillary/twoWeeks)*100;
            controller.Chromophobe = (Chromophobe/twoWeeks)*100;
            controller.Sarcomatoid = (Sarcomatoid/twoWeeks)*100;
            controller.oncocytoma = (oncocytoma/twoWeeks)*100;
            controller.other = (other/twoWeeks)*100;
            controller.angiomyolipoma = (angiomyolipoma/twoWeeks)*100;
        }else{
            controller.ClearAll = 0;
            controller.Papillary = 0;
            controller.Chromophobe = 0;
            controller.Sarcomatoid = 0;
            controller.oncocytoma = 0;
            controller.other = 0;
            controller.angiomyolipoma = 0;
        }
        if(s_twoWeeks>0){
            controller.s_ClearAll = (s_ClearAll/s_twoWeeks)*100;
            controller.s_Papillary = (s_Papillary/s_twoWeeks)*100;
            controller.s_Chromophobe = (s_Chromophobe/s_twoWeeks)*100;
            controller.s_Sarcomatoid = (s_Sarcomatoid/s_twoWeeks)*100;
            controller.s_oncocytoma = (s_oncocytoma/s_twoWeeks)*100;
            controller.s_other = (s_other/s_twoWeeks)*100;
            controller.s_angiomyolipoma = (s_angiomyolipoma/s_twoWeeks)*100;
        }else{
            controller.s_ClearAll = 0;
            controller.s_Papillary = 0;
            controller.s_Chromophobe = 0;
            controller.s_Sarcomatoid = 0;
            controller.s_oncocytoma = 0;
            controller.s_other = 0;
            controller.s_angiomyolipoma = 0;
        }
        
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        
        //controller.NationalSize = self.totalNationalCount;
        //controller.SurgeonSize = self.totalSurgeonCount;
        
        //controller.NationalSize = [self.performanceCases count];
        //controller.SurgeonSize = [self.surgeonCases count];
        controller.graphView = @"tumorCh";
        [self.navigationController pushViewController:controller animated:YES];

    }
    
}


-(IBAction)fuhrmanGrade:(id)sender{
    
    if(!isNational){
        [self calculate];
        
        UCSurgeonPerformanceGraphs *controller = [[UCSurgeonPerformanceGraphs alloc] initWithNibName:@"UCSurgeonPerformanceGraphs" bundle:nil];
        if(twoWeeks>0){
            controller.FGoneByFour = (FGoneByFour/twoWeeks)*100;
            controller.FGtwoByFour = (FGtwoByFour/twoWeeks)*100;
            controller.FGthreeByFour = (FGthreeByFour/twoWeeks)*100;
            controller.FGfourByFour = (FGfourByFour/twoWeeks)*100;
        }else{
            controller.FGoneByFour = 0;
            controller.FGtwoByFour = 0;
            controller.FGthreeByFour = 0;
            controller.FGfourByFour = 0;
        }
        controller.maxSampleSize = twoWeeks;
        //controller.maxSampleSize = self.totalCount;
        //controller.maxSampleSize = [self.performanceCases count];
        controller.graphView = @"FGrade";
        
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [self calculate];
        [self calculateSurgeonData];
        UCNationalPerformanceGraphs *controller = [[UCNationalPerformanceGraphs alloc] initWithNibName:@"UCNationalPerformanceGraphs" bundle:nil];
        if(twoWeeks>0){
            controller.FGoneByFour = (FGoneByFour/twoWeeks)*100;
            controller.FGtwoByFour = (FGtwoByFour/twoWeeks)*100;
            controller.FGthreeByFour = (FGthreeByFour/twoWeeks)*100;
            controller.FGfourByFour = (FGfourByFour/twoWeeks)*100;
        }else{
            controller.FGoneByFour = 0;
            controller.FGtwoByFour = 0;
            controller.FGthreeByFour = 0;
            controller.FGfourByFour = 0;
        }
        if(s_twoWeeks>0){
            controller.s_FGoneByFour = (s_FGoneByFour/s_twoWeeks)*100;
            controller.s_FGtwoByFour = (s_FGtwoByFour/s_twoWeeks)*100;
            controller.s_FGthreeByFour = (s_FGthreeByFour/s_twoWeeks)*100;
            controller.s_FGfourByFour = (s_FGfourByFour/s_twoWeeks)*100;
        }else{
            controller.s_FGoneByFour = 0;
            controller.s_FGtwoByFour = 0;
            controller.s_FGthreeByFour = 0;
            controller.s_FGfourByFour = 0;
        }
        
        
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        
        //controller.NationalSize = self.totalNationalCount;
        //controller.SurgeonSize = self.totalSurgeonCount;
        
        //controller.NationalSize = [self.performanceCases count];
        //controller.SurgeonSize = [self.surgeonCases count];
        controller.graphView = @"FGrade";
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
}


-(IBAction)margins:(id)sender{
    
    if(!isNational){
        [self calculate];
        
        UCSurgeonPerformanceGraphs *controller = [[UCSurgeonPerformanceGraphs alloc] initWithNibName:@"UCSurgeonPerformanceGraphs" bundle:nil];
        if(twoWeeks>0){
            controller.mPositive = (mPositive/twoWeeks)*100;
            controller.mNegative = (mNegative/twoWeeks)*100;
        }else{
            controller.mPositive = 0;
            controller.mNegative = 0;
        }
        controller.maxSampleSize = twoWeeks;
        //controller.maxSampleSize = self.totalCount;
        //controller.maxSampleSize = [self.performanceCases count];
        
        controller.graphView = @"margins";
        
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [self calculate];
        [self calculateSurgeonData];
        UCNationalPerformanceGraphs *controller = [[UCNationalPerformanceGraphs alloc] initWithNibName:@"UCNationalPerformanceGraphs" bundle:nil];
        if(twoWeeks>0){
            controller.mPositive = (mPositive/twoWeeks)*100;
            controller.mNegative = (mNegative/twoWeeks)*100;
        }else{
            controller.mPositive = 0;
            controller.mNegative = 0;
        }
        
        if(s_twoWeeks>0){
            controller.s_mPositive = (s_mPositive/s_twoWeeks)*100;
            controller.s_mNegative = (s_mNegative/s_twoWeeks)*100;
        }else{
            controller.s_mPositive = 0;
            controller.s_mNegative = 0;
        }
        
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        
        //controller.NationalSize = self.totalNationalCount;
        //controller.SurgeonSize = self.totalSurgeonCount;
        
        //controller.NationalSize = [self.performanceCases count];
        //controller.SurgeonSize = [self.surgeonCases count];
        controller.graphView = @"margins";
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
}

-(IBAction)dMargin:(id)sender{
    
    if(!isNational){
        [self calculate];
        
        UCSurgeonPerformanceGraphs *controller = [[UCSurgeonPerformanceGraphs alloc] initWithNibName:@"UCSurgeonPerformanceGraphs" bundle:nil];
        if(twoWeeks>0){
            controller.dmPositive = (dmPositive/twoWeeks)*100;
            controller.dmNegative = (dmNegative/twoWeeks)*100;
        }else{
            controller.dmPositive = 0;
            controller.dmNegative = 0;
        }
        controller.maxSampleSize = twoWeeks;
        //controller.maxSampleSize = self.totalCount;
        //controller.maxSampleSize = [self.performanceCases count];
        
        controller.graphView = @"dMargin";
        
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [self calculate];
        [self calculateSurgeonData];
        UCNationalPerformanceGraphs *controller = [[UCNationalPerformanceGraphs alloc] initWithNibName:@"UCNationalPerformanceGraphs" bundle:nil];
        if(twoWeeks>0){
            controller.dmPositive = (dmPositive/twoWeeks)*100;
            controller.dmNegative = (dmNegative/twoWeeks)*100;
        }else{
            controller.dmPositive = 0;
            controller.dmNegative = 0;
        }
        if(s_twoWeeks>0){
            controller.s_dmPositive = (s_dmPositive/s_twoWeeks)*100;
            controller.s_dmNegative = (s_dmNegative/s_twoWeeks)*100;
        }else{
            controller.s_dmPositive = 0;
            controller.s_dmNegative = 0;
        }
        
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        
        //controller.NationalSize = self.totalNationalCount;
        //controller.SurgeonSize = self.totalSurgeonCount;
        
        //controller.NationalSize = [self.performanceCases count];
        //controller.SurgeonSize = [self.surgeonCases count];
        controller.graphView = @"dMargin";
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
}


-(IBAction)nights:(id)sender{
    
    if(!isNational){
        [self calculate];
        
        UCSurgeonPerformanceGraphs *controller = [[UCSurgeonPerformanceGraphs alloc] initWithNibName:@"UCSurgeonPerformanceGraphs" bundle:nil];
        
        NSLog(@"*** LENGTH OF STAY  ::  %f",stayCount/twoWeeks);
        controller.graphView = @"nights";
        if(twoWeeks>0){
            controller.averageStay = stayCount/twoWeeks;
            controller.minStay = minStay;
            controller.maxStay = maxStay;
        }else{
            controller.averageStay = 0;
            controller.minStay = 0;
            controller.maxStay = 0;
        }
        controller.maxSampleSize = twoWeeks;
        //controller.maxSampleSize = self.totalCount;
        //controller.maxSampleSize = [self.performanceCases count];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [self calculate];
        [self calculateSurgeonData];
        UCNationalPerformanceGraphs *controller = [[UCNationalPerformanceGraphs alloc] initWithNibName:@"UCNationalPerformanceGraphs" bundle:nil];
        
        NSLog(@"*** LENGTH OF STAY  ::  %f",stayCount/twoWeeks);
        controller.graphView = @"nights";
        if(twoWeeks>0){
            controller.averageStay = stayCount/twoWeeks;
            controller.minStay = minStay;
            controller.maxStay = maxStay;
        }else{
            controller.averageStay = 0;
            controller.minStay = 0;
            controller.maxStay = 0;
        }
        if(s_twoWeeks>0){
            controller.s_averageStay = s_stayCount/s_twoWeeks;
            controller.s_minStay = s_minStay;
            controller.s_maxStay = s_maxStay;
        }else{
            controller.s_averageStay = 0;
            controller.s_minStay = 0;
            controller.s_maxStay = 0;
        }
        
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        
        //controller.NationalSize = self.totalNationalCount;
        //controller.SurgeonSize = self.totalSurgeonCount;
        
        //controller.NationalSize = [self.performanceCases count];
        //controller.SurgeonSize = [self.surgeonCases count];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}


-(IBAction)complications:(id)sender{
    
    if(!isNational){
        [self calculate];
        
        UCSurgeonPerformanceGraphs *controller = [[UCSurgeonPerformanceGraphs alloc] initWithNibName:@"UCSurgeonPerformanceGraphs" bundle:nil];
        if(twoWeeks>0){
            controller.Ileus = (Ileus/twoWeeks)*100;
            controller.BowelInjury = (BowelInjury/twoWeeks)*100;
            controller.Infection = (Infection/twoWeeks)*100;
            controller.UrineLeak = (UrineLeak/twoWeeks)*100;
            controller.DVT = (DVT/twoWeeks)*100;
            controller.PE = (PE/twoWeeks)*100;
            controller.CardiacEvent = (CardiacEvent/twoWeeks)*100;
            controller.Hernia = (Hernia/twoWeeks)*100;
            controller.Transfusion = (Transfusion/twoWeeks)*100;
            controller.Death = (Death/twoWeeks)*100;
            controller.OtherComp = (OtherComp/twoWeeks)*100;
        }else{
            controller.Ileus = 0;
            controller.BowelInjury = 0;
            controller.Infection = 0;
            controller.UrineLeak = 0;
            controller.DVT = 0;
            controller.PE = 0;
            controller.CardiacEvent = 0;
            controller.Hernia = 0;
            controller.Transfusion = 0;
            controller.Death = 0;
            controller.OtherComp = 0;
        }
        controller.maxSampleSize = twoWeeks;
        //controller.maxSampleSize = self.totalCount;
        //controller.maxSampleSize = [self.performanceCases count];
        controller.graphView = @"complications";
        
        [self.navigationController pushViewController:controller animated:YES];

    }else{
        [self calculate];
        [self calculateSurgeonData];
        UCNationalPerformanceGraphs *controller = [[UCNationalPerformanceGraphs alloc] initWithNibName:@"UCNationalPerformanceGraphs" bundle:nil];
        if(twoWeeks>0){
            controller.Ileus = (Ileus/twoWeeks)*100;
            controller.BowelInjury = (BowelInjury/twoWeeks)*100;
            controller.Infection = (Infection/twoWeeks)*100;
            controller.UrineLeak = (UrineLeak/twoWeeks)*100;
            controller.DVT = (DVT/twoWeeks)*100;
            controller.PE = (PE/twoWeeks)*100;
            controller.CardiacEvent = (CardiacEvent/twoWeeks)*100;
            controller.Hernia = (Hernia/twoWeeks)*100;
            controller.Transfusion = (Transfusion/twoWeeks)*100;
            controller.Death = (Death/twoWeeks)*100;
            controller.OtherComp = (OtherComp/twoWeeks)*100;
        }else{
            controller.Ileus = 0;
            controller.BowelInjury = 0;
            controller.Infection = 0;
            controller.UrineLeak = 0;
            controller.DVT = 0;
            controller.PE = 0;
            controller.CardiacEvent = 0;
            controller.Hernia = 0;
            controller.Transfusion = 0;
            controller.Death = 0;
            controller.OtherComp = 0;
        }
        
        if(s_twoWeeks>0){
            controller.s_Ileus = (s_Ileus/s_twoWeeks)*100;
            controller.s_BowelInjury = (s_BowelInjury/s_twoWeeks)*100;
            controller.s_Infection = (s_Infection/s_twoWeeks)*100;
            controller.s_UrineLeak = (s_UrineLeak/s_twoWeeks)*100;
            controller.s_DVT = (s_DVT/s_twoWeeks)*100;
            controller.s_PE = (s_PE/s_twoWeeks)*100;
            controller.s_CardiacEvent = (s_CardiacEvent/s_twoWeeks)*100;
            controller.s_Hernia = (s_Hernia/s_twoWeeks)*100;
            controller.s_Transfusion = (s_Transfusion/s_twoWeeks)*100;
            controller.s_Death = (s_Death/s_twoWeeks)*100;
            controller.s_OtherComp = (s_OtherComp/s_twoWeeks)*100;
        }else{
            controller.s_Ileus = 0;
            controller.s_BowelInjury = 0;
            controller.s_Infection = 0;
            controller.s_UrineLeak = 0;
            controller.s_DVT = 0;
            controller.s_PE = 0;
            controller.s_CardiacEvent = 0;
            controller.s_Hernia = 0;
            controller.s_Transfusion = 0;
            controller.s_Death = 0;
            controller.s_OtherComp = 0;
        }
        
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        
        //controller.NationalSize = self.totalNationalCount;
        //controller.SurgeonSize = self.totalSurgeonCount;
        
        //controller.NationalSize = [self.performanceCases count];
        //controller.SurgeonSize = [self.surgeonCases count];
        controller.graphView = @"complications";
        
        [self.navigationController pushViewController:controller animated:YES];
    }
        
    
}

-(IBAction)changeBUN:(id)sender{

    if(!isNational){
        [self calculate];
        NSLog(@" ^^^^^^ SUM OF BUN  : %f",bunDiffSum);
        UCSurgeonPerformanceGraphs *controller = [[UCSurgeonPerformanceGraphs alloc] initWithNibName:@"UCSurgeonPerformanceGraphs" bundle:nil];
        controller.graphView = @"BUN";
        if(twoWeeks>0){
            controller.bunSum = bunDiffSum/twoWeeks;
        }else{
            controller.bunSum = 0;
        }
        controller.maxSampleSize = twoWeeks;
        //controller.maxSampleSize = self.totalCount;
        //controller.maxSampleSize = [self.performanceCases count];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [self calculate];
        [self calculateSurgeonData];
        NSLog(@" ^^^^^^ SUM OF BUN  : %f",bunDiffSum);
        UCNationalPerformanceGraphs *controller = [[UCNationalPerformanceGraphs alloc] initWithNibName:@"UCNationalPerformanceGraphs" bundle:nil];
        controller.graphView = @"BUN";
        if(twoWeeks>0){
            controller.bunSum = bunDiffSum/twoWeeks;
        }else{
            controller.bunSum = 0;
        }
        if(s_twoWeeks>0){
            controller.s_bunSum = s_bunDiffSum/s_twoWeeks;
        }else{
            controller.s_bunSum = 0;
        }
        
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        
        //controller.NationalSize = self.totalNationalCount;
        //controller.SurgeonSize = self.totalSurgeonCount;
        
        //controller.NationalSize = [self.performanceCases count];
        //controller.SurgeonSize = [self.surgeonCases count];
        [self.navigationController pushViewController:controller animated:YES];
    }
    

}

-(IBAction)changeCreatinine:(id)sender{
    
    if(!isNational){
        [self calculate];
        NSLog(@" ^^^^^^ SUM OF Creatinine  : %f",creatinineDiffSum);
        UCSurgeonPerformanceGraphs *controller = [[UCSurgeonPerformanceGraphs alloc] initWithNibName:@"UCSurgeonPerformanceGraphs" bundle:nil];
        controller.graphView = @"Creatinine";
        if(twoWeeks>0){
            controller.creatinineSum = creatinineDiffSum/twoWeeks;
        }else{
            controller.creatinineSum = 0;
        }
        controller.maxSampleSize = twoWeeks;
        //controller.maxSampleSize = self.totalCount;
        //controller.maxSampleSize = [self.performanceCases count];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [self calculate];
        [self calculateSurgeonData];
        NSLog(@" ^^^^^^ SUM OF Creatinine  : %f",creatinineDiffSum);
        UCNationalPerformanceGraphs *controller = [[UCNationalPerformanceGraphs alloc] initWithNibName:@"UCNationalPerformanceGraphs" bundle:nil];
        controller.graphView = @"Creatinine";
        if(twoWeeks>0){
            controller.creatinineSum = creatinineDiffSum/twoWeeks;
        }else{
            controller.creatinineSum = 0;
        }
        if(s_twoWeeks>0){
            controller.s_creatinineSum = s_creatinineDiffSum/s_twoWeeks;
        }else{
            controller.s_creatinineSum = 0;
        }
        
        controller.NationalSize = twoWeeks;
        controller.SurgeonSize = s_twoWeeks;
        
        //controller.NationalSize = self.totalNationalCount;
        //controller.SurgeonSize = self.totalSurgeonCount;
        
        //controller.NationalSize = [self.performanceCases count];
        //controller.SurgeonSize = [self.surgeonCases count];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
    
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
    if (DELEGATE.isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}

@end
