//
//  ProfileVC.m
//  RP
//
//  Created by Mac on 02/09/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)


#import "ProfileVC.h"
#import "AllPhotosView.h"
#import "RunnerUser.h"
#import "EditProfileVC.h"
#import "JSON.h"

@interface ProfileVC()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, AllPhotosDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate>

{
    NSURL *imageURL;
    BOOL isProfileImageDownloaded;
    NSMutableArray *arrMFeedBacks;
    
}

@property (nonatomic, assign) genderType userGender;
@property (nonatomic, strong) NSArray *arrActivities;
@property (nonatomic, strong)  DVSwitch *segmentController;

@end

@implementation ProfileVC


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.lblHeader.text = @"My Profile";
    
    self.segmentController = [[DVSwitch alloc] initWithStringsArray:@[@"Profile Info", @"All Photos"]];
    self.vwSegment.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.segmentController.frame = self.vwSegment.frame;
    
    self.segmentController.font = PAGE_TITLE_FONT;
    self.segmentController.cornerRadius = 0;
    //    self.segmentController.sliderColor = [UIColor clearColor];
    [self.view addSubview:self.segmentController];
    self.segmentController.backgroundColor = [UIColor clearColor];
    
    arrMFeedBacks = [NSMutableArray array];
    
    if (!_isVistingFriendProfile) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogout) name:USER_LOGOUT_NOTIFICATION object:nil];
        self.topView.hidden = YES;
    }
    else
    {
        self.headerView.hidden = YES;
        self.topView.hidden = NO;
        self.topView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
//        self.lblTopTitle.font = TOP_BAR_TITLE_FONT;
        self.lblTopTitle.textColor = TOP_BAR_TEXT_COLOR;
        self.lblTopTitle.text = @"Friend's Profile";
        self.btnEditProfile.hidden = YES;
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] init];
        gesture.delegate = self;
        [self.view addGestureRecognizer:gesture];
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if (!_isVistingFriendProfile) {
        [self connectionGetUserwithcompletion:^{
            //        [self connectionGetJoggerActivity];
            [self connectionGetJoggerFeedback];
        }];
    }
    else
    {
        CGRect frame = self.scroll.frame;
        if (IS_IPHONE5) {
            frame.size.height += 30;
        }
        else
            frame.size.height += 50;
        self.scroll.frame = frame;
        [self connectionGetJoggerFeedback];
    }

}

#pragma mark - Gesture Recogniser Delegate
//this will disable the swipe gesture for Friend Profile
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    BOOL shouldResponse = YES;
    if ( self.isVistingFriendProfile) {
        shouldResponse = NO;
    }
    
    return shouldResponse;
}


-(void)setScrollView
{
    CGFloat xPos = 0;
    
    CGRect frame = _scroll.frame;
    frame.origin.x = xPos;
    for (int i = 0; i <= 1; i++) {
        [self addViewsIntoScrollwithFrame:frame andIndex:i];
        xPos += CGRectGetWidth(frame);
        frame.origin.x = xPos;
        [self.scroll setContentSize:CGSizeMake(xPos, self.scroll.frame.size.height)];
    }
}

#pragma mark - Config Main Scroll View For User Profile

