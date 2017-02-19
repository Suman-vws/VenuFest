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
#import "ForgetPasswordVC.h"
#import "LiveFeedVC.h"
#import "TermsConditionsVC.h"
#import "SelectUserTypeVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    if ([AppManager sharedDataAccess].isUserLoggedIN) {
        [self gotoHome];
    }
 
    [self createCustomizeUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UserSocialLoginNotification) name:USER_DID_LOGGED_IN_NOTIFICATION object:nil];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

#pragma mark - Customize UI

-(void)createCustomizeUI
{
    self.btnLoginGplus.accessibilityHint = @"Gplus";
    self.btnLoginFacebook.accessibilityHint = @"fb";
    
    self.btnLogin.backgroundColor = APP_BUTTON_BACKGROUND_COLOR;
    [self.btnLogin setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnLogin.tintColor = APP_BUTTON_TEXT_COLOR;
    self.btnLogin.titleLabel.font =  APP_BUTTON_TITLE_FONT;
    
    self.btnLoginFacebook.backgroundColor = FB_BUTTON_BACKGROUND_COLOR;
    [self.btnLoginFacebook setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnLoginFacebook.tintColor = APP_BUTTON_TEXT_COLOR;
    self.btnLoginFacebook.titleLabel.font =  APP_BUTTON_TITLE_FONT_SMALL;
    
    self.btnLoginGplus.backgroundColor = GPLUS_BUTTON_BACKGROUND_COLOR;
    [self.btnLoginGplus setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnLoginGplus.tintColor = APP_BUTTON_TEXT_COLOR;
    self.btnLoginGplus.titleLabel.font =  APP_BUTTON_TITLE_FONT_SMALL;
    
    //    self.btnRegister.backgroundColor = REGISTER_BUTTON_BACKGROUND_COLOR;
    [self.btnRegister setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnForgetPassword.titleLabel.font =  APP_BUTTON_TITLE_FONT_MEDIUM;
    
    self.btnForgetPassword.backgroundColor = [UIColor clearColor];
    [self.btnForgetPassword setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnForgetPassword.titleLabel.font =  APP_BUTTON_TITLE_FONT_SMALL;
    
    
    [self customizeTextField:_txtEmail];
    [self.txtEmail setPlaceholder:@"Email ID"];
    
    [self customizeTextField:_txtpassword];
    [self.txtpassword setPlaceholder:@"Password"];
    
}

-(void)setPlaceHolderColor:(UITextField*)txtField
{
    
    if ([txtField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        txtField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txtField.placeholder attributes:@{NSForegroundColorAttributeName: TEXT_FIELD_PLACEHOLDER_COLOR}];
        txtField.tintColor = TEXT_FIELD_INPUT_COLOR;
    }
}

-(void)customizeTextField:(UITextField *)textField
{
    textField.font = APPLICATION_TEXTFIELD_FONT_MEDIUM;
    [self setPlaceHolderColor:textField];
    [self setupLeftViewForTextField:textField];
    /*    if (textField == _txtpassword)
     [self setupRightViewForTxtField:textField];
     */
}

-(void)setupLeftViewForTextField:(UITextField *)textField
{
    UIView *leftView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 32, 20)];
    leftView.backgroundColor = [UIColor clearColor];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView *imgView = [[UIImageView alloc]  initWithFrame:CGRectMake(0, -3, 25, 20)];
    [leftView addSubview:imgView];
    
    if (textField == _txtEmail)
        imgView.image = [UIImage imageNamed:@"mail"];
    else if (textField == _txtpassword)
        imgView.image = [UIImage imageNamed:@"lock"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
//    imgView.center = leftView.center;
    
}

// ============ For Padding ============

-(void)setupPaddingView:(UITextField *)textField
{
    UIView *leftView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 8, 20)];
    leftView.backgroundColor = [UIColor clearColor];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}


// ============ For Show password ============

-(void)setupRightViewForTxtField:(UITextField *)textField
{
    UIView *rightView = [[UIView alloc]  initWithFrame:CGRectMake(0, 2, 32, 16)];
    //    rightView.layer.cornerRadius = rightView.frame.size.width / 2;
    rightView.backgroundColor = [UIColor clearColor];
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    UIImageView *imgVw = [[UIImageView alloc]  initWithFrame:CGRectMake(2, 2, rightView.frame.size.width - 2, rightView.frame.size.height - 2 )];
    [imgVw setImage:[UIImage imageNamed:@"password-eye"] ];
    imgVw.contentMode = UIViewContentModeScaleAspectFit;
    [rightView addSubview:imgVw];
    
    [self addGesturewithView:rightView];
}
-(void)addGesturewithView:(UIView *)view
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(tappedShowHidePassword:)];
    
    tapGesture.accessibilityHint = @"1";
    tapGesture.numberOfTapsRequired = 1;
    [view addGestureRecognizer:tapGesture];
}

