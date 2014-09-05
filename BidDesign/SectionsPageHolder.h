//
//  SectionsPageHolder.h
//  BidDesign
//
//  Created by Nickyboy on 2014-08-27.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Internet.h"
@interface SectionsPageHolder : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate,InternetDelegate>
{
    Internet *conn;
    IBOutlet UIView *viewTable;
    BOOL isShow;
    IBOutlet UITableView *tableShow;
    NSMutableArray *arrayTable;
    IBOutlet UIPageControl *dPageControl;
    NSString *dVehID;
}
@property (strong, nonatomic) UIPageViewController *pageController;
@property(nonatomic,retain) Internet *conn;
@property (strong, nonatomic) NSString *dVehID;
@property(nonatomic,retain) IBOutlet UITableView *tableShow;
@property(nonatomic,retain) NSMutableArray *arrayTable;
@property(nonatomic,assign) BOOL isShow;
@property(nonatomic,retain) IBOutlet UIView *viewTable;
@property(nonatomic,retain) IBOutlet UIPageControl *dPageControl;
@end
