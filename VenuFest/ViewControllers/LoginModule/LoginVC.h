//
//  LoginVC.h
//  RP
//
//  Created by Mac on 31/08/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutlinedTextField.h"
#import "OutlinedButton.h"
#import "RPNetworkManager.h"
#import "MBProgressHUD.h"


@interface LoginVC : UIViewController

//Header View
@property (weak, nonatomic) IBOutlet UIView *vwheader;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;

@property (weak, nonatomic) IBOutlet UILabel *lblPageTagLine;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtEmail;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtpassword;
//buttons
@property (weak, nonatomic) IBOutlet OutlinedButton *btnLogin;
@property (weak, nonatomic) IBOutlet OutlinedButton *btnLoginFacebook;
@property (weak, nonatomic) IBOutlet OutlinedButton *btnLoginGplus;
@property (weak, nonatomic) IBOutlet OutlinedButton *btnRegister;
@property (weak, nonatomic) IBOutlet OutlinedButton *btnForgetPassword;


//FooterView
@property (weak, nonatomic) IBOutlet UIView *vwfooter;
@property (weak, nonatomic) IBOutlet UILabel *lblFooter;

@end
