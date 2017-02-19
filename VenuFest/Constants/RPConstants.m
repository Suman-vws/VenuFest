//
//  RPConstants.m
//  RP
//
//  Created by Mac on 29/08/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPConstants.h"


#if DEBUG


NSString *USER_LOGOUT_NOTIFICATION = @"USER_LOGOUT_EVENT";

//NSString *VENU_FEST_API_KEY = @"OEFFRTJERjUtNkM4NS00NDI5LUIxRTYtOTAyMTRCQzQ1NTgw";
NSString *VENU_FEST_BASE_URL =  @"http://venuefest.teqnico.com/fest_connect/api/";
NSString *AUTH_USER_PATH = @"auth";
NSString *USER_REGISTRATION_PATH = @"usersignup";
NSString *USER_LOGIN_PATH = @"validatelogin";
NSString *FORGET_USER_PATH = @"forgotpassword";
NSString *USER_PROFILE_PATH = @"profiledetail";
NSString *UPDATE_USER_PROFILE_PATH = @"updateprofile";
NSString *UPDATE_USER_PROFILE_IMAGE_PATH = @"updateprofileImage";

NSString *CHANGE_USER_PASSWORD_PATH = @"changepassword";

#else

NSString *USER_LOGOUT_NOTIFICATION = @"USER_LOGOUT_EVENT";

//NSString *VENU_FEST_API_KEY = @"OEFFRTJERjUtNkM4NS00NDI5LUIxRTYtOTAyMTRCQzQ1NTgw";
NSString *VENU_FEST_BASE_URL =  @"http://venuefest.teqnico.com/fest_connect/api/";

NSString *USER_LOGIN_PATH = @"user";
NSString *USER_REGISTRATION_PATH = @"usersignup";
NSString *FORGET_USER_PATH = @"forgotpassword";
NSString *USER_PROFILE_PATH = @"profiledetail";
NSString *UPDATE_USER_PROFILE_PATH = @"updateprofile";
NSString *UPDATE_USER_PROFILE_IMAGE_PATH = @"updateprofileImage";

NSString *CHANGE_USER_PASSWORD_PATH = @"changepassword";

#endif


NSString  *APPLICATION_FONT_NAME =  @"SinkinSans-300Light";

CGFloat TOP_BAR_TITLE_FONT_SIZE = 24.f;

CGFloat  APP_BUTTON_TITLE_FONT_SIZE = 20.0f;
CGFloat  APP_BUTTON_TITLE_FONT_SIZE_MEDIUM = 16.0f;
CGFloat  APP_BUTTON_TITLE_FONT_SIZE_SMALL = 12.0f;

CGFloat  APPLICATION_TEXTFIELD_FONT_SIZE = 16.0f;
CGFloat  APPLICATION_TEXTFIELD_FONT_SIZE_MEDIUM = 14.0f;
CGFloat  APPLICATION_TEXTFIELD_FONT_SIZE_SMALL = 12.0f;

CGFloat APPLICATION_BODY_FONT_SIZE = 16.0f;
CGFloat APPLICATION_BODY_FONT_SIZE_MEDIUM = 14.0f;
CGFloat APPLICATION_BODY_FONT_SIZE_SMALL = 12.0f;


// For Social Login

NSString * FACEBOOK_API_CALLBACK_URL_SCHEME = @"fb1144340155656269";
NSString * FACEBOOK_API_CALLBACK_NOTIFICATION = @"__FACEBOOK_API_CALLBACK_NOTIFICATION__";

NSString * GOOGLE_PLUS_API_CLIENT_ID =  @"1020819682155-evs20ejou86pnismn2b6sjol0toa67s9.apps.googleusercontent.com";
NSString * GOOGLE_PLUS_REVERSED_CLIENT_ID =  @"com.googleusercontent.apps.1020819682155-evs20ejou86pnismn2b6sjol0toa67s9";

NSString * GOOGLE_PLUS_API_CALLBACK_URL_SCHEME = @"com.mcs.VenuFest";
NSString * USER_DID_LOGGED_IN_NOTIFICATION  = @"__USER_DID_LOGGED_IN_NOTIFICATION__";








