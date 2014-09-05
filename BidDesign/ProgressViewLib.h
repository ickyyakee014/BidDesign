//
//  ProgressViewLib.h
//  BidDesign
//
//  Created by Nickyboy on 2014-08-21.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ProgressViewDelegate;
@interface ProgressViewLib : UIViewController
{
    id <ProgressViewDelegate> delegate;
    IBOutlet UIProgressView *progressView;
    float dProgress;
    
}
@property(nonatomic,retain) IBOutlet UIProgressView *progressView;
@property(nonatomic,assign) float dProgress;
@property(assign) id<ProgressViewDelegate> delegate;



@end

@protocol ProgressViewDelegate <NSObject>

@required
-(void)initProgress:(float)dSet;
-(void)setProgress:(float)getProgress;

@end
