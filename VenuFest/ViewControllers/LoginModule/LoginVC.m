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
#import "RPConstants.h"

@interface LoginVC ()<UITextFieldDelegate>

@end

@implementation LoginVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self createCustomizeUI];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UserSocialLoginNotification) name:USER_DID_LOGGED_IN_NOTIFICATION object:nil];
    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width, self.scroll.frame.size.height+10);

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

#pragma mark - Customize UI

-(void)createCustomizeUI
{
    self.vwheader.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
    self.lblHeader.text = @"Login with Runnr's Paradise";
//    self.lblHeader.font = TOP_BAR_TITLE_FONT;
    self.lblHeader.textColor = TOP_BAR_TEXT_COLOR;
    self.lblHeader.minimumScaleFactor = 0.5;
    self.vwfooter.backgroundColor = BOTTOM_BAR_BACKGROUND_COLOR;
    self.lblFooter.text = @"© copyright information . All right reserved.";
//    self.lblFooter.font = BOTTOM_BAR_TITLE_FONT;
    self.lblFooter.textColor = BOTTOM_BAR_TEXT_COLOR;

    self.btnLogin.backgroundColor = APP_BUTTON_BACKGROUND_COLOR;
    [self.btnLogin setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnLogin.tintColor = APP_BUTTON_TEXT_COLOR;
//    self.btnLogin.titleLabel.font =  APP_BUTTON_TITLE_FONT;
    /*
    self.btnLoginFacebook.backgroundColor = FB_BUTTON_BACKGROUND_COLOR;
    [self.btnLoginFacebook setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnLoginFacebook.tintColor = APP_BUTTON_TEXT_COLOR;

    self.btnLoginGplus.backgroundColor = GPLUS_BUTTON_BACKGROUND_COLOR;
    [self.btnLoginGplus setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnLoginGplus.tintColor = APP_BUTTON_TEXT_COLOR;

    self.btnRegister.backgroundColor = REGISTER_BUTTON_BACKGROUND_COLOR;
    [self.btnRegister setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnRegister.tintColor = APP_BUTTON_TEXT_COLOR;
    */
    self.btnForgetPassword.backgroundColor = [UIColor clearColor];
    self.btnForgetPassword.tintColor = [UIColor clearColor];
    [self.btnForgetPassword setTitleColor:APP_BUTTON_GREY_TEXT_COLOR forState:UIControlStateNormal];
//    self.btnForgetPassword.titleLabel.font =  APP_BUTTON_TITLE_FONT_MEDIUM;


    [self customizeTextField:_txtEmail];
    [self.txtEmail setPlaceholder:@"Login ID"];

    [self customizeTextField:_txtpassword];
    [self.txtpassword setPlaceholder:@"Password"];

    // SignIn Tag-Line
    NSString *str1 = @"LOGIN";
    NSString *str2 = @"YOUR ACCOUNT";
    [self setUpAttributeTextForlable:_lblPageTagLine WithItem1:str1 Font1:PAGE_TITLE_FONT color1:TOP_BAR_BACKGROUND_COLOR andItem2:str2 Font2:PAGE_TITLE_FONT color2:PAGE_TITLE_TEXT_COLOR_BLACK];
    
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
//    [self addBottomBorderForView:textField withcolor:TEXT_FIELD_PLACEHOLDER_COLOR andHeight:1];
    [self setPlaceHolderColor:textField];
    [self setupLeftViewForTextField:textField];
/*    if (textField == _txtpassword)
        [self setupRightViewForTxtField:textField];
*/
}

-(void)setupLeftViewForTextField:(UITextField *)textField
{
    UIView *leftView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 25, 20)];
    leftView.backgroundColor = [UIColor clearColor];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView *imgView = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, 25, 20)];
    [leftView addSubview:imgView];

    if (textField == _txtEmail)
        imgView.image = [UIImage imageNamed:@"User.png"];
    else if (textField == _txtpassword)
        imgView.image = [UIImage imageNamed:@"password.png"];
    [imgView sizeToFit];
    
    imgView.center = leftView.center;

}

