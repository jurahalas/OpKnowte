//
//  OKAccessSettingsViewController.m
//  OpKnowte
//
//  Created by Olegek on 01.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKAccessSettingsViewController.h"
#import "OKAccessSettingsTableViewCell.h"
#import "OKInstituteVC.h"
#import "OKAccessSettingManager.h"
#import "OKContactManager.h"
#import "OKContactModel.h"

@interface OKAccessSettingsViewController ()
@property (strong, nonatomic) IBOutlet UIButton *updateButton;
@property (strong, nonatomic) IBOutlet UITableView *accessSettingsTableView;

@end

@implementation OKAccessSettingsViewController
@synthesize accessSettingsTableView,updateButton,procID,userID,accessArray,selectedContacts,choosedContacts;

- (void)viewDidLoad
{
    
    self.dataDict =  @{@"Surgeons":@"1",
                       @"Assistans":@"2",
                       @"Others":@"6"};
    
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    
    accessSettingsTableView.backgroundColor = [UIColor clearColor];
    self.accessSettingsTableView.dataSource = self;
    self.accessSettingsTableView.delegate = self;
    accessSettingsTableView.frame = CGRectMake(accessSettingsTableView.frame.origin.x, accessSettingsTableView.frame.origin.y, accessSettingsTableView.frame.size.width, (accessSettingsTableView.frame.size.height - 57.f));
    [self.accessSettingsTableView reloadData];

    updateButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    updateButton.layer.cornerRadius = 14;
    
    selectedContacts = [[NSMutableArray alloc]init];
    choosedContacts = [[NSMutableArray alloc]init];
    accessArray = [[NSMutableArray alloc] init];
    
    userID = [OKUserManager instance].currentUser.identifier;

    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [self getAccessVariables];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width+27, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
}
-(void)getAccessVariables{
    OKAccessSettingManager *accessManager = [OKAccessSettingManager instance];
    [accessManager getAccessSettingsWithUserID:userID AndProcedureID:procID handler:^(NSString* error, NSMutableArray* aArray){
        NSLog(@"Error - %@", error);
        
        self.accessArray = aArray ;
    }];
}
- (IBAction)backButton:(id)sender
{    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)updateSettingsButton:(id)sender
{
    NSString * contactEmail = [choosedContacts componentsJoinedByString:@","];
    
    NSLog(@"%@",contactEmail);
    [[OKLoadingViewController instance] showWithText:@"Loading..."];

        OKAccessSettingManager *aM = [OKAccessSettingManager instance];
        [aM updateAccessSettingsWithUserID:userID withProcedureID:procID withContactEmail:contactEmail handler:^(NSString *errorMsg, NSDictionary *json) {
            if (!errorMsg) {
                UIAlertView *customAlertView = [[UIAlertView alloc] initWithTitle:@"Access Settings" message:@"Access Settings is updated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [customAlertView show];
            }
            NSLog(@"Error - %@", errorMsg);}];
    [[OKLoadingViewController instance] hide];

    [self getAccessVariables];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"choseContact"]){
        OKAccessSettingsCCViewController *vc = (OKAccessSettingsCCViewController*)segue.destinationViewController;
        vc.contactID = [self.dataDict valueForKey:sender];
        vc.cameFromVC = @"Access Settings View Controller";
        vc.accessArray = [[NSMutableArray alloc]init];
        vc.accessArray = self.accessArray;
        vc.delegate = self;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.dataDict.allKeys.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"accessSetings";
    OKAccessSettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKAccessSettingsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.aSettingLable.text = [self.dataDict.allKeys objectAtIndex:indexPath.row];
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"choseContact" sender:self.dataDict.allKeys[indexPath.row]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    OKAccessSettingsCCViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"AS"];
    vc.accessArray = [self accessArray];
}

-(void)updateWithArray:(NSMutableArray *)array
{
    choosedContacts = array;
}

@end
