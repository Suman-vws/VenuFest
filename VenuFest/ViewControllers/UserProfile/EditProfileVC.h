//
//  EditProfileVC.h
//  RP
//
//  Created by Mac on 09/09/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RunnerUser.h"
#import "RPNetworkManager.h"
#import "RPConstants.h"
#import "OutlinedTextField.h"
#import "DCKeyValueObjectMapping.h"
#import "DCParserConfiguration.h"
#import "DCObjectMapping.h"
#import "MBProgressHUD.h"

@interface EditProfileVC : UIViewController

//@property (weak, nonatomic) IBOutlet UITableView *tableEditProfile;
@property (nonatomic, strong) RunnerUser *user;

@property (assign) BOOL isPresentModal;

//Header View
@property (weak, nonatomic) IBOutlet UIView *vwheader;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UIButton *btnback;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;

//Body
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIImageView *imgVwBG;


//=================TextFields======================

@property (weak, nonatomic) IBOutlet OutlinedTextField *txtName;              //1
//Email
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtPhoneNo;
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtCity;
               //13
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtHeight;                 //6
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtWeight;                 //7
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtAge;                    //8
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtAboutMe;                //12

//=================For Gender Selection======================

//@property (weak, nonatomic) IBOutlet OutlinedTextField *txtGender;                 //13
//@property (weak, nonatomic) IBOutlet UIButton *btnGender;

@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UIImageView *imgVwMale;
@property (weak, nonatomic) IBOutlet UIButton *btnMale;
@property (weak, nonatomic) IBOutlet UIImageView *imgVwFemale;
@property (weak, nonatomic) IBOutlet UIButton *btnFemale;
@property (weak, nonatomic) IBOutlet UIImageView *imgVwOther;
@property (weak, nonatomic) IBOutlet UIButton *btnOther;

/*
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtFirstName;              //1
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtLastName;               //2
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtStreeetAddress1;        //3
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtStreeetAddress2;        //4
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtCountry;                //9
@property (weak, nonatomic) IBOutlet OutlinedTextField *txtState;                  //10

*/

//for Save buttons
@property (weak, nonatomic) IBOutlet UIButton *btnUpdateData;
@end
