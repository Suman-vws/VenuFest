//
//  RootVC.h
//  testSlideMenu
//
//  Created by Sayan Chatterjee on 24/07/16.
//  Copyright © 2016 Sayan Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

#import "MBProgressHUD.h"
#import "RPNetworkManager.h"
#import "AppManager.h"
#import "OutlinedButton.h"

@interface RootVC : UIViewController
{
    UIView *viewHeader;
}

@property (nonatomic, strong) UILabel *lblHeader;
@property (nonatomic, strong) UIView *headerView;
@property (strong, nonatomic) NSLayoutConstraint *headerViewTopSpaceConst;

@end