-(void)setupPaddingView:(UITextField *)textField
{
    UIView *leftView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 8, 20)];
    leftView.backgroundColor = [UIColor clearColor];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}


-(void)setupRightViewForTxtField:(UITextField *)textField
{
    UIView *rightView = [[UIView alloc]  initWithFrame:CGRectMake(0, 5, 32, 18)];
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


-(void)setUpAttributeTextForlable:(UILabel *)Lbl WithItem1:(NSString *)str1 Font1:(UIFont *)font1 color1:(UIColor *)color1 andItem2:(NSString *)str2 Font2:(UIFont *)font2 color2:(UIColor *)color2
{
    NSString *str = [NSString stringWithFormat:@"%@ %@", str1, str2];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSRange range1 = str1 ? [str rangeOfString:str1] : NSMakeRange(0, 0);
    
    [attributeString addAttribute:NSFontAttributeName value:font1 range:range1];
    [attributeString addAttribute:NSForegroundColorAttributeName value:color1 range:range1];
    
    if (str2.length > 0) {
        NSRange range2 = str2 ? [str rangeOfString:str2] : NSMakeRange(0, 0);
        [attributeString addAttribute:NSFontAttributeName value:font2 range:range2];
        [attributeString addAttribute:NSForegroundColorAttributeName value:color2 range:range2];
    }
    
    Lbl.attributedText = attributeString;
}

-(void)customizeTextFieldForError:(UITextField *)textField
{
    [self addBottomBorderForView:textField withcolor:TXTFIELD_ERROR_COLOR_RED andHeight:2];
    [self setupRightViewForWarning:textField];
}

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



#pragma  mark - Frame Animation

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

//    [self addBottomBorderForView:textField withcolor:TEXT_FIELD_INPUT_COLOR andHeight:2];

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    [self setupLeftViewForTextField:textField];
    [self addBottomBorderForView:textField withcolor:TEXT_FIELD_PLACEHOLDER_COLOR andHeight:0];
    [self animateScrollOffsetwithYpos:0 andHeight:5];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

//Helpers Animation of scroll

-(void)animateScrollOffsetwithYpos:(CGFloat)Ypos andHeight:(CGFloat)height
{
    CGPoint offset = self.scroll.contentOffset;
    offset.y = Ypos;
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.scroll setContentOffset:offset];
                     }
                     completion:^(BOOL finished){
                     }];
    
    _scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.scroll.frame.size.height+ height);
}

#pragma mark - Click Events

-(IBAction)clickedback:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)clickedLogin:(id)sender
{
//    _txtEmail.text = @"suman.chatterjee.dml@gmail.com";
//    _txtpassword.text = @"123456";

    self.btnLogin.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.btnLogin.userInteractionEnabled = YES;
    });
    
    if ([self validateLoginData]) {
        [RPNetworkManager defaultNetworkManager].authType = userAuthTypeLogin;
        [RPNetworkManager defaultNetworkManager].loginType = userLoginTypeNormal;
        [AppManager sharedDataAccess].strUserEmailId = _txtEmail.text;
        [AppManager sharedDataAccess].strUserPassword = _txtpassword.text;
        [self connectionUserLogin];
    }


}
/*
-(IBAction)clickedFacebookLogin:(id)sender
{
    [RPNetworkManager defaultNetworkManager].authType = userAuthTypeLogin;
    [RPNetworkManager defaultNetworkManager].loginType = userLoginTypeFacebook;

    [[RPNetworkManager defaultNetworkManager] loginWithFbFromViewController:self];

}

-(IBAction)clickedGPlusLogin:(id)sender
{
    [RPNetworkManager defaultNetworkManager].authType = userAuthTypeLogin;
    [RPNetworkManager defaultNetworkManager].loginType = userLoginTypeGPlus;

    [[RPNetworkManager defaultNetworkManager] loginUsingGooglePlusInViewController:self loginHandler:nil];
}

*/
-(IBAction)clickedForgetPassword:(id)sender
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgetPasswordVC"];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - validation Checking

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
        // [[AppManager sharedDataAccess] showAlertWithTitle:@"Alert!" andMessage:strMsg fromViewController:self];
    }
    return isValid;
}

