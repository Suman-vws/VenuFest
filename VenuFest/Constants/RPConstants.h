//
//  RPConstants.h
//  RP
//
//  Created by Mac on 29/08/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>


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
    userExprienceNormal = 0,
    userExprienceGood,
    userExprienceExcellent,
    userExprienceNone
    
}userExprience;

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
    RequestTypeAddFriend = 0,
    RequestTypeUnfriend,
    RequestTypeInformation,
    RequestTypeAdminNotification,
    
}friendRequestType;


typedef enum
{
    feedTypeAdmin = 0,
    feedTypeStory,
}feedType;


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

UIKIT_EXTERN NSString *RP_BASE_URL;
UIKIT_EXTERN NSString *RP_API_KEY;
UIKIT_EXTERN NSString *RP_GUID_ID; 

UIKIT_EXTERN NSString *USER_REGISTRATION_AND_LOGIN_PATH;
UIKIT_EXTERN NSString *GET_USER_PATH;
UIKIT_EXTERN NSString *UPDATE_USER_PATH;

UIKIT_EXTERN NSString *FORGET_USER_PATH;

UIKIT_EXTERN NSString *USER_PROFILE_IMAGE_PATH;
UIKIT_EXTERN NSString *POST_PROFILE_IMAGE;  // imagetype
UIKIT_EXTERN NSString *POST_PROFILE_IMAGE_INBYTES;  // imagetypeInBytes
UIKIT_EXTERN NSString *OTHER_USER_PROFILE;
UIKIT_EXTERN NSString *JOGGER_ACTIVITY;
UIKIT_EXTERN NSString *POST_ACTIVITY;
UIKIT_EXTERN NSString *POST_FEEDBACK;
UIKIT_EXTERN NSString *POST_FEEDBACK_IMAGE_INBYTES;
UIKIT_EXTERN NSString *ACTIVITY_PATH;
UIKIT_EXTERN NSString *FEEDBACK_PATH;
UIKIT_EXTERN NSString *TRACKS_PARAMS_PATH;
UIKIT_EXTERN NSString *NEAREST_TRACKS_PATH;
UIKIT_EXTERN NSString *JOGGER_FRIENDS_PATH;
UIKIT_EXTERN NSString *SEND_FRIEND_REQUEST_PATH;
UIKIT_EXTERN NSString *GET_NEARBY_JOGGER_PATH;
UIKIT_EXTERN NSString *USER_FEEDS_PATH;
UIKIT_EXTERN NSString *PRODUCTS_PATH;
UIKIT_EXTERN NSString *EVENTS_PATH;
UIKIT_EXTERN NSString *USER_LAST_LOCATION_PATH;
UIKIT_EXTERN NSString *SEARCH_JOGGER_FRIEND_PATH;


UIKIT_EXTERN NSString  *TOP_BAR_TITLE_FONT_NAME;
UIKIT_EXTERN CGFloat TOP_BAR_TITLE_FONT_SIZE;

UIKIT_EXTERN NSString  *BOTTOM_BAR_TITLE_FONT_NAME;
UIKIT_EXTERN CGFloat BOTTOM_BAR_TITLE_FONT_SIZE;


UIKIT_EXTERN NSString  *TAB_BAR_TITLE_FONT_NAME;
UIKIT_EXTERN CGFloat TAB_BAR_TITLE_FONT_SIZE;


UIKIT_EXTERN NSString  *APPLICATION_TEXTFIELD_FONT_NAME;
UIKIT_EXTERN CGFloat  APPLICATION_TEXTFIELD_FONT_SIZE;
UIKIT_EXTERN CGFloat  APPLICATION_TEXTFIELD_FONT_SIZE_MEDIUM;
UIKIT_EXTERN CGFloat  APPLICATION_TEXTFIELD_FONT_SIZE_SMALL;

UIKIT_EXTERN NSString  * APPLICATION_BODY_FONT_NAME;
UIKIT_EXTERN CGFloat APPLICATION_BODY_FONT_SIZE;
UIKIT_EXTERN CGFloat APPLICATION_BODY_FONT_SIZE_MEDIUM;
UIKIT_EXTERN CGFloat APPLICATION_BODY_FONT_SIZE_SMALL;


