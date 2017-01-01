//
//  RegistrationVC.m
//  RP
//
//  Created by Mac on 31/08/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "RegistrationVC.h"
#import "RPConstants.h"
#import "RPNetworkManager.h"
#import "AppManager.h"
#import "MBProgressHUD.h"

@interface RegistrationVC ()
{
    NSString *userName;
}

@end

@implementation RegistrationVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self createCustomizeUI];
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
    self.lblHeader.text = @"Create New Account";
//    self.lblHeader.font = TOP_BAR_TITLE_FONT;
    self.lblHeader.textColor = TOP_BAR_TEXT_COLOR;
    
    self.vwfooter.backgroundColor = BOTTOM_BAR_BACKGROUND_COLOR;
    self.lblFooter.text = @"All rights reserved © FITOFY FITNESS SOLUTIONS PVT LTD.";
//    self.lblFooter.font = BOTTOM_BAR_TITLE_FONT;
    self.lblFooter.textColor = BOTTOM_BAR_TEXT_COLOR;
    UITapGestureRecognizer *tapProfile= [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(clickedFooterView)];
    tapProfile.numberOfTapsRequired = 1;
    [self.vwfooter addGestureRecognizer:tapProfile];

    self.btnSubmit.backgroundColor = APP_BUTTON_BACKGROUND_COLOR;
    [self.btnSubmit setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnSubmit.tintColor = APP_BUTTON_TEXT_COLOR;
    
    [self customizeTextField:_txtUserName];
    [self.txtEmail setPlaceholder:@"Name"];
    [self customizeTextField:_txtEmail];
    [self.txtEmail setPlaceholder:@"Email"];
    [self customizeTextField:_txtpassword];
    [self.txtpassword setPlaceholder:@"Password"];
    [self customizeTextField:_txtConfirmpassword];
    [self.txtConfirmpassword setPlaceholder:@"Confirm Password"];
    
/*
    // SignIn Tag-Line
    NSString *str1 = @"REGISTER";
    NSString *str2 = @"YOUR ACCOUNT";
    [self setUpAttributeTextForlable:_lblPageTagLine WithItem1:str1 Font1:PAGE_TITLE_FONT color1:TOP_BAR_BACKGROUND_COLOR andItem2:str2 Font2:PAGE_TITLE_FONT color2:PAGE_TITLE_TEXT_COLOR_BLACK];
 */
}

-(void)setPlaceHolderColor:(UITextField*)txtField
{
    
    if ([txtField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        txtField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txtField.placeholder attributes:@{NSForegroundColorAttributeName: TEXT_FIELD_PLACEHOLDER_COLOR}];
        txtField.tintColor = TEXT_FIELD_INPUT_COLOR;
    }
}

-(void)setupPaddingView:(UITextField *)textField
{
    UIView *leftView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 8, 20)];
    leftView.backgroundColor = [UIColor clearColor];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

-(void)customizeTextField:(UITextField *)textField
{
//    [self addBottomBorderForView:textField withcolor:TEXT_FIELD_PLACEHOLDER_COLOR andHeight:1];
    [self setPlaceHolderColor:textField];
    [self setupLeftViewForTextField:textField];
//    if (textField != _txtEmail) {
//        [self setupRightViewForTxtField:textField];
//    }
//    [self setupPaddingView:textField];

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
    
    if (textField == _txtUserName)
        imgView.image = [UIImage imageNamed:@"User.png"];

    else if (textField == _txtEmail){
        imgView.image = [UIImage imageNamed:@"mail.png"];
    }
    else
        imgView.image = [UIImage imageNamed:@"password.png"];
    
    [imgView sizeToFit];
    imgView.center = leftView.center;
    
}