-(void)UserSocialLoginNotification
{
    [self connectionUserLogin];
}

//call to parse json data
//    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass: [RPNetworkManager class]];

#pragma mark - Webservice

-(void)connectionUserLogin
{
    int loginType = [RPNetworkManager defaultNetworkManager].loginType;
    int authType = [RPNetworkManager defaultNetworkManager].authType;
    NSString *imageURL = [AppManager sharedDataAccess].strSocialImageURL;
    NSString *socialId = [AppManager sharedDataAccess].strSocialLoginID;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSDictionary *params = @{@"LoginType" :[NSNumber numberWithInt:loginType], @"UserName" : [AppManager sharedDataAccess].strUserName, @"Email" : [AppManager sharedDataAccess].strUserEmailId, @"Password" :[AppManager sharedDataAccess].strUserPassword, @"SocialLoginId" : socialId != nil ? socialId : @"", @"AuthenticationType" :[NSNumber numberWithInt:authType], @"SocialImageUrl" : imageURL};
 
    NSString *requestTypeMethod =   [[AppManager sharedDataAccess]  getStringForRequestType: POST];

    [[RPNetworkManager defaultNetworkManager] RPSignUpwithParameters:params andRequestType:requestTypeMethod success:^(id response) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        NSDictionary *dictData;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dictData = response;
        }
        if ([[dictData objectForKey:@"ErrorCode"]  intValue] == 200 ) {
            RPLog(@"Success : %@", response);
            //storing auth token
            NSString *authKey = [[dictData objectForKey:@"Result"] objectForKey:@"AuthToken"];
            [[NSUserDefaults standardUserDefaults] setObject:authKey forKey:@"AuthToken"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //clear User Login Data
//            [self clearLoginData];    //Guided through a alert....
//            [self showAlertWithTitle:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"ErrorMessage"]] andMessage:@"You Have Sucesfully Logged In." fromViewController:self];
            [AppManager sharedDataAccess].IsLoggedIn = YES;
            [self.navigationController popToRootViewControllerAnimated:NO];
//            [self gotoHome:YES];
        }
        else if ([[dictData objectForKey:@"ErrorCode"]  intValue] == 403 )
        {
            if ([RPNetworkManager defaultNetworkManager].loginType == userLoginTypeGPlus || [RPNetworkManager defaultNetworkManager].loginType == userLoginTypeFacebook) {
                [RPNetworkManager defaultNetworkManager].authType = userAuthTypeRegistration;
                [self connectionUserLogin];
            }
            else
                [[AppManager sharedDataAccess] showAlertWithTitle:@"Warning!" andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"ErrorMessage"]] fromViewController:self];
        }
        else
        {
            [[AppManager sharedDataAccess] showAlertWithTitle:@"Warning!" andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"ErrorMessage"]] fromViewController:self];
        }
        ;
    } failure:^(id failureMessage, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        RPLog(@"Error : %@", error.localizedDescription);
    }];
}

-(void)clearLoginData
{
    [RPNetworkManager defaultNetworkManager].loginType = userLoginTypeNone;
    [RPNetworkManager defaultNetworkManager].authType = userAuthTypeNone;
//    [[AppManager sharedDataAccess] clearUserLoginData];
}



-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message fromViewController:(UIViewController *)vc{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       [AppManager sharedDataAccess].IsLoggedIn = YES;
                                       [self.navigationController popToRootViewControllerAnimated:NO];
//                                       [self gotoHome:YES];
                                   }];
    
    
    [alertController addAction:cancelAction];
    alertController.view.tintColor = [UIColor redColor];
    [vc presentViewController: alertController animated:YES completion:nil];
    
}


-(void)goBackToView:(UIViewController*)viewController withAnimation:(BOOL)animation
{
    [self.navigationController popToViewController:viewController animated:animation];
}

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
