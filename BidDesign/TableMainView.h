//
//  TableMainView.h
//  BidDesign
//
//  Created by Nickyboy on 2014-08-27.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableMainView : UIViewController
{
    NSInteger index;
    
    IBOutlet UIView *view1;
    IBOutlet UIView *view2;
    
}

@property(nonatomic,assign) NSInteger index;

@property(nonatomic,retain)IBOutlet UIView *view1;
@property(nonatomic,retain)IBOutlet UIView *view2;
@end
