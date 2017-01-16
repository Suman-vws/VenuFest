//
//  loginView.h
//  VenuFest
//
//  Created by Sayan Chatterjee on 01/01/17.
//  Copyright © 2017 Sayan Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutlinedTextField.h"
#import "OutlinedButton.h"

@protocol LoginViewDelegate <NSObject>

-(void)socialLoginButtonTappedWithSender:(UIButton *)sender;
-(void)userLoginButtonTappedWithUserName:(NSString *)userName andPassword:(NSString *)password;
-(void)userForgotPasswordButtonTappedWithSender:(UIButton *)sender;
-(void)userSignUpButtonTappedWithSender:(UIButton *)sender;

@end


@interface loginView : UIView

@property (strong, nonatomic) id<LoginViewDelegate> delegate;

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
