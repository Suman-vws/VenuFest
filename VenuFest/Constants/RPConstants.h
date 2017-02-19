//
//  RPConstants.h
//  RP
//
//  Created by Mac on 29/08/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "VenuFest-Swift.h"
#import "UIColor+AppColor.h"

#ifndef RPConstants_h
#define RPConstants_h

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

typedef enum
{
    userLoginTypeNormal = 0,
    userLoginTypeGPlus,
    userLoginTypeFacebook,
    userLoginTypeNone
    
}userLoginType;

typedef enum
{
    userAuthTypeLogin = 0,
    userAuthTypeRegistration,
    userAuthTypeNone
    
}userAuthType;

typedef enum
{
    profileListTypeNone = 0,
    profileListTypeRunningTracks,
    profileListTypeUserInfo,
}profileListType;

typedef enum
{
    userGenderTypeFemale = 0,
    userGenderTypeMale,
    userGenderTypeOther,
    userGenderTypeNone,
}genderType;


typedef enum
{
    profileImageTypeJPG = 0,
    profileImageTypePNG,
}profileImageType;

typedef enum
{
    userTypeCustomer = 0,
    userTypeVendor,
    userTypeNone
    
}userType;

typedef enum RequestTypes{
    
    GET,
    POST,
    PUT,
    DELETE
    
}RequestType;

/*!
 * @function ZCLog  Macro
 */
#ifdef DEBUG
    #ifndef FC_DISABLE_DEBUG_LOGGING
        #define RPLogFunction()        NSLog(@"%s", __FUNCTION__)
        #define RPLog(...)             NSLog(@"%s: %@", __FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
    #else
        #define RPLogFunction(...)
        #define RPLog(...)
    #endif
#else
    #define RPLogFunction(...)
    #define RPLog(...)
#endif
/*!
 * @function Singleton GCD Macro
 */

#define SHARED_INSTANCE(...) ({\
        static dispatch_once_t pred;\
        static id sharedObject;\
        dispatch_once(&pred, ^{\
        sharedObject = (__VA_ARGS__);\
        });\
        sharedObject;\
    })

#endif /* RPConstants_h */



#define COLOR_FRACTION(v) ( v / 255.0f)

UIKIT_EXTERN NSString *USER_LOGOUT_NOTIFICATION;

// ============= URL PATHS ===============
UIKIT_EXTERN NSString *VENU_FEST_BASE_URL;
UIKIT_EXTERN NSString *VENU_FEST_API_KEY;
UIKIT_EXTERN NSString *AUTH_USER_PATH;
UIKIT_EXTERN NSString *USER_REGISTRATION_PATH;
UIKIT_EXTERN NSString *USER_LOGIN_PATH;
UIKIT_EXTERN NSString *FORGET_USER_PATH;
UIKIT_EXTERN NSString *USER_PROFILE_PATH;
UIKIT_EXTERN NSString *UPDATE_USER_PROFILE_PATH;
UIKIT_EXTERN NSString *UPDATE_USER_PROFILE_IMAGE_PATH;

UIKIT_EXTERN NSString *CHANGE_USER_PASSWORD_PATH;

// ============= END ===============

UIKIT_EXTERN NSString  *APPLICATION_FONT_NAME;


UIKIT_EXTERN CGFloat TOP_BAR_TITLE_FONT_SIZE;

UIKIT_EXTERN CGFloat  APP_BUTTON_TITLE_FONT_SIZE;
UIKIT_EXTERN CGFloat  APP_BUTTON_TITLE_FONT_SIZE_MEDIUM;
UIKIT_EXTERN CGFloat  APP_BUTTON_TITLE_FONT_SIZE_SMALL;


UIKIT_EXTERN CGFloat  APPLICATION_TEXTFIELD_FONT_SIZE;
UIKIT_EXTERN CGFloat  APPLICATION_TEXTFIELD_FONT_SIZE_MEDIUM;
UIKIT_EXTERN CGFloat  APPLICATION_TEXTFIELD_FONT_SIZE_SMALL;

UIKIT_EXTERN CGFloat APPLICATION_BODY_FONT_SIZE;
UIKIT_EXTERN CGFloat APPLICATION_BODY_FONT_SIZE_MEDIUM;
UIKIT_EXTERN CGFloat APPLICATION_BODY_FONT_SIZE_SMALL;

// ============= SOCIAL LOGIN DETAILS ===============

UIKIT_EXTERN NSString * FACEBOOK_API_CALLBACK_URL_SCHEME;
UIKIT_EXTERN NSString * FACEBOOK_API_CALLBACK_NOTIFICATION;
UIKIT_EXTERN NSString * GOOGLE_PLUS_API_CLIENT_ID;
UIKIT_EXTERN NSString * GOOGLE_PLUS_API_CALLBACK_URL_SCHEME;
UIKIT_EXTERN NSString * GOOGLE_PLUS_REVERSED_CLIENT_ID;

