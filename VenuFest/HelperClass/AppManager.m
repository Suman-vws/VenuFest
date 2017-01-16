//
//  AppManager.m
//  TablePouncer
//
//  Created by Md Aftabuddin on 28/05/13.
//  Copyright (c) 2013 Digital Avenues. All rights reserved.
//

#import "AppManager.h"
#import "AppDelegate.h"

//#import "IEURLConnection.h"

@interface AppManager ()
{
    //UIAlertView *alertview;
}
@end

@implementation AppManager
@synthesize userInfo = _userInfo;
@synthesize restaurantInfo = _restaurantInfo;
@synthesize arrUserMenuList = _arrUserMenuList;
@synthesize arrInviteeList = _arrInviteeList;
@synthesize strDeviceToken = _strDeviceToken;
@synthesize strUUID = _strUUID;
@synthesize strCurrentUUID = _strCurrentUUID;
@synthesize selectedRestaurantId = _selectedRestaurantId;
@synthesize isFromPushNotification = _isFromPushNotification;
@synthesize isPickUpOptionMe = _isPickUpOptionMe;
@synthesize isUserCreateOrder = _isUserCreateOrder;
//@synthesize viewRightMenu = _viewRightMenu;
@synthesize latitudeLast = _latitudeLast;
@synthesize longitudeLast = _longitudeLast;

@synthesize strPaymentUUID = _strPaymentUUID;

@synthesize iEditMenuIndex = _iEditMenuIndex;
@synthesize arrInvitees = _arrInvitees;
@synthesize senderId = _senderId, senderName = _senderName, pickupVenmoAccount = _pickupVenmoAccount, picupId = _picupId, picupName = _picupName, lastOrderAmount = _lastOrderAmount;

@synthesize isInvitationActive = _isInvitationActive;

static AppManager *sharedInstance_ = nil;


+ (AppManager *) sharedDataAccess{
    @synchronized(self){
		if (sharedInstance_ == nil) {
			sharedInstance_ = [[self alloc] init];
            [sharedInstance_ initalization];
            return sharedInstance_;
		}
        return sharedInstance_;
	}
}

-(void)initalization{
    
    [self connectionAuth:^(BOOL finished) {
        if(finished){
            NSLog(@"success");
        }
    }];
    
    self.pickupVenmoAccount = @"";
    self.lastOrderAmount = 0;
    self.selectedRestaurantId = @"0";
    self.strDeviceToken = @"";
    self.strUUID = @"";
    self.arrUserMenuList = [NSMutableArray array];
    self.arrInviteeList = [NSMutableArray array];
    [AppManager sharedDataAccess].userInfo = [NSMutableDictionary dictionary];
    self.iEditMenuIndex = 0;
    /*
    self.userId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] intValue];
    self.firstName = [[NSUserDefaults standardUserDefaults] objectForKey:@"first_name"];
    NSLog(@"Name : %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"first_name"]);
    self.lastName = [[NSUserDefaults standardUserDefaults] objectForKey:@"last_name"];
    self.email = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
     */
}

-(void)clearInstance{
    /*
    self.userId = 0;
    self.firstName = @"";
    self.lastName = @"";
    self.email = @"";
    */


    // TO DO
    //self.selectedRestaurantId = 0;
    //self.restaurantInfo = nil;
    //[self.arrUserMenuList removeAllObjects];
    
    self.arrInvitees = nil;
    self.lastOrderAmount = 0;
    self.selectedRestaurantId = @"0";
    self.strDeviceToken = @"";
    self.strUUID = @"";
    self.pickupVenmoAccount = @"";
    [self.arrUserMenuList removeAllObjects];
    [self.arrInviteeList removeAllObjects];
    self.isFromPushNotification = NO;
    self.isUserCreateOrder = NO;
}

