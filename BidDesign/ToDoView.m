//
//  ToDoView.m
//  BidDesign
//
//  Created by Nickyboy on 2014-08-13.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import "ToDoView.h"

@interface ToDoView ()

@end

@implementation ToDoView
@synthesize index,view1,view2;
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
    if (index == 0) {
        [view2 removeFromSuperview];
        [self.view addSubview:view1];
    }else{
        
        [view1 removeFromSuperview];
        [self.view addSubview:view2];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
