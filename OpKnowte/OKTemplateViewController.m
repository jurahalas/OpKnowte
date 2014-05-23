//
//  OKTemplateViewController.m
//  OpKnowte
//
//  Created by Olegek on 02.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKTemplateViewController.h"
#import "OKTemplateTableViewCell.h"
#import "OKProcedureTemplateModel.h"
#import "OKProcedureTemplateVariablesModel.h"
#import "OKProceduresManager.h"

#import "OKCaseDataViewController.h"
#import "OKIndicationTemplateViewController.h"
#import "OKLTemplateViewController.h"

@interface OKTemplateViewController () <OKLTemplateViewControllerDelegate, OKCaseDataViewControllerDelegate, OKIndicationTemplateViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *templateTableView;
@property (strong, nonatomic) OKProcedureTemplateModel *templateModel;
@property (strong, nonatomic) NSMutableArray *variablesArray;
@property (strong, nonatomic) IBOutlet UIButton *updateButton;

@end

@implementation OKTemplateViewController
@synthesize templateTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)updateButtonAction:(id)sender {
    OKProceduresManager *procedureManager = [OKProceduresManager instance];

    [procedureManager updateProcedureTemplateWithUserID:[OKUserManager instance].currentUser.identifier AndProcedureTemplate:_templateModel handler:^(NSString *errorMsg, NSDictionary *json) {
        NSLog(@"Error - %@", errorMsg);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    
    _updateButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _updateButton.layer.cornerRadius = 14;
    _updateButton.clipsToBounds = YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    
    templateTableView.backgroundColor = [UIColor clearColor];
    self.templateTableView.dataSource = self;
    self.templateTableView.delegate = self;
    templateTableView.frame = CGRectMake(templateTableView.frame.origin.x, templateTableView.frame.origin.y, templateTableView.frame.size.width, (templateTableView.frame.size.height - 57.f));
    [self.templateTableView reloadData];
    
    
    
    _templateModel = [[OKProcedureTemplateModel alloc] init];
    _variablesArray = [[NSMutableArray alloc] init];
    
    
    OKProceduresManager *procedureManager = [OKProceduresManager instance];
    [procedureManager getProcedureTemplateVariablesByProcedureID:_procID handler:^(NSString *errorMsg, NSMutableArray *templateVariables) {
        
        NSLog(@"Error - %@", errorMsg);
        _variablesArray = templateVariables;
        [procedureManager getProcedureTemplateByUserID:[OKUserManager instance].currentUser.identifier ProcedureID:_procID handler:^(NSString *errorMsg, NSDictionary *template) {
            NSLog(@"Error - %@", errorMsg);
            [_templateModel  setModelWithDictionary:template];
            [[OKLoadingViewController instance] hide];
            
        }];
    }];
    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
	// Do any additional setup after loading the view.
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
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"template";
    OKTemplateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKTemplateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSMutableArray *dataTitleArray = [[NSMutableArray alloc] initWithObjects:
                                      @"Case Data",
                                      @"Indications",
                                      @"Procedures",nil];
    
    cell.templateLable.text = [dataTitleArray objectAtIndex:indexPath.row];
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKTemplateTableViewCell *cell = [[OKTemplateTableViewCell alloc] init];
    cell = (OKTemplateTableViewCell*)[templateTableView cellForRowAtIndexPath:indexPath];
    if ([cell.templateLable.text  isEqualToString:@"Procedures"])
    {
        [self performSegueWithIdentifier:@"procedures" sender:indexPath];
    }else if ([cell.templateLable.text isEqualToString:@"Indications"]){
        [self performSegueWithIdentifier:@"indication" sender:indexPath];
    }else if ([cell.templateLable.text isEqualToString:@"Case Data"]){
        [self performSegueWithIdentifier:@"dataCase" sender:indexPath];
    }

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
    if([segue.identifier isEqualToString:@"procedures"]){
        OKLTemplateViewController *instVC = (OKLTemplateViewController*)segue.destinationViewController;
        instVC.templateModel = [[OKProcedureTemplateModel alloc] init];
        instVC.templateModel = _templateModel;
        instVC.variablesArray = [[NSMutableArray alloc] init];
        instVC.variablesArray = _variablesArray;
        instVC.delegate = self;
    } else if ([segue.identifier isEqualToString:@"indication"]){
        OKIndicationTemplateViewController *instVC = (OKIndicationTemplateViewController*)segue.destinationViewController;
        instVC.templateModel = [[OKProcedureTemplateModel alloc] init];
        instVC.templateModel = _templateModel;
        instVC.variablesArray = [[NSMutableArray alloc] init];
        instVC.variablesArray = _variablesArray;
        instVC.delegate = self;

    } else if ([segue.identifier isEqualToString:@"dataCase"]){
        OKCaseDataViewController *instVC = (OKCaseDataViewController*)segue.destinationViewController;
        instVC.templateModel = [[OKProcedureTemplateModel alloc] init];
        instVC.templateModel = _templateModel;
        instVC.variablesArray = [[NSMutableArray alloc] init];
        instVC.variablesArray = _variablesArray;
        instVC.delegate = self;

    }
}

-(void) updateTemplateModelWith:(OKProcedureTemplateModel *)templateModel{
    _templateModel = templateModel;
}
@end
