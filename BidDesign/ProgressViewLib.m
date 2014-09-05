//
//  ProgressViewLib.m
//  BidDesign
//
//  Created by Nickyboy on 2014-08-21.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import "ProgressViewLib.h"

@interface ProgressViewLib ()

@end

@implementation ProgressViewLib
@synthesize progressView,dProgress,delegate;
-(void)dealloc{
    [progressView release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setProgressValue:)
                                                 name:@"MoveProgress" object:nil];
    [super viewDidLoad];
}
- (void)setProgressValue:(NSNotification *)note {
    float dValue = [[[note userInfo]valueForKey:@"Value"] floatValue]/[[[note userInfo]valueForKey:@"MaxValue"] floatValue];
    [self.progressView setProgress:dValue animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
