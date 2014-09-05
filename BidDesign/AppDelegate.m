//
//  AppDelegate.m
//  BidDesign
//
//  Created by Nickyboy on 2014-08-13.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//
//MyAppDelegate *appDelegate = (MyAppDelegate*)[[UIApplication sharedApplication] delegate];
#import "AppDelegate.h"
#import "BidReDesign.h"
#import "LAILib.h"
#import "Reachability.h"
@implementation AppDelegate
@synthesize window,mainPage,tabBar,hostReach;
-(void)dealloc{
    [hostReach release];
    [window release];
    [mainPage release];
    [tabBar release];
    [super dealloc];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window.rootViewController = self.tabBar;
    //self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //[self.window setRootViewController:tabBar];
    //self.mainPage = [[BidReDesign alloc]init];
    //[self.window setRootViewController:mainPage];
    [self.window makeKeyAndVisible];
    //self.window.backgroundColor = [UIColor whiteColor];
    [tabBar setSelectedIndex:3];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
    
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//CHECKING INTERNET PART
- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
    if(curReach == hostReach)
	{
		
        NetworkStatus netStatus = [curReach currentReachabilityStatus];
        BOOL connectionRequired= [curReach connectionRequired];
        
        NSString* statusString= @"";
        
        switch(netStatus){
                
            case NotReachable:{
                
                statusString = @"NO";
                connectionRequired= NO;
                break;
                
            }
            case ReachableViaWWAN:{
                
                statusString = @"YES";
                break;
                
            }
            case ReachableViaWiFi:{
                
                statusString = @"YES";
                break;
                
            }
                
        }
        
        //summaryLabel.hidden = (netStatus != ReachableViaWWAN);
        NSString* baseLabel=  @"";
        if(connectionRequired)
        {
            baseLabel=  @"Cellular data network is available.\n  Internet traffic will be routed through it after a connection is established.";
        }
        else
        {
            baseLabel=  @"Cellular data network is active.\n  Internet traffic will be routed through it.";
        }
        //summaryLabel.text= baseLabel;
        
        if([statusString isEqual: @"YES"]){
            [LAILib globalValue:@"InternetConn" willSet:YES setString:@"YES"];
            
        }else {
            
            [LAILib globalValue:@"InternetConn" willSet:YES setString:@"YES"];
            
        }
        
        //NSLog(@"Status: '%@'",statusString);
        
    }
    
	//if(curReach == internetReach)
	//{
    //[self configureTextField: internetConnectionStatusField imageView: internetConnectionIcon reachability: curReach];
	//}
	//if(curReach == wifiReach)
	//{
    //[self configureTextField: localWiFiConnectionStatusField imageView: localWiFiConnectionIcon reachability: curReach];
	//}
	
}

- (void) reachability: (Reachability*) curReach
{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    BOOL connectionRequired= [curReach connectionRequired];
    NSString* statusString= @"";
    switch (netStatus)
    {
        case NotReachable:
        {
            //statusString = @"Access Not Available";
            //imageView.image = [UIImage imageNamed: @"stop-32.png"] ;
            //Minor interface detail- connectionRequired may return yes, even when the host is unreachable.  We cover that up here...
            
            connectionRequired= NO;
            break;
        }
            
        case ReachableViaWWAN:
        {
            statusString = @"Reachable WWAN";
            //imageView.image = [UIImage imageNamed: @"WWAN5.png"];
            break;
        }
        case ReachableViaWiFi:
        {
            statusString= @"Reachable WiFi";
            //imageView.image = [UIImage imageNamed: @"Airport.png"];
            break;
        }
    }
    if(connectionRequired)
    {
        statusString= [NSString stringWithFormat: @"%@, Connection Required", statusString];
    }
    //textField.text= statusString;
}


//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateInterfaceWithReachability: curReach];
}

@end