-(void)addViewsIntoScrollwithFrame:(CGRect)frame andIndex:(int)index
{
    switch (index) {
        case 0:
        {
            Personal_infoView *personalVw = [[Personal_infoView alloc]  initWithFrame:frame];
            //For Others prfole Visit
            if (self.isVistingFriendProfile) {
                personalVw.isVisitingOthersProfile = YES;
            }
            frame.origin.y = 0;
            personalVw.frame = frame;
            [self.scroll addSubview:personalVw];
            
            personalVw.strAbout = _user.AboutMe;
            personalVw.strEmail = _user.Email;
            personalVw.strPhone = _user.Phone;
            personalVw.strCity = _user.City;
            
            self.userGender = [_user.Gender intValue];
            NSString *strGender = [[AppManager sharedDataAccess]getUserGenderTypeWithValue:_userGender];
            personalVw.strGender = strGender;
            
            NSString *age = [NSString stringWithFormat:@"%d", [_user.Age intValue]];
            personalVw.strAge = age;
            
            NSString *height = [NSString stringWithFormat:@"%.1f", [_user.Height floatValue]];
            NSString *weight = [NSString stringWithFormat:@"%.1f", [_user.Weight floatValue]];
            personalVw.strHeight = height;
            personalVw.strWeight = weight;
            
            [personalVw configData];
            break;
        }
            /*
             case 1:
             {
             Physical_InfoView *physicalVw = [[Physical_InfoView alloc]  initWithFrame:frame];
             frame.origin.y = 0;
             physicalVw.frame = frame;
             [self.scroll addSubview:physicalVw];
             NSString *height = [NSString stringWithFormat:@"%.1f", [_user.Height floatValue]];
             NSString *weight = [NSString stringWithFormat:@"%.1f", [_user.Weight floatValue]];
             
             physicalVw.strHeight = height;
             physicalVw.strWeight = weight;
             [physicalVw configData];
             break;
             }
             case 2:
             {
             Contact_InfoView *contactVw = [[Contact_InfoView alloc]  initWithFrame:frame];
             frame.origin.y = 0;
             contactVw.frame = frame;
             [self.scroll addSubview:contactVw];
             contactVw.strEmail = _user.Email;
             contactVw.strPhone = _user.Phone;
             contactVw.strState = _user.State;
             contactVw.strAddressLine1 = _user.StreetAddress1;
             contactVw.strAddressLine2 = _user.StreetAddress2;
             contactVw.strCountry = _user.Country;
             
             [contactVw configData];
             break;
             }
             case 3:
             {
             UserRunningTracks_Vw *runningTracks = [[UserRunningTracks_Vw alloc]  initWithFrame:frame];
             runningTracks.arrTracks = self.arrActivities;
             frame.origin.y = 0;
             runningTracks.frame = frame;
             [self.scroll addSubview:runningTracks];
             break;
             }
             */
        case 1:
        {
            AllPhotosView *allPhotos = [[AllPhotosView alloc]  initWithFrame:frame];
            allPhotos.cellDelegate = self;
            if (arrMFeedBacks.count > 0)
                allPhotos.arrPhotos = arrMFeedBacks;
            
            frame.origin.y = 0;
            allPhotos.frame = frame;
            [self.scroll addSubview:allPhotos];
            break;
        }
        default:
            break;
    }
}

