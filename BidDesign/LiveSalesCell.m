//
//  LiveSalesCell.m
//  BidDesign
//
//  Created by Nickyboy on 2014-09-02.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import "LiveSalesCell.h"
@implementation LiveSalesCell
@synthesize imageCell,labelDesc,labelName;
-(void)dealloc{
    [imageCell release];
    [labelDesc release];
    [labelName release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
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