-(void)setupRightViewForWarning:(UITextField *)textField
{
    UIView *rightView = [[UIView alloc]  initWithFrame:CGRectMake(0, 5, 32, 18)];
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



-(void)setupRightViewForTxtField:(UITextField *)textField
{
    UIView *rightView = [[UIView alloc]  initWithFrame:CGRectMake(0, 5, 30, 30)];
    //    rightView.layer.cornerRadius = rightView.frame.size.width / 2;
    rightView.backgroundColor = [UIColor clearColor];
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    UIImageView *imgVw = [[UIImageView alloc]  initWithFrame:CGRectMake(2, 2, rightView.frame.size.width - 2, rightView.frame.size.height - 2 )];
    [imgVw setImage:[UIImage imageNamed:@"password-eye"]];
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
//    if (textField != _txtEmail )
//    {
//        [self setupRightViewForTxtField:textField];
//    }
    [self addBottomBorderForView:textField withcolor:TEXT_FIELD_PLACEHOLDER_COLOR andHeight:1];

//    [self addBottomBorderForView:textField withcolor:TEXT_FIELD_INPUT_COLOR andHeight:2];
    
    
    //animate scroll view .....
    if (textField == _txtUserName)
    {
        [self animateScrollOffsetwithYpos:60 andHeight:250];
    }
    else if (textField == _txtEmail)
    {
        [self animateScrollOffsetwithYpos:120 andHeight:250];
    }
    else if (textField == _txtpassword)
    {
        [self animateScrollOffsetwithYpos:180 andHeight:250];
    }
    else if (textField == _txtConfirmpassword)
    {
        [self animateScrollOffsetwithYpos:240 andHeight:250];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self addBottomBorderForView:textField withcolor:TEXT_FIELD_PLACEHOLDER_COLOR andHeight:0];
    [self animateScrollOffsetwithYpos:0 andHeight:5];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _txtUserName)
    {
        [_txtEmail becomeFirstResponder];
    }
    else if (textField == _txtEmail)
    {
        [_txtpassword becomeFirstResponder];
    }
    else if (textField == _txtpassword)
    {
        [_txtConfirmpassword becomeFirstResponder];
    }
    else if (textField == _txtConfirmpassword)
    {
        [textField resignFirstResponder];
    }
    
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

-(IBAction)clickedSubmit:(id)sender
{
    self.btnSubmit.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.btnSubmit.userInteractionEnabled = YES;
    });
    
    if ([self validateSingupData]) {
        [RPNetworkManager defaultNetworkManager].authType = userAuthTypeRegistration;
        [RPNetworkManager defaultNetworkManager].loginType = userLoginTypeNormal;
        [AppManager sharedDataAccess].strUserName =   userName;  // _txtUserName.text;  //Trimmed For White Spaces
        [AppManager sharedDataAccess].strUserEmailId = _txtEmail.text;
        [AppManager sharedDataAccess].strUserPassword = _txtpassword.text;
        [self connectionUserRegister];
    }
}


-(BOOL)validateSingupData
{
    //    it will remove all extra space from left as well as right but not from middle
    NSString* result = [_txtUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    userName = result;

    BOOL isValid = YES;
    NSString *strMsg = @"";
    if (![[AppManager sharedDataAccess] isValidUserName:result]) {
        isValid = NO;
        [self customizeTextFieldForError:_txtUserName];
        strMsg = @"Please Enter a Valid Name. Name can contain only alphabetic charecters.";
    }
    
    else if (![[AppManager sharedDataAccess] validateEmailWithString:_txtEmail.text]) {
        isValid = NO;
        [self customizeTextFieldForError:_txtEmail];
         strMsg = @"Please Enter a valid Email.";
    }
    else if ([_txtpassword.text isEqualToString:@""]) {
        isValid = NO;
        strMsg = @"Please Enter A Valid password.";
        [self customizeTextFieldForError:_txtpassword];
    }
    else if (![_txtpassword.text isEqualToString:_txtConfirmpassword.text ])
    {
        isValid = NO;
        strMsg = @"Confirm Password Mismatch.";
        [self customizeTextFieldForError:_txtConfirmpassword];
    }
    if (strMsg.length > 0) {
         [[AppManager sharedDataAccess] showAlertWithTitle:@"More info needed!" andMessage:strMsg fromViewController:self];
    }
    return isValid;
}


#pragma mark - Webservice

-(void)connectionUserRegister
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

        RPLog(@"response : %@", response);
        NSDictionary *dictData;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dictData = response;
        }
        if ([[dictData objectForKey:@"ErrorCode"]  intValue] == 200 ) {
            RPLog(@"Success : %@", response);
            if ([[dictData objectForKey:@"Result"] objectForKey:@"AuthToken"] != [NSNull null]) {
                [[AppManager sharedDataAccess] showAlertWithTitle:@"Alert!" andMessage:@"Your email id already exists, please login." fromViewController:self];
            }
            else{
                //clear User Login Data
                [self clearLoginData];
                [[AppManager sharedDataAccess] showAlertWithTitle:@"Success" andMessage:[NSString stringWithFormat:@"%@", @"Your account has been created successfully. Please check your email to activate your account"] fromViewController:self];
            }

        }
        else
        {
            [[AppManager sharedDataAccess] showAlertWithTitle:@"Error!" andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"ErrorMessage"]] fromViewController:self];
        }
        ;
    } failure:^(id failureMessage, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        RPLog(@"failureMessage : %@, Error :%@", failureMessage,error.localizedDescription);
    }];
}

-(void)clearLoginData
{
    [RPNetworkManager defaultNetworkManager].loginType = userLoginTypeNone;
    [RPNetworkManager defaultNetworkManager].authType = userAuthTypeNone;
    [[AppManager sharedDataAccess] clearUserLoginData];
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
