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
@property (strong, nonatomic) IBOutlet UIView *segmentControllView;
@property (strong, nonatomic) IBOutlet UITableView *caseDataTableView;
@property (strong, nonatomic) IBOutlet UIView *IndicationView;
@property (strong, nonatomic) IBOutlet UILabel *indicationLabel;
@property (strong, nonatomic) IBOutlet UIView *procedureView;
@property (strong, nonatomic) IBOutlet UILabel *procedureLable;
@property (strong, nonatomic) IBOutlet UIScrollView *indicationScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *procedureScrollView;

@end

@implementation OKOperatieNoteViewController
@synthesize segmentControl,caseDataTableView,IndicationView,indicationLabel,procedureView,procedureLable,indicationScrollView,procedureScrollView,segmentControllView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    
    segmentControllView.backgroundColor = [UIColor clearColor];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
  
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"segmentControllBG.png"]];
    [self.segmentControllView addSubview:backgroundView];
    
    caseDataTableView.backgroundColor = [UIColor clearColor];

    self.caseDataTableView.dataSource = self;
    self.caseDataTableView.delegate = self;
    
   caseDataTableView.frame = CGRectMake(caseDataTableView.frame.origin.x, caseDataTableView.frame.origin.y, caseDataTableView.frame.size.width, (caseDataTableView.frame.size.height - 60.f));

    [self.caseDataTableView reloadData];

    [self indicationMethod];
    [self procedureMethod];
    
    self.caseDataTableView.hidden = NO;
    self.IndicationView.hidden = YES;
    self.procedureView.hidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)indicationMethod{

    IndicationView.backgroundColor = [UIColor clearColor];
    
    NSString *indicationText = [NSString stringWithFormat:@"Indications: The patient is a (15) calculated age from DOB) (16) (ethnicity) male who was recently diagnosed with clinically localized prostate cancer. The patient underwent a Trus biopsy of the prostate that  revealed (17) stage of disease) (18)Gleason Score). (19) X of 12 cores were involved. The largest percentage of a core involved was  (20)) x. Prebiopsy  PSA was (21)PSA  value) . Prostate Volume is estimated to be (22) X gm). The patient’s BMI is  (23) X). The patient was thoroughly counseled on treatment options and has elected to proceed with a lap robotic prostatectomy with (24) taken from procedure above). The patient understands the risks of infection, bleeding, injury to surrounding structures and possible need for re-intervention in the future. The patient has been counseled on the risk for positioning injuries, peri-operative morbidity as well as mortality. The patient has also been made aware of the potential for urinary incontinence as well as erectile dysfunction or impotence. The patient understands these risks  and has elected to proceed. The patient received pre-operative antibiotics.Procedure: Patient was brought to operating room and a general anesthetic was induced. Prior to induction the patient was wearing SCDs and TEDs which were on and functioning.  The patient was then positioned in low lithotomy with arms padded and tucked as his sides.  A safety strap was placed over his chest and he was then tested in the high trendelenberg position and found to be well padded and secure. Next the patient was prepped and draped in the usual sterile fashion. A 18 french was then placed without difficulty and the balloon was raised with 10cc of sterile water. Clear urine returned.We then made a small incision above the umbilicus with a 15 blade and introduced a Veress needle without difficulty. We performed the drip test with sterile water. Next we achieved a pneumoperitoneum with Carbon Dioxide to 15mm of Mercury. The 12 mm camera port was then placed atraumatically and we introduced the robotic port and surveyed the abdomen. No evidence of visceral injury was present. No adhesions were present. (free dictate if adhesiolysis was necessary). We then introduced 5 additional ports across the abdomen. One 8mm robotic port was placed one handbreath to either side of the midline port. Two handbreaths to the left, an additional 8mm robotic port was placed for the 4th arm assistant port. Two handbreaths to the right a 12mm bedside port was placed and pre-mptively an 0 vicryl was placed via the Carter-Thomason technique. Lastly a 5mm secondary bedside assistant port was placed to triangulate the ports on the right side of the abdomen.  All ports were placed under direct vision. The robot was then docked. The instrument were introduced under direct vision.We began by mobilizing the sigmoid colon and carried our dissection into the cul-de-sac. We incised over the seminal vesicles and ampulla and dissected these structures free. We raised these structures anterior to expose Denovielle’s fascia which was then incised. The plain between the prostate was then developed.The bladder was then dropped by incising lateral to medial umbilical ligaments. The spaze of retzius was then developed and the anterior surface of the prostate was groomed. The endopelvic fascia was incised and the dorsal vein complex was secured with a 2-0 Vicryl.  Additional 2-0 back bleeder stitches were placed along the bladder neck."];
    
    indicationLabel.text = indicationText;
    
    [indicationLabel sizeToFit];
    indicationScrollView.contentSize = CGSizeMake(indicationScrollView.contentSize.width, indicationLabel.frame.size.height+80);
    [indicationScrollView addSubview:indicationLabel];
    [self.IndicationView addSubview:indicationScrollView];
    
}

-(void)procedureMethod{

    procedureView.backgroundColor = [UIColor clearColor];
    
    
    NSString * procedureText = [NSString stringWithFormat:@"Procedure: Patient was brought to operating room and a general anesthetic was induced. Prior to induction the patient was wearing SCDs and TEDs which were on and functioning.  The patient was then positioned in low lithotomy with arms padded and tucked as his sides.  A safety strap was placed over his chest and he was then tested in the high trendelenberg position and found to be well padded and secure. Next the patient was prepped and draped in the usual sterile fashion. A 18 french was then placed without difficulty and the balloon was raised with 10cc of sterile water. Clear urine returned.We then made a small incision above the umbilicus with a 15 blade and introduced a Veress needle without difficulty. We performed the drip test with sterile water. Next we achieved a pneumoperitoneum with Carbon Dioxide to 15mm of Mercury. The 12 mm camera port was then placed atraumatically and we introduced the robotic port and surveyed the abdomen. No evidence of visceral injury was present. No adhesions were present. (free dictate if adhesiolysis was necessary). We then introduced 5 additional ports across the abdomen. One 8mm robotic port was placed one handbreath to either side of the midline port. Two handbreaths to the left, an additional 8mm robotic port was placed for the 4th arm assistant port. Two handbreaths to the right a 12mm bedside port was placed and pre-mptively an 0 vicryl was placed via the Carter-Thomason technique. Lastly a 5mm secondary bedside assistant port was placed to triangulate the ports on the right side of the abdomen.  All ports were placed under direct vision. The robot was then docked. The instrument were introduced under direct vision.We began by mobilizing the sigmoid colon and carried our dissection into the cul-de-sac. We incised over the seminal vesicles and ampulla and dissected these structures free. We raised these structures anterior to expose Denovielle’s fascia which was then incised. The plain between the prostate was then developed.The bladder was then dropped by incising lateral to medial umbilical ligaments. The spaze of retzius was then developed and the anterior surface of the prostate was groomed. The endopelvic fascia was incised and the dorsal vein complex was secured with a 2-0 Vicryl.  Additional 2-0 back bleeder stitches were placed along the bladder neck."];
   
    procedureLable.text = procedureText;
    
    [procedureLable sizeToFit];
    procedureScrollView.contentSize = CGSizeMake(procedureScrollView.contentSize.width, procedureLable.frame.size.height+80);
    [procedureScrollView addSubview:procedureLable];
    [self.procedureView addSubview:procedureScrollView];

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
    return 23;
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

@end
