//
//  EditProfileVC.m
//  RP
//
//  Created by Mac on 09/09/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "EditProfileVC.h"
#import "RPConstants.h"
#import "AppManager.h"

@interface EditProfileVC ()<UITextFieldDelegate>

{
    UITextField *activeTextfield;
}

@property (assign) genderType userGenderType;
@end

@implementation EditProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createCustomizeUI];
    [self setupDataForTextFields];
    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width, self.view.frame.size.height+ 350);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}


#pragma mark - Set Up Initial Data

-(void)setupDataForTextFields
{

//    if (_user.FirstName)
//        _txtName.text = _user.FirstName;
//    else
//        _txtName.text = @"";
   
    //setup the gender values from Initial User Data
    self.userGenderType = 0;
    [self.imgVwMale setImage:[UIImage imageNamed:@"circleblack.png"]];
    [self.imgVwFemale setImage:[UIImage imageNamed:@"circleblack.png"]];
    [self.imgVwOther setImage:[UIImage imageNamed:@"circleblack.png"]];
    
    if (self.userGenderType == userGenderTypeFemale) {
        [self.imgVwFemale setImage:[UIImage imageNamed:@"circlegreen.png"]];
    }
    else if (self.userGenderType == userGenderTypeMale) {
        [self.imgVwMale setImage:[UIImage imageNamed:@"circlegreen.png"]];
    }
    else if (self.userGenderType == userGenderTypeOther) {
        [self.imgVwOther setImage:[UIImage imageNamed:@"circlegreen.png"]];
    }
}


#pragma mark - Customize UI

-(void)createCustomizeUI
{
       
    self.vwheader.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
    self.lblHeader.text = @"Edit Profile";
    self.lblHeader.font = TOP_BAR_TITLE_FONT;
    self.lblHeader.textColor = TOP_BAR_TEXT_COLOR;

    //textfields
    [self customizeTextField:_txtFullName];
    [self.txtFullName setPlaceholder:@"Full Name"];

    [self customizeTextField:_txtUserName];
    [self.txtUserName setPlaceholder:@"Username"];

    [self customizeTextField:_txtAddress];
    [self.txtAddress setPlaceholder:@"Address"];
    
    [self customizeTextField:_txtContactNo];
    [self.txtContactNo setPlaceholder:@"Contact Number"];

    [self customizeTextField:_txtEmail];
    [self.txtEmail setPlaceholder:@"Email Address"];

    
    //=================For Gender Selection======================

    self.lblGender.textColor = TEXT_FIELD_INPUT_COLOR;
    self.lblGender.font = APP_BUTTON_TITLE_FONT;

    self.btnMale.backgroundColor = [UIColor clearColor];
    self.btnMale.tag = 1;
    [self.btnMale setTitleColor:TEXT_FIELD_INPUT_COLOR forState:UIControlStateNormal];
//    self.btnMale.titleLabel.font = APP_BUTTON_TITLE_FONT_MEDIUM;
    [self.btnMale setTitle:@"Male" forState:UIControlStateNormal];
    
    self.btnFemale.backgroundColor = [UIColor clearColor];
    self.btnFemale.tag = 2;
    [self.btnFemale setTitleColor:TEXT_FIELD_INPUT_COLOR forState:UIControlStateNormal];
//    self.btnFemale.titleLabel.font = APP_BUTTON_TITLE_FONT_MEDIUM;
    [self.btnFemale setTitle:@"Female" forState:UIControlStateNormal];
    
    self.btnOther.backgroundColor = [UIColor clearColor];
    self.btnOther.tag = 3;
    [self.btnOther setTitleColor:TEXT_FIELD_INPUT_COLOR forState:UIControlStateNormal];
//    self.btnOther.titleLabel.font = APP_BUTTON_TITLE_FONT_MEDIUM;
    [self.btnOther setTitle:@"Other" forState:UIControlStateNormal];
    
    
    [self.imgVwMale setImage:[UIImage imageNamed:@"circleblack.png"]];
    [self.imgVwFemale setImage:[UIImage imageNamed:@"circleblack.png"]];
    [self.imgVwOther setImage:[UIImage imageNamed:@"circleblack.png"]];

    //vuttons
    _btnUpdateData.backgroundColor = APP_BUTTON_BACKGROUND_COLOR;
    _btnUpdateData.titleLabel.textColor =  APP_BUTTON_TEXT_COLOR;
//    _btnUpdateData.titleLabel.font = APP_BUTTON_TITLE_FONT_MEDIUM;
    [_btnUpdateData setTitle:@"UPDATE" forState:UIControlStateNormal];
    _btnUpdateData.tintColor = APP_BUTTON_TEXT_COLOR;

}


-(void)customizeTextField:(UITextField *)textField
{
//    textField.font = APPLICATION_TEXTFIELD_FONT;
    
    [self setupPaddingView:textField];
    [self setPlaceHolderColor:textField];
}

// =========== text field AccessoryView Tool Bar ==============

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

// =========== text field AccessoryView End ==============


