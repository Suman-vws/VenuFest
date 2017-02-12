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

NSString *VENU_FEST_API_KEY = @"OEFFRTJERjUtNkM4NS00NDI5LUIxRTYtOTAyMTRCQzQ1NTgw";
NSString *VENU_FEST_BASE_URL =  @"http://venuefest.teqnico.com/fest_connect/";
NSString *RP_GUID_ID = @"00000000-0000-0000-0000-000000000000";

NSString *USER_REGISTRATION_PATH = @"create_user.php";
NSString *GET_USER_PATH = @"user";
NSString *UPDATE_USER_PATH = @"user";
NSString *FORGET_USER_PATH = @"forgotpass";
NSString *USER_PROFILE_IMAGE_PATH = @"profileimage";
NSString *POST_PROFILE_IMAGE = @"profileimage";
NSString *POST_PROFILE_IMAGE_INBYTES = @"profileimagebytes";
NSString *OTHER_USER_PROFILE = @"otheruser";
NSString *JOGGER_ACTIVITY = @"joggeractivity";
NSString *POST_ACTIVITY = @"activity";
NSString *POST_FEEDBACK =  @"feedback";
NSString *POST_FEEDBACK_IMAGE_INBYTES = @"feedbackimagebytes";
NSString *ACTIVITY_PATH = @"activity";
NSString *FEEDBACK_PATH =  @"feedback";
NSString *TRACKS_PARAMS_PATH =  @"tracks";
NSString *NEAREST_TRACKS_PATH =  @"nearesttracks";
NSString *JOGGER_FRIENDS_PATH =  @"joggerfriends";
NSString *SEND_FRIEND_REQUEST_PATH =  @"requestmessage";
NSString *GET_NEARBY_JOGGER_PATH = @"nearbyjoggers";
NSString *ACCEPT_FRIEND_REQUEST =  @"joggerfriend";
NSString *USER_FEEDS_PATH = @"userfeeds";
NSString *PRODUCTS_PATH = @"products";
NSString *EVENTS_PATH = @"events";
NSString *USER_LAST_LOCATION_PATH = @"lastlocation";
NSString *SEARCH_JOGGER_FRIEND_PATH = @"searchjoggers/";

#else

NSString *USER_LOGOUT_NOTIFICATION = @"USER_LOGOUT_EVENT";

NSString *RP_API_KEY = @"OEFFRTJERjUtNkM4NS00NDI5LUIxRTYtOTAyMTRCQzQ1NTgw";
NSString *VENU_FEST_BASE_URL =  @"http://venuefest.teqnico.com/fest_connect/";
NSString *RP_GUID_ID = @"00000000-0000-0000-0000-000000000000";

// @"http://61.95.147.86/rpservicestaging/";   //Staging
//live --->>  @"http://61.95.147.86/rpservice/";

NSString *USER_REGISTRATION_PATH = @"create_user.php";

NSString *USER_REGISTRATION_AND_LOGIN_PATH = @"user";
NSString *GET_USER_PATH = @"user";
NSString *UPDATE_USER_PATH = @"user";
NSString *FORGET_USER_PATH = @"forgotpass";
NSString *USER_PROFILE_IMAGE_PATH = @"profileimage";
NSString *POST_PROFILE_IMAGE = @"profileimage";
NSString *POST_PROFILE_IMAGE_INBYTES = @"profileimagebytes";
NSString *OTHER_USER_PROFILE = @"otheruser";
NSString *JOGGER_ACTIVITY = @"joggeractivity";
NSString *POST_ACTIVITY = @"activity";
NSString *POST_FEEDBACK =  @"feedback";
NSString *POST_FEEDBACK_IMAGE_INBYTES = @"feedbackimagebytes";
NSString *ACTIVITY_PATH = @"activity";
NSString *FEEDBACK_PATH =  @"feedback";
NSString *TRACKS_PARAMS_PATH =  @"tracks";
NSString *NEAREST_TRACKS_PATH =  @"nearesttracks";
NSString *JOGGER_FRIENDS_PATH =  @"joggerfriends";
NSString *SEND_FRIEND_REQUEST_PATH =  @"requestmessage";
NSString *GET_NEARBY_JOGGER_PATH = @"nearbyjoggers";
NSString *ACCEPT_FRIEND_REQUEST =  @"joggerfriend";
NSString *USER_FEEDS_PATH = @"userfeeds";
NSString *PRODUCTS_PATH = @"products";
NSString *EVENTS_PATH = @"events";
NSString *USER_LAST_LOCATION_PATH = @"lastlocation";
NSString *SEARCH_JOGGER_FRIEND_PATH = @"searchjoggers/";

#endif


//Oswald-Bold
NSString  *TOP_BAR_TITLE_FONT_NAME =  @"SinkinSans-300Light";          // @"ROBOTO-REGULAR";
CGFloat TOP_BAR_TITLE_FONT_SIZE = 40.f;

NSString  *BOTTOM_BAR_TITLE_FONT_NAME = @"SinkinSans-300Light";       // @"ROBOTO-REGULAR";
CGFloat BOTTOM_BAR_TITLE_FONT_SIZE = 14.f;

NSString  *TAB_BAR_TITLE_FONT_NAME =   @"SinkinSans-300Light";       // @"ROBOTO-REGULAR";
CGFloat TAB_BAR_TITLE_FONT_SIZE = 14.0f;

NSString  *APPLICATION_TEXTFIELD_FONT_NAME =   @"SinkinSans-300Light";     //  @"ROBOTO-REGULAR";
CGFloat  APPLICATION_TEXTFIELD_FONT_SIZE = 16.0f;
CGFloat  APPLICATION_TEXTFIELD_FONT_SIZE_MEDIUM = 14.0f;
CGFloat  APPLICATION_TEXTFIELD_FONT_SIZE_SMALL = 12.0f;

NSString  * APPLICATION_BODY_FONT_NAME =  @"SinkinSans-300Light";         // @"ROBOTO-REGULAR";
CGFloat APPLICATION_BODY_FONT_SIZE = 16.0f;
CGFloat APPLICATION_BODY_FONT_SIZE_MEDIUM = 14.0f;
CGFloat APPLICATION_BODY_FONT_SIZE_SMALL = 12.0f;


// For Social Login

NSString * FACEBOOK_API_CALLBACK_URL_SCHEME = @"fb1144340155656269";
NSString * FACEBOOK_API_CALLBACK_NOTIFICATION = @"__FACEBOOK_API_CALLBACK_NOTIFICATION__";

NSString * GOOGLE_PLUS_API_CLIENT_ID =  @"1020819682155-evs20ejou86pnismn2b6sjol0toa67s9.apps.googleusercontent.com";
NSString * GOOGLE_PLUS_REVERSED_CLIENT_ID =  @"com.googleusercontent.apps.1020819682155-evs20ejou86pnismn2b6sjol0toa67s9";

//@"1020819682155-evs20ejou86pnismn2b6sjol0toa67s9.apps.googleusercontent.com";

NSString * GOOGLE_PLUS_API_CALLBACK_URL_SCHEME = @"com.mcs.VenuFest";
NSString * USER_DID_LOGGED_IN_NOTIFICATION  = @"__USER_DID_LOGGED_IN_NOTIFICATION__";






