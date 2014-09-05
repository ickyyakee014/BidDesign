//
//  HtmlFileViewController.m
//  BidDesign
//
//  Created by Nickyboy on 2014-08-15.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import "HtmlFileViewController.h"

@interface HtmlFileViewController ()

@end

@implementation HtmlFileViewController
@synthesize webView;
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
    
   // UIWebView *wv = [[UIWebView alloc] init];
    // [wv loadHTMLString:@"<html><body><p><br><center><img src="ADESA.jpg" alt="Adesa" width="204" height="264"><br><br><h1><font color="teal"><b>Sorry, we'll be back in a moment!</b></font></h1><font color="black">We are busy making important updates. Please check back later.</font></p></body></html> " baseURL:nil];
    
    
  //  NSURL *htmlFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"] isDirectory:NO];
   // [wv loadRequest:[NSURLRequest requestWithURL:htmlFile]];
    
    
    [super viewDidLoad];
    
    //webView =[[UIWebView alloc]init];
    //webView.delegate = self;
    
    NSURL *htmlFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SecondHTML" ofType:@"html"] isDirectory:NO];
    [webView loadRequest:[NSURLRequest requestWithURL:htmlFile]];
    
    
    
   // [webView loadHTMLString:@"<html><body><p><br><center><img src='ADESA.jpg' alt='Adesa' width='204' height='264'><br><br><h1><font color='teal'><b>Sorry, we'll be back in a moment!</b></font></h1><font color='black'>We are busy making important updates. Please check back later.</font></p></body></html> " baseURL:nil];
    // [webView loadHTMLString:@"<html><body>YOUR-TEXT-HERE</body></html>" baseURL:nil];
   // NSURL *htmlFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"FirstHTML" ofType:@"html"]];
   // NSURLRequest *requestObj = [NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"FirstHTML" withExtension:@"html"]];
    //[webView loadRequest:[NSURLRequest requestWithURL:htmlFile]];
    // [webView loadRequest:requestObj];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
