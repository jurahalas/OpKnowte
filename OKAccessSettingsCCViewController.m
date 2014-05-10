//
//  OKAccessSettingsCCViewController.m
//  OpKnowte
//
//  Created by Olegek on 10.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKAccessSettingsCCViewController.h"
#import "OKAccessSettingsCCTableViewCell.h"
#import "OKInstituteVC.h"
#import "OKContactManager.h"
#import "OKContactModel.h"
#import "OKUserModel.h"

@interface OKAccessSettingsCCViewController ()

@property (strong, nonatomic) IBOutlet UITableView *accessSettingsTableView;
@property(strong, nonatomic) NSArray *contactsArray;
@property(strong, nonatomic) NSString *selectedContactID;
@property (strong, nonatomic) NSMutableArray *choosedVariables;

@end

@implementation OKAccessSettingsCCViewController
@synthesize contactsArray,selectedContactID,accessSettingsTableView,choosedVariables;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    accessSettingsTableView.backgroundColor = [UIColor clearColor];
    
    self.accessSettingsTableView.dataSource = self;
    self.accessSettingsTableView.delegate = self;
    
    accessSettingsTableView.frame = CGRectMake(accessSettingsTableView.frame.origin.x, accessSettingsTableView.frame.origin.y, accessSettingsTableView.frame.size.width, (accessSettingsTableView.frame.size.height - 50.f));
    
    [self addBottomTabBar];
    [self addRightButtonsToNavbar];
    
    choosedVariables = [NSMutableArray arrayWithArray:[_templateModel.aSettings componentsSeparatedByString:@","]];
}

-(void) addVariableToTemplate:(OKProcedureTemplateVariablesModel *)contact{
    NSMutableArray *choosedModelsArray = [[NSMutableArray alloc] init];
    choosedModelsArray = [self addValueOfModel:contact toArray:YES];
    NSString *newAS = [choosedModelsArray componentsJoinedByString:@","];
    _templateModel.aSettings = newAS;
}


-(void) deleteVariableFromTemplate:(OKProcedureTemplateVariablesModel *)contact{
    NSMutableArray *choosedModelsArray = [[NSMutableArray alloc] init];
    choosedModelsArray = [self addValueOfModel:contact toArray:NO];
    NSString *newAS =[choosedModelsArray componentsJoinedByString:@","];
    _templateModel.aSettings = newAS;
}

-(NSMutableArray*) addValueOfModel:(OKProcedureTemplateVariablesModel *)contact toArray: (BOOL) add{
    
    NSMutableArray *choosedModelsArray = [[NSMutableArray alloc] init];
    for (OKProcedureTemplateVariablesModel *model in _variablesArray) {
        if ([choosedVariables containsObject:[NSString stringWithFormat:@"(%@)",model.value]]) {
            [choosedModelsArray addObject:model];
        }
    }
    if (choosedModelsArray.count) {
        for (int i = 0; i<choosedModelsArray.count; i++) {
            OKProcedureTemplateVariablesModel *model = (OKProcedureTemplateVariablesModel*)choosedModelsArray[i];
            int modelID = (int)model.ID;
            int contactID = (int)contact.ID;
            if (add) {
                if (modelID < contactID ) {
                    [choosedModelsArray insertObject:contact atIndex:i+1];
                    break;
                }
            } else {
                if (modelID == contactID ) {
                    [choosedModelsArray removeObjectAtIndex:i];
                    break;
                }
            }
        }
        
    } else {
        [choosedModelsArray addObject:contact];
    }
    
    [choosedVariables removeAllObjects];
    for (OKProcedureTemplateVariablesModel *model in choosedModelsArray) {
        [choosedVariables addObject:[NSString stringWithFormat:@"(%@)",model.value]];
    }
    
    return choosedVariables;

}

-(void)viewWillAppear:(BOOL)animated
{
    [self getContactsList];
}


-(void) addRightButtonsToNavbar
{
    UIButton *addContact = [[UIButton alloc] init];
    addContact.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"plusGreenIcon"].size.width, [UIImage imageNamed:@"plusGreenIcon"].size.height );
    [addContact setImage:[UIImage imageNamed:@"plusGreenIcon"] forState:UIControlStateNormal];
    [addContact addTarget:self action:@selector(addContactTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *deleteContact = [[UIButton alloc] init];
    deleteContact.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"redCross"].size.width, [UIImage imageNamed:@"redCross"].size.height );
    [deleteContact setImage:[UIImage imageNamed:@"redCross"] forState:UIControlStateNormal];
    [deleteContact addTarget:self action:@selector(deleteContactTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithCustomView:addContact];
    UIBarButtonItem *delete = [[UIBarButtonItem alloc] initWithCustomView:deleteContact];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:add,delete, nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fromAccessSettingToInstitute"]){
        OKInstituteVC *instVC = (OKInstituteVC*)segue.destinationViewController;
        instVC.contactID = self.contactID;
        instVC.cameFromVC = @"AccessSettingsCCViewController";
    }
}


-(void) addContactTapped
{
    [self performSegueWithIdentifier:@"fromAccessSettingToInstitute" sender:_contactID];
}


-(void) deleteContactTapped
{
    if (selectedContactID==nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"You must select contact to delete it"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        [self.view endEditing:YES];
        
    }else{
        OKContactManager *manager = [OKContactManager instance];
        [manager deleteContactWithContactID:self.selectedContactID handler:^(NSString *errorMsg) {
            if (!errorMsg) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                message:@"Сontact was successfully removed"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
            [self getContactsList];
        }];
    }
}


-(void) getContactsList
{
    OKContactManager *contactManager = [OKContactManager instance];
    [contactManager getContactsByUserID:[OKUserManager instance].currentUser.identifier roleID:_contactID handler: ^(NSString* error, NSMutableArray* array){
        if (!error) {
            self.contactsArray = array;
            [self.accessSettingsTableView reloadData];
        }
    }];
}


#pragma mark - IBActions


- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate updateTemplateModelWith:_templateModel];
}


#pragma mark - Table View methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contactsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"contactCell";
    OKAccessSettingsCCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKAccessSettingsCCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    OKProcedureTemplateVariablesModel *varModel = [[OKProcedureTemplateVariablesModel alloc] init];
   // varModel = (OKProcedureTemplateVariablesModel*)_variablesArray[indexPath.row];
    
    OKContactModel *contact = (OKContactModel*)self.contactsArray[indexPath.row];
    cell.contactNameLabel.text = contact.name;
    cell.emailLabel.text = contact.contactEmail;
    
    [cell setCellButtonBGImageWithGreenMinusIcon:[choosedVariables containsObject:[NSString stringWithFormat:@"(%@)",varModel.value]]];

    cell.delegate = self;
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKContactModel *contact = [OKContactModel new];
    contact = self.contactsArray[indexPath.row];
    self.selectedContactID = contact.identifier;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
