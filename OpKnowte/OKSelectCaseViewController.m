//
//  OKSelectCaseViewController.m
//  OpKnowte
//
//  Created by Olegek on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectCaseViewController.h"
#import "OKSelectCaseTableViewCell.h"
#import "OKCaseManager.h"
#import "OKUserManager.h"
#import "OKCase.h"
#import "OKProceduresManager.h"
#import "OKProcedureModel.h"
#import "OKTemplateManager.h"

@interface OKSelectCaseViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *cases;

@end

@implementation OKSelectCaseViewController
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isReminderSetting = NO;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, (tableView.frame.size.height - 57.f));
    [self addBottomTabBar];
    [self setupData];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


-(void)setupData
{
    [[OKLoadingViewController instance]showWithText:@"Loading"];
    if (self.fromSettings) {
        [[OKTemplateManager instance]getTemplate:[OKUserManager instance].currentUser.userID withProcedureID:[OKProceduresManager instance].selectedProcedure
         .procedureID handler:[self getTemplateHandler]];
        
        
    }else {
        
        [[OKCaseManager instance]getCaseListForProcedureWithID:[OKProceduresManager instance].selectedProcedure.procedureID surgeonID:[OKUserManager instance].currentUser.userID handler:[self getCaseListHandler]];
        
    }
}


- (void (^)(NSString *errorMg, id json))getTemplateHandler
{
    void (^ myBlock)(NSString *errorMg, id json) = ^ (NSString *errorMg, id json) {
        [[OKLoadingViewController instance]hide];
    };
    return myBlock;
}


- (void (^)(NSString *errorMg, id caseArray))getCaseListHandler
{
    void (^ myBlock)(NSString *errorMg, id caseArray) = ^ (NSString *errorMg, id caseArray) {
        [[OKLoadingViewController instance]hide];
        if(!errorMg){
            self.cases = [caseArray sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"DOS" ascending:YES]]];
            [self.tableView reloadData];
        }
    };
    return myBlock;
}


#pragma mark IBAction metods

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Table View datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cases.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"selectCase";
    OKSelectCaseTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKSelectCaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    OKCase *selCase = self.cases[indexPath.row];
    
    if(self.fromSettings)
        cell.textLabel.text = selCase.patientName;
    else
        cell.caseName.text = [NSString stringWithFormat:@"%i. %@",indexPath.row, selCase.patientName];;
    
    cell.dataLable.text = selCase.dateOfServiceString;
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.isReminderSetting) {
//        UCSettingReminderSettingsViewController *obj = [[UCSettingReminderSettingsViewController alloc] initWithNibName:@"UCSettingReminderSettingsViewController" bundle:nil];
//        obj.patientID = [[self.cases objectAtIndex:indexPath.row] objectForKey:@"DetailID"];
//        NSLog(@"%@",[self.cases objectAtIndex:indexPath.row]);
//        NSLog(@"%@",obj.patientID);
//        [self.navigationController pushViewController:obj animated:YES];
    }else{
        OKCase *selCase = self.cases[indexPath.row];
        [OKCaseManager instance].selectedCase = selCase;
        [self performSegueWithIdentifier:@"selectTimepoint" sender:nil];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