-(void)createCustomUI
{
    self.lblHeader.text = @"My Profile";
  
    self.imgVwProfilePic.layer.cornerRadius =   self.imgVwProfilePic.frame.size.width /2;
    
//    self.lblName.font = BODY_TEXT_FONT;
    self.lblName.textColor = APP_BUTTON_BACKGROUND_COLOR;
    self.lblName.text= [NSString stringWithFormat:@"%@", _user.FirstName.length == 0 ? @"User" : _user.FirstName];

    self.lblDistance.font = APP_NUMBER_FONT_MEDIUM_BOLD;
    self.lblDistance.textColor = PAGE_TITLE_TEXT_COLOR_BLACK;
    self.lblDistance.text=[NSString stringWithFormat:@"%.2f KM",[_user.TotalDistance floatValue]];

    self.lblTime.font = APP_NUMBER_FONT_MEDIUM_BOLD;
    self.lblTime.textColor = PAGE_TITLE_TEXT_COLOR_BLACK;
    self.lblTime.text =  [self calculateRunTimeWithValue:_user.TotalTime];

//    self.lblTagTime.font= BODY_TEXT_FONT;
    self.lblTagTime.textColor = SEARCH_HEADER_BACKGROUND_COLOR;
      self.lblTagTime.text = @"Total Runs:";     // @"Total Time:";
    
//    self.lblTagDistance.font = BODY_TEXT_FONT;
    self.lblTagDistance.textColor = SEARCH_HEADER_BACKGROUND_COLOR;
    self.btnUpload.hidden=YES;
     self.lblTagDistance.text = @"Total Distance:";
    
    UITapGestureRecognizer *DoubletapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    DoubletapGesture.numberOfTapsRequired = 1;
    if (!self.isVistingFriendProfile) {
        [_imgVwProfilePic addGestureRecognizer:DoubletapGesture];
    }
    
//    NSString *imgURL = [NSString stringWithFormat:@"%@%@", RP_BASE_URL, _user.UserImage];
    NSString *imgURL = [NSString stringWithFormat:@"%@", _user.UserImage];
    NSString *escapedPath = [imgURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    if ( !isProfileImageDownloaded) {
        [self downloadandConfigImageWithURL:[NSURL URLWithString:escapedPath] WithImageView:self.imgVwProfilePic];
    }
    self.imgVwProfilePic.clipsToBounds = YES;
    self.imgVwProfilePic.layer.borderWidth = 0.5;
    self.imgVwProfilePic.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imgVwProfilePic.contentMode = UIViewContentModeScaleAspectFit;
    
    //buttons
    _btnUpload.backgroundColor = [UIColor clearColor];
//    _btnUpload.titleLabel.textColor =  APP_BUTTON_TEXT_COLOR;
//    _btnUpload.titleLabel.font = APP_BUTTON_TITLE_FONT;
//    [_btnUpload setTitle:@"UPLOAD" forState:UIControlStateNormal];
//    _btnUpload.tintColor = APP_BUTTON_TEXT_COLOR;

    
    __weak typeof(self) weakSelf = self;

    [self.segmentController setPressedHandler:^(NSUInteger index) {
        
        if (index == 0) {
            RPLog(@"Profile Info");
            [weakSelf autoScrollOnSlectedIndex:index];
        }
        else if (index == 1)
        {
            RPLog(@"All Photos");
            [weakSelf autoScrollOnSlectedIndex:index];
        }

    }];
    
    //TODO: Currently all validation are Hidden
    /*
    if (!self.user.Weight || [self.user.Weight intValue] == 0)
    {
        [self showAlertWithTitle:@"Alert!" andMessage:@"You need to set your body weight correctly to get desired result!!!"];
    }
    */
}

#pragma mark - Alert

-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Later"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   [self clickEditprofile:nil];
                               }];
    
    alertController.view.tintColor = PAGE_TITLE_TEXT_COLOR_GREEN;
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController: alertController animated:YES completion:nil];
}

#pragma mark - Scroll View Off Set Change

//Helper For Auto Scroll On Seleted Button Index.
-(void)autoScrollOnSlectedIndex:(NSUInteger)index
{
    CGFloat xPOs = self.scroll.frame.size.width;
    xPOs *= index;
    CGPoint visiblePoint = CGPointMake(xPOs, 0);
    [UIView animateWithDuration:0.3 animations:^{
        [_scroll setContentOffset:visiblePoint];
        
    } completion:^(BOOL finished) {
        ;
    }];
}

/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.scroll]) {
        
        CGFloat xPOs = scrollView.contentOffset.x;
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = xPOs / pageWidth;
        
        RPLog(@"page : %d", page);
        
        if (page > 0) {
            [self.segmentController forceSelectedIndex:page animated:YES];
        }
        else
        {
            [self.segmentController forceSelectedIndex:page animated:YES];
        }
    }
}
*/

- (void)handleTapGesture:(UITapGestureRecognizer *)sender
{
    isProfileImageDownloaded = YES;
    [self  showAlertForProfileImageWithTitle:@"Upload Your Profile Image" andMessage:@"Please select from below"];
}

#pragma mark - Helpers

