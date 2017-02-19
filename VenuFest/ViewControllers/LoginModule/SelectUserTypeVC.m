//
//  SelectUserTypeVC.m
//  VenuFest
//
//  Created by Sayan Chatterjee on 16/02/17.
//  Copyright © 2017 Sayan Chatterjee. All rights reserved.
//

#import "SelectUserTypeVC.h"
#import "RegistrationVC.h"

@interface SelectUserTypeVC ()

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UIView *vwUser;
@property (weak, nonatomic) IBOutlet UILabel *lblUser;

@property (weak, nonatomic) IBOutlet UIView *vwFreelancer;
@property (weak, nonatomic) IBOutlet UILabel *lblFreelancer;


@end

@implementation SelectUserTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCustomizeUI];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(void)createCustomizeUI
{
    self.lblTitle.font = [UIFont fontWithName: APPLICATION_FONT_NAME size:37];
    self.lblTitle.textColor = BODY_TEXT_COLOR_WHITE;

    self.lblUser.font = PAGE_TITLE_FONT;
    self.lblUser.textColor = BODY_TEXT_COLOR_WHITE;
    self.lblFreelancer.textColor = BODY_TEXT_COLOR_WHITE;
    self.lblFreelancer.font = PAGE_TITLE_FONT;

    self.vwUser.accessibilityHint = @"User";
    self.vwUser.layer.borderWidth = 2.0;
    self.vwUser.layer.borderColor = BODY_TEXT_COLOR_WHITE.CGColor;
    
    self.vwFreelancer.layer.borderWidth = 2.0;
    self.vwFreelancer.layer.borderColor = BODY_TEXT_COLOR_WHITE.CGColor;
    self.vwFreelancer.accessibilityHint = @"Freelancer";
    
    [self addGesturewithView:self.vwUser];
    [self addGesturewithView:self.vwFreelancer];
}

-(void)addGesturewithView:(UIView *)view
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(tappedUserType:)];
    tapGesture.numberOfTapsRequired = 1;
    [view addGestureRecognizer:tapGesture];
}

-(void)tappedUserType:(UITapGestureRecognizer *)sender
{
    if ([sender.view.accessibilityHint isEqualToString:@"User"]) {
        
        [self signupUserWithType:sender.view.accessibilityHint];
    }
    else if([sender.view.accessibilityHint isEqualToString:@"Freelancer"])
    {
        [self signupUserWithType:sender.view.accessibilityHint];
    }
}

-(IBAction)clickedback:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)signupUserWithType:(NSString *)userType
{
    //TODO: Handle Show Forgot Password View
    RegistrationVC *registerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationVC"];
    registerVC.regType = userType;
    [self.navigationController pushViewController:registerVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
