//
//  RPNetworkManager.m
//  RP
//
//  Created by Mac on 29/08/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import "AFNetworking.h"
#import "RPNetworkManager.h"
#import "AppManager.h"
//#import "DCKeyValueObjectMapping.h"
#import "MBProgressHUD.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>



#define REQUEST_TIMEOUT_THRESOLD 241

@interface RPNetworkManager  ()<GPPSignInDelegate>

@property (nonatomic, strong) NSURL *requestURL;
@property (nonatomic, assign) NSInteger lastResponseStatusCode;
@property (nonatomic, strong) id lastResponseObject;
@property (nonatomic, strong) NSError *lastError;

@property (nonatomic, strong) NSString *methodName;
@property (nonatomic, strong) NSString *methodType;
@property (nonatomic, strong) NSDictionary *methodPramas;

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) UIViewController *targetVC;


@property (nonatomic, strong)  GPPSignIn *gppClient;
@property (nonatomic, strong) FBSDKLoginManager *fbClient;

@end

@implementation RPNetworkManager

- (id) init {
    if ( (self = [super init]) ) {
        // Initialization code here.
       /*
        NSNumber *loginType = [[NSUserDefaults standardUserDefaults]  objectForKey:@"userLoginType"];
        if (loginType)
            self.loginType = [loginType intValue];
        else
            self.loginType = userLoginTypeNone;

        
        NSNumber *authType = [[NSUserDefaults standardUserDefaults]  objectForKey:@"userAuthType"];
        if (authType)
            self.loginType = [authType intValue];
        else
            self.authType = userAuthTypeNone;
        */
    }
    return self;
}

+ (instancetype) defaultNetworkManager{
    
    return SHARED_INSTANCE([[self alloc] init]);
}


#pragma mark - Private Methods

- (void) createRequestURLFromBaseURLString:(NSString *) baseURLString andQueryPath:(NSString *) path{
    NSString *requestURLString = baseURLString;
    requestURLString = [baseURLString stringByAppendingString:path];
    self.requestURL = [NSURL URLWithString:requestURLString];
}

- (void) resetCache{
    self.lastError = nil;
    self.lastResponseObject = nil;
    self.lastResponseStatusCode = NSIntegerMax;
    self.requestURL = nil;
    self.methodName = nil;
    self.methodType = nil;
    self.methodPramas = nil;
    
}


#pragma mark - Social Login Properties

//google plus
- (GPPSignIn *) gppClient{
    if (!_gppClient) {
        _gppClient = [GPPSignIn sharedInstance];
        _gppClient.shouldFetchGooglePlusUser = YES;
        _gppClient.shouldFetchGoogleUserEmail = YES;
        _gppClient.shouldFetchGoogleUserID = YES;
        _gppClient.clientID = GOOGLE_PLUS_API_CLIENT_ID;
        // Uncomment one of these two statements for the scope you chose in the previous step
        _gppClient.scopes = @[ kGTLAuthScopePlusLogin ];
        // "https://www.googleapis.com/auth/plus.login" scope
        //signIn.scopes = @[ @"profile" ];            // "profile" scope
        // Optional: declare signIn.actions, see "app activities"
        _gppClient.delegate = self;
    }
    return _gppClient;
}

//Facebook
- (FBSDKLoginManager *) fbClient{
    if (!_fbClient) {
        _fbClient = [[FBSDKLoginManager alloc] init];
    }
    return _fbClient;
}

#pragma mark - LoadingIndicator

- (void)showLoadingIndicatorInView:(UIView *)view{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)hideLoadingIndicatorInView:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - Google+

- (void) loginUsingGooglePlusInViewController:(UIViewController *)vc loginHandler:(void(^)(id ))result{
    self.targetVC = vc;
    [self showLoadingIndicatorInView:vc.view];
    [self.gppClient authenticate];
    NSLog(@"result %@", result);
    
}

#pragma mark - GPPSignInDelegate

- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error {
    
    __weak typeof(self) weakSelf = self;
    if (error) {
        RPLog(@"Google Plus Sign in Error : %@", error.debugDescription);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideLoadingIndicatorInView:weakSelf.targetVC.view];
            weakSelf.targetVC = nil;
        });
    }
    else {
        [weakSelf hideLoadingIndicatorInView:weakSelf.targetVC.view];

        if ([GPPSignIn sharedInstance].authentication == nil) {
            RPLog(@"Google Plus Sign in Error : %@", error.debugDescription);
        }
        else {
            // The googlePlusUser member will be populated only if the appropriate
            // scope is set when signing in.
            GTLPlusPerson *person = [GPPSignIn sharedInstance].googlePlusUser;
            if (person == nil) {
                RPLog(@"Google Plus Sign in Error : %@", error.debugDescription);
            }
            else {
                RPLog(@"Name: %@ EmailId: %@",person.displayName,[GPPSignIn sharedInstance].userEmail);
                NSString *strName = person.displayName;
                NSString *strUserEmail = [GPPSignIn sharedInstance].userEmail;
                NSString *strUserId = [GPPSignIn sharedInstance].userID;
                NSString *strProfileImgUrl = person.image.url;
                
                //Save Data For User
                [AppManager sharedDataAccess].strUserEmailId = strUserEmail;
                [AppManager sharedDataAccess].strSocialLoginID = strUserId;
                [AppManager sharedDataAccess].strSocialImageURL = strProfileImgUrl;
                [AppManager sharedDataAccess].strUserImagePath = strProfileImgUrl;
                [AppManager sharedDataAccess].strUserName = strName;
                
                [weakSelf hideLoadingIndicatorInView:weakSelf.targetVC.view];
                [weakSelf callNotification];
                [[GPPSignIn sharedInstance] signOut];
                
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideLoadingIndicatorInView:weakSelf.targetVC.view];
            weakSelf.targetVC = nil;
        });
    }
}


#pragma mark - FaceBook

- (void)loginWithFbFromViewController:(UIViewController *)vc{
    
    self.targetVC = vc;
    __weak typeof(self) weakSelf = self;
    [self showLoadingIndicatorInView:self.targetVC.view];
    
    [self.fbClient logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"] fromViewController:self.targetVC handler:^(FBSDKLoginManagerLoginResult*result, NSError *error) {
        if (error) {
            // Process error
            NSLog(@"Process error");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideLoadingIndicatorInView:weakSelf.targetVC.view];
                weakSelf.targetVC = nil;
            });
        }
        else if (result.isCancelled) {
            // Handle cancellations
            NSLog(@"Cancelled");
            // Handle cancellations
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideLoadingIndicatorInView:weakSelf.targetVC.view];
                weakSelf.targetVC = nil;
            });
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if ([result.grantedPermissions containsObject:@"email"]) {
                // Do work
                NSLog(@"login");
                [self getFacebookProfileInfos];
            }
        }
    }];
}


-(void)getFacebookProfileInfos {
    
    __weak typeof(self) weakSelf = self;
    
    FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, picture.type(large), email, name, id, gender"}];
    FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
    [connection addRequest:requestMe completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if(result) {
            [self hideLoadingIndicatorInView:weakSelf.targetVC.view];

            if ([result objectForKey:@"id"]) {
                NSLog(@"Social Id: %@",[result objectForKey:@"id"]);
                
                if ([result objectForKey:@"first_name"]) {
                    NSLog(@"First Name : %@",[result objectForKey:@"first_name"]);
                }
                if ([result objectForKey:@"email"]) {
                    NSLog(@"User Email : %@",[result objectForKey:@"email"]);
                }
                
                NSString *strFirstName = [result objectForKey:@"first_name"];
                NSString *strLastName = [result objectForKey:@"last_name"];
                NSString *strName = [result objectForKey:@"name"];
                NSString *strEmail = [result objectForKey:@"email"];
                NSString *strUserId = [result objectForKey:@"id"];
                NSString *strProfileImgUrl = [[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"];
                
                //Save Data For User
                [AppManager sharedDataAccess].strUserName = strName;
                [AppManager sharedDataAccess].strUserEmailId = strEmail;
                [AppManager sharedDataAccess].strSocialLoginID = strUserId;
                [AppManager sharedDataAccess].strSocialImageURL = strProfileImgUrl;
                [AppManager sharedDataAccess].strUserImagePath = strProfileImgUrl;

                [weakSelf callNotification];
                [weakSelf.fbClient logOut];
                
            }
            else {
                // Handle cancellations
                [weakSelf.fbClient logOut];
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.targetVC = nil;
                    [[AppManager sharedDataAccess] showAlertWithTitle:@"Warning!" andMessage:@"Sorry! we couldn't connect to your account. The reason may be you haven't verified your facebook account Email Id."];
                });
            }
        }
    }];
    [connection start];
}

- (void)callNotification{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:USER_DID_LOGGED_IN_NOTIFICATION object:nil];
}

#pragma mark - Network Connection Calling API

