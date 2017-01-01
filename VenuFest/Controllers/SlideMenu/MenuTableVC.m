//
//  MenuTableVC.m
//  testSlideMenu
//
//  Created by Sayan Chatterjee on 24/07/16.
//  Copyright © 2016 Sayan Chatterjee. All rights reserved.
//

#import "MenuTableVC.h"
#import "RPConstants.h"
#import "AppManager.h"

@interface UserCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblUSerName;

@end

@implementation UserCell

@end

@interface MenuTableVC ()
{
    NSArray *menuItems;
}

@end

@implementation MenuTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    CGRect frame = self.tableView.frame;
    frame.origin.y = -20;
    self.tableView.frame = frame;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self configHeaderView];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    [self.tableView reloadData];
}

-(void)gotoProfile
{
    [self performSegueWithIdentifier:@"gotoProfile" sender:self];

}

#pragma mark - Config UI
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

-(void)configHeaderView
{
    self.VwTblHeader.backgroundColor = [UIColor clearColor];
    self.lblUserName.textColor = SLIDER_TEXT_COLOR;
//    self.lblUserName.font = MENU_HEADER_TITLE_FONT;
    self.lblUserName.textColor = APP_BUTTON_BACKGROUND_COLOR;
    self.imgProfile.backgroundColor = [UIColor whiteColor];
    self.imgProfile.clipsToBounds = YES;
    self.imgProfile.layer.cornerRadius =   self.imgProfile.layer.frame.size.width /2;
    UITapGestureRecognizer *tapProfile= [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(gotoProfile)];
    tapProfile.numberOfTapsRequired = 1;
    [self.VwTblHeader addGestureRecognizer:tapProfile];
    
    NSString *imgPath =  [[NSUserDefaults standardUserDefaults] objectForKey:@"userProfileImage"];
    NSString *escapedPath = [imgPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    [self downloadandConfigImageWithURL:[NSURL URLWithString:escapedPath] WithImageView:self.imgProfile];
    self.imgProfile.contentMode = UIViewContentModeScaleAspectFit;

    /*
    NSString *imgURL;
    if ([AppManager sharedDataAccess].user.LoginType == userLoginTypeGPlus || [AppManager sharedDataAccess].user.LoginType == userLoginTypeFacebook)
    {
        imgURL = imgPath;
  
    }
    else
        imgURL = [NSString stringWithFormat:@"%@%@", RP_BASE_URL, imgPath];

    
    [self downloadandConfigImageWithURL:[NSURL URLWithString:imgURL] WithImageView:self.imgProfile];
*/
//imgProfile
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


#pragma mark - Table View Data Source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    return 160.0f;
    return self.view.bounds.size.height / 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    /*
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectZero];
    UILabel *lblWellcome = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, 20)];
    lblWellcome.backgroundColor = [UIColor clearColor];
    lblWellcome.text = @"Welcome";
    lblWellcome.font = [UIFont systemFontOfSize:16];
    lblWellcome.textColor = [UIColor whiteColor];
    [viewHeader addSubview:lblWellcome];
    
    UILabel *lblUserName = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, tableView.frame.size.width-20, 30)];
    lblUserName.backgroundColor = [UIColor clearColor];
    lblUserName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
    lblUserName.font = [UIFont systemFontOfSize:22];
    lblUserName.textColor = [UIColor whiteColor];
    [viewHeader addSubview:lblUserName];
    
    viewHeader.backgroundColor = [UIColor colorWithRed:166.0/255 green:207.0/255 blue:115.0/255 alpha:1.0];
    */
    NSString *userName=[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    
    if (userName.length > 0)
        self.lblUserName.text = userName;
    else
        self.lblUserName.text = @"User";
   
    
    return self.VwTblHeader;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==0)
    {
        static NSString *CellIdentifier1 = @"HOME";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
        [self configCelllabelWith:lblCellTag];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
        [cell setSelectedBackgroundView:bgColorView];

        return cell;
    }
    else if(indexPath.row ==1)
    {
        static NSString *CellIdentifier2 = @"ACTIVITY";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
        [self configCelllabelWith:lblCellTag];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];

        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
        [cell setSelectedBackgroundView:bgColorView];
        return cell;
    }
    /*
    else if(indexPath.row ==2)
    {
        static NSString *CellIdentifier3 = @"PROFILE";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
        [self configCelllabelWith:lblCellTag];
        cell.contentView.backgroundColor = MENU_BACKGROUND_COLOR;
        return cell;
    }
    */
    else if(indexPath.row ==2)
    {
        static NSString *CellIdentifier4 = @"TRACKS";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
        UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
        [self configCelllabelWith:lblCellTag];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
        [cell setSelectedBackgroundView:bgColorView];
        return cell;
    }
    else if(indexPath.row ==3)
    {
        static NSString *CellIdentifier3 = @"FRIENDS";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
        [self configCelllabelWith:lblCellTag];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];

        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
        [cell setSelectedBackgroundView:bgColorView];
        
        return cell;
    }
    else if(indexPath.row ==4)
    {
        static NSString *CellIdentifier4 = @"EVENTS";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
        UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
        [self configCelllabelWith:lblCellTag];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];

        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
        [cell setSelectedBackgroundView:bgColorView];
        
        return cell;
    }
    else if(indexPath.row ==5)
    {
        static NSString *CellIdentifier4 = @"TERMS";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
        UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
        [self configCelllabelWith:lblCellTag];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
        [cell setSelectedBackgroundView:bgColorView];
        
        return cell;
    }
    /*
    else if(indexPath.row ==6)
    {
        static NSString *CellIdentifier5= @"LOGOUT";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier5];
        UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
        [self configCelllabelWith:lblCellTag];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor clearColor];
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
        [cell setSelectedBackgroundView:bgColorView];
        
        return cell;
    }
    */
    else
        return nil;
}

-(void)configCelllabelWith:(UILabel *)lblTag
{
    lblTag.textColor = MENU_BACKGROUND_COLOR;
//    lblTag.font = MENU_CELL_TITLE_FONT;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    /*
    if (indexPath.row == 6) {
        [self showAlertWithTitle:@"Alert!" andMessage:@"Are you sure, you want to logout from Runnr's Paradise" fromViewController:self];
    }   */
}

-(void)logoutUser
{
    [self performSegueWithIdentifier:@"LOGOUT" sender:self];
}

-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message fromViewController:(UIViewController *)vc{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"CANCEL"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                   }];
    UIAlertAction *logoutAction = [UIAlertAction
                                   actionWithTitle:@"LOGOUT"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       [[AppManager sharedDataAccess] clearInstance];
                                       [self logoutUser];
                                   }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:logoutAction];
    alertController.view.tintColor = [UIColor redColor];
    [vc presentViewController: alertController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
