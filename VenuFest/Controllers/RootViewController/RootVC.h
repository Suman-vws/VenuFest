//
//  RootVC.h
//  testSlideMenu
//
//  Created by Sayan Chatterjee on 24/07/16.
//  Copyright © 2016 Sayan Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
//#import "DCKeyValueObjectMapping.h"
//#import "DCParserConfiguration.h"
//#import "DCObjectMapping.h"
#import "MBProgressHUD.h"
#import "RPNetworkManager.h"
#import "AppManager.h"
#import "OutlinedButton.h"

@interface RootVC : UIViewController
{
    UIView *viewHeader;
}

@property (nonatomic, strong) UILabel *lblHeader;
@property (nonatomic, strong) UIImageView *imgVwLogo;
@property (nonatomic, strong) UIView *headerView;

-(void)clickedNotification; //Only Runnr's Paradise

@end