-(void)setupPaddingView:(UITextField *)textField
{
    UIView *leftView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 8, 20)];
    leftView.backgroundColor = [UIColor clearColor];
    if (!textField.leftView) {
        textField.leftView = leftView;
    }
    textField.leftViewMode = UITextFieldViewModeAlways;
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

-(void)setPlaceHolderColor:(UITextField*)txtField
{
    if ([txtField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        txtField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:txtField.placeholder attributes:@{NSForegroundColorAttributeName: TEXT_FIELD_PLACEHOLDER_COLOR}];
        txtField.tintColor = TEXT_FIELD_INPUT_COLOR;
    }
}

#pragma mark - TextField Delegate Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self addBottomBorderForView:textField withcolor:TEXT_FIELD_PLACEHOLDER_COLOR andHeight:1];
    
    if (textField == self.txtFullName){
        activeTextfield = textField;
        [self animateScrollOffsetwithYpos:0 andHeight:320];
    }
    else if (textField == self.txtUserName){
        activeTextfield = textField;
        [self animateScrollOffsetwithYpos:60 andHeight:320];
    }
    else if (textField == self.txtAddress){
        activeTextfield = textField;
        [self animateScrollOffsetwithYpos:120 andHeight:320];
    }
    else if (textField == self.txtContactNo){
        activeTextfield = textField;
        [self animateScrollOffsetwithYpos:180 andHeight:320];
    }
    else if (textField == self.txtEmail){
        activeTextfield = textField;
        [self animateScrollOffsetwithYpos:240 andHeight:320];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self addBottomBorderForView:textField withcolor:TEXT_FIELD_PLACEHOLDER_COLOR andHeight:0];
    [self animateScrollOffsetwithYpos:0 andHeight:350];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

#pragma mark - Helpers

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
    
    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width, self.view.frame.size.height+ height);
}

#pragma mark - Click Events

-(IBAction)clickedGender:(UIButton*)sender
{
    [self.imgVwMale setImage:[UIImage imageNamed:@"circleblack.png"]];
    [self.imgVwFemale setImage:[UIImage imageNamed:@"circleblack.png"]];
    [self.imgVwOther setImage:[UIImage imageNamed:@"circleblack.png"]];
    
    switch (sender.tag) {
        case 1:
            [self.imgVwMale setImage:[UIImage imageNamed:@"circlegreen.png"]];
            self.userGenderType = userGenderTypeMale;
            break;
        case 2:
            [self.imgVwFemale setImage:[UIImage imageNamed:@"circlegreen.png"]];
            self.userGenderType = userGenderTypeFemale;
            break;
        case 3:
            [self.imgVwOther setImage:[UIImage imageNamed:@"circlegreen.png"]];
            self.userGenderType = userGenderTypeOther;
            break;
        default:
            break;
    }
    
}

-(IBAction)clickedSaveData:(id)sender
{
    RPLog(@"User Profile Update  Data");
    if ([self validateUserProfileData]) {
        [self connectionUpdateUser];
    }
}


-(IBAction)clickedBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)clickedClose:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Validate Profile Data
-(BOOL) validateUserProfileData
{
    BOOL isValid = YES;
   
    return isValid;
}

#pragma mark - Webservice

/*
 
 {
 apitoken = "$2y$05$hrnlzrIV1fPkrVB7qBlH8e4NmNpFn7khR6GBkJY5QHd4NNSCHZVY.";
 address = "Kolkata";
 mobile = 923459895;
 fname = MD;
 lname = Aftab;
 userid = 6;
 }
 
 */

-(void)connectionUpdateUser
{
    NSDictionary *dictParam = @{@"apitoken" :@"", @"address" : @"kolkata", @"mobile" : @"9432569874" , @"fname" :@"demo", @"lname" : @"user", @"userid" :@"10"};
    NSString *requestTypeMethod =   [[AppManager sharedDataAccess]  getStringForRequestType: PUT];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[RPNetworkManager defaultNetworkManager] VFServicewithMethodName:UPDATE_USER_PROFILE_PATH withParameters:dictParam andRequestType:requestTypeMethod success:^(id response) {
        
        NSDictionary *dictData;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dictData = response;
        }
        if ([[dictData objectForKey:@"ErrorCode"]  intValue] == 200 ) {
            
            [self showAlertWithTitle:@"Success" andMessage:@"Your Profile has been succesfully updated." fromViewController:self];
        }
        else
        {
            [[AppManager sharedDataAccess] showAlertWithTitle:@"Warning!" andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"ErrorMessage"]] fromViewController:self];
        }
        
    } failure:^(id failureMessage, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        RPLog(@"Error : %@", error.localizedDescription);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [super viewWillDisappear:YES];
}


-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message fromViewController:(UIViewController *)vc{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       [self.navigationController popViewControllerAnimated:YES];
                                   }];
    
    
    [alertController addAction:cancelAction];
    alertController.view.tintColor = [UIColor redColor];
    [vc presentViewController: alertController animated:YES completion:nil];
    
}

@end
