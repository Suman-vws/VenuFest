//
//  loginView.m
//  VenuFest
//
//  Created by Sayan Chatterjee on 01/01/17.
//  Copyright © 2017 Sayan Chatterjee. All rights reserved.
//

#import "loginView.h"

@interface loginView()<UITextFieldDelegate, UIGestureRecognizerDelegate>

@end

@implementation loginView

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Set default font when init in code
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"loginVIew" owner:self options:nil];
        self = [subviewArray objectAtIndex:0];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    
    return self;
}


- (void)layoutSubviews {

    [super layoutSubviews];
    [self createCustomizeUI];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    RPLog(@"Touch Began");
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];

    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width, self.scroll.frame.size.height+5);
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
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
    self.btnLoginFacebook.titleLabel.font =  APP_BUTTON_TITLE_FONT;

    self.btnLoginGplus.backgroundColor = GPLUS_BUTTON_BACKGROUND_COLOR;
    [self.btnLoginGplus setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnLoginGplus.tintColor = APP_BUTTON_TEXT_COLOR;
    self.btnLoginGplus.titleLabel.font =  APP_BUTTON_TITLE_FONT;
    
//    self.btnRegister.backgroundColor = REGISTER_BUTTON_BACKGROUND_COLOR;
    [self.btnRegister setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnForgetPassword.titleLabel.font =  APP_BUTTON_TITLE_FONT_MEDIUM;

    self.btnForgetPassword.backgroundColor = [UIColor clearColor];
    [self.btnForgetPassword setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnForgetPassword.titleLabel.font =  APP_BUTTON_TITLE_FONT_MEDIUM;

    
    [self customizeTextField:_txtEmail];
    [self.txtEmail setPlaceholder:@"Username"];
    
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
    
    _scroll.contentSize = CGSizeMake(self.frame.size.width, self.scroll.frame.size.height+ height);
}

#pragma mark - Click Event Methods

-(IBAction)GPlusButtonTapped:(id)sender
{
    if([self.delegate respondsToSelector:@selector(socialLoginButtonTappedWithSender:)])
        [self.delegate socialLoginButtonTappedWithSender:sender];
}

-(IBAction)FBButtonTapped:(id)sender
{
    if([self.delegate respondsToSelector:@selector(socialLoginButtonTappedWithSender:)])
        [self.delegate socialLoginButtonTappedWithSender:sender];
}


-(IBAction)LoginButtonTapped:(id)sender
{
    
    self.btnLogin.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.btnLogin.userInteractionEnabled = YES;
    });
    
    if([self.delegate respondsToSelector:@selector(userLoginButtonTappedWithUserName:andPassword:)])
        [self.delegate userLoginButtonTappedWithUserName:_txtEmail.text andPassword:_txtpassword.text];
    
    /*
// =============== Uncomment these line To Check validation =====================
    
    if ([self validateLoginData ]) {
        if([self.delegate respondsToSelector:@selector(userLoginButtonTappedWithUserName:andPassword:)])
            [self.delegate userLoginButtonTappedWithUserName:_txtEmail.text andPassword:_txtpassword.text];
    }
     */
}


-(IBAction)RegisterButtonTapped:(id)sender
{
    if([self.delegate respondsToSelector:@selector(userSignUpButtonTappedWithSender:)])
        [self.delegate userSignUpButtonTappedWithSender:sender];
}

-(IBAction)ForgotPasswordButtonTapped:(id)sender    
{
    if([self.delegate respondsToSelector:@selector(userForgotPasswordButtonTappedWithSender:)])
        [self.delegate userForgotPasswordButtonTappedWithSender:sender];
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
//         [[AppManager sharedDataAccess] showAlertWithTitle:@"Alert!" andMessage:strMsg fromViewController:self];
        NSLog(@"Validation Error");
    }
    return isValid;
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



@end






