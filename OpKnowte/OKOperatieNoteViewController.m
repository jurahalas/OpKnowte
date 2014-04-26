//
//  OKOperatieNoteViewController.m
//  OpKnowte
//
//  Created by Olegek on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKOperatieNoteViewController.h"

@interface OKOperatieNoteViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic) IBOutlet UITableView *caseDataTableView;
@property (strong, nonatomic) IBOutlet UIView *IndicationView;
@property (strong, nonatomic) IBOutlet UILabel *indicationLabel;
@property (strong, nonatomic) IBOutlet UIView *procedureView;
@property (strong, nonatomic) IBOutlet UILabel *procedureLable;

@end

@implementation OKOperatieNoteViewController
@synthesize segmentControl,caseDataTableView,IndicationView,indicationLabel,procedureView,procedureLable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    caseDataTableView.backgroundColor = [UIColor clearColor];

    self.caseDataTableView.dataSource = self;
    self.caseDataTableView.delegate = self;
    
   caseDataTableView.frame = CGRectMake(caseDataTableView.frame.origin.x, caseDataTableView.frame.origin.y, caseDataTableView.frame.size.width, (caseDataTableView.frame.size.height - 60.f));

    [self.caseDataTableView reloadData];

    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];

    IndicationView.backgroundColor = [UIColor clearColor];
    procedureView.backgroundColor = [UIColor clearColor];
    
    self.caseDataTableView.hidden = NO;
    self.IndicationView.hidden = YES;
    self.procedureView.hidden = YES;
    
    NSString *indicationText = [NSString stringWithFormat:@"The patient is a (15) calculated age from DOB) (16) (ethnicity) male who was recently diagnosed with clinically localized prostate cancer. The patient underwent a Trus biopsy of the prostate that  revealed (17) stage of disease) (18)Gleason Score). (19) X of 12 cores were involved. The largest percentage of a core involved was  (20)) x. Prebiopsy  PSA was (21)PSA  value) . Prostate Volume is estimated to be (22) X gm). The patient’s BMI is  (23) X). The patient was thoroughly counseled on treatment options and has elected to proceed with a lap robotic prostatectomy with (24) taken from procedure above). The patient understands the risks of infection, bleeding, injury to surrounding structures and possible need for re-intervention in the future. The patient has been counseled on the risk for positioning injuries, peri-operative morbidity as well as mortality. The patient has also been made aware of the potential for urinary incontinence as well as erectile dysfunction or impotence. The patient understands these risks  and has elected to proceed. The patient received pre-operative antibiotics."];
    indicationLabel.text = indicationText;
    
    NSString * procedureText = [NSString stringWithFormat:@"We then made a small incision above the umbilicus with a 15 blade and introduced a Veress needle without difficulty. We performed the drip test with sterile water. Next we achieved a pneumoperitoneum with Carbon Dioxide to 15mm of Mercury. The 12 mm camera port was then placed atraumatically and we introduced the robotic port and surveyed the abdomen. No evidence of visceral injury was present. No adhesions were present. (free dictate if adhesiolysis was necessary). We then introduced 5 additional ports across the abdomen. One 8mm robotic port was placed one handbreath to either side of the midline port. Two handbreaths to the left, an additional 8mm robotic port was placed for the 4th arm assistant port. Two handbreaths to the right a 12mm bedside port was placed and pre-mptively an 0 vicryl was placed via the Carter-Thomason technique. Lastly a 5mm secondary bedside assistant port was placed to triangulate the ports on the right side of the abdomen.  All ports were placed under direct vision. The robot was then docked. The instrument were introduced under direct vision. "];
    procedureLable.text = procedureText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark IBAction

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)segmentControlButton:(UISegmentedControl *)sender {
    UIColor *selectedColor = [UIColor colorWithRed: 255/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    UIColor *deselectedColor = [UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    
    for (UIControl *subview in [segmentControl subviews]) {

        if ([subview isSelected]){
            [subview setTintColor:selectedColor];

        }
        else
            [subview setTintColor:deselectedColor];
             }
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.IndicationView.hidden = YES;
            self.procedureView.hidden = YES;
            self.caseDataTableView.hidden = NO;
            break;
        case 1:
            self.IndicationView.hidden = NO;
            self.procedureView.hidden = YES;
            self.caseDataTableView.hidden = YES;
            break;
        case 2:
            self.IndicationView.hidden = YES;
            self.procedureView.hidden = NO;
            self.caseDataTableView.hidden = YES;
        default:
            break;
    }
    
    
}
#pragma mark Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"caseData";
    OKOperatieNoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKOperatieNoteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setLabels];
     [tableView setContentInset:UIEdgeInsetsMake(1.0, 0.0, 0.0, 0.0)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerColor= [[UIView alloc]init];
    headerColor.backgroundColor = [UIColor blackColor];
    return headerColor;
    
}

@end
