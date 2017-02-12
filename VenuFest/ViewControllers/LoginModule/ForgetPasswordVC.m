//
//  ForgetPasswordVC.m
//  RP
//
//  Created by Mac on 31/08/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "ForgetPasswordVC.h"
#import "RPConstants.h"
#import "AppManager.h"
#import "RPNetworkManager.h"
#import "MBProgressHUD.h"


@interface ForgetPasswordVC ()<UITextFieldDelegate>

@end

@implementation ForgetPasswordVC

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
    [self customizeTextField:_txtEmail];
    [self.txtEmail setPlaceholder:@"Login ID"];
    
    self.btnSubmit.backgroundColor = APP_BUTTON_BACKGROUND_COLOR;
    [self.btnSubmit setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnSubmit.tintColor = APP_BUTTON_TEXT_COLOR;

    self.btnSupportEmail.backgroundColor = [UIColor clearColor];
    [self.btnSupportEmail setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];

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
    [self setPlaceHolderColor:textField];
    [self setupLeftViewForTextField:textField];
//    [self addBottomBorderForView:textField withcolor:TEXT_FIELD_PLACEHOLDER_COLOR andHeight:1];
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
    
    imgView.image = [UIImage imageNamed:@"User.png"];
    [imgView sizeToFit];
    
    imgView.center = leftView.center;
    
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
//    [self addBottomBorderForView:textField withcolor:TEXT_FIELD_INPUT_COLOR andHeight:2];
    [self addBottomBorderForView:textField withcolor:TEXT_FIELD_PLACEHOLDER_COLOR andHeight:1];
    
    //animate scroll view .....
    if (textField == _txtEmail)
    {
        [self animateScrollOffsetwithYpos:400 andHeight:160];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
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

-(IBAction)clickedSubmit:(id)sender
{
    self.btnSubmit.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.btnSubmit.userInteractionEnabled = YES;
    });
    
    if (![[AppManager sharedDataAccess] validateEmailWithString:_txtEmail.text]) {
        [self customizeTextFieldForError:_txtEmail];
        [[AppManager sharedDataAccess] showAlertWithTitle:@"Invalid Email !" andMessage:@"Please input a vald email address" fromViewController:self];
    }
    else
    {
        [self connectionRetrivePassword];

    }
    
}

#pragma mark - Webservice

/*
 {
 apitoken =
 "$2y$05$xqg81lxTmy0OSsLW1TzWL.usQ4u43srObJzkId8bQ2iqgxpRLRwjS";
 email = "testsocial5@ouracademia.in";
 }

 */

-(void)connectionRetrivePassword
{
    //Email
    NSDictionary *params = @{ @"apitoken" : @"", @"emailId" : _txtEmail.text};
    NSString *requestTypeMethod =  [[AppManager sharedDataAccess]  getStringForRequestType: POST];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[RPNetworkManager defaultNetworkManager] VFServicewithMethodName:FORGET_USER_PATH withParameters:params andRequestType:requestTypeMethod success:^(id response) {
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
