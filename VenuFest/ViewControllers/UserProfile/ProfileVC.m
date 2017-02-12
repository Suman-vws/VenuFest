//
//  ProfileVC.m
//  RP
//
//  Created by Mac on 02/09/16.
//  Copyright © 2016 Mac. All rights reserved.
//

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)


#import "ProfileVC.h"
#import "Personal_infoView.h"
#import "ChangePasswordView.h"
#import "EditProfileVC.h"
#import "JSON.h"

@interface ProfileVC()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate, ChangePasswordDelegate>

{
    NSURL *imageURL;
    BOOL isProfileImageDownloaded;
    Personal_infoView *personalVw;
    ChangePasswordView *changePasswordVw;
}

@property (nonatomic, assign) genderType userGender;
@property (nonatomic, weak) IBOutlet ADVSegmentedControl *customSegmentController;

@end

@implementation ProfileVC


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogout) name:USER_LOGOUT_NOTIFICATION object:nil];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setScrollView];
    [self createCustomUI];
    
}

-(void)addConstrainsForView:(UIView *)childView withRefence:(UIView *)parentView
{
    NSLayoutConstraint *width =[NSLayoutConstraint
                                constraintWithItem:childView
                                attribute:NSLayoutAttributeWidth
                                relatedBy:0
                                toItem:parentView
                                attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                constant:0];
    NSLayoutConstraint *height =[NSLayoutConstraint
                                 constraintWithItem:childView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:0
                                 toItem:parentView
                                 attribute:NSLayoutAttributeHeight
                                 multiplier:1.0
                                 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:childView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:parentView
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0f
                               constant:0.0f];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:childView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:parentView
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0.f];
    
    [parentView addConstraint:width];
    [parentView addConstraint:height];
    [parentView addConstraint:top];
    [parentView addConstraint:leading];
    
}

-(void)setScrollView
{
    CGFloat xPos = 0;
    CGRect frame = self.bottomScrollVw.frame;
    
    for (int i = 0; i <= 1; i++) {
        
        [self addViewsIntoScrollwithFrame:self.bottomScrollVw.bounds andIndex:i];
        xPos += CGRectGetWidth(frame);
        [self.bottomScrollVw setContentSize:CGSizeMake(xPos, self.bottomScrollVw.frame.size.height)];
    }
}

#pragma mark - Config Main Scroll View For User Profile

-(void)addViewsIntoScrollwithFrame:(CGRect)frame andIndex:(int)index
{
    switch (index) {
            
        case 0:
        {
            if (!personalVw) {
                personalVw = [[Personal_infoView alloc]  initWithFrame:frame];
            }
            personalVw.translatesAutoresizingMaskIntoConstraints = NO;
            personalVw.backgroundColor = [UIColor whiteColor];
            [self.bottomScrollVw addSubview:personalVw];
//            [personalVw configData];
            [self addConstrainsForView:personalVw withRefence:self.bottomScrollVw];

            break;
        }
            
        case 1:
        {
            if (!changePasswordVw) {
                changePasswordVw = [[ChangePasswordView alloc]  initWithFrame:frame];
            }
            changePasswordVw.translatesAutoresizingMaskIntoConstraints = NO;
            changePasswordVw.passwordDelgate = self;
            changePasswordVw.backgroundColor = [UIColor clearColor];
            [self.bottomScrollVw addSubview:changePasswordVw];
            [self addConstraintsForChangePasswordVw];
            
            break;
        }
        default:
            break;
    }
}

-(void)addConstraintsForChangePasswordVw
{
    NSLayoutConstraint *width =[NSLayoutConstraint
                                constraintWithItem:changePasswordVw
                                attribute:NSLayoutAttributeWidth
                                relatedBy:0
                                toItem:self.bottomScrollVw
                                attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                constant:0];
    NSLayoutConstraint *height =[NSLayoutConstraint
                                 constraintWithItem:changePasswordVw
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:0
                                 toItem:self.bottomScrollVw
                                 attribute:NSLayoutAttributeHeight
                                 multiplier:1.0
                                 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:changePasswordVw
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:self.bottomScrollVw
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0f
                               constant:0.0f];
    
    
    NSDictionary *viewsDictionary =  NSDictionaryOfVariableBindings(personalVw, changePasswordVw);
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[personalVw]-0-[changePasswordVw]"
                                                                   options:0 metrics:nil views:viewsDictionary];
    [NSLayoutConstraint activateConstraints:constraints];
    
    [self.bottomScrollVw addConstraint:width];
    [self.bottomScrollVw addConstraint:height];
    [self.bottomScrollVw addConstraint:top];
}

-(void)createCustomUI
{
    self.customSegmentController.items = @[@"Profile Info", @"Change Password"];
    self.customSegmentController.font = PAGE_TITLE_FONT;
    self.customSegmentController.borderColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    self.customSegmentController.selectedIndex = 0;
    self.customSegmentController.thumbView.layer.cornerRadius = 0.0;
    self.customSegmentController.layer.cornerRadius = 0.0;
    self.customSegmentController.selectedLabelColor = PAGE_TITLE_TEXT_COLOR_BLACK;
    self.customSegmentController.unselectedLabelColor = BODY_TEXT_COLOR_WHITE;
    self.customSegmentController.backgroundColor =  PAGE_TITLE_TEXT_COLOR_GREEN;

    self.lblHeader.text = @"My Profile";
    self.imgVwProfilePic.layer.cornerRadius =   self.imgVwProfilePic.frame.size.width /2;
    self.lblUserName.font = PAGE_TITLE_FONT_LARGE;
    self.lblUserName.textColor = APP_BUTTON_BACKGROUND_COLOR;

    
    UITapGestureRecognizer *DoubletapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    DoubletapGesture.numberOfTapsRequired = 1;
    [_imgVwProfilePic addGestureRecognizer:DoubletapGesture];

    // ============== Download Profile Image ==========
    /*
    NSString *imgURL = [NSString stringWithFormat:@"%@", _user.UserImage];
    NSString *escapedPath = [imgURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    if ( !isProfileImageDownloaded) {
        [self downloadandConfigImageWithURL:[NSURL URLWithString:escapedPath] WithImageView:self.imgVwProfilePic];
    }
    */
    
    // ============== End ==========

    self.imgVwProfilePic.clipsToBounds = YES;
    self.imgVwProfilePic.layer.borderWidth = 0.5;
    self.imgVwProfilePic.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imgVwProfilePic.contentMode = UIViewContentModeScaleAspectFit;
}


