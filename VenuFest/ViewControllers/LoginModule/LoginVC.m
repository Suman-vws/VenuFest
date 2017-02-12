//
//  LoginVC.m
//  RP
//
//  Created by Mac on 31/08/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "LoginVC.h"
#import "RPConstants.h"
#import "AppManager.h"
#import "loginView.h"
#import "RegisterView.h"
#import "ForgetPasswordVC.h"
#import "LiveFeedVC.h"
#import "AppDelegate.h"
#import "TermsConditionsVC.h"

@interface LoginVC ()<LoginViewDelegate, RegisterViewDelegate>
{
    loginView *loginVw;
    RegisterView *regVw;
    BOOL isFilpped;
    AppDelegate *appDelegate;

}

@end

@implementation LoginVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    if ([AppManager sharedDataAccess].IsLoggedIn) {
        [self gotoHome];
    }
    appDelegate = [UIApplication sharedApplication].delegate;

    loginVw = [[loginView alloc] init];
    loginVw.delegate = self;
    loginVw.userInteractionEnabled = YES;

    regVw = [[RegisterView alloc]  init];
    regVw.delegate = self;
    regVw.userInteractionEnabled = YES;

    isFilpped = NO;
    [self addChildView:loginVw InView:self.containerView andAnimation:YES];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UserSocialLoginNotification) name:USER_DID_LOGGED_IN_NOTIFICATION object:nil];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

}

#pragma mark - Setup Sub Views

//ADD Child View
-(void)addChildView:(UIView *)childView InView:(UIView *)parentView andAnimation:(BOOL)animation{
    
    childView.frame = parentView.bounds;
    childView.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addSubview:childView];
    [self addConstrainsForView:childView withRefence:parentView];
    
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
                                 relatedBy:0
                                 toItem:parentView
                                 attribute:NSLayoutAttributeHeight
                                 multiplier:1.0
                                 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:childView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:parentView
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0f
                               constant:0.f];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:childView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:parentView
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0.f];
    
    [parentView addConstraint:width];
    [parentView addConstraint:height];
    [parentView addConstraint:top];
    [parentView addConstraint:leading];
    
}

#pragma mark - Login View Delegate Methods

-(void)socialLoginButtonTappedWithSender:(UIButton *)sender
{
    if ([sender.accessibilityHint isEqualToString:@"Gplus"]) {
        [self performUserGPlusLogin];
    }
    else if ([sender.accessibilityHint isEqualToString:@"fb"])
    {
        [self performUserFBLogin];
    }
}

-(void)userLoginButtonTappedWithUserName:(NSString *)userName andPassword:(NSString *)password
{
    [self performUserLoginWithUserName:userName andPassword:password];
}

-(void)userForgotPasswordButtonTappedWithSender:(UIButton *)sender
{
    [self gotoForgotPassword];
}

-(void)userSignUpButtonTappedWithSender:(UIButton *)sender
{
    [self flipViewAnimation];
}

#pragma mark - Register View Delegate Methods

-(void)RegisterButtonTappedWithUserData:(NSDictionary *)dictUserData;
{
    [self connectionUserSignupWithDetails:dictUserData];
}

-(void)AlreadyHaveanAccount:(UIButton *)sender
{
    [self flipViewAnimation];
}

//animation
-(void)flipViewAnimation
{
    
    [UIView transitionWithView:self.containerView
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        
                        if (!isFilpped) {
                            for (UIView *child in self.containerView.subviews) {
                                if ([child isKindOfClass:[loginView class]]) {
                                    [child removeFromSuperview];
                                    loginVw = nil;
                                }
                            }
                            if (!regVw) {
                                regVw = [[RegisterView alloc]  init];
                                regVw.delegate = self;
                                regVw.userInteractionEnabled = YES;
                            }
                            [self addChildView:regVw InView:self.containerView andAnimation:YES];
                            isFilpped = YES;
                        } else {
                            for (UIView *child in self.containerView.subviews) {
                                if ([child isKindOfClass:[RegisterView class]]) {
                                    [child removeFromSuperview];
                                    regVw = nil;
                                }
                            }
                            if (!loginVw) {
                                loginVw = [[loginView alloc] init];
                                loginVw.delegate = self;
                                loginVw.userInteractionEnabled = YES;
                            }
                            [self addChildView:loginVw InView:self.containerView andAnimation:YES];
                            isFilpped = NO;
                        }
                        
                    } completion:nil];
}


#pragma mark - User Login With App Credential

-(void)performUserLoginWithUserName:(NSString *)userName andPassword:(NSString *)password
{
    //TODO: Handle User Login
    /*
     [RPNetworkManager defaultNetworkManager].authType = userAuthTypeLogin;
     [RPNetworkManager defaultNetworkManager].loginType = userLoginTypeNormal;
     [AppManager sharedDataAccess].strUserEmailId = _txtEmail.text;
     [AppManager sharedDataAccess].strUserPassword = _txtpassword.text;
     [self connectionUserLogin];
     */
    NSDictionary *params = @{@"LoginType" :@"", @"UserName" : userName, @"Email" : userName , @"Password" :password, @"SocialLoginId" : @"", @"AuthenticationType" :@"", @"SocialImageUrl" : @""};
//    [self connectionUserLoginWithDetails:params];
    [self gotoHome];

}

#pragma mark - Navigation

-(void)gotoHome
{
    //TODO: Handle Show Forgot Password View
//    LiveFeedVC *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LiveFeedVC"];
//    [self.navigationController pushViewController:homeVC animated:YES];
    
    if (appDelegate.isuserLoggedinFirstTime) {
        TermsConditionsVC *termsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TermsConditionsVC"];
        UINavigationController *nav = [[UINavigationController alloc]  initWithRootViewController:termsVC];
        nav.navigationBar.hidden = YES;
        [self presentViewController:nav animated:YES completion:nil];
    }
    else
    {
        [AppManager sharedDataAccess].IsLoggedIn = YES;
        [AppManager sharedDataAccess].loggedInUserType = userTypeCustomer;
        SWRevealViewController *revealVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        [self.navigationController pushViewController:revealVC animated:YES];
    }
}