- (void)VFServicewithMethodName:(NSString *)methodName withParameters:(NSDictionary *)params andRequestType:(NSString *)requestType success:(RPNetworkManagerSuccessBlock)success failure:(RPNetworkManagerFailureBlock) failure{
    
    [self resetCache];
    [self createRequestURLFromBaseURLString:VENU_FEST_BASE_URL andQueryPath:methodName];
    __weak typeof(self) weakSelf = self;
    
    //get the Params & Method Name
    self.methodName = methodName;
    self.methodType = requestType;
    if (params && ![requestType isEqualToString:@"GET"]) {
        self.methodPramas = params;
    }
    
    
    self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.requestURL];
    [self.manager.requestSerializer setTimeoutInterval:REQUEST_TIMEOUT_THRESOLD];
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //insert value for Auth-token
    /*
    NSString *authKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"AuthToken"];

    NSDictionary *headers = @ {@"S-Api-Key" :VENU_FEST_API_KEY, @"S-Auth-Token" :authKey};
    
    for (NSString *key in [headers allKeys]) {
        [self.manager.requestSerializer setValue:[headers valueForKey:key] forHTTPHeaderField:key];
    }
    */
    
    NSMutableURLRequest *request;
    if (params && ![requestType isEqualToString:@"GET"]) {
       request = [self.manager.requestSerializer requestWithMethod:requestType URLString:[[NSURL URLWithString:[self.requestURL absoluteString] relativeToURL:_manager.baseURL] absoluteString] parameters:params error:nil];
    }
    else
        request = [self.manager.requestSerializer requestWithMethod:requestType URLString:[[NSURL URLWithString:[self.requestURL absoluteString] relativeToURL:_manager.baseURL] absoluteString] parameters:nil error:nil];

    
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            weakSelf.lastError = error;
            weakSelf.lastResponseObject = response;
            
            NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse *) response;
            weakSelf.lastResponseStatusCode = httpresponse.statusCode;
            failure([NSString stringWithFormat:@"Operation failed with Status Code : %ld", (long)self.lastResponseStatusCode ], error);
            
        }
        else
        {
            //TODO: HANDLE SUCCESS & if any error
            NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse *) response;
            weakSelf.lastResponseStatusCode = httpresponse.statusCode;
            
            weakSelf.lastResponseObject = responseObject;
            success(responseObject);        }
    }];
    
    [dataTask resume];
    
}


#pragma mark - Auto Login

/*
 
-(void) connectionAuth:(authCompletion)completion;
 {
     [self createRequestURLFromBaseURLString:RP_BASE_URL andQueryPath:USER_REGISTRATION_AND_LOGIN_PATH];

     self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self.requestURL absoluteString]]];
     self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
     
     NSString *name =  [AppManager sharedDataAccess].strUserName;
     NSString *email = [AppManager sharedDataAccess].strUserEmailId;
     NSString *password = [AppManager sharedDataAccess].strUserPassword;
     NSString *socialID = [AppManager sharedDataAccess].strSocialLoginID;
     NSString *socialImageURL = [AppManager sharedDataAccess].strSocialImageURL;
     
     NSDictionary *params = @ {@"LoginType" : [NSNumber numberWithInt:self.loginType], @"UserName" : name, @"Email" :email, @"Password" : password, @"SocialLoginId" : socialID != nil ? socialID : @"", @"AuthenticationType" : [NSNumber numberWithInt:self.authType], @"SocialImageUrl" : socialImageURL};
     
     NSString *requestTypeMethod =   [[AppManager sharedDataAccess]  getStringForRequestType: POST];
     
     NSDictionary *headers = @ {@"S-Api-Key" :RP_API_KEY};
     
     for (NSString *key in [headers allKeys]) {
         [self.manager.requestSerializer setValue:[headers valueForKey:key] forHTTPHeaderField:key];
     }

     
     NSMutableURLRequest *request = [self.manager.requestSerializer requestWithMethod:requestTypeMethod URLString:[[NSURL URLWithString:[self.requestURL absoluteString] relativeToURL:_manager.baseURL] absoluteString] parameters:params error:nil];
     
     NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
         
         if (error) {
             NSLog(@"%@", error.localizedDescription);
             //show alert
         }
         else
         {
             NSDictionary *dictResponse;
             if ([responseObject isKindOfClass:[NSDictionary class]]) {
                 dictResponse = (NSDictionary *)responseObject;
             }
              if ([[dictResponse objectForKey:@"ErrorCode"]  intValue] == 200 )
              {
                  //success
                  NSString *authKey = [[dictResponse objectForKey:@"Result"] objectForKey:@"AuthToken"];
                  [[NSUserDefaults standardUserDefaults] setObject:authKey forKey:@"AuthToken"];
                  [[NSUserDefaults standardUserDefaults] synchronize];
                  
                  //TODO: Update User Location
                  [self startUpdatingUserLcoation];
                  
                  completion(YES);
              }
             
             else
             {
                completion(NO);
             }
             //TODO: On succesful Login & regenerated auth toke
//             [self RPServicewithMethodName:self.methodName withParameters:self.methodPramas andRequestType:self.methodType success:^(id response) {
//                 NSLog(@"Result From Uto Login : %@", response);
//             } failure:^(id failureMessage, NSError *error) {
//                 NSLog(@"%@", error.localizedDescription);
//                 ;
//             }];
         }
     }];
     
     [dataTask resume];
 }
*/

@end