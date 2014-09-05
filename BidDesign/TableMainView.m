//
//  TableMainView.m
//  BidDesign
//
//  Created by Nickyboy on 2014-08-27.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import "TableMainView.h"

@interface TableMainView ()

@end

@implementation TableMainView
@synthesize index,view2,view1;
-(void)dealloc{
    [view1 release];
    [view2 release];
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
{if (index == 0) {
        [view2 removeFromSuperview];
        [self.view addSubview:view1];
    }else{
        
        [view1 removeFromSuperview];
        [self.view addSubview:view2];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"Value"] = [NSNumber numberWithFloat:index];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MovePage" object:nil userInfo:dict];//Call by Notification
   // NSLog(@"DICT:%@",[dict valueForKey:@"Value"]);
    [dict release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
