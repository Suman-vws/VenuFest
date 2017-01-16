//
//  RegisterView.h
//  VenuFest
//
//  Created by Sayan Chatterjee on 01/01/17.
//  Copyright © 2017 Sayan Chatterjee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutlinedTextField.h"
#import "OutlinedButton.h"


@protocol RegisterViewDelegate <NSObject>

-(void)RegisterButtonTappedWithUserData:(NSDictionary *)dictUserData;
-(void)AlreadyHaveanAccount:(UIButton *)sender;

@end


@interface RegisterView : UIView

@property (strong, nonatomic) id<RegisterViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *lblHeader;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtFullName;
@property (weak, nonatomic) IBOutlet UIView *divFullName;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtAddress;
@property (weak, nonatomic) IBOutlet UIView *divAddress;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtContactNo;
@property (weak, nonatomic) IBOutlet UIView *divContactNo;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtEmail;
@property (weak, nonatomic) IBOutlet UIView *divEmail;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtUserName;
@property (weak, nonatomic) IBOutlet UIView *divUserName;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtpassword;
@property (weak, nonatomic) IBOutlet UIView *divPassword;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtConfirmPassword;
@property (weak, nonatomic) IBOutlet UIView *divConfirmPassword;
//buttons
@property (weak, nonatomic) IBOutlet OutlinedButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnAlreadyRegistered;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@end
