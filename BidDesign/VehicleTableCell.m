//
//  VehicleTableCell.m
//  BidDesign
//
//  Created by Nickyboy on 2014-08-28.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import "VehicleTableCell.h"

@implementation VehicleTableCell
@synthesize labelNY,labelOdo,labelVin,imageVeh,labelName,labelTimeDate,buttonWatchlist,labelLaneGrade;
-(void)dealloc{
    [labelLaneGrade release];
    [buttonWatchlist release];
    [labelTimeDate release];
    [labelName release];
    [labelVin release];
    [labelNY release];
    [labelOdo release];
    [imageVeh release];
    [super dealloc];
    
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
