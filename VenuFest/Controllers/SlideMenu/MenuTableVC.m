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

@interface MenuTableVC ()
{
    NSArray *menuItems;
}

@end

@implementation MenuTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    CGRect frame = self.tableView.frame;
//    frame.origin.y = -20;
    self.tableView.frame = frame;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView reloadData];
}


#pragma mark - Config UI
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
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
                imgView.image  = [UIImage imageNamed:@"default_profile.jpg"];
            });

        }
    }];
    [task resume];
}


#pragma mark - Table View Data Source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return  self.view.bounds.size.height / 3 ;
    }
    else
        return 50;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([AppManager sharedDataAccess].loggedInUserType == userTypeCustomer) {
        
        UITableViewCell *cell ;
        
        if(indexPath.row ==0)
        {
            static NSString *CellIdentifier1 = @"profile";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
            [self configCelllabelWith:lblCellTag];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor clearColor];
            
            UIView *bgColorView = [[UIView alloc] init];
            bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
            [cell setSelectedBackgroundView:bgColorView];
        }
        
        else if(indexPath.row ==1)
        {
            static NSString *CellIdentifier2 = @"home";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
            [self configCelllabelWith:lblCellTag];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor clearColor];
            
            UIView *bgColorView = [[UIView alloc] init];
            bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
            [cell setSelectedBackgroundView:bgColorView];
        }
        
        else if(indexPath.row ==2)
        {
            static NSString *CellIdentifier4 = @"bookings";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
            UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
            [self configCelllabelWith:lblCellTag];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor clearColor];
            
            UIView *bgColorView = [[UIView alloc] init];
            bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
            [cell setSelectedBackgroundView:bgColorView];
        }
        
        else if(indexPath.row ==3)
        {
            static NSString *CellIdentifier3 = @"settings";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
            UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
            [self configCelllabelWith:lblCellTag];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor clearColor];
            
            UIView *bgColorView = [[UIView alloc] init];
            bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
            [cell setSelectedBackgroundView:bgColorView];
            
        }
        
        else if(indexPath.row ==4)
        {
            static NSString *CellIdentifier4 = @"help";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
            UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
            [self configCelllabelWith:lblCellTag];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor clearColor];
            
            UIView *bgColorView = [[UIView alloc] init];
            bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
            [cell setSelectedBackgroundView:bgColorView];
            
        }
        else if(indexPath.row ==5)
        {
            static NSString *CellIdentifier4 = @"logout";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
            UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
            [self configCelllabelWith:lblCellTag];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor clearColor];
            
            UIView *bgColorView = [[UIView alloc] init];
            bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
            [cell setSelectedBackgroundView:bgColorView];
            
        }
        
        return cell;

    }
    else if ([AppManager sharedDataAccess].loggedInUserType == userTypeVendor)
    {
        UITableViewCell *cell;
        
        if(indexPath.row ==0)
        {
            static NSString *CellIdentifier1 = @"profile";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
            UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
            [self configCelllabelWith:lblCellTag];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor clearColor];
            
            UIView *bgColorView = [[UIView alloc] init];
            bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
            [cell setSelectedBackgroundView:bgColorView];
            
        }
        
        else if(indexPath.row ==1)
        {
            static NSString *CellIdentifier2 = @"home";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
            [self configCelllabelWith:lblCellTag];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor clearColor];
            
            UIView *bgColorView = [[UIView alloc] init];
            bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
            [cell setSelectedBackgroundView:bgColorView];
        }
        
        else if(indexPath.row ==2)
        {
            static NSString *CellIdentifier4 = @"my_assets";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
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
            static NSString *CellIdentifier4 = @"bookings";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
            UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
            [self configCelllabelWith:lblCellTag];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor clearColor];
            
            UIView *bgColorView = [[UIView alloc] init];
            bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
            [cell setSelectedBackgroundView:bgColorView];
        }
        
        else if(indexPath.row ==4)
        {
            static NSString *CellIdentifier3 = @"settings";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
            UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
            [self configCelllabelWith:lblCellTag];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor clearColor];
            
            UIView *bgColorView = [[UIView alloc] init];
            bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
            [cell setSelectedBackgroundView:bgColorView];
            
        }
        
        else if(indexPath.row ==5)
        {
            static NSString *CellIdentifier4 = @"help";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
            UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
            [self configCelllabelWith:lblCellTag];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor clearColor];
            
            UIView *bgColorView = [[UIView alloc] init];
            bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
            [cell setSelectedBackgroundView:bgColorView];
            
        }
        
        else if(indexPath.row ==6)
        {
            static NSString *CellIdentifier4 = @"logout";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
            UILabel *lblCellTag = (UILabel *) [cell.contentView viewWithTag:1];
            [self configCelllabelWith:lblCellTag];
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor clearColor];
            
            UIView *bgColorView = [[UIView alloc] init];
            bgColorView.backgroundColor = TOP_BAR_BACKGROUND_COLOR;
            [cell setSelectedBackgroundView:bgColorView];
            
        }
        
        return cell;

    }
    else
        return nil;
}

-(void)configCelllabelWith:(UILabel *)lblTag
{
    lblTag.textColor = MENU_BACKGROUND_COLOR;
    lblTag.font = MENU_CELL_TITLE_FONT;
    
}

#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ([AppManager sharedDataAccess].loggedInUserType == userTypeCustomer) {
        
        if (indexPath.row == 5) {
            [self showAlertWithTitle:@"Alert!" andMessage:@"Are you sure, you want to logout from Venu Fest" fromViewController:self];
        }
    }
    else if ([AppManager sharedDataAccess].loggedInUserType == userTypeVendor)
    {
        if (indexPath.row == 6) {
            [self showAlertWithTitle:@"Alert!" andMessage:@"Are you sure, you want to logout from Venu Fest" fromViewController:self];
        }
    }
}

-(void)logoutUser
{
    [self.navigationController popToRootViewControllerAnimated:NO];
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
