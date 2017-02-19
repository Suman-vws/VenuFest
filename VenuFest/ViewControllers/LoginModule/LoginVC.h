//
//  LoginVC.h
//  RP
//
//  Created by Mac on 31/08/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPNetworkManager.h"
#import "MBProgressHUD.h"
#import "OutlinedButton.h"
#import "OutlinedTextField.h"

@interface LoginVC : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtEmail;
@property (weak, nonatomic) IBOutlet UIView *divEmail;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtpassword;
@property (weak, nonatomic) IBOutlet UIView *divPassword;

//buttons
@property (weak, nonatomic) IBOutlet OutlinedButton *btnLogin;
@property (weak, nonatomic) IBOutlet OutlinedButton *btnLoginFacebook;
@property (weak, nonatomic) IBOutlet OutlinedButton *btnLoginGplus;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnForgetPassword;

@end
