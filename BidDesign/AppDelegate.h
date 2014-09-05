//
//  AppDelegate.h
//  BidDesign
//
//  Created by Nickyboy on 2014-08-13.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BidReDesign;
@class Reachability;
@interface AppDelegate : NSObject <UIApplicationDelegate>
{
    BidReDesign *mainPage;
    IBOutlet UITabBarController *tabBar;
    Reachability *hostReach;
    
}
@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) BidReDesign *mainPage;
@property (strong, nonatomic) IBOutlet UITabBarController *tabBar;
@property (nonatomic, retain) Reachability *hostReach;
@end