-(void)gotoForgotPassword
{
    //TODO: Handle Show Forgot Password View
    ForgetPasswordVC *forgotVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgetPasswordVC"];
    [self.navigationController pushViewController:forgotVC animated:YES];
}

-(void)gotoUserSignup
{
    //TODO: Handle User Sign Up
}

#pragma mark - Social Login

-(void)performUserGPlusLogin
 {
     //     [RPNetworkManager defaultNetworkManager].authType = userAuthTypeLogin;
     //     [RPNetworkManager defaultNetworkManager].loginType = userLoginTypeGPlus;

      [[RPNetworkManager defaultNetworkManager] loginUsingGooglePlusInViewController:self loginHandler:nil];
 }
 
 -(void)performUserFBLogin
 {
//     [RPNetworkManager defaultNetworkManager].authType = userAuthTypeLogin;
//     [RPNetworkManager defaultNetworkManager].loginType = userLoginTypeFacebook;
     
     [[RPNetworkManager defaultNetworkManager] loginWithFbFromViewController:self];
 }




-(void)UserSocialLoginNotification
{
//    [self connectionUserLoginWithDetails:nil];
    NSLog(@"Social Login Succesful");
}

#pragma mark - Webservice

-(void)connectionUserLoginWithDetails:(NSDictionary *)dictParam
{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
 
    NSString *requestTypeMethod =   [[AppManager sharedDataAccess]  getStringForRequestType: POST];
   
    [[RPNetworkManager defaultNetworkManager] VFServicewithMethodName:@"" withParameters:dictParam andRequestType:requestTypeMethod success:^(id response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSDictionary *dictData;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dictData = response;
        }
        if ([[dictData objectForKey:@"ErrorCode"]  intValue] == 200 ) {
            RPLog(@"Success : %@", response);
            
            [[AppManager sharedDataAccess] showAlertWithTitle:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"ErrorMessage"]] andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"Result"]] fromViewController:self];
        }
        else
        {
            [[AppManager sharedDataAccess] showAlertWithTitle:@"Error!" andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"Result"]] fromViewController:self];
        }
        
    } failure:^(id failureMessage, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        RPLog(@"Error : %@", error.localizedDescription);
        
    }];
}


/*
 URL : http://venuefest.teqnico.com/fest_connect/create_user.php
 Method	Post
 Input Parameters:
 Parameter Name
 Data Type
 name	String
 address	String
 contactnumber	String
 emailaddress	String
 username	String
 password	String
 Output
 success	1
 failure	0
 */

-(void)connectionUserSignupWithDetails:(NSDictionary *)dictParam
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *requestTypeMethod =   [[AppManager sharedDataAccess]  getStringForRequestType: POST];
    NSString *strMethodname = [NSString stringWithFormat:@"%@",USER_REGISTRATION_PATH];
    
    NSDictionary *params = @{@"name" : @"Suman ios", @"address" : @"kolkata", @"contactnumber" : @"8820044725", @"emailaddress" : @"suman@yopmail.com", @"username": @"demo_user", @"password" : @"123456"};

    [[RPNetworkManager defaultNetworkManager] VFServicewithMethodName:strMethodname withParameters:params andRequestType:requestTypeMethod success:^(id response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSDictionary *dictData;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dictData = response;
        }
        if ([[dictData objectForKey:@"ErrorCode"]  intValue] == 200 ) {
            RPLog(@"Success : %@", response);
            
            [[AppManager sharedDataAccess] showAlertWithTitle:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"ErrorMessage"]] andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"Result"]] fromViewController:self];
        }
        else
        {
            [[AppManager sharedDataAccess] showAlertWithTitle:@"Error!" andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"Result"]] fromViewController:self];
        }
        
    } failure:^(id failureMessage, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        RPLog(@"Error : %@", error.localizedDescription);
        
    }];
}



/*
 RL : http://venuefest.teqnico.com/fest_connect/get_all_users.php
 Method	Get
 Input Parameters:
 Parameter Name
 Data Type
 name	String
 username	String
 password	String
 */


-(void)connectionGetAllUSer
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *requestTypeMethod =   [[AppManager sharedDataAccess]  getStringForRequestType: POST];
    NSDictionary *dictParam = @{@"name" : @"rana" , @"username": @"rana", @"password" : @"rana123"};

    [[RPNetworkManager defaultNetworkManager] VFServicewithMethodName:@"get_all_users.php" withParameters:dictParam andRequestType:requestTypeMethod success:^(id response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSDictionary *dictData;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dictData = response;
        }
        if ([[dictData objectForKey:@"ErrorCode"]  intValue] == 200 ) {
            RPLog(@"Success : %@", response);
            
        }
        else
        {
            [[AppManager sharedDataAccess] showAlertWithTitle:@"Error!" andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"Result"]] fromViewController:self];
        }
        
    } failure:^(id failureMessage, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        RPLog(@"Error : %@", error.localizedDescription);
        
    }];
}


#pragma mark - Alert

-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message fromViewController:(UIViewController *)vc{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       [AppManager sharedDataAccess].IsLoggedIn = YES;
                                       [self gotoHome];
                                   }];
    
    
    [alertController addAction:cancelAction];
    alertController.view.tintColor = [UIColor redColor];
    [vc presentViewController: alertController animated:YES completion:nil];
    
}

#pragma mark - View Disapper

-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [super viewWillDisappear:YES];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
