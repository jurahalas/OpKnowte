//
//  UCSurgeonPerformanceSixMonths.m
//  MZUroCapture
//
//  Created by Atif Joyia on 20/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSurgeonPerformanceSixMonths.h"
#import "UCSurgeonPerformanceGraphs.h"
#import "UCSettingsViewController.h"
#import "UCHomeScreenViewController.h"
#import "UCNationalPerformanceGraphs.h"
@interface UCSurgeonPerformanceSixMonths ()

@end

float twoWeeks;
float sixMonths;

float bunSum;
float minBun;
float maxBun;

float creatinineSum;
float minCreatinine;
float maxCreatinine;

float xrayPositive;
float xrayNegative;

float liverNormal;
float liverAbNormal;

float herniaNO;
float herniaYES;

float metastaticDisease;
float LocalRecurrence;
float Lymphadenopathy;
float LiverMetastasis;
float BoneMetastasis;
float BrainMetastasis;

float s_twoWeeks;
float s_sixMonths;

float s_bunSum;
float s_minBun;
float s_maxBun;

float s_creatinineSum;
float s_minCreatinine;
float s_maxCreatinine;

float s_xrayPositive;
float s_xrayNegative;

float s_liverNormal;
float s_liverAbNormal;

float s_herniaNO;
float s_herniaYES;

float s_metastaticDisease;
float s_LocalRecurrence;
float s_Lymphadenopathy;
float s_LiverMetastasis;
float s_BoneMetastasis;
float s_BrainMetastasis;

@implementation UCSurgeonPerformanceSixMonths

@synthesize scroller,totalCount, totalSurgeonCount, totalNationalCount;
@synthesize performanceCases;
@synthesize surgeonCases,isNational, timepointID;

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
    
    [self.scroller setContentSize:CGSizeMake(320, 200)];
    
    if (IS_IPHONE_5) {
        l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }
    if (self.isNational) {
        [l_Header setText:@"NATIONAL PERFORMANCE DATA"];
    }
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
}

-(void)resetCounter{
    twoWeeks = 0;
    sixMonths = 0;
    
    creatinineSum=0;
    bunSum=0;
    minCreatinine=0;
    maxCreatinine=0;
    minBun=0;
    maxBun=0;
    
    xrayPositive = 0;
    xrayNegative = 0;
    
    liverAbNormal = 0;
    liverNormal = 0;
    
    herniaYES = 0;
    herniaNO = 0;

    
    metastaticDisease = 0;
    LocalRecurrence = 0;
    Lymphadenopathy = 0;
    LiverMetastasis = 0;
    BoneMetastasis = 0;
    BrainMetastasis = 0;
    
   // dmPositive = 0;
    //dmNegative = 0;
    
}

-(void)resetSurgeonCounter{
    s_twoWeeks = 0;
    s_sixMonths = 0;
    
    s_creatinineSum=0;
    s_bunSum=0;
    s_minCreatinine=0;
    s_maxCreatinine=0;
    s_minBun=0;
    s_maxBun=0;
    
    s_xrayPositive = 0;
    s_xrayNegative = 0;
    
    s_liverAbNormal = 0;
    s_liverNormal = 0;
    
    s_herniaYES = 0;
    s_herniaNO = 0;
    
    
    s_metastaticDisease = 0;
    s_LocalRecurrence = 0;
    s_Lymphadenopathy = 0;
    s_LiverMetastasis = 0;
    s_BoneMetastasis = 0;
    s_BrainMetastasis = 0;
    
    // dmPositive = 0;
    //dmNegative = 0;
    
}


