//
//  RegistrationVC.h
//  RP
//
//  Created by Mac on 31/08/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutlinedTextField.h"


@interface RegistrationVC : UIViewController

//Header View
@property (weak, nonatomic) IBOutlet UIView *vwheader;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UIButton *btnback;

@property (weak, nonatomic) IBOutlet UILabel *lblPageTagLine;


@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtUserName;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtEmail;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtpassword;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtConfirmpassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

//FooterView
@property (weak, nonatomic) IBOutlet UIView *vwfooter;
@property (weak, nonatomic) IBOutlet UILabel *lblFooter;

@end
