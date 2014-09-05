//
//  LiveSalesCell.h
//  BidDesign
//
//  Created by Nickyboy on 2014-09-02.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveSalesCell : UITableViewCell
{
    IBOutlet UIImageView *imageCell;
    IBOutlet UILabel *labelName;
    IBOutlet UILabel *labelDesc;
}

@property(nonatomic,retain) IBOutlet UIImageView *imageCell;
@property(nonatomic,retain) IBOutlet UILabel *labelName;
@property(nonatomic,retain) IBOutlet UILabel *labelDesc;
@end
