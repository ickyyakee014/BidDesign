//
//  LiveSales.h
//  BidDesign
//
//  Created by Nickyboy on 2014-09-02.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Internet.h"
@interface LiveSales : UIViewController<InternetDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrayLiveSales;
    Internet *conn;
    IBOutlet UITableView *tableLiveSales;
}

@property(nonatomic,retain) NSMutableArray *arrayLiveSales;
@property(nonatomic,retain) Internet *conn;
@property(nonatomic,retain) IBOutlet UITableView *tableLiveSales;
@end