-(NSString *)calculateRunTimeWithValue:(NSNumber *)value
{
    NSMutableString *result;
    result = [NSMutableString string];
    
    unsigned long milliseconds=[value longValue];
    unsigned long seconds = milliseconds / 1000;
    milliseconds %= 1000;
    unsigned long minutes = seconds / 60;
    seconds %= 60;
    unsigned long hours = minutes / 60;
    minutes %= 60;
    result = [NSMutableString new];
    [result appendFormat: @"%lu:", hours];
    
    if (minutes <=9)
        [result appendFormat: @"0%lu:", minutes];
    else
        [result appendFormat: @"%2lu:", minutes];
    
    if (seconds <=9)
        [result appendFormat: @"0%lu", seconds];
    else
        [result appendFormat: @"%2lu", seconds];
    
    return result;
}

-(void) downloadandConfigImageWithURL:(NSURL *)url WithImageView:(UIImageView*)imgView{
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = imgView.center;
    [imgView addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [activityIndicator stopAnimating];
                    imgView.image = image;
                });
            }
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [activityIndicator stopAnimating];
                imgView.image  = [UIImage imageNamed:@"profile.jpg"];
            });
        }
    }];
    [task resume];
}

#pragma mark - Click Events

-(void)userLogout
{
    RPLog(@"RP User logout action....");
    [[AppManager sharedDataAccess] clearInstance];
    [self.tabBarController.navigationController popToRootViewControllerAnimated:NO];
}

-(IBAction)clickedClose:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)clickEditprofile:(id)sender
{
    
    EditProfileVC *editprofile = [self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileVC"];
    editprofile.user = self.user;
    [self.navigationController pushViewController:editprofile animated:YES];
    
}
-(IBAction)clickedUploadImage:(id)sender
{
    [self connectionPostImagewithImage:_imgVwProfilePic.image];
}

-(void)showAlertForProfileImageWithTitle:(NSString *)title andMessage:(NSString *)message
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Canceled.");
                                   }];
    
    
    UIAlertAction *gallaryAction = [UIAlertAction
                                    actionWithTitle:@"Choose Photo Gallary"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action)
                                    {
                                        NSLog(@"Gallary Action.");
                                        [self choosePhotoFromGallary];
                                    }];
    UIAlertAction *takePhotoAction = [UIAlertAction
                                      actionWithTitle:@"Take Photo"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction *action)
                                      {
                                          
                                          NSLog(@"Take Photo.");
                                          [self takePhoto];
                                      }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:gallaryAction];
    [alertController addAction:takePhotoAction];
    
    alertController.view.tintColor = [UIColor redColor];
    [self presentViewController: alertController animated:YES completion:nil];
}

#pragma mark - All Photos Delegate

-(void)cellSelected:(id)selectedView
{
    if ([selectedView isKindOfClass:[UIImageView class]]) {
        UIImageView *imgVw = selectedView;
        [self addZoomForImageWithImage:imgVw.image];
    }
}


-(void)addZoomForImageWithImage:(UIImage *)image
 {
     UIView *layeredVw = [[UIView alloc]  initWithFrame:self.view.frame];
     layeredVw.center = self.view.center;
     [self attachGestureWithSender:layeredVw];
     layeredVw.tag = 666;
     layeredVw.backgroundColor = PAGE_BACKGROUND_TRANSPARENT_BLACK;
     [self.view addSubview:layeredVw];
     
     
     CGRect rc = CGRectMake(20, layeredVw.frame.size.height/6, layeredVw.frame.size.width - 40, layeredVw.frame.size.height/1.5);
     UIScrollView *zoomedVw = [[UIScrollView alloc]initWithFrame: rc];
     zoomedVw.tag = 555;
     zoomedVw.minimumZoomScale=1.0;
     zoomedVw.maximumZoomScale=3.0;
     [zoomedVw setDelegate:self];
     UIImageView *imageVw = [[UIImageView alloc]  initWithFrame:zoomedVw.bounds];
     imageVw.image = image;
     imageVw.tag = 1001;
     imageVw.contentMode = UIViewContentModeScaleAspectFit;
     [zoomedVw addSubview:imageVw];

     [layeredVw addSubview:zoomedVw];
 }

-(void)attachGestureWithSender:(UIView *)sender
{
    UITapGestureRecognizer *tapToClose = [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(tappedOnZoomedVwWithSender:)];
    tapToClose.numberOfTapsRequired = 1;
    [sender addGestureRecognizer:tapToClose];
}

