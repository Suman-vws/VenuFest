//
//  Personal_infoView.m
//  RP
//
//  Created by Mac on 07/09/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "Personal_infoView.h"
#import "RPConstants.h"
#import "PersonalInfoCell.h"


@interface Personal_infoView()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblPersonalInfo;

@end

@implementation Personal_infoView


-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"Personal_Info" owner:self options:nil];
        self = [subviewArray objectAtIndex:0];
        [self awakeFromNib];
        [self configData];
    }
    return self;
}

-(void)configData
{
    self.tblPersonalInfo.dataSource = self;
    self.tblPersonalInfo.delegate = self;
    self.tblPersonalInfo.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table View Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"PersonalInfoCell";
    PersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    if (!cell) {
        cell = [[PersonalInfoCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UIView *cellContentView = [[[NSBundle mainBundle] loadNibNamed:@"PersonalInfoCell" owner:self options:nil] objectAtIndex:0];
        cell.lblTag  = (UILabel *)[cellContentView viewWithTag:101];
        cell.lblValues  = (UILabel *)[cellContentView viewWithTag:102];
//        cell.btnLogout = (UIButton *)[cellContentView viewWithTag:103];
//        [cell.btnLogout addTarget:self action:@selector(clickedLogout) forControlEvents:UIControlEventTouchUpInside];

        cellContentView.frame = cell.frame;
        cellContentView.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:cellContentView];
    }
    
    [self setUpUiForCell:cell]; //for UI
    [self setupDataForCellWithIndex:indexPath.row andCell:cell];    //config Data
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void) setupLablesFor:(UILabel *)label
{
    label.font = BODY_TEXT_FONT_SMALL;
    label.textColor = [UIColor blackColor];
}

-(void)setupDataForCellWithIndex:(NSInteger)index andCell:(PersonalInfoCell *)cell
{
    cell.btnLogout.hidden = YES;
    cell.lblTag.hidden = NO;
    cell.lblValues.hidden = NO;
    switch (index) {
        case 0:
            cell.lblTag.text = @"About Me :";
            cell.lblValues.text = self.strAbout;
            break;
        case 1:
            cell.lblTag.text = @"Email :";
            cell.lblValues.text = self.strEmail;
            break;
        case 2:
            cell.lblTag.text = @"Phone :";
            cell.lblValues.text = self.strPhone;
            break;
        case 3:
            cell.lblTag.text = @"City :";
            cell.lblValues.text = self.strCity;
            break;
        case 4:
            cell.lblTag.text = @"Gender :";
            cell.lblValues.text = self.strGender;
            break;
        case 5:
            cell.lblTag.text = @"Age :";
            cell.lblValues.text = self.strAge;
            break;
        case 6:
            cell.lblTag.text = @"Height :";
            cell.lblValues.text = self.strHeight;
            break;
        case 7:
            cell.lblTag.text = @"Weight :";
            cell.lblValues.text = self.strWeight;
            break;
        default:
            break;
    }
}

-(void)setUpUiForCell:(PersonalInfoCell *)cell
{
    [self setupLablesFor:cell.lblTag];
    [self setupLablesFor:cell.lblValues];
}


-(void)clickedLogout
{
    [[NSNotificationCenter defaultCenter] postNotificationName:USER_LOGOUT_NOTIFICATION object:self];
}

#pragma mark - table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
