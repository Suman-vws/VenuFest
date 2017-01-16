//
//  EditProfileVC.h
//  RP
//
//  Created by Mac on 09/09/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPNetworkManager.h"
#import "RPConstants.h"
#import "OutlinedTextField.h"
//#import "DCKeyValueObjectMapping.h"
//#import "DCParserConfiguration.h"
//#import "DCObjectMapping.h"
#import "MBProgressHUD.h"

@interface EditProfileVC : UIViewController



//Header View
@property (weak, nonatomic) IBOutlet UIView *vwheader;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UIButton *btnback;

//Body
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;


//=================TextFields======================

@property (weak, nonatomic) IBOutlet OutlinedTextField *txtFullName;              //1
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtUserName;              //1
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtAddress;              //1
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtContactNo;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtEmail;              //1

//=================For Gender Selection======================

@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UIImageView *imgVwMale;
@property (weak, nonatomic) IBOutlet UIButton *btnMale;
@property (weak, nonatomic) IBOutlet UIImageView *imgVwFemale;
@property (weak, nonatomic) IBOutlet UIButton *btnFemale;
@property (weak, nonatomic) IBOutlet UIImageView *imgVwOther;
@property (weak, nonatomic) IBOutlet UIButton *btnOther;

//for Save buttons
@property (weak, nonatomic) IBOutlet UIButton *btnUpdateData;
@end