#pragma mark - Scroll View Off Set Change

//Helper For Auto Scroll On Seleted Button Index.
-(void)autoScrollOnSlectedIndex:(NSUInteger)index
{
    CGFloat xPOs = self.bottomScrollVw.frame.size.width;
    xPOs *= index;
    CGPoint visiblePoint = CGPointMake(xPOs, 0);
    [UIView animateWithDuration:0.3 animations:^{
        [self.bottomScrollVw setContentOffset:visiblePoint];
        
    } completion:^(BOOL finished) {
        ;
    }];
}

#pragma mark - Upload Profile Image Action

- (void)handleTapGesture:(UITapGestureRecognizer *)sender
{
    isProfileImageDownloaded = YES;
    [self  showAlertForProfileImageWithTitle:@"Upload Your Profile Image" andMessage:@"Please select from below"];
}

#pragma mark - Helpers

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

#pragma mark - Change Password Delegate

-(void)animateScrollViewWithYpos:(CGFloat)Ypos andHeight:(CGFloat)height
{
    CGPoint offset = self.outerScrollVw.contentOffset;
    offset.y = Ypos;
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.outerScrollVw setContentOffset:offset];
                     }
                     completion:^(BOOL finished){
                     }];
    
    self.outerScrollVw.contentSize = CGSizeMake(self.view.frame.size.width, self.outerScrollVw.frame.size.height+ height);
}

-(void)userPasswordChangedWithData:(NSDictionary *)dictPasswordData
{
    [self connectionChangeUserPasswordWithParam:dictPasswordData];
}


#pragma mark - Click Events

-(IBAction)segmentValueChange:(ADVSegmentedControl *)sender
{
    if (sender.selectedIndex == 0) {
        
        RPLog(@"Selected Index : %lu", sender.selectedIndex);
        [self autoScrollOnSlectedIndex:sender.selectedIndex];
    }
    else if(sender.selectedIndex == 1) {
        
        RPLog(@"Selected Index : %lu", sender.selectedIndex);
        [self autoScrollOnSlectedIndex:sender.selectedIndex];
    }
}

-(void)userLogout
{
    RPLog(@"RP User logout action....");
    [[AppManager sharedDataAccess] clearInstance];
    [self.tabBarController.navigationController popToRootViewControllerAnimated:NO];
}


-(IBAction)clickEditprofile:(id)sender
{
    
    EditProfileVC *editprofile = [self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileVC"];
    [self.navigationController pushViewController:editprofile animated:YES];
    
}

                            // ============ Upload Image To Server ===============

                            //TODO: Handle Action For Upload Profile Image
                            // self connectionPostImagewithImage:[UIImage imageNamed:@""];

                            // ============ End ===============

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
        
        ;
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


#pragma mark - Webservice


-(void)connectionUserProfileDetails
{
    NSString *requestTypeMethod =   [[AppManager sharedDataAccess]  getStringForRequestType: POST];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[RPNetworkManager defaultNetworkManager] VFServicewithMethodName:USER_PROFILE_PATH withParameters:nil andRequestType:requestTypeMethod success:^(id response) {
        
        NSDictionary *dictData;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dictData = response;
        }
        if ([[dictData objectForKey:@"ErrorCode"]  intValue] == 200 ) {
            
            // TODO: Handle Serilization
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

-(void)connectionChangeUserPasswordWithParam:(NSDictionary *)dictParam
{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *requestTypeMethod =   [[AppManager sharedDataAccess]  getStringForRequestType: POST];

    [[RPNetworkManager defaultNetworkManager] VFServicewithMethodName:CHANGE_USER_PASSWORD_PATH withParameters:dictParam andRequestType:requestTypeMethod success:^(id response) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSDictionary *dictData;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dictData = response;
        }
        if ([[dictData objectForKey:@"ErrorCode"]  intValue] == 200 ) {
            RPLog(@"Success : %@", response);
            
            [[AppManager sharedDataAccess] showAlertWithTitle:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"ErrorMessage"]] andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"Result"]] fromViewController:self];
        }
        else
        {
            [[AppManager sharedDataAccess] showAlertWithTitle:@"Error!" andMessage:[NSString stringWithFormat:@"%@", [dictData objectForKey:@"Result"]] fromViewController:self];
        }
        
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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", VENU_FEST_BASE_URL,UPDATE_USER_PROFILE_IMAGE_PATH]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *authKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"AuthToken"];
    [request addValue:VENU_FEST_API_KEY forHTTPHeaderField:@"S-Api-Key"];
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
            }
            else
            {
                [[AppManager sharedDataAccess] showAlertWithTitle:@"Warning!" andMessage:[NSString stringWithFormat:@"%@", [dictResult objectForKey:@"ErrorMessage"]] fromViewController:self];
            }
        });
    }];
    
    [postDataTask resume];
}

#pragma mark - View Dissapper

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