UIKIT_EXTERN NSString * FACEBOOK_API_CALLBACK_URL_SCHEME;
UIKIT_EXTERN NSString * FACEBOOK_API_CALLBACK_NOTIFICATION;
UIKIT_EXTERN NSString * GOOGLE_PLUS_API_CLIENT_ID;
UIKIT_EXTERN NSString * GOOGLE_PLUS_API_CALLBACK_URL_SCHEME;

UIKIT_EXTERN NSString * USER_DID_LOGGED_IN_NOTIFICATION;
UIKIT_EXTERN NSString *ACCEPT_FRIEND_REQUEST;

#define CLOSE_GRADIENT_VIEW_FROM_SUPERVIEW          @"REMOVE_CHILD_VIEW"
#define CLOSE_FEED_DETAILS_FROM_SUPERVIEW           @"REMOVE_FEED_VIEW"

//SinkinSans

        //============================ Page HEADER & FOOTER ==============================

// Header
#define TOP_BAR_BACKGROUND_COLOR      [UIColor colorWithRed:COLOR_FRACTION(151.0) green:COLOR_FRACTION(194.0) blue:COLOR_FRACTION(122.0) alpha:1.0]
#define TOP_BAR_TEXT_COLOR      [UIColor colorWithRed:COLOR_FRACTION(255.0) green:COLOR_FRACTION(255.0) blue:COLOR_FRACTION(255.0) alpha:1.0]

#define TOP_BAR_TITLE_FONT      [UIFont fontWithName:TOP_BAR_TITLE_FONT_NAME size:TOP_BAR_TITLE_FONT_SIZE]

#define SEARCH_BAR_BACKGROUND_COLOR      [UIColor colorWithRed:COLOR_FRACTION(4.0) green:COLOR_FRACTION(4.0) blue:COLOR_FRACTION(4.0) alpha:0.15]

//FOOTER
#define BOTTOM_BAR_BACKGROUND_COLOR      [UIColor colorWithRed:COLOR_FRACTION(151.0) green:COLOR_FRACTION(194.0) blue:COLOR_FRACTION(122.0) alpha:1.0]
#define  BOTTOM_BAR_TEXT_COLOR      [UIColor colorWithRed:COLOR_FRACTION(255.0) green:COLOR_FRACTION(255.0) blue:COLOR_FRACTION(255.0) alpha:1.0]

#define BOTTOM_BAR_TITLE_FONT      [UIFont fontWithName:TOP_BAR_TITLE_FONT_NAME size:BOTTOM_BAR_TITLE_FONT_SIZE]


        //============================ Tab Bar ==============================

#define TAB_BAR_TITLE_LABLE_FONT      [UIFont fontWithName:TOP_BAR_TITLE_FONT_NAME size:TAB_BAR_TITLE_FONT_SIZE]

#define TAB_BAR_DE_SELECTED_COLOR      [UIColor colorWithRed:COLOR_FRACTION(34.0) green:COLOR_FRACTION(34.0) blue:COLOR_FRACTION(34.0) alpha:1.0]

#define TAB_BAR_SELECTED_COLOR      [UIColor colorWithRed:COLOR_FRACTION(255.0) green:COLOR_FRACTION(255.0) blue:COLOR_FRACTION(255.0) alpha:1.0]


        //============================ Text-Fields ==============================

#define  APPLICATION_TEXTFIELD_FONT      [UIFont fontWithName:APPLICATION_TEXTFIELD_FONT_NAME size:APPLICATION_TEXTFIELD_FONT_SIZE]
#define  APPLICATION_TEXTFIELD_FONT_MEDIUM      [UIFont fontWithName:APPLICATION_TEXTFIELD_FONT_NAME size:APPLICATION_TEXTFIELD_FONT_SIZE_MEDIUM]
#define  APPLICATION_TEXTFIELD_FONT_SMALL      [UIFont fontWithName:APPLICATION_TEXTFIELD_FONT_NAME size:APPLICATION_TEXTFIELD_FONT_SIZE_SMALL]