-(void)tappedOnZoomedVwWithSender:(UIGestureRecognizer *)sender
{
    UIView *superView = sender.view.superview;
    NSArray *subViews = [superView subviews];
    for (UIView *vw in subViews) {
        if (vw.tag == 666) {
            [vw removeFromSuperview];
        }
    }
}

#pragma mark - Scroll View Delegate Methgods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    UIImageView *scrollImage;
    if (scrollView.tag == 555) {
        scrollImage = (UIImageView *)[scrollView viewWithTag:1001];
        return  scrollImage;
    }
    return  nil;
}

#pragma mark - Image Picker Helpers

-(void)choosePhotoFromGallary
{
    UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
    imagePickController.delegate=self;
    imagePickController.allowsEditing=YES;
    
    if ([UIImagePickerController  isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {//Check PhotoLibrary  available or not
        imagePickController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickController animated:YES completion:nil];
    }
}

-(void)takePhoto
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        [[AppManager sharedDataAccess] showAlertWithTitle:@"Alert!" andMessage:@"Device has no camera" fromViewController:self];
    }
    else
    {
        UIImagePickerController* imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
    }
}




#pragma mark - ImagePicker Delegates

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    NSURL* localUrl = (NSURL *)[info valueForKey:UIImagePickerControllerReferenceURL];
    imageURL = localUrl;
    
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if(originalImage==nil)
    {
        originalImage = [info objectForKey:UIImagePickerControllerCropRect];
    }
    if(originalImage==nil)
    {
        originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    originalImage = [self imageWithImage:originalImage];
    self.imgVwProfilePic.image = originalImage;
    
    [picker dismissViewControllerAnimated:YES completion:^{
        self.btnUpload.hidden=NO;
    }];
}
-(UIImage*)imageWithImage: (UIImage*) sourceImage
{
    float  i_width = 300;
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
//    [AppManager sharedDataAccess].scrollListType = profileListTypeNone;
}

#pragma mark - Webservice


-(void)connectionGetUserwithcompletion: (void (^ __nullable)(void))completion
{
    NSString *requestTypeMethod =   [[AppManager sharedDataAccess]  getStringForRequestType: GET];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[RPNetworkManager defaultNetworkManager] RPServicewithMethodName:GET_USER_PATH withParameters:nil andRequestType:requestTypeMethod success:^(id response) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSDictionary *dictData;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dictData = response;
        }
        if ([[dictData objectForKey:@"ErrorCode"]  intValue] == 200 ) {
            
            DCParserConfiguration *config = [DCParserConfiguration configuration];
            DCObjectMapping *mapper = [DCObjectMapping mapKeyPath:@"Id" toAttribute:@"userID" onClass:[RunnerUser class]];
            [config addObjectMapping:mapper];
            
            
            DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass: [RunnerUser class] andConfiguration:config];
            RunnerUser *user = [parser parseDictionary:[dictData objectForKey:@"Result"]];
            
            if (user) {
                RPLog(@"Get User Result : %@", user.description);
                self.user =  user;
                [AppManager sharedDataAccess].user = user;
            }
            completion();
        }
        else
        {
            [[AppManager sharedDataAccess] showAlertWithTitle:@"Warning!" andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"ErrorMessage"]] fromViewController:self];
        }
    } failure:^(id failureMessage, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        RPLog(@"Error : %@", error.localizedDescription);
    }];
    
}
/*
-(void)connectionGetJoggerActivity
{
    NSString *requestTypeMethod =   [[AppManager sharedDataAccess]  getStringForRequestType: GET];
    NSString *strMethodname = [NSString stringWithFormat:@"%@/%@",JOGGER_ACTIVITY, _user.userID ];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RPNetworkManager defaultNetworkManager] RPServicewithMethodName:strMethodname withParameters:nil andRequestType:requestTypeMethod success:^(id response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        NSDictionary *dictData;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dictData = response;
        }
        NSLog(@"%@", response);
        if ([[dictData objectForKey:@"ErrorCode"]  intValue] == 200 ) {
            
            self.arrActivities = [dictData objectForKey:@"Result"];
//            [self setScrollView];
            [self createCustomUI];

        }
        else
        {
            [[AppManager sharedDataAccess] showAlertWithTitle:@"Warning!" andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"ErrorMessage"]] fromViewController:self];
        }
    } failure:^(id failureMessage, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        RPLog(@"Error : %@", error.localizedDescription);
    }];

}
*/

