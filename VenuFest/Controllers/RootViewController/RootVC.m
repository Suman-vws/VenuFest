//
//  RootVC.m
//  testSlideMenu
//
//  Created by Sayan Chatterjee on 24/07/16.
//  Copyright © 2016 Sayan Chatterjee. All rights reserved.
//

#import "RootVC.h"
#import "RPConstants.h"
#import "MenuTableVC.h"

@interface RootVC ()

@end

@implementation RootVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    float sWidth = [[UIScreen mainScreen] bounds].size.width;
    
    if(viewHeader)
    {
        [viewHeader removeFromSuperview];
        viewHeader = nil;
    }
    viewHeader = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] objectAtIndex:0];
    viewHeader.backgroundColor = TOP_BAR_BACKGROUND_COLOR;

    viewHeader.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:viewHeader];
    [self addConstrainsForView:viewHeader withRefence:self.view];
    
    self.headerView = viewHeader;
    
    UIButton *btnMenu = (UIButton*)[viewHeader viewWithTag:1];
    /*
    btnMenu.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *menu_width =[NSLayoutConstraint
                                constraintWithItem:btnMenu
                                attribute:NSLayoutAttributeWidth
                                relatedBy:NSLayoutRelationEqual
                                toItem:nil
                                attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                constant:btnMenu.frame.size.width];
    
    NSLayoutConstraint *menu_height =[NSLayoutConstraint
                                 constraintWithItem:btnMenu
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1.0
                                 constant:btnMenu.frame.size.height];
    
    
    NSLayoutConstraint *menu_top = [NSLayoutConstraint
                               constraintWithItem:btnMenu
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:viewHeader
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0f
                               constant:16.0f];
    
    NSLayoutConstraint *menu_leading = [NSLayoutConstraint
                                   constraintWithItem:btnMenu
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:viewHeader
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:10.0f];
    
    [NSLayoutConstraint activateConstraints:@[menu_height, menu_width, menu_top, menu_leading]];
    
    */

    self.lblHeader = (UILabel*)[viewHeader viewWithTag:2];
    self.lblHeader.text = @"Venu Fest";
    self.lblHeader.textColor = TOP_BAR_TEXT_COLOR;
       
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [btnMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self setNeedsStatusBarAppearanceUpdate];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

-(void)addConstrainsForView:(UIView *)childView withRefence:(UIView *)parentView
{
    NSLayoutConstraint *width =[NSLayoutConstraint
                                constraintWithItem:childView
                                attribute:NSLayoutAttributeWidth
                                relatedBy:0
                                toItem:parentView
                                attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                constant:0];
    
    NSLayoutConstraint *height =[NSLayoutConstraint
                                 constraintWithItem:childView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1.0
                                 constant:60];

    
    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:childView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:parentView
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0f
                               constant:0.f];
    self.headerViewTopSpaceConst = top;
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:childView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:parentView
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0.f];
    
    [NSLayoutConstraint activateConstraints:@[width, height, top, leading]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
