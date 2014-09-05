//
//  BidCell.m
//  BidDesign
//
//  Created by Nickyboy on 2014-08-25.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import "BidCell.h"

@implementation BidCell
@synthesize labelMsg;
-(void)dealloc{
    [labelMsg release];
    
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