-(void)connectionGetJoggerFeedback
{
    NSString *requestTypeMethod =   [[AppManager sharedDataAccess]  getStringForRequestType: GET];
    NSString *methodName = [NSString stringWithFormat:@"%@/%@",@"userfeedbacks", self.user.userID];
    //userfeedbacks/{joggerId}
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[RPNetworkManager defaultNetworkManager] RPServicewithMethodName:methodName withParameters:nil andRequestType:requestTypeMethod success:^(id response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSDictionary *dictData;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dictData = response;
        }
        NSLog(@"%@", response);
        if ([[dictData objectForKey:@"ErrorCode"]  intValue] == 200 ) {
            [arrMFeedBacks removeAllObjects];
            NSArray *arrFeedBack = [dictData objectForKey:@"Result"];
            for (NSDictionary *dictFeedBack  in arrFeedBack) {
                
                NSString *strImagePath = [NSString stringWithFormat:@"%@", [dictFeedBack objectForKey:@"PhotoPath"]];
                if (strImagePath.length > 0) {
                    //TODO: Append the dict into main array
                    [arrMFeedBacks addObject:dictFeedBack];
                }
            }
        }
        else
        {
            //Could Not Fetch Photos
//            [[AppManager sharedDataAccess] showAlertWithTitle:@"Warning!" andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"ErrorMessage"]] fromViewController:self];
        }
        
        [self setScrollView];
        [self createCustomUI];

        
    } failure:^(id failureMessage, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        RPLog(@"Error : %@", error.localizedDescription);
    }];
    
}

//upload image to server

-(void)connectionPostImagewithImage:(UIImage *)image
{
    NSString *base64ImageThmb = [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys: base64ImageThmb, @"ImageContent", nil];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    //Image_type PNG ---->>> 1
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%d", RP_BASE_URL,POST_PROFILE_IMAGE_INBYTES,profileImageTypePNG]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *authKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"AuthToken"];
    [request addValue:RP_API_KEY forHTTPHeaderField:@"S-Api-Key"];
    [request addValue:authKey forHTTPHeaderField:@"S-Auth-Token"];
    [request addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-type"];

    [request setHTTPMethod:@"POST"];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    
    NSString *jsonStringMEDIA=[NSString stringWithString:[parameters JSONRepresentation]];
    [request setHTTPBody:[jsonStringMEDIA dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        if (error) {
            NSLog(@"Error Desc. ==>>%@",[error description]);
            return ;
        }
        NSDictionary *dictResult = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        RPLog(@"%@", dictResult);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([[dictResult objectForKey:@"ErrorCode"] intValue] == 200) {

                NSString *imagepath = [dictResult objectForKey:@"Result"];
                if (imagepath.length > 0) {
                    [AppManager sharedDataAccess].strUserImagePath = imagepath;
                    [[NSUserDefaults standardUserDefaults] setObject:[AppManager sharedDataAccess].strUserImagePath forKey:@"userProfileImage"];
                }
                
                isProfileImageDownloaded = YES;
                [[AppManager sharedDataAccess] showAlertWithTitle:@"Success!" andMessage:@"Your Profile Image has been changed successfully" fromViewController:self];
                self.btnUpload.hidden=YES;
            }
            else
            {
                [[AppManager sharedDataAccess] showAlertWithTitle:@"Warning!" andMessage:[NSString stringWithFormat:@"%@", [dictResult objectForKey:@"ErrorMessage"]] fromViewController:self];
            }
        });
    }];
    
    [postDataTask resume];
}



-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