-(void)calculate{
    
    [self resetCounter];
    
    for (int i = 0; i < [self.performanceCases count]; i++) {
        NSDictionary *dict = [self.performanceCases objectAtIndex:i];
        NSLog(@"%@",[dict objectForKey:@"timePointID"]);
        
        if ([[dict objectForKey:@"timePointID"] isEqualToString:@"1"]) {
            twoWeeks++;
            
        }else if ([[dict objectForKey:@"timePointID"] intValue] >1 && [[dict objectForKey:@"timePointID"] intValue] <12 && [[dict objectForKey:@"timePointID"] intValue] == self.timepointID){
            sixMonths++;
            
            NSString *xray = [dict objectForKey:@"chestXray"];
            //NSLog(@"%@", xray);
            if (xray.length > 0) {
                if ([xray isEqualToString:@"Positive"]) {
                    xrayPositive++;
                }else if ([xray isEqualToString:@"Negative"]){
                    xrayNegative++;
                }
            }
            
            if([dict objectForKey:@"Bun"]){
                float bun = [[dict objectForKey:@"Bun"] floatValue];
                bunSum+=bun;
                if(sixMonths == 1){
                    minBun = bun;
                    maxBun = bun;
                }else{
                    if(bun>maxBun){
                        maxBun = bun;
                    }
                    if(bun<minBun){
                        minBun = bun;
                    }
                }
            }
            
            if([dict objectForKey:@"Creatinine"]){
                float crt = [[dict objectForKey:@"Creatinine"] floatValue];
                creatinineSum+= crt;
                if(sixMonths == 1){
                    minCreatinine = crt;
                    maxCreatinine = crt;
                }else{
                    if(crt>maxCreatinine){
                        maxCreatinine = crt;
                    }
                    if(crt<minCreatinine){
                        minCreatinine = crt;
                    }
                }
            }
            
            NSString *liver = [dict objectForKey:@"liverEnzymes"];
            //NSLog(@"%@", liver);
            if (xray.length > 0) {
                if ([liver isEqualToString:@"Normal"]) {
                    liverNormal++;
                }else if ([liver isEqualToString:@"Abnormal"]){
                    liverAbNormal++;
                }
            }
            
            NSString *hernia = [dict objectForKey:@"portSiteHemia"];
            //NSLog(@"%@", hernia);
            if (hernia.length > 0) {
                if ([hernia isEqualToString:@"Yes"]) {
                    herniaYES++;
                }else if ([hernia isEqualToString:@"No"]){
                    herniaNO++;
                }
            }

            
            NSString *ctscan = [dict objectForKey:@"CtScan"];
            //NSLog(@"%@", ctscan);
            if (ctscan.length > 0) {
                if ([ctscan isEqualToString:@"No evidence of metastatic disease"]) {
                    metastaticDisease++;
                }else if ([ctscan isEqualToString:@"Local recurrence"]){
                    LocalRecurrence++;
                }else if ([ctscan isEqualToString:@"Lymphadenopathy"]){
                    Lymphadenopathy++;
                }else if ([ctscan isEqualToString:@"Liver metastasis"]){
                    LiverMetastasis++;
                }else if ([ctscan isEqualToString:@"Bone metastasis"]){
                    BoneMetastasis++;
                }else if ([ctscan isEqualToString:@"Brain metastasis"]){
                    BrainMetastasis++;
                }
            }
        }
    }
}


