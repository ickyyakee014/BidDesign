//
//  TableSections.h
//  BidDesign
//
//  Created by Nickyboy on 2014-08-26.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Internet.h"
@interface TableSections : UIViewController<InternetDelegate>
{
    Internet *conn;
    IBOutlet UITableView *tableView;
    IBOutlet UILabel *labelAloc;
    IBOutlet UISlider* slider;
    NSDictionary *dictVeh;
    NSMutableArray *arrayDict;
}
@property(nonatomic,retain)NSMutableArray *arrayDict;
@property(nonatomic, retain) NSDictionary *dictVeh;
@property(nonatomic, retain) Internet *conn;
@property(nonatomic,retain) IBOutlet UILabel *labelAloc;
@property(nonatomic,retain) IBOutlet UISlider* slider;
@property(nonatomic,retain) IBOutlet UITableView *tableView;
@end
