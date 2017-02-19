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

@interface RegistrationVC ()<UITextFieldDelegate>
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
    
    if ([AppManager sharedDataAccess].socialUser.isSocialSignup) {
        [self getUserSocialSignupData];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

#pragma mark - Initialize Info For Social Registration

-(void)getUserSocialSignupData
{
    if ([AppManager sharedDataAccess].socialUser.userName.length) {
        self.txtFullName.text = [AppManager sharedDataAccess].socialUser.userName;
        self.txtFullName.userInteractionEnabled = NO;
    }
    if ([AppManager sharedDataAccess].socialUser.userEmail.length) {
        self.txtEmail.text = [AppManager sharedDataAccess].socialUser.userEmail;
        self.txtEmail.userInteractionEnabled = NO;
    }
}

#pragma mark - Customize UI

-(void)createCustomizeUI
{
    self.lblHeader.font =   [UIFont fontWithName: APPLICATION_FONT_NAME size:37];
    self.lblHeader.textColor = BODY_TEXT_COLOR_WHITE;
    self.lblUserType.font =   BODY_TEXT_FONT;
    self.lblUserType.textColor = BODY_TEXT_COLOR_WHITE;
    self.lblUserType.text = self.regType;
    
    self.btnRegister.backgroundColor = APP_BUTTON_BACKGROUND_COLOR;
    [self.btnRegister setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnRegister.tintColor = APP_BUTTON_TEXT_COLOR;
    self.btnRegister.titleLabel.font =  APP_BUTTON_TITLE_FONT;
    
    self.btnAlreadyRegistered.backgroundColor = [UIColor clearColor];
    [self.btnAlreadyRegistered setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnAlreadyRegistered.titleLabel.font =  APP_BUTTON_TITLE_FONT_MEDIUM;
    
    self.btnBack.backgroundColor = [UIColor clearColor];
    [self.btnBack setTitleColor:APP_BUTTON_BACKGROUND_COLOR forState:UIControlStateNormal];
    self.btnBack.titleLabel.font =  APP_BUTTON_TITLE_FONT_MEDIUM;
    
    [self customizeTextField:_txtFullName withLeftViewImage:@"user"];
    [self.txtFullName setPlaceholder:@"Name"];
    
    [self customizeTextField:_txtAddress withLeftViewImage:@"address"];
    [self.txtAddress setPlaceholder:@"Address"];
    
    [self customizeTextField:_txtContactNo withLeftViewImage:@"contact"];
    [self.txtContactNo setPlaceholder:@"Contact Number"];
    _txtContactNo.inputAccessoryView = [self customizeAccessoryView];
    
    [self customizeTextField:_txtEmail withLeftViewImage:@"mail"];
    [self.txtEmail setPlaceholder:@"Email Address"];
    
    [self customizeTextField:_txtpassword withLeftViewImage:@"lock"];
    [self.txtpassword setPlaceholder:@"Password"];
    
    [self customizeTextField:_txtConfirmPassword withLeftViewImage:@"lock"];
    [self.txtConfirmPassword setPlaceholder:@"Re-enter password"];
    
}

-(void)setPlaceHolderColor:(UITextField*)txtField
{
    if ([txtField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        txtField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txtField.placeholder attributes:@{NSForegroundColorAttributeName: TEXT_FIELD_PLACEHOLDER_COLOR}];
        txtField.tintColor = TEXT_FIELD_INPUT_COLOR;
    }
}

-(void)customizeTextField:(UITextField *)textField withLeftViewImage:(NSString *)strImage
{
    textField.delegate = self;
    textField.font = APPLICATION_TEXTFIELD_FONT_MEDIUM;
    [self setPlaceHolderColor:textField];
    [self setupLeftViewForTextField:textField withLeftViewImage:strImage];
}

-(void)setupLeftViewForTextField:(UITextField *)textField withLeftViewImage:(NSString *)strImage
{
    UIView *leftView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 32, 20)];
    leftView.backgroundColor = [UIColor clearColor];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView *imgView = [[UIImageView alloc]  initWithFrame:CGRectMake(0, -3, 25, 20)];
    [leftView addSubview:imgView];
    
    imgView.image = [UIImage imageNamed:strImage];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    
//    imgView.center = leftView.center;
    
}

//Tool Bar
-(UIToolbar *)customizeAccessoryView
{
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    buttonDone.tintColor = TOP_BAR_BACKGROUND_COLOR;
    
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    [toolbar sizeToFit];
    
    return toolbar;
}

-(void)doneClicked:(id)sender
{
    [self.view endEditing:YES];
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
    if (textField == _txtFullName)
    {
        [self animateScrollOffsetwithYpos:90 andHeight:350];
    }
    else if (textField == _txtAddress)
    {
        [self animateScrollOffsetwithYpos:140 andHeight:350];
    }
    else if (textField == _txtContactNo)
    {
        [self animateScrollOffsetwithYpos:190 andHeight:350];
    }
    else if (textField == _txtEmail)
    {
        [self animateScrollOffsetwithYpos:240 andHeight:350];
    }
    else if (textField == _txtpassword)
    {
        [self animateScrollOffsetwithYpos:290 andHeight:350];
    }
    else if (textField == _txtConfirmPassword)
    {
        [self animateScrollOffsetwithYpos:340 andHeight:350];
    }

    [self addBottomBorderForView:textField withcolor:TEXT_FIELD_PLACEHOLDER_COLOR andHeight:1];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self addBottomBorderForView:textField withcolor:[UIColor clearColor] andHeight:0];
    if (textField == _txtConfirmPassword) {
        [self animateScrollOffsetwithYpos:0 andHeight:10];
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _txtFullName)
    {
        [_txtAddress becomeFirstResponder];
    }
    else if (textField == _txtAddress)
    {
        [_txtContactNo becomeFirstResponder];
    }
    else if (textField == _txtContactNo)
    {
        [_txtEmail becomeFirstResponder];
    }
    else if (textField == _txtEmail)
    {
        [_txtpassword becomeFirstResponder];
    }
    else if (textField == _txtpassword)
    {
        [_txtConfirmPassword becomeFirstResponder];
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
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.scroll setContentOffset:offset];
                     }
                     completion:^(BOOL finished){
                     }];
    
    _scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.scroll.frame.size.height+ height);
}

#pragma mark - Clicked Events

-(IBAction)clcikedRegisterUser:(UIButton *)sender
{
    self.btnRegister.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.btnRegister.userInteractionEnabled = YES;
    });
    
    if ([self validateSignupData ]) {
        
        NSDictionary *dictUserData = @{@"name" : _txtFullName.text, @"address" : _txtAddress.text, @"contactnumber" : _txtContactNo.text, @"emailaddress" : _txtEmail.text, @"password" : _txtpassword.text};
        [self connectionUserSignupWithDetails:dictUserData];
    }
}

-(IBAction)clickedAlreadyRegister:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}
-(IBAction)clickedback:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - validation Checking

-(BOOL)validateSignupData
{
    //Need To About The mandetory Fields.....
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

#pragma mark - Webservice

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

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
