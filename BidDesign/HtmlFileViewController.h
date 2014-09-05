//
//  HtmlFileViewController.h
//  BidDesign
//
//  Created by Nickyboy on 2014-08-15.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HtmlFileViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
}
@property(nonatomic,retain) IBOutlet UIWebView *webView;
@end
