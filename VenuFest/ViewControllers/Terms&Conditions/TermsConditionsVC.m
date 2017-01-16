//
//  TermsConditionsVC.m
//  VenuFest
//
//  Created by Sayan Chatterjee on 06/12/16.
//  Copyright © 2016 Sayan Chatterjee. All rights reserved.
//

#import "TermsConditionsVC.h"
#import "LiveFeedVC.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"

@interface TermsConditionsVC ()<UIScrollViewDelegate>
{
    UIView *firstView;
    UIView *secondView;
    AppDelegate *appDelegate;

}

@end

@implementation TermsConditionsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //[self configureCustomizeUI];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    appDelegate = [UIApplication sharedApplication].delegate;
    if (!appDelegate.isuserLoggedinFirstTime) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    else
        [self.scroll setContentSize:CGSizeMake(self.containerView.frame.size.width*2, 300)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

-(void)configureCustomizeUI
{
    self.btnReject.backgroundColor = APP_BUTTON_BACKGROUND_COLOR;
    [self.btnReject setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnReject.tintColor = APP_BUTTON_TEXT_COLOR;
    self.btnReject.titleLabel.font =  APP_BUTTON_TITLE_FONT;
    
    self.btnAccept.backgroundColor = APP_BUTTON_BACKGROUND_COLOR;
    [self.btnAccept setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnAccept.tintColor = APP_BUTTON_TEXT_COLOR;
    self.btnAccept.titleLabel.font =  APP_BUTTON_TITLE_FONT;
    
    self.btnNext.backgroundColor = APP_BUTTON_BACKGROUND_COLOR;
    [self.btnNext setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnNext.tintColor = APP_BUTTON_TEXT_COLOR;
    self.btnNext.titleLabel.font =  APP_BUTTON_TITLE_FONT;

    self.txtVwTermsConditions.font = APP_BUTTON_TITLE_FONT_MEDIUM ;
    self.txtVwTermsConditions.textColor = APP_BUTTON_GREY_TEXT_COLOR;
    
    self.lblHeader.font =  APP_BUTTON_TITLE_FONT;
    self.lblHeader.textColor = APP_BUTTON_GREY_TEXT_COLOR;
    
    self.pageController.tintColor = TEXTFIELD_BORDER_COLOR ;
    self.pageController.currentPageIndicatorTintColor = APP_BUTTON_BACKGROUND_COLOR;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scroll setContentSize:CGSizeMake(self.containerView.frame.size.width*2, 300)];
}

-(IBAction)clickedNext:(id)sender
{
    [AppManager sharedDataAccess].IsLoggedIn = YES;
    appDelegate.isuserLoggedinFirstTime = NO;
    [AppManager sharedDataAccess].loggedInUserType = userTypeCustomer;
    SWRevealViewController *revealVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    [self.navigationController pushViewController:revealVC animated:YES];
}

-(IBAction)clickedReject:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)clickedAccept:(id)sender
{
    self.pageController.currentPage = 1;
    _btnNext.hidden = NO;
    _btnAccept.hidden = YES;
    _btnReject.hidden = YES;
    [self.scroll setContentOffset:CGPointMake(self.scroll.contentSize.width/2.0, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%@", scrollView);
    if(scrollView.contentOffset.x == 0)
    {
        self.pageController.currentPage = 0;
        _btnReject.hidden = NO;
        _btnAccept.hidden = NO;
        _btnNext.hidden = YES;
    }
    else
    {
        self.pageController.currentPage = 1;
        _btnReject.hidden = YES;
        _btnAccept.hidden = YES;
        _btnNext.hidden = NO;
    }
}

@end