-(void)calculateSurgeonData{
    
    [self resetSurgeonCounter];
    
    for (int i = 0; i < [self.surgeonCases count]; i++) {
        NSDictionary *dict = [self.surgeonCases objectAtIndex:i];
        NSLog(@"%@",[dict objectForKey:@"timePointID"]);
        
        if ([[dict objectForKey:@"timePointID"] isEqualToString:@"1"]) {
            s_twoWeeks++;
            
        }else if ([[dict objectForKey:@"timePointID"] intValue] >1 && [[dict objectForKey:@"timePointID"] intValue] <12 && [[dict objectForKey:@"timePointID"] intValue] == self.timepointID){
            s_sixMonths++;
            
            NSString *xray = [dict objectForKey:@"chestXray"];
            NSLog(@"%@", xray);
            if (xray.length > 0) {
                if ([xray isEqualToString:@"Positive"]) {
                    s_xrayPositive++;
                }else if ([xray isEqualToString:@"Negative"]){
                    s_xrayNegative++;
                }
            }
            
            if([dict objectForKey:@"Bun"]){
                float bun = [[dict objectForKey:@"Bun"] floatValue];
                s_bunSum+=bun;
                if(s_sixMonths == 1){
                    s_minBun = bun;
                    s_maxBun = bun;
                }else{
                    if(bun>s_maxBun){
                        s_maxBun = bun;
                    }
                    if(bun<s_minBun){
                        s_minBun = bun;
                    }
                }
            }
            
            if([dict objectForKey:@"Creatinine"]){
                float crt = [[dict objectForKey:@"Creatinine"] floatValue];
                s_creatinineSum+= crt;
                if(s_sixMonths == 1){
                    s_minCreatinine = crt;
                    s_maxCreatinine = crt;
                }else{
                    if(crt>s_maxCreatinine){
                        s_maxCreatinine = crt;
                    }
                    if(crt<s_minCreatinine){
                       s_minCreatinine = crt;
                    }
                }
            }
            
            NSString *liver = [dict objectForKey:@"liverEnzymes"];
            NSLog(@"%@", liver);
            if (xray.length > 0) {
                if ([liver isEqualToString:@"Normal"]) {
                    s_liverNormal++;
                }else if ([liver isEqualToString:@"Abnormal"]){
                    s_liverAbNormal++;
                }
            }
            
            NSString *hernia = [dict objectForKey:@"portSiteHemia"];
            NSLog(@"%@", hernia);
            if (hernia.length > 0) {
                if ([hernia isEqualToString:@"Yes"]) {
                    s_herniaYES++;
                }else if ([hernia isEqualToString:@"No"]){
                    s_herniaNO++;
                }
            }
            
            
            NSString *ctscan = [dict objectForKey:@"CtScan"];
            NSLog(@"%@", ctscan);
            if (ctscan.length > 0) {
                if ([ctscan isEqualToString:@"No evidence of metastatic disease"]) {
                    s_metastaticDisease++;
                }else if ([ctscan isEqualToString:@"Local recurrence"]){
                    s_LocalRecurrence++;
                }else if ([ctscan isEqualToString:@"Lymphadenopathy"]){
                    s_Lymphadenopathy++;
                }else if ([ctscan isEqualToString:@"Liver metastasis"]){
                    s_LiverMetastasis++;
                }else if ([ctscan isEqualToString:@"Bone metastasis"]){
                    s_BoneMetastasis++;
                }else if ([ctscan isEqualToString:@"Brain metastasis"]){
                    s_BrainMetastasis++;
                }
            }
            
        }
        
    }
    
}
-(IBAction)xray:(id)sender{
    
    if(!isNational){
        [self calculate];
        
        UCSurgeonPerformanceGraphs *controller = [[UCSurgeonPerformanceGraphs alloc] initWithNibName:@"UCSurgeonPerformanceGraphs" bundle:nil];
        if(sixMonths>0)
        {
            controller.xrayPositive = (xrayPositive/sixMonths)*100;
            controller.xrayNegative = (xrayNegative/sixMonths)*100;
        }
        controller.maxSampleSize = sixMonths;
        //controller.maxSampleSize = self.totalCount;
        //controller.maxSampleSize = [self.performanceCases count];
        controller.graphView = @"xray";
        
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [self calculate];
        [self calculateSurgeonData];
        UCNationalPerformanceGraphs *controller = [[UCNationalPerformanceGraphs alloc] initWithNibName:@"UCNationalPerformanceGraphs" bundle:nil];
        if(sixMonths>0)
        {
            controller.xrayPositive = (xrayPositive/sixMonths)*100;
            controller.xrayNegative = (xrayNegative/sixMonths)*100;
        }
        if(s_sixMonths>0)
        {
            controller.s_xrayPositive = (s_xrayPositive/s_sixMonths)*100;
            controller.s_xrayNegative = (s_xrayNegative/s_sixMonths)*100;
        }
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        
        //controller.NationalSize = self.totalNationalCount;
        //controller.SurgeonSize = self.totalSurgeonCount;
        
        //controller.NationalSize = [self.performanceCases count];
        //controller.SurgeonSize = [self.surgeonCases count];
        controller.graphView = @"xray";
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}


-(IBAction)Liver:(id)sender{
    
    if(!isNational){
        [self calculate];
        
        UCSurgeonPerformanceGraphs *controller = [[UCSurgeonPerformanceGraphs alloc] initWithNibName:@"UCSurgeonPerformanceGraphs" bundle:nil];
        if(sixMonths>0){
            controller.liverNormal = (liverNormal/sixMonths)*100;
            controller.liverAbNormal = (liverAbNormal/sixMonths)*100;
        }else{
            controller.liverNormal = 0;
            controller.liverAbNormal = 0;
        }
        controller.maxSampleSize = sixMonths;
        //controller.maxSampleSize = self.totalCount;
        //controller.maxSampleSize = [self.performanceCases count];
        controller.graphView = @"liver";
        
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [self calculate];
        [self calculateSurgeonData];
        UCNationalPerformanceGraphs *controller = [[UCNationalPerformanceGraphs alloc] initWithNibName:@"UCNationalPerformanceGraphs" bundle:nil];
        if(sixMonths>0){
            controller.liverNormal = (liverNormal/sixMonths)*100;
            controller.liverAbNormal = (liverAbNormal/sixMonths)*100;
        }else{
            controller.liverNormal = 0;
            controller.liverAbNormal = 0;
        }
        if(s_sixMonths>0){
            controller.s_liverNormal = (s_liverNormal/s_sixMonths)*100;
            controller.s_liverAbNormal = (s_liverAbNormal/s_sixMonths)*100;
        }else{
            controller.s_liverNormal = 0;
            controller.s_liverAbNormal = 0;
        }
        controller.graphView = @"liver";
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        
        //controller.NationalSize = self.totalNationalCount;
        //controller.SurgeonSize = self.totalSurgeonCount;
        
        //controller.NationalSize = [self.performanceCases count];
        //controller.SurgeonSize = [self.surgeonCases count];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}


-(IBAction)Hernia:(id)sender{
    
    if(!isNational){
        [self calculate];
        
        UCSurgeonPerformanceGraphs *controller = [[UCSurgeonPerformanceGraphs alloc] initWithNibName:@"UCSurgeonPerformanceGraphs" bundle:nil];
        if(sixMonths>0){
            controller.herniaYES = (herniaYES/sixMonths)*100;
            controller.herniaNO = (herniaNO/sixMonths)*100;
        }else{
            controller.herniaYES = 0;
            controller.herniaNO = 0;
        }
        
        controller.maxSampleSize = sixMonths;
        //controller.maxSampleSize = self.totalCount;
        //controller.maxSampleSize = [self.performanceCases count];
        controller.graphView = @"hernia";
        
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [self calculate];
        [self calculateSurgeonData];
        UCNationalPerformanceGraphs *controller = [[UCNationalPerformanceGraphs alloc] initWithNibName:@"UCNationalPerformanceGraphs" bundle:nil];
        if(sixMonths>0){
            controller.herniaYES = (herniaYES/sixMonths)*100;
            controller.herniaNO = (herniaNO/sixMonths)*100;
        }else{
            controller.herniaYES = 0;
            controller.herniaNO = 0;
        }
        if(s_sixMonths>0){
            controller.s_herniaYES = (s_herniaYES/s_sixMonths)*100;
            controller.s_herniaNO = (s_herniaNO/s_sixMonths)*100;
        }else{
            controller.s_herniaYES = 0;
            controller.s_herniaNO = 0;
        }
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        
        //controller.NationalSize = self.totalNationalCount;
        //controller.SurgeonSize = self.totalSurgeonCount;
        
        //controller.NationalSize = [self.performanceCases count];
        //controller.SurgeonSize = [self.surgeonCases count];
        controller.graphView = @"hernia";
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
}


-(IBAction)CTScan:(id)sender{
    
    if(!isNational){
        [self calculate];
        
        UCSurgeonPerformanceGraphs *controller = [[UCSurgeonPerformanceGraphs alloc] initWithNibName:@"UCSurgeonPerformanceGraphs" bundle:nil];
        if(sixMonths>0){
            controller.metastaticDisease = (metastaticDisease/sixMonths)*100;
            controller.LocalRecurrence = (LocalRecurrence/sixMonths)*100;
            controller.Lymphadenopathy = (Lymphadenopathy/sixMonths)*100;
            controller.LiverMetastasis = (LiverMetastasis/sixMonths)*100;
            controller.BoneMetastasis = (BoneMetastasis/sixMonths)*100;
            controller.BrainMetastasis = (BrainMetastasis/sixMonths)*100;
        }else{
            controller.metastaticDisease = 0;
            controller.LocalRecurrence = 0;
            controller.Lymphadenopathy = 0;
            controller.LiverMetastasis = 0;
            controller.BoneMetastasis = 0;
            controller.BrainMetastasis = 0;
        }
        
        controller.maxSampleSize = sixMonths;
        //controller.maxSampleSize = self.totalCount;
        //controller.maxSampleSize = [self.performanceCases count];
        controller.graphView = @"CTScan";
        
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [self calculate];
        [self calculateSurgeonData];
        UCNationalPerformanceGraphs *controller = [[UCNationalPerformanceGraphs alloc] initWithNibName:@"UCNationalPerformanceGraphs" bundle:nil];
        if(sixMonths>0){
            controller.metastaticDisease = (metastaticDisease/sixMonths)*100;
            controller.LocalRecurrence = (LocalRecurrence/sixMonths)*100;
            controller.Lymphadenopathy = (Lymphadenopathy/sixMonths)*100;
            controller.LiverMetastasis = (LiverMetastasis/sixMonths)*100;
            controller.BoneMetastasis = (BoneMetastasis/sixMonths)*100;
            controller.BrainMetastasis = (BrainMetastasis/sixMonths)*100;
        }else{
            controller.metastaticDisease = 0;
            controller.LocalRecurrence = 0;
            controller.Lymphadenopathy = 0;
            controller.LiverMetastasis = 0;
            controller.BoneMetastasis = 0;
            controller.BrainMetastasis = 0;
        }
        if(s_sixMonths>0){
            controller.s_metastaticDisease = (s_metastaticDisease/s_sixMonths)*100;
            controller.s_LocalRecurrence = (s_LocalRecurrence/s_sixMonths)*100;
            controller.s_Lymphadenopathy = (s_Lymphadenopathy/s_sixMonths)*100;
            controller.s_LiverMetastasis = (s_LiverMetastasis/s_sixMonths)*100;
            controller.s_BoneMetastasis = (s_BoneMetastasis/s_sixMonths)*100;
            controller.s_BrainMetastasis = (s_BrainMetastasis/s_sixMonths)*100;
        }else{
            controller.s_metastaticDisease = 0;
            controller.s_LocalRecurrence = 0;
            controller.s_Lymphadenopathy = 0;
            controller.s_LiverMetastasis = 0;
            controller.s_BoneMetastasis = 0;
            controller.s_BrainMetastasis = 0;
        }
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        
        //controller.NationalSize = self.totalNationalCount;
        //controller.SurgeonSize = self.totalSurgeonCount;
        
        //controller.NationalSize = [self.performanceCases count];
        //controller.SurgeonSize = [self.surgeonCases count];
        
        controller.graphView = @"CTScan";
        
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
}

-(IBAction)BUN:(id)sender{
    
    if(!isNational){
        [self calculate];
        NSLog(@" ^^^^^^ SUM OF BUN  : %f",bunSum);
        UCSurgeonPerformanceGraphs *controller = [[UCSurgeonPerformanceGraphs alloc] initWithNibName:@"UCSurgeonPerformanceGraphs" bundle:nil];
        controller.graphView = @"AverageBUN";
        if(sixMonths>0){
            controller.averageBun = bunSum/sixMonths;
            controller.minBun = minBun;
            controller.maxBun = maxBun;
        }else{
            controller.averageBun = 0;
            controller.minBun = 0;
            controller.maxBun = 0;
        }
        
        controller.maxSampleSize = sixMonths;
        //controller.maxSampleSize = self.totalCount;
        //controller.maxSampleSize = [self.performanceCases count];
        [self.navigationController pushViewController:controller animated:YES];

    }else{
        [self calculate];
        [self calculateSurgeonData];
        NSLog(@" ^^^^^^ SUM OF BUN  : %f",bunSum);
        UCNationalPerformanceGraphs *controller = [[UCNationalPerformanceGraphs alloc] initWithNibName:@"UCNationalPerformanceGraphs" bundle:nil];
        controller.graphView = @"AverageBUN";
        if(sixMonths>0){
            controller.averageBun = bunSum/sixMonths;

        }else{
            controller.averageBun = 0;

        }
        if(s_sixMonths>0){
            controller.s_averageBun = s_bunSum/s_sixMonths;

        }else{
            controller.s_averageBun = 0;

        }
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        
        //controller.NationalSize = self.totalNationalCount;
        //controller.SurgeonSize = self.totalSurgeonCount;
        
        //controller.NationalSize = [self.performanceCases count];
        //controller.SurgeonSize = [self.surgeonCases count];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
        
}

-(IBAction)Creatinine:(id)sender{
    
    if(!isNational){
        [self calculate];
        NSLog(@" ^^^^^^ SUM OF Creatinine  : %f",creatinineSum);
        UCSurgeonPerformanceGraphs *controller = [[UCSurgeonPerformanceGraphs alloc] initWithNibName:@"UCSurgeonPerformanceGraphs" bundle:nil];
        controller.graphView = @"AverageCreatinine";
        if(sixMonths>0){
            controller.averageCreatinine = creatinineSum/sixMonths;
            controller.minCreatinine = minCreatinine;
            controller.maxCreatinine = maxCreatinine;
        }else{
            controller.averageCreatinine = 0;
            controller.minCreatinine = 0;
            controller.maxCreatinine = 0;
        }
        
        controller.maxSampleSize = sixMonths;
        //controller.maxSampleSize = self.totalCount;
        //controller.maxSampleSize = [self.performanceCases count];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [self calculate];
        [self calculateSurgeonData];
        NSLog(@" ^^^^^^ SUM OF Creatinine  : %f",creatinineSum);
        UCNationalPerformanceGraphs *controller = [[UCNationalPerformanceGraphs alloc] initWithNibName:@"UCNationalPerformanceGraphs" bundle:nil];
        controller.graphView = @"AverageCreatinine";
        if(sixMonths>0){
            controller.averageCreatinine = creatinineSum/sixMonths;

        }else{
            controller.averageCreatinine = 0;

        }
        if(s_sixMonths>0){
            controller.s_averageCreatinine = s_creatinineSum/s_sixMonths;
            
        }else{
            controller.s_averageCreatinine = 0;
        }
        
        controller.NationalSize = sixMonths;
        controller.SurgeonSize = s_sixMonths;
        
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
