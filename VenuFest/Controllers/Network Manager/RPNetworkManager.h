//
//  RPNetworkManager.h
//  RP
//
//  Created by Mac on 29/08/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPConstants.h"
//#import  "ActivityPoints.h"

typedef void(^RPNetworkManagerSuccessBlock)  (id response);
typedef void(^RPNetworkManagerFailureBlock)  (id failureMessage, NSError *error);
typedef void(^authCompletion)(BOOL);

@interface RPNetworkManager : NSObject


@property (nonatomic, strong, readonly) NSURL *requestURL;

@property (nonatomic, assign, readonly) NSInteger lastResponseStatusCode;

@property (nonatomic, strong, readonly) id lastResponseObject;

@property (nonatomic, strong, readonly) NSError *lastError;

@property (nonatomic, assign) userLoginType loginType;
@property (nonatomic, assign) userAuthType authType;
@property (nonatomic, assign) BOOL isReLogin;


+ (instancetype) defaultNetworkManager;

- (void) VFServicewithMethodName:(NSString *)methodName withParameters:(NSDictionary *)params andRequestType:(NSString *)requestType  success:(RPNetworkManagerSuccessBlock)success failure:(RPNetworkManagerFailureBlock) failure;

- (void)showLoadingIndicatorInView:(UIView *)view;
-(void)hideLoadingIndicatorInView:(UIView *)view;

//Social Login
- (void)loginWithFbFromViewController:(UIViewController *)vc;
- (void) loginUsingGooglePlusInViewController:(UIViewController *)vc loginHandler:(void(^)(id ))result;


@end
