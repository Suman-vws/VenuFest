//
//  RegistrationVC.h
//  RP
//
//  Created by Mac on 31/08/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutlinedTextField.h"
#import "OutlinedButton.h"

@interface RegistrationVC : UIViewController

@property (strong, nonatomic) NSString *regType;

@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblUserType;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtFullName;
@property (weak, nonatomic) IBOutlet UIView *divFullName;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtAddress;
@property (weak, nonatomic) IBOutlet UIView *divAddress;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtContactNo;
@property (weak, nonatomic) IBOutlet UIView *divContactNo;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtEmail;
@property (weak, nonatomic) IBOutlet UIView *divEmail;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtpassword;
@property (weak, nonatomic) IBOutlet UIView *divPassword;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtConfirmPassword;
@property (weak, nonatomic) IBOutlet UIView *divConfirmPassword;
//buttons
@property (weak, nonatomic) IBOutlet OutlinedButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnAlreadyRegistered;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;


@end