+ (NSString*)getTodayTomorrowFormat:(NSString*)day{
    
    NSDate *dtBooking = [NSDate date];
    
    if([day isEqualToString:@"Tomorrow"])
        dtBooking = [[NSDate date] dateByAddingTimeInterval:60*60*24*1];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM"];
    day = [formatter stringFromDate:dtBooking];
    
    return day;
}

#pragma mark - File handeling

+ (Boolean)writeFile:(NSString*)filePath Content:(NSString*)fileContent{
    
    @autoreleasepool {
        NSData *data = [fileContent dataUsingEncoding:NSUTF8StringEncoding];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:filePath] == NO){
            [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
        }
        else{
            if ([[NSFileManager defaultManager] isWritableFileAtPath:filePath]) {
                NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
                [file writeData:data];
                [file closeFile];
            }
        }
    }
    
    return true;
}

+ (Boolean)truncateFile:(NSString*)filePath{
    @autoreleasepool {
        if([[NSFileManager defaultManager] fileExistsAtPath:filePath] == YES){
            if ([[NSFileManager defaultManager] isWritableFileAtPath:filePath]) {
                NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
                [file truncateFileAtOffset:0];
                [file closeFile];
            }
        }
    }
    
    return true;
}

+ (NSString*)readFile:(NSString*)filePath{
    
    NSString *fileContent;
    @autoreleasepool {
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath] ==YES) {
            if ([[NSFileManager defaultManager] isReadableFileAtPath:filePath]) {
                NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePath];
                fileContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
        }
    }
    return fileContent;
}

+ (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}

- (Boolean)isValidPhoneNumber:(NSString *)phoneNumber{
    bool result = false;

    if ([phoneNumber length]>10) {
        NSString *mobileNumberPattern = @"[0-9]+";
        NSPredicate *mobileNumberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumberPattern];
        result = [mobileNumberPred evaluateWithObject:phoneNumber];
    }
    
    return result;
}

- (Boolean)validateEmailWithString:(NSString*)email{
    
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:email];
    
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}

- (Boolean)isEmptyString:(NSString*) textToCheck{
    BOOL blnReruntValue = false;
    
    textToCheck = [textToCheck stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([textToCheck length] <= 0) {
        return true;
    }
    
    return blnReruntValue;
}

#pragma validation Checking

-(void) checkPasswordValidation:(NSString *) password withConfirmedPassword:(NSString *) ConfirmedPassword{
    if([password  isEqualToString:ConfirmedPassword])
        return ;
    else
    {
        
        [self showAlertWithTitle:@"Alert" andMessage:@"Password Mismatch"];
    }
}


#pragma mark - Alert

// For ---> (Default Alert) TOBE Presented From Any Place
-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    
    [alertController addAction:cancelAction];
    
    //   Finally we can present the alert view controller as with any other view controller:
    
    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate ;
    UIViewController *vc = [ appdelegate.window rootViewController];
    
    [vc presentViewController: alertController animated:YES completion:nil];
    
}

// For ---> (Default Alert) TOBE Presented From Any View Controller

-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message fromViewController:(UIViewController *)vc{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    
    [alertController addAction:cancelAction];
    [vc presentViewController: alertController animated:YES completion:nil];
    
}

#pragma mark - Webservice

-(void) connectionAuth:(tokenCompletion) compblock{
    
    NSString *string = [NSString stringWithFormat:@"%@auth", ROOT_URL];
    NSDictionary *params = @ {@"userid" : @"sworksapi", @"password" : @"YL3nUUXKEXbRqn7H"};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:[NSSet setWithObject:@"text/json"]];
    [contentTypes addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = contentTypes;
    
    [manager POST:string parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        
        if([[responseObject objectForKey:@"status"] intValue] == 100)
        {
            NSString *authToken = [responseObject objectForKey:@"apitoken"];
            [[NSUserDefaults standardUserDefaults] setObject:authToken forKey:@"apitoken"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            compblock(YES);
        }
        else
            compblock(NO);
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@, %@", error, operation.responseString);
         compblock(NO);
         
     }];
    
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}


@end
