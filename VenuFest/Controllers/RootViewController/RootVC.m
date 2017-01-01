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
    
    float sWidth = [[UIScreen mainScreen] bounds].size.width;
    
    if(viewHeader)
    {
        [viewHeader removeFromSuperview];
        viewHeader = nil;
    }
    viewHeader = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] objectAtIndex:0];
    self.headerView = viewHeader;
    CGRect rc = viewHeader.frame;
    rc.size.width = sWidth;
    viewHeader.frame = rc;
    viewHeader.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
    [self.view addSubview:viewHeader];
    UIButton *btnMenu = (UIButton*)[viewHeader viewWithTag:1];
    UIButton *btnNotification = (UIButton*)[viewHeader viewWithTag:3];
    [btnNotification addTarget:self action:@selector(clickedNotification) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btnLogout = (UIButton*)[viewHeader viewWithTag:4];
    [btnLogout addTarget:self action:@selector(clickedLogout) forControlEvents:UIControlEventTouchUpInside];

    self.lblHeader = (UILabel*)[viewHeader viewWithTag:2];
    self.imgVwLogo = (UIImageView *)[viewHeader viewWithTag:101];
    self.lblHeader.text = @"RUNNR'S PARADISE";
//    self.lblHeader.font = [UIFont fontWithName:@"ROBOTO-REGULAR" size:20];
    self.lblHeader.textColor = TOP_BAR_TEXT_COLOR;
    
//    UIImageView *imgViewLogo = (UIImageView*)[viewHeader viewWithTag:3];
//    imgViewLogo.image = [UIImage imageNamed:@"notification"];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [btnMenu addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self setNeedsStatusBarAppearanceUpdate];

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

//added by suman 26.10.2016
-(void)clickedNotification
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationVC"];
      [self.navigationController presentViewController:vc animated:YES completion:^{
            ;
       }];
}

-(void)clickedLogout
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
