//
//  LandingVC.h
//  RP
//
//  Created by Mac on 12/10/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface LandingVC : UIViewController

@property (weak, nonatomic) IBOutlet UIView *vwRPLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnRPLogin;

@property (weak, nonatomic) IBOutlet UIView *vwFBLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnFBLogin;

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UILabel *lblDiv;

//FooterView
@property (weak, nonatomic) IBOutlet UIView *vwfooter;
@property (weak, nonatomic) IBOutlet UILabel *lblFooter;

@end