#define  TEXT_FIELD_PLACEHOLDER_COLOR      [UIColor colorWithRed:78.0/255 green:78.0/255 blue:78.0/255 alpha:1.0]
#define  TEXT_FIELD_INPUT_COLOR      [UIColor colorWithRed:65.0/255 green:65.0/255 blue:65.0/255 alpha:1.0]

            //============================ BUTTONS ==============================

//LOGIN SCREEN
#define APP_BUTTON_BACKGROUND_COLOR      [UIColor colorWithRed:COLOR_FRACTION(51.0) green:COLOR_FRACTION(51.0) blue:COLOR_FRACTION(51.0) alpha:1.0]
#define APP_BUTTON_TEXT_COLOR      [UIColor colorWithRed:COLOR_FRACTION(255.0) green:COLOR_FRACTION(255.0) blue:COLOR_FRACTION(255.0) alpha:1.0]
#define APP_BUTTON_GREY_TEXT_COLOR      [UIColor colorWithRed:COLOR_FRACTION(68.0) green:COLOR_FRACTION(68.0) blue:COLOR_FRACTION(68.0) alpha:1.0]
#define APP_BUTTON_TITLE_FONT      [UIFont fontWithName:@"ROBOTO-REGULAR" size:20]
#define APP_BUTTON_TITLE_FONT_MEDIUM      [UIFont fontWithName:@"ROBOTO-REGULAR" size:16]
#define APP_BUTTON_TITLE_FONT_SMALL      [UIFont fontWithName:@"ROBOTO-REGULAR" size:12]

#define APP_FONT_LARGE      [UIFont fontWithName:@"ROBOTO-REGULAR" size:40]

#define TEXTFIELD_BORDER_COLOR      [UIColor colorWithRed:COLOR_FRACTION(235.0) green:COLOR_FRACTION(235.0) blue:COLOR_FRACTION(235.0) alpha:0.2]


#define FB_BUTTON_BACKGROUND_COLOR      [UIColor colorWithRed:COLOR_FRACTION(61.0) green:COLOR_FRACTION(90.0) blue:COLOR_FRACTION(152.0) alpha:1.0]

#define GPLUS_BUTTON_BACKGROUND_COLOR      [UIColor colorWithRed:COLOR_FRACTION(222.0) green:COLOR_FRACTION(38.0) blue:COLOR_FRACTION(31.0) alpha:1.0]

#define REGISTER_BUTTON_BACKGROUND_COLOR      [UIColor colorWithRed:COLOR_FRACTION(68.0) green:COLOR_FRACTION(151.0) blue:COLOR_FRACTION(211.0) alpha:1.0]

#define FORGET_BUTTON_TEXT_COLOR      [UIColor colorWithRed:COLOR_FRACTION(69.0) green:COLOR_FRACTION(154.0) blue:COLOR_FRACTION(211.0) alpha:1.0]

        //============================ SLIDER ==============================

#define  HEADER_BACKGROUND_COLOR       [UIColor colorWithRed:COLOR_FRACTION(78.0) green:COLOR_FRACTION(78.0) blue:COLOR_FRACTION(78.0) alpha:1.0]

#define  SLIDER_TEXT_COLOR       [UIColor colorWithRed:COLOR_FRACTION(255.0) green:COLOR_FRACTION(255.0) blue:COLOR_FRACTION(255.0) alpha:1.0]

#define MENU_HEADER_TITLE_FONT      [UIFont fontWithName:TOP_BAR_TITLE_FONT_NAME size:TOP_BAR_TITLE_FONT_SIZE]
#define MENU_CELL_TITLE_FONT      [UIFont fontWithName:TOP_BAR_TITLE_FONT_NAME size:APPLICATION_BODY_FONT_SIZE]
#define  MENU_BACKGROUND_COLOR       [UIColor colorWithRed:COLOR_FRACTION(28.0) green:COLOR_FRACTION(28.0) blue:COLOR_FRACTION(28.0) alpha:1.0]


        //============================ OTHERS ==============================

