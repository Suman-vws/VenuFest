//
//  LandingVC.m
//  RP
//
//  Created by Mac on 12/10/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "LandingVC.h"
#import "RPConstants.h"
#import "RPNetworkManager.h"
#import "AppManager.h"
#import "AppDelegate.h"

@interface LandingVC ()
{
    AppDelegate *appDelegate;
}

@end

@implementation LandingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createCustomizeUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UserSocialLoginNotification) name:USER_DID_LOGGED_IN_NOTIFICATION object:nil];   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    appDelegate = [UIApplication sharedApplication].delegate;

    if ([AppManager sharedDataAccess].IsLoggedIn) {
//        appDelegate.userLoggedIN = YES;
        [self performSegueWithIdentifier:@"LOGIN" sender:self];
    }
}

#pragma mark - Customize UI

-(void)createCustomizeUI
{
    self.vwRPLogin.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
    self.vwFBLogin.backgroundColor = FB_BUTTON_BACKGROUND_COLOR;
    
    
    self.btnRPLogin.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
    [self.btnRPLogin setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnRPLogin.tintColor = APP_BUTTON_TEXT_COLOR;
//    self.btnRPLogin.titleLabel.font =  APP_BUTTON_TITLE_FONT_MEDIUM;
//    self.btnRPLogin.titleLabel.adjustsFontSizeToFitWidth = YES;
//    self.btnRPLogin.titleLabel.lineBreakMode = NSLineBreakByClipping;
    
    self.btnFBLogin.backgroundColor = FB_BUTTON_BACKGROUND_COLOR;
    [self.btnFBLogin setTitleColor:APP_BUTTON_TEXT_COLOR forState:UIControlStateNormal];
    self.btnFBLogin.tintColor = APP_BUTTON_TEXT_COLOR;
//    self.btnFBLogin.titleLabel.font =  APP_BUTTON_TITLE_FONT_MEDIUM;

    
    self.btnRegister.backgroundColor = [UIColor clearColor];
    self.btnRegister.tintColor = [UIColor clearColor];
    [self.btnRegister setTitleColor:APP_BUTTON_GREY_TEXT_COLOR forState:UIControlStateNormal];
//    self.btnRegister.titleLabel.font =  APP_BUTTON_TITLE_FONT_MEDIUM;
    
    self.lblDiv.backgroundColor = APP_BUTTON_BACKGROUND_COLOR;
    
    self.vwfooter.backgroundColor = BOTTOM_BAR_BACKGROUND_COLOR;
    self.lblFooter.text = @"All rights reserved © FITOFY FITNESS SOLUTIONS PVT LTD.";
    
    UITapGestureRecognizer *tapProfile= [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(clickedFooterView)];
    tapProfile.numberOfTapsRequired = 1;
    [self.vwfooter addGestureRecognizer:tapProfile];
    
}




#pragma mark - Clicked Events

-(IBAction)clickedRPLogin:(id)sender
{
    UIStoryboard *stroryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [stroryBoard instantiateViewControllerWithIdentifier:@"LoginVC"];
    [self.navigationController pushViewController:vc animated:YES];

}

-(IBAction)clickedRegister:(id)sender
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(IBAction)clickedFBLogin:(id)sender
{
    [RPNetworkManager defaultNetworkManager].authType = userAuthTypeLogin;
    [RPNetworkManager defaultNetworkManager].loginType = userLoginTypeFacebook;
    
    [[RPNetworkManager defaultNetworkManager] loginWithFbFromViewController:self];
}

-(void)UserSocialLoginNotification
{
    [self connectionUserLogin];
}


#pragma mark - Webservice

-(void)connectionUserLogin
{
    int loginType = [RPNetworkManager defaultNetworkManager].loginType;
    int authType = [RPNetworkManager defaultNetworkManager].authType;
    NSString *imageURL = [AppManager sharedDataAccess].strSocialImageURL;
    NSString *socialId = [AppManager sharedDataAccess].strSocialLoginID;
    NSString *userName = [AppManager sharedDataAccess].strUserName;
    
    NSDictionary *params = @{@"LoginType" :[NSNumber numberWithInt:loginType], @"UserName" : userName, @"Email" : [AppManager sharedDataAccess].strUserEmailId, @"Password" :[AppManager sharedDataAccess].strUserPassword, @"SocialLoginId" : socialId, @"AuthenticationType" :[NSNumber numberWithInt:authType], @"SocialImageUrl" : imageURL};
    
    NSString *requestTypeMethod =   [[AppManager sharedDataAccess]  getStringForRequestType: POST];
    
    [[RPNetworkManager defaultNetworkManager] RPSignUpwithParameters:params andRequestType:requestTypeMethod success:^(id response) {
        NSDictionary *dictData;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dictData = response;
        }
        if ([[dictData objectForKey:@"ErrorCode"]  intValue] == 200 ) {
            RPLog(@"Success : %@", response);
            //storing auth token
            NSString *authKey = [[dictData objectForKey:@"Result"] objectForKey:@"AuthToken"];
            [[NSUserDefaults standardUserDefaults] setObject:authKey forKey:@"AuthToken"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [RPNetworkManager defaultNetworkManager].authType = userAuthTypeLogin;
            [RPNetworkManager defaultNetworkManager].loginType = userLoginTypeFacebook;

            [AppManager sharedDataAccess].IsLoggedIn = YES;
//            [self gotoHome:YES];
            /*
            if ([AppManager sharedDataAccess].IsLoggedIn) {
                appDelegate.userLoggedIN = YES;
                [self performSegueWithIdentifier:@"LOGIN" sender:self];
            }
            */
        }
        else if ([[dictData objectForKey:@"ErrorCode"]  intValue] == 403 )
        {
            if ([RPNetworkManager defaultNetworkManager].loginType == userLoginTypeGPlus || [RPNetworkManager defaultNetworkManager].loginType == userLoginTypeFacebook) {
                [RPNetworkManager defaultNetworkManager].authType = userAuthTypeRegistration;
                [self connectionUserLogin];
            }
            else
                [[AppManager sharedDataAccess] showAlertWithTitle:@"Warning!" andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"ErrorMessage"]] fromViewController:self];
        }
        else
        {
            [[AppManager sharedDataAccess] showAlertWithTitle:@"Warning!" andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"ErrorMessage"]] fromViewController:self];
        }
        ;
    } failure:^(id failureMessage, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        RPLog(@"Error : %@", error.localizedDescription);
    }];
}

/*
-(void)gotoHome:(BOOL)animation{
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    if(viewControllers.count > 0)
    {
        BOOL isPop = NO;
        UIViewController *viewController = [viewControllers objectAtIndex:viewControllers.count-1];
        if([viewController isKindOfClass:[HomeVC class]])
        {
            isPop = YES;
            
            return;
        }
        for (UIViewController *controller in viewControllers) {
            if([controller isKindOfClass:[HomeVC class]])
            {
                isPop = YES;
                [self.navigationController popViewControllerAnimated:NO];
                //                [self goBackToView:controller withAnimation:animation];
                break;
            }
        }
        if(!isPop)
        {
            HomeVC *loginVC = [[HomeVC alloc] initWithNibName:@"HomeVC" bundle:nil];
            [self.navigationController pushViewController:loginVC animated:animation];
        }
        
    }
    else
    {
        HomeVC *loginVC = [[HomeVC alloc] initWithNibName:@"HomeVC" bundle:nil];
        [self.navigationController pushViewController:loginVC animated:animation];
    }
    
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
