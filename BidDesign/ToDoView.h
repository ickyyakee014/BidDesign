//
//  ToDoView.h
//  BidDesign
//
//  Created by Nickyboy on 2014-08-13.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoView : UIViewController
{
    IBOutlet UIView *view1;
    IBOutlet UIView *view2;
    NSInteger index;
}
@property (nonatomic, retain) IBOutlet UIView *view1;
@property (nonatomic, retain) IBOutlet UIView *view2;
@property (assign, nonatomic) NSInteger index;
@end
