//
//  ChangePasswordView.m
//  VenuFest
//
//  Created by Sayan Chatterjee on 06/01/17.
//  Copyright © 2017 Sayan Chatterjee. All rights reserved.
//

#import "ChangePasswordView.h"

@interface ChangePasswordView()<UITextFieldDelegate>

@end

@implementation ChangePasswordView


#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Set default font when init in code
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"ChangePassword" owner:self options:nil];
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


#pragma mark - Customize UI

-(void)createCustomizeUI
{
    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width, self.scroll.frame.size.height+10);
    
    self.btnChangePassword.backgroundColor = APP_BUTTON_BACKGROUND_COLOR;
    [self.btnChangePassword setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnChangePassword.tintColor = APP_BUTTON_TEXT_COLOR;
    self.btnChangePassword.titleLabel.font =  APP_BUTTON_TITLE_FONT;
    
    [self customizeTextField:self.txtCurrentPassword];
    [self.txtCurrentPassword setPlaceholder:@"Old Password"];
    
    [self customizeTextField:self.txtNewPassword];
    [self.txtNewPassword setPlaceholder:@"New Password"];
    
    [self customizeTextField:self.txtConfirmPassword];
    [self.txtConfirmPassword setPlaceholder:@"Re-enter Password"];
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
    if (textField == _txtCurrentPassword)
    {
        if ([self.passwordDelgate respondsToSelector:@selector(animateScrollViewWithYpos:andHeight:)]) {
            [self.passwordDelgate animateScrollViewWithYpos:160 andHeight:300];
        }
    }
    else if (textField == _txtNewPassword)
    {
        if ([self.passwordDelgate respondsToSelector:@selector(animateScrollViewWithYpos:andHeight:)]) {
            [self.passwordDelgate animateScrollViewWithYpos:200 andHeight:300];
        }
    }
    else if (textField == _txtConfirmPassword)
    {
        if ([self.passwordDelgate respondsToSelector:@selector(animateScrollViewWithYpos:andHeight:)]) {
            [self.passwordDelgate animateScrollViewWithYpos:240 andHeight:300];
        }
    }
    
    [self addBottomBorderForView:_txtConfirmPassword withcolor:TEXT_FIELD_PLACEHOLDER_COLOR andHeight:1];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self addBottomBorderForView:textField withcolor:[UIColor clearColor] andHeight:0];
    if ([self.passwordDelgate respondsToSelector:@selector(animateScrollViewWithYpos:andHeight:)]) {
        [self.passwordDelgate animateScrollViewWithYpos:0 andHeight:0];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.txtCurrentPassword]) {
        [_txtCurrentPassword resignFirstResponder];
        [_txtNewPassword becomeFirstResponder];
    }
    
    else if ([textField isEqual:self.txtNewPassword]) {
        [_txtNewPassword resignFirstResponder];
        [_txtConfirmPassword becomeFirstResponder];
    }
    
    else
        [textField resignFirstResponder];
    return  YES;
}

#pragma mark - validation Checking

-(BOOL)validatePassword
{
    
    BOOL isValid = YES;
    NSString *strMsg = @"";
    if ([[AppManager sharedDataAccess] isEmptyString:_txtCurrentPassword.text]) {
        
        isValid = NO;
        strMsg = @"Please enter Current Password.";
        [self customizeTextFieldForError:_txtCurrentPassword];
        [self animateFrameTextFieldFrame:_txtCurrentPassword];
    }
    else if ([[AppManager sharedDataAccess] isEmptyString:_txtNewPassword.text]) {
        
        isValid = NO;
        strMsg = @"Please enter New Password.";
        [self customizeTextFieldForError:_txtNewPassword];
        [self animateFrameTextFieldFrame:_txtNewPassword];
    }
    else if (![_txtNewPassword.text isEqualToString:_txtConfirmPassword.text]) {

        isValid = NO;
        strMsg = @"Confirm password is not matching with Password.";
        [self customizeTextFieldForError:_txtConfirmPassword];
        [self animateFrameTextFieldFrame:_txtConfirmPassword];
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

#pragma mark - Click Events

- (IBAction)clickChangePassword:(id)sender {
    
    if([self validatePassword]){
        
        NSDictionary *dictPasswordData = @{@"old_password" : _txtCurrentPassword.text, @"new_password" : _txtNewPassword.text };
        
        if ([self.passwordDelgate respondsToSelector:@selector(userPasswordChangedWithData:)] && dictPasswordData) {
            [self.passwordDelgate userPasswordChangedWithData:dictPasswordData];
        }
    }
}

@end
