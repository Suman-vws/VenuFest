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

@interface TermsConditionsVC ()<UIScrollViewDelegate>
{
    UIView *firstView;
    UIView *secondView;
    BOOL isTermsAccepted;
}

@end

@implementation TermsConditionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureCustomizeUI];
    isTermsAccepted = NO;
    self.scroll.scrollEnabled = false;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (![AppManager sharedDataAccess].isuserLoggedinFirstTime) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
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
    self.btnReject.titleLabel.font =  APP_BUTTON_TITLE_FONT_MEDIUM;
    
    self.btnAccept.backgroundColor = APP_BUTTON_BACKGROUND_COLOR;
    [self.btnAccept setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnAccept.tintColor = APP_BUTTON_TEXT_COLOR;
    self.btnAccept.titleLabel.font =  APP_BUTTON_TITLE_FONT_MEDIUM;
    
    self.btnNext.backgroundColor = APP_BUTTON_BACKGROUND_COLOR;
    [self.btnNext setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnNext.tintColor = APP_BUTTON_TEXT_COLOR;
    self.btnNext.titleLabel.font =  APP_BUTTON_TITLE_FONT_MEDIUM;

    self.txtVwWelcome.font = BODY_TEXT_FONT_SMALL ;
    self.txtVwWelcome.textColor = BODY_TEXT_COLOR_GREY;
    self.txtVwTermsConditions.font = BODY_TEXT_FONT_SMALL ;
    self.txtVwTermsConditions.textColor = BODY_TEXT_COLOR_GREY;
    self.lblHeader.font =  APP_BUTTON_TITLE_FONT;
    self.lblHeader.textColor = APP_BUTTON_GREY_TEXT_COLOR;
    self.lblWelcome.font =  APP_BUTTON_TITLE_FONT;
    self.lblWelcome.textColor = APP_BUTTON_GREY_TEXT_COLOR;
    
    self.pageController.tintColor = APP_BUTTON_GREY_TEXT_COLOR ;
    self.pageController.currentPageIndicatorTintColor = APP_BUTTON_BACKGROUND_COLOR;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.scroll setContentSize:CGSizeMake(self.containerView.frame.size.width*2, 300)];
}

-(IBAction)clickedNext:(id)sender
{
    [AppManager sharedDataAccess].isUserLoggedIN = YES;
    [AppManager sharedDataAccess].isuserLoggedinFirstTime = NO;
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
    self.scroll.scrollEnabled = true;
    isTermsAccepted = YES;
    [self showButtonsWithOption:isTermsAccepted];
    [self.scroll setContentOffset:CGPointMake(self.scroll.contentSize.width/2.0, 0) animated:YES];
}


-(IBAction)cilckedPageController:(UIPageControl *)sender
{
    if (!isTermsAccepted) {
        self.pageController.currentPage = 0;
    }
    else
    {
        isTermsAccepted = NO;
        [self.scroll setContentOffset:CGPointMake(0, 0) animated:YES];
        [self showButtonsWithOption:isTermsAccepted];
    }
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView.contentOffset.x == 0.0)
    {
        self.pageController.currentPage = 0;
        self.scroll.scrollEnabled = false;
        isTermsAccepted = NO;
        [self showButtonsWithOption:isTermsAccepted];
    }
}

-(void)showButtonsWithOption:(BOOL)show
{
    _btnNext.hidden = !show;
    _btnAccept.hidden = show;
    _btnReject.hidden = show;
}

@end