-(void)tappedShowHidePassword:(UITapGestureRecognizer *)sender
{
    UITextField *txtField;
    if ([[sender.view superview] isKindOfClass:[UITextField class]]) {
        txtField =  (UITextField *) [sender.view superview];
    }
    
    if ([sender.accessibilityHint isEqualToString:@"0"]) {
        sender.accessibilityHint = @"1";
        txtField.secureTextEntry = NO;
        
    }
    //Hide password in textfield
    else if([sender.accessibilityHint isEqualToString:@"1"])
    {
        sender.accessibilityHint = @"0";
        txtField.secureTextEntry = YES;
    }
}

// ============ End Show-Hide Password ============

-(void)addBottomBorderForView:(UIView *)Vw withcolor:(UIColor *)color andHeight:(CGFloat)height
{
    NSArray *layers = [Vw.layer sublayers];
    for (CALayer *layer in layers) {
        if ([layer.accessibilityHint isEqualToString:@"101"]) {
            [layer setFrame:CGRectMake(0.0f, Vw.frame.size.height-height, Vw.frame.size.width, height)];
            layer.backgroundColor = color.CGColor;
            return;
        }
    }
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.accessibilityHint = @"101";
    bottomBorder.frame = CGRectMake(0.0f, Vw.frame.size.height-height, Vw.frame.size.width, height);
    bottomBorder.backgroundColor = color.CGColor;
    [Vw.layer addSublayer:bottomBorder];
}

// ============ Mark Error In Text Field For Validation Error ============


-(void)customizeTextFieldForError:(UITextField *)textField
{
    [self addBottomBorderForView:textField withcolor:TXTFIELD_ERROR_COLOR_RED andHeight:2];
    [self setupRightViewForWarning:textField];
}

-(void)setupRightViewForWarning:(UITextField *)textField
{
    UIView *rightView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 25, 25)];
    rightView.backgroundColor = [UIColor clearColor];
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    UIImageView *imgVw = [[UIImageView alloc]  initWithFrame:CGRectMake(1, 1, rightView.frame.size.width - 2, rightView.frame.size.height - 2 )];
    imgVw.tag = 101;
    [imgVw setImage:[UIImage imageNamed:@"error"] ];
    imgVw.contentMode = UIViewContentModeScaleAspectFit;
    [rightView addSubview:imgVw];
}

// Frame Animation

-(void)animateFrameTextFieldFrame:(UITextField *)txtField
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.3;
    
    animation.additive = YES;
    
    [txtField.layer addAnimation:animation forKey:@"shake"];
}


#pragma mark - Uitext Field delegate Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //for setup the right view after the warning effect
    UIView *rightView = textField.rightView;
    for (UIImageView *imgVw in [rightView subviews]) {
        if (imgVw.tag == 101) {
            [imgVw removeFromSuperview];
        }
    }
    /*
     if (textField != _txtEmail )
     {
     [self setupRightViewForTxtField:textField];
     }
     */
    
    //animate scroll view .....
    if (textField == _txtEmail)
    {
        [self animateScrollOffsetwithYpos:90 andHeight:160];
    }
    else if (textField == _txtpassword)
    {
        [self animateScrollOffsetwithYpos:150 andHeight:160];
    }
    [self addBottomBorderForView:textField withcolor:TEXT_FIELD_PLACEHOLDER_COLOR andHeight:1];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self addBottomBorderForView:textField withcolor:[UIColor clearColor] andHeight:0];
    if (textField == _txtpassword)
        [self animateScrollOffsetwithYpos:0 andHeight:5];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.txtEmail]) {
        [_txtEmail resignFirstResponder];
        [_txtpassword becomeFirstResponder];
    }
    else
        [textField resignFirstResponder];
    return  YES;
}

//Helpers Animation of scroll

-(void)animateScrollOffsetwithYpos:(CGFloat)Ypos andHeight:(CGFloat)height
{
    CGPoint offset = self.scroll.contentOffset;
    offset.y = Ypos;
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.scroll setContentOffset:offset];
                     }
                     completion:^(BOOL finished){
                     }];
    
    _scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.scroll.frame.size.height+ height);
}

#pragma mark - Click Events

-(IBAction)clickedGplusLogin:(UIButton *)sender
 {
      [[VFNetworkManager defaultNetworkManager] loginUsingGooglePlusInViewController:self loginHandler:nil];
 }
 
-(IBAction)clickedFBLogin:(UIButton *)sender
{
     [[VFNetworkManager defaultNetworkManager] loginWithFbFromViewController:self];
 }

-(IBAction)clickedRegister:(UIButton *)sender
{
    [AppManager sharedDataAccess].socialUser.isSocialSignup = false;
    [self gotoSelectUser];
}

-(void)gotoSelectUser
{
    SelectUserTypeVC *selectUser = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectUserTypeVC"];
    [self.navigationController pushViewController:selectUser animated:YES];
}

