//
//  ForgetPasswordVC.h
//  RP
//
//  Created by Mac on 31/08/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OutlinedButton.h"
#import "OutlinedTextField.h"

@interface ForgetPasswordVC : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnback;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblPageTagLine;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtEmail;
@property (weak, nonatomic) IBOutlet UIView *divEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblSupport;
@property (weak, nonatomic) IBOutlet UIButton *btnSupportEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;


@end
