//
//  VehicleTableCell.h
//  BidDesign
//
//  Created by Nickyboy on 2014-08-28.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehicleTableCell : UITableViewCell
{
    IBOutlet UIImageView *imageVeh;
    IBOutlet UILabel *labelVin;
    IBOutlet UILabel *labelName;
    IBOutlet UILabel *labelOdo;
    IBOutlet UILabel *labelNY;
    IBOutlet UILabel *labelTimeDate;
    IBOutlet UILabel *labelLaneGrade;
    IBOutlet UIButton *buttonWatchlist;
}


@property(nonatomic,retain)IBOutlet UILabel *labelLaneGrade;
@property(nonatomic,retain)IBOutlet UIButton *buttonWatchlist;
@property(nonatomic,retain)IBOutlet UILabel *labelTimeDate;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UIImageView *imageVeh;
@property(nonatomic,retain)IBOutlet UILabel *labelVin;
@property(nonatomic,retain)IBOutlet UILabel *labelOdo;
@property(nonatomic,retain)IBOutlet UILabel *labelNY;
@end