#define APP_DEFAULT_GREEN_COLOR_TRANS     [UIColor colorWithRed:COLOR_FRACTION(151.0) green:COLOR_FRACTION(194.0) blue:COLOR_FRACTION(122.0) alpha:0.7]

#define  TXTFIELD_ERROR_COLOR_RED      [UIColor colorWithRed:242.0/255 green:25.0/255 blue:38.0/255 alpha:1.0]

#define PAGE_TITLE_FONT      [UIFont fontWithName:@"ROBOTO-REGULAR" size:20]
#define PAGE_TITLE_FONT_BOLD      [UIFont fontWithName:@"ROBOTO-BOLD" size:20]
#define PAGE_TITLE_FONT_BOLD_SMALL      [UIFont fontWithName:@"ROBOTO-BOLD" size:14]

#define PAGE_TITLE_FONT_LARGE      [UIFont fontWithName:@"ROBOTO-REGULAR" size:30]

#define PAGE_TITLE_TEXT_COLOR_BLACK      [UIColor colorWithRed:COLOR_FRACTION(51.0) green:COLOR_FRACTION(51.0) blue:COLOR_FRACTION(51.0) alpha:1.0]

#define PAGE_TITLE_TEXT_COLOR_GREEN     [UIColor colorWithRed:COLOR_FRACTION(151.0) green:COLOR_FRACTION(194.0) blue:COLOR_FRACTION(122.0) alpha:1.0]

#define PAGE_TITLE_COLOR_TRANSPARENT_GREEN     [UIColor colorWithRed:COLOR_FRACTION(151.0) green:COLOR_FRACTION(194.0) blue:COLOR_FRACTION(122.0) alpha:0.5]

#define PAGE_BACKGROUND_TRANSPARENT_BLACK   [UIColor colorWithRed:5.0/255 green:5.0/255 blue:5.0/255 alpha:0.80]

#define LIST_CELL_BG_COLOR_FADE      [UIColor colorWithRed:COLOR_FRACTION(236.0) green:COLOR_FRACTION(236.0) blue:COLOR_FRACTION(236.0) alpha:1.0]


#define BODY_TEXT_FONT      [UIFont fontWithName:@"ROBOTO-REGULAR" size:20]
#define BODY_TEXT_FONT_SMALL      [UIFont fontWithName:@"ROBOTO-REGULAR" size:16]
#define BODY_TEXT_COLOR_WHITE      [UIColor colorWithRed:COLOR_FRACTION(255.0) green:COLOR_FRACTION(255.0) blue:COLOR_FRACTION(255.0) alpha:1.0]
#define LIST_HEADER_FONT_SMALL      [UIFont fontWithName:@"ROBOTO-REGULAR" size:12]
#define ACTIVITY_LIST_TEXT_FONT      [UIFont fontWithName:@"ROBOTO-REGULAR" size:14]

#define APP_NUMBER_FONT_LARGE      [UIFont fontWithName:@"Oswald-Bold" size:50]
#define APP_NUMBER_FONT_MEDIUM_BOLD      [UIFont fontWithName:@"Oswald-Bold" size:20]



//============================ HOME PAGE ==============================


#define SEARCH_HEADER_BACKGROUND_COLOR      [UIColor colorWithRed:COLOR_FRACTION(21.0) green:COLOR_FRACTION(21.0) blue:COLOR_FRACTION(21.0) alpha:1.0]
#define TOP_KM_TEXT_FONT      [UIFont fontWithName:@"ROBOTO-REGULAR" size:60]
#define KMNOS_TEXT_FONT      [UIFont fontWithName:@"ROBOTO-REGULAR" size:30]


//============================ACTIVITY PAGE=============================

#define ACTIVITY_HEADER_BACKGROUND_COLOR      [UIColor colorWithRed:COLOR_FRACTION(149.0) green:COLOR_FRACTION(179.0) blue:COLOR_FRACTION(122.0) alpha:1.0]