-(IBAction)LoginButtonTapped:(id)sender
{
    
    self.btnLogin.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.btnLogin.userInteractionEnabled = YES;
    });

    [self gotoHome];
    /*
    if ([self  validateLoginData]) {
        [self gotoHome];
    }   */
}

-(IBAction)clickedForgetPassword:(UIButton *)sender
{
    //TODO: Handle Show Forgot Password View
    ForgetPasswordVC *forgotVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgetPasswordVC"];
    [self.navigationController pushViewController:forgotVC animated:YES];
}

// Social Call Back

-(void)UserSocialLoginNotification
{
//    [self connectionUserLoginWithDetails:nil];
    NSLog(@"Social Login Succesful");
    [AppManager sharedDataAccess].socialUser.isSocialSignup = true;
    [self gotoSelectUser];
}


/*
 {
 apitoken =
 "$2y$05$xqg81lxTmy0OSsLW1TzWL.usQ4u43srObJzkId8bQ2iqgxpRLRwjS";
 email = "testsocial5@ouracademia.in";
 password = 12345;
 }
 
 */

#pragma mark - Helpers

-(BOOL)validateLoginData
{
    
    BOOL isValid = YES;
    NSString *strMsg = @"";
    if (![[AppManager sharedDataAccess] validateEmailWithString:_txtEmail.text]) {
        isValid = NO;
        strMsg = @"Please Enter a valid Email.";
        [self customizeTextFieldForError:_txtEmail];
        [self animateFrameTextFieldFrame:_txtEmail];
    }
    else if ([_txtpassword.text isEqualToString:@""]) {
        isValid = NO;
        strMsg = @"Please Enter A Valid password.";
        [self customizeTextFieldForError:_txtpassword];
        [self animateFrameTextFieldFrame:_txtpassword];
    }
    if (strMsg.length > 0) {
        //         [[AppManager sharedDataAccess] showAlertWithTitle:@"Alert!" andMessage:strMsg fromViewController:self];
        NSLog(@"Validation Error");
    }
    return isValid;
}

-(void)gotoHome
{
    //TODO: Handle Show Forgot Password View
    //    LiveFeedVC *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LiveFeedVC"];
    //    [self.navigationController pushViewController:homeVC animated:YES];
    
    if ([AppManager sharedDataAccess].isuserLoggedinFirstTime) {
        TermsConditionsVC *termsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TermsConditionsVC"];
        UINavigationController *nav = [[UINavigationController alloc]  initWithRootViewController:termsVC];
        nav.navigationBar.hidden = YES;
        [self presentViewController:nav animated:YES completion:nil];
    }
    else
    {
        [AppManager sharedDataAccess].loggedInUserType = userTypeCustomer;
        SWRevealViewController *revealVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        [self.navigationController pushViewController:revealVC animated:YES];
    }
}

#pragma mark - Webservice

-(void)connectionUserLoginWithDetails:(NSDictionary *)dictParam
{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *requestTypeMethod =   [[VFNetworkManager defaultNetworkManager]  getStringForRequestType: POST];
   
    [[VFNetworkManager defaultNetworkManager] VFServicewithMethodName:USER_LOGIN_PATH withParameters:dictParam andRequestType:requestTypeMethod success:^(id response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSDictionary *dictData;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dictData = response;
        }
        if ([[dictData objectForKey:@"ErrorCode"]  intValue] == 200 ) {
            RPLog(@"Success : %@", response);
            
            [self showAlertWithTitle:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"ErrorMessage"]] andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"Result"]] fromViewController:self];
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
    NSString *requestTypeMethod =   [[VFNetworkManager defaultNetworkManager]  getStringForRequestType: POST];
    
//    NSDictionary *params = @{@"name" : @"Suman ios", @"address" : @"kolkata", @"contactnumber" : @"8820044725", @"emailaddress" : @"suman@yopmail.com", @"username": @"demo_user", @"password" : @"123456"};

    [[VFNetworkManager defaultNetworkManager] VFServicewithMethodName:USER_REGISTRATION_PATH withParameters:dictParam andRequestType:requestTypeMethod success:^(id response) {
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

#pragma mark - Test Network Connection Method

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

/*
-(void)connectionGetAllUSer
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *requestTypeMethod =   [[VFNetworkManager defaultNetworkManager]  getStringForRequestType: POST];
    NSDictionary *dictParam = @{@"name" : @"rana" , @"username": @"rana", @"password" : @"rana123"};

    [[VFNetworkManager defaultNetworkManager] VFServicewithMethodName:@"get_all_users.php" withParameters:dictParam andRequestType:requestTypeMethod success:^(id response) {
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

*/


#pragma mark - Alert

-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message fromViewController:(UIViewController *)vc{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       [AppManager sharedDataAccess].isUserLoggedIN = YES;
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
