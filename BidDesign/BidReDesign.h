//
//  BidReDesign.h
//  BidDesign
//
//  Created by Nickyboy on 2014-08-14.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Internet.h"
@interface BidReDesign : UIViewController<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,InternetDelegate,UISearchBarDelegate>
{
    Internet *conn;
    NSMutableArray *arrayRunlist;
    NSMutableArray *arrayFilter;
    NSMutableArray *arrayMessage;
    NSMutableArray *arrayCarName;
    NSMutableArray *arrayRunID;
    NSMutableArray *arrayYear;
    NSMutableArray *arrayModel;
    
    //Tutorial
    BOOL inTutorial;
    IBOutlet UITextView *labelTutorial;
    IBOutlet UIImageView *imagePointer;
    IBOutlet UIView *viewTutorial;
    IBOutlet UIButton *buttonTutorial;
    NSInteger dTutorialValue;
    BOOL alreadyShow;
    IBOutlet UILabel *labelLane;
    IBOutlet UITableView *tableBid;
    NSMutableArray *arrayBid;
    
    IBOutlet UITableView *tableView;
    NSMutableArray *arrayData;
    
    IBOutlet UIView *viewMain;
    
    IBOutlet UISearchBar *searchVehicle;
    IBOutlet UIButton *buttonSell;
    IBOutlet UIButton *buttonPass;
    IBOutlet UIButton *buttonBack;
    NSInteger intPassCount;
    NSInteger intSellCount;
    NSInteger intPassCounter;
    NSInteger intSellCounter;
    NSTimer *timerSell;
    NSTimer *timerPass;
    UIButton *clearButton;
    IBOutlet UITableView *tableVehInfo;
    
    IBOutlet UIView *viewPrices;
    IBOutlet UIView *viewInit;
    IBOutlet UIView *viewMsg;
    
    IBOutlet UIView *viewSlide;
    IBOutlet UIView *viewSlideContainer;
    IBOutlet UISlider *slider;
    IBOutlet UILabel *labelSlide;
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIView *viewRemoteRep;
    IBOutlet UIView *viewRunlist;
    
    IBOutlet UITextView *dTextView;
    IBOutlet UIButton *buttonSend;
    
    IBOutlet UITableView *tableVeh;
    BOOL isRunlist;

}
@property(nonatomic,retain) IBOutlet UISearchBar *searchVehicle;
@property(nonatomic,retain) IBOutlet UIButton *buttonBack;
@property(nonatomic,retain) NSMutableArray *arrayCarName;
@property(nonatomic,retain) NSMutableArray *arrayRunID;
@property(nonatomic,retain) NSMutableArray *arrayYear;
@property(nonatomic,retain) NSMutableArray *arrayModel;

@property(nonatomic,retain) UIButton *clearButton;
@property(nonatomic,retain) NSMutableArray *arrayMessage;
@property(nonatomic,retain) NSMutableArray *arrayFilter;
@property(nonatomic,retain) IBOutlet UILabel *labelLane;
@property(nonatomic,retain) Internet *conn;
@property(nonatomic,retain) NSMutableArray *arrayRunlist;
//Tutorial

@property(nonatomic,assign) BOOL alreadyShow;
@property(nonatomic,assign) NSInteger dTutorialValue;
@property(nonatomic,assign) BOOL inTutorial;
@property(nonatomic,retain) IBOutlet UIButton *buttonTutorial;
@property(nonatomic,retain) IBOutlet UIView *viewTutorial;
@property(nonatomic,retain) IBOutlet UITextView *labelTutorial;
@property(nonatomic,retain) IBOutlet UIImageView *imagePointer;

@property(nonatomic,assign) BOOL isRunlist;
@property(nonatomic,retain) IBOutlet UITableView *tableVeh;
@property(nonatomic,retain) IBOutlet UITextView *dTextView;
@property(nonatomic,retain) IBOutlet UIButton *buttonSend;
@property(nonatomic,retain) IBOutlet UITableView *tableVehInfo;
@property(nonatomic,retain) IBOutlet UIButton *buttonSell;
@property(nonatomic,retain) IBOutlet UIButton *buttonPass;

@property(nonatomic,retain) IBOutlet UITableView *tableBid;
@property(nonatomic,retain) NSMutableArray *arrayBid;

@property(nonatomic,retain) IBOutlet UITableView *tableView;
@property(nonatomic,retain) NSMutableArray *arrayData;

@property(nonatomic,retain) IBOutlet UIView *viewMain;

@property(nonatomic,retain) IBOutlet UIView *viewPrices;
@property(nonatomic,retain) IBOutlet UIView *viewInit;
@property(nonatomic,retain) IBOutlet UIView *viewMsg;


@property(nonatomic,retain) IBOutlet UIView *viewSlide;
@property(nonatomic,retain) IBOutlet UIView *viewSlideContainer;
@property(nonatomic,retain) IBOutlet UISlider *slider;
@property(nonatomic,retain) IBOutlet UILabel *labelSlide;

@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIView *viewRemoteRep;
@property(nonatomic,retain) IBOutlet UIView *viewRunlist;



@property(nonatomic,assign) NSInteger intPassCount;
@property(nonatomic,assign) NSInteger intSellCount;
@property(nonatomic,assign) NSInteger intPassCounter;
@property(nonatomic,assign) NSInteger intSellCounter;
@property(nonatomic,assign) NSTimer *timerSell;
@property(nonatomic,assign) NSTimer *timerPass;
@end