UIKIT_EXTERN NSString * USER_DID_LOGGED_IN_NOTIFICATION;

// ============= END ===============



        //============================ Page HEADER & FOOTER ==============================

// Header
#define TOP_BAR_BACKGROUND_COLOR        [UIColor colorWithRed:COLOR_FRACTION(151.0) green:COLOR_FRACTION(194.0) blue:COLOR_FRACTION(122.0) alpha:1.0]
#define TOP_BAR_TEXT_COLOR              [UIColor colorWithHexString:@"#FFFFFF"]

#define TOP_BAR_TITLE_FONT              [UIFont fontWithName:APPLICATION_FONT_NAME size:TOP_BAR_TITLE_FONT_SIZE]

//Page Header
#define PAGE_TITLE_FONT                 [UIFont fontWithName: APPLICATION_FONT_NAME size:20]

        //============================ Text-Fields ==============================

#define  APPLICATION_TEXTFIELD_FONT             [UIFont fontWithName: APPLICATION_FONT_NAME size: APPLICATION_TEXTFIELD_FONT_SIZE]
#define  APPLICATION_TEXTFIELD_FONT_MEDIUM      [UIFont fontWithName: APPLICATION_FONT_NAME size: APPLICATION_TEXTFIELD_FONT_SIZE_MEDIUM]
#define  APPLICATION_TEXTFIELD_FONT_SMALL       [UIFont fontWithName: APPLICATION_FONT_NAME size: APPLICATION_TEXTFIELD_FONT_SIZE_SMALL]

#define  TEXT_FIELD_PLACEHOLDER_COLOR           [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1.0]
#define  TEXT_FIELD_INPUT_COLOR                 [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1.0]


            //============================ BUTTONS ==============================

#define APP_BUTTON_TITLE_FONT               [UIFont fontWithName: APPLICATION_FONT_NAME size: APP_BUTTON_TITLE_FONT_SIZE]
#define APP_BUTTON_TITLE_FONT_MEDIUM        [UIFont fontWithName: APPLICATION_FONT_NAME size: APP_BUTTON_TITLE_FONT_SIZE_MEDIUM]
#define APP_BUTTON_TITLE_FONT_SMALL         [UIFont fontWithName: APPLICATION_FONT_NAME size: APP_BUTTON_TITLE_FONT_SIZE_SMALL]

#define APP_BUTTON_BACKGROUND_COLOR         [UIColor colorWithHexString:@"#73121b"]
#define APP_BUTTON_TEXT_COLOR               [UIColor colorWithHexString:@"#FFFFFF"]
#define APP_BUTTON_GREY_TEXT_COLOR          [UIColor colorWithRed:COLOR_FRACTION(68.0) green:COLOR_FRACTION(68.0) blue:COLOR_FRACTION(68.0) alpha:1.0]

#define FB_BUTTON_BACKGROUND_COLOR          [UIColor colorWithRed:COLOR_FRACTION(61.0) green:COLOR_FRACTION(90.0) blue:COLOR_FRACTION(152.0) alpha:1.0]
#define GPLUS_BUTTON_BACKGROUND_COLOR       [UIColor colorWithRed:COLOR_FRACTION(222.0) green:COLOR_FRACTION(38.0) blue:COLOR_FRACTION(31.0) alpha:1.0]


        //============================ SLIDER ==============================

#define  MENU_CELL_TITLE_FONT                [UIFont fontWithName:APPLICATION_FONT_NAME size:APPLICATION_BODY_FONT_SIZE]
#define  MENU_BACKGROUND_COLOR               [UIColor colorWithRed:COLOR_FRACTION(28.0) green:COLOR_FRACTION(28.0) blue:COLOR_FRACTION(28.0) alpha:1.0]


        //============================ OTHERS ==============================

#define  TXTFIELD_ERROR_COLOR_RED            [UIColor colorWithRed:242.0/255 green:25.0/255 blue:38.0/255 alpha:1.0]


//Body Font Details

#define BODY_TEXT_FONT                      [UIFont fontWithName: APPLICATION_FONT_NAME size:20]
#define BODY_TEXT_FONT_SMALL                [UIFont fontWithName: APPLICATION_FONT_NAME size:16]
#define BODY_TEXT_COLOR_WHITE               [UIColor colorWithHexString:@"#FFFFFF"]
#define BODY_TEXT_COLOR_GREY                [UIColor colorWithRed:COLOR_FRACTION(68.0) green:COLOR_FRACTION(68.0) blue:COLOR_FRACTION(68.0) alpha:1.0]




