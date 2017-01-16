//
//  LiveFeedVC.m
//  VenuFest
//
//  Created by Sayan Chatterjee on 06/12/16.
//  Copyright © 2016 Sayan Chatterjee. All rights reserved.
//

#import "LiveFeedVC.h"

@interface EventFeedCell : UITableViewCell

@property (weak, nonatomic)  IBOutlet UIImageView *imgVwEvent;
@property (weak, nonatomic)  IBOutlet UILabel *lblEventName;
@property (weak, nonatomic)  IBOutlet UILabel *lblEventDate;

@end

@implementation EventFeedCell

-(void)setUpUIForCell
{
    self.lblEventName.font  = [UIFont systemFontOfSize:14];
    self.lblEventName.textColor = PAGE_TITLE_TEXT_COLOR_BLACK;
    
    self.lblEventDate.font  = [UIFont systemFontOfSize:14];
    self.lblEventDate.textColor = PAGE_TITLE_TEXT_COLOR_BLACK;
    self.imgVwEvent.contentMode = UIViewContentModeScaleAspectFit;
}


@end


@interface LiveFeedVC ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    NSMutableArray *arrEventFeeds;
    CGPoint lastOffset;
}

@property (weak, nonatomic) IBOutlet UITableView *tableEventFeed;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopSpaceConst;

@end

@implementation LiveFeedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

#pragma mark - Table View Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return arrEventFeeds.count;
      return 10;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  180;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dictEventFeed = [arrEventFeeds objectAtIndex:indexPath.row];
    
    static NSString *cellIdentifier = @"feedCell";
    EventFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell setUpUIForCell];
    [self setupDataForCellWithCell:cell andEventDetaisl:dictEventFeed];
    
    //========= Test Code , Remove Later =======
    if (indexPath.row %2 == 0) {
        cell.lblEventName.text = @"Sample Event";
        cell.lblEventDate.text = @"31st December";
        cell.imgVwEvent.image = [UIImage imageNamed:@"cover1"];
    }
    else
    {
        cell.lblEventName.text = @"New Year Event";
        cell.lblEventDate.text = @"1st Januaryr";
        cell.imgVwEvent.image = [UIImage imageNamed:@"cover2"];
    }
    //========= End Test Code =======

    return cell;
}

#pragma mark - Table Data Source Helpers


-(void)setupDataForCellWithCell:(EventFeedCell *)cell andEventDetaisl:(NSDictionary *)dictEvent
{
    cell.lblEventName.text = @"DEMO EVENT";
    cell.lblEventDate.text = @"31ST DECEMBER";
    
    //For Downloading tracks images
    /*
     NSString *imgURL = [NSString stringWithFormat:@"%@", _user.UserImage];
     NSString *escapedPath = [imgURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
     
     if ( !isProfileImageDownloaded) {
     [self downloadandConfigImageWithURL:[NSURL URLWithString:escapedPath] WithImageView:self.imgVwProfilePic];
     }
     */
}

//Download Image Asycn
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
                imgView.image  = [UIImage imageNamed:@"defaulttrack.png"];
            });
        }
    }];
    [task resume];
}

#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSDictionary *dictActivity = [arrEventFeeds objectAtIndex:indexPath.row];
    
}

#pragma mark - Scrol View Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.tableEventFeed]) {
        CGPoint currentOffset = scrollView.contentOffset;
        
        if (currentOffset.y > lastOffset.y) {
            if (self.headerViewTopSpaceConst.constant >= -self.headerView.frame.size.height) {
                self.headerViewTopSpaceConst.constant -= 1.0;
                self.tableViewTopSpaceConst.constant -= 1.0;
            }
        }
        else
        {
            if (self.headerViewTopSpaceConst.constant < 0) {
                self.headerViewTopSpaceConst.constant += 1.0;
                self.tableViewTopSpaceConst.constant += 1.0;
            }
            
        }
        
        if (scrollView.contentOffset.y  > 0)
            lastOffset = scrollView.contentOffset;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
