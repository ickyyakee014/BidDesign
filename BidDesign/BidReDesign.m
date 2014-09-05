//
//  BidReDesign.m
//  BidDesign
//
//  Created by Nickyboy on 2014-08-14.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import "BidReDesign.h"
#import "LAILib.h"
#import "AppDelegate.h"
#import "ProgressViewLib.h"
#import "VehicleTableCell.h"
#import "XMLReader.h"
#import "UIImageView+WebCache.h"
@interface BidReDesign ()

@end

@implementation BidReDesign
@synthesize viewMain;
@synthesize viewInit,viewMsg,viewPrices,arrayData;
@synthesize viewSlide,viewSlideContainer,slider,labelSlide,scrollView;
@synthesize viewRemoteRep,viewRunlist,tableView;
@synthesize tableBid,arrayBid,buttonPass,buttonSell;
@synthesize tableVehInfo,tableVeh;
@synthesize dTextView,buttonSend,isRunlist;
@synthesize intPassCount,intPassCounter,intSellCount,intSellCounter;
@synthesize timerPass,timerSell,buttonTutorial,alreadyShow;
@synthesize conn,arrayRunlist;
@synthesize labelTutorial,imagePointer,viewTutorial;
@synthesize inTutorial,dTutorialValue,labelLane,arrayFilter,arrayMessage,clearButton;
@synthesize arrayCarName,arrayModel,arrayRunID,arrayYear,buttonBack,searchVehicle;
-(void)dealloc{
    [buttonBack release];
    [searchVehicle release];
    [arrayCarName release];
    [arrayModel release];
    [arrayRunID release];
    [arrayYear release];
    
    [conn release];
    [clearButton release];
    [arrayMessage release];
    [labelLane release];
    [arrayRunlist release];
    [arrayFilter release];
    
    [labelTutorial release];
    [imagePointer release];
    [viewTutorial release];
    [buttonTutorial release];
    
    [tableVeh release];
    [tableVehInfo release];
    [buttonSell release];
    [buttonPass release];
    [viewInit release];
    [viewMain release];
    [viewMsg release];
    [viewPrices release];
    [arrayData release];
    [viewSlide release];
    [viewSlideContainer release];
    [slider release];
    [labelSlide release];
    [scrollView release];
    [viewRemoteRep release];
    [viewRunlist release];
    [tableView release];
    [tableBid release];
    [arrayBid release];
    
    
    [super dealloc];
}/*
  -(IBAction)speakNow:(id)sender{
  LanguageModelGenerator *lmGenerator = [[LanguageModelGenerator alloc] init];
  
  NSArray *words = [NSArray arrayWithObjects:@"WORD", @"STATEMENT", @"OTHER WORD", @"A PHRASE", nil];
  NSString *name = @"NameIWantForMyLanguageModelFiles";
  NSError *err = [lmGenerator generateLanguageModelFromArray:words withFilesNamed:name forAcousticModelAtPath:[AcousticModel pathToModel:@"AcousticModelEnglish"]]; // Change "AcousticModelEnglish" to "AcousticModelSpanish" to create a Spanish language model instead of an English one.
  
  
  NSDictionary *languageGeneratorResults = nil;
  
  NSString *lmPath = nil;
  NSString *dicPath = nil;
  
  if([err code] == noErr) {
  
  languageGeneratorResults = [err userInfo];
  
  lmPath = [languageGeneratorResults objectForKey:@"LMPath"];
  dicPath = [languageGeneratorResults objectForKey:@"DictionaryPath"];
  
  } else {
  NSLog(@"Error: %@",[err localizedDescription]);
  }
  
  }
  */
-(void)timePassStartCount{
    intPassCounter++;
    NSLog(@"intPassCounter: %i",intPassCounter);
    if (intPassCounter == 4) {
        NSLog(@"Muust Invalidate");
        [buttonPass setTitle:@"PASS" forState:UIControlStateNormal];
        [self.timerPass invalidate];
        self.timerPass = nil;
        [buttonPass setBackgroundColor:[LAILib getRGBRed:0 Green:128 Blue:128 Alpha:1.0f]];
        intPassCounter = 0;
        intPassCount = 0;
    }
}

-(void)timeSellStartCount{
    intSellCounter++;
    NSLog(@"intSellCounter: %i",intSellCounter);
    if (intSellCounter == 4) {
        NSLog(@"Muust Invalidate");
        [buttonSell setTitle:@"SELL" forState:UIControlStateNormal];
        [self.timerSell invalidate];
        [buttonSell setBackgroundColor:[LAILib getRGBRed:0 Green:128 Blue:128 Alpha:1.0f]];
        self.timerSell = nil;
        intSellCounter = 0;
        intSellCount = 0;
    }
}
-(IBAction)sellPressed:(id)sender{
    intSellCount++;
    switch (intSellCount) {
        case 1:
            
            [buttonSell setBackgroundColor:[LAILib getRGBRed:100 Green:100 Blue:100 Alpha:1.0f]];//Null Color
            [sender setTitle:@"SELL?" forState:UIControlStateNormal];
            timerSell = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                         target: self
                                                       selector:@selector(timeSellStartCount)
                                                       userInfo: nil repeats:YES];
            break;
            
        case 2:
            [sender setTitle:@"SELL" forState:UIControlStateNormal];
            if (!inTutorial) {
                [self addDataToArray:@"SELL"];
            }
            
            [self.timerSell invalidate];
            self.timerSell = nil;
            [buttonSell setBackgroundColor:[LAILib getRGBRed:0 Green:128 Blue:0 Alpha:1.0f]];//Green Color
            
            //[self backToNormal];
            break;
        case 3:
            intSellCount = 0;
            intSellCounter = 0;
            [sender setTitle:@"SELL" forState:UIControlStateNormal];
            [buttonSell setBackgroundColor:[LAILib getRGBRed:0 Green:128 Blue:128 Alpha:1.0f]];
            break;
        default:
            break;
    }
}
-(IBAction)passPressed:(id)sender{
    intPassCount++;
    switch (intPassCount) {
        case 1:
            [sender setTitle:@"PASS?" forState:UIControlStateNormal];
            [buttonPass setBackgroundColor:[LAILib getRGBRed:100 Green:100 Blue:100 Alpha:1.0f]];//Nill Color
            timerPass = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                         target: self
                                                       selector:@selector(timePassStartCount)
                                                       userInfo: nil repeats:YES];
            break;
            
        case 2:
            [sender setTitle:@"PASS" forState:UIControlStateNormal];if (!inTutorial) {
                [self addDataToArray:@"PASS"];
            }
            [self.timerPass invalidate];
            self.timerPass = nil;
            [buttonPass setBackgroundColor:[UIColor redColor]];//Green Color
            //[self backToNormal];
            break;
        case 3:
            intPassCount = 0;
            intPassCounter = 0;
            [sender setTitle:@"PASS" forState:UIControlStateNormal];
            [buttonPass setBackgroundColor:[LAILib getRGBRed:0 Green:128 Blue:128 Alpha:1.0f]];
            break;
        default:
            break;
    }
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self = [super initWithNibName:@"BidReDesign" bundle:nibBundleOrNil];
    
    return self;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textFields{
    [self.dTextView resignFirstResponder];
    return YES;
}
-(IBAction)toRemoteRep:(id)sender{
    [viewRunlist removeFromSuperview];
    [self.view addSubview:viewRemoteRep];
    [scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, 600)];
    [scrollView setScrollEnabled:YES];
}
-(IBAction)toRunlist:(id)sender{
    [viewRemoteRep removeFromSuperview];
    [self.view addSubview:viewRunlist];
    
    
}
//Add Progress in View
-(void)showProgressView{
    ProgressViewLib *dprogressView = [[ProgressViewLib alloc]init];
    dprogressView.view.frame = CGRectMake(0, 100, self.viewRunlist.frame.size.width, dprogressView.progressView.frame.size.height);
    dprogressView.progressView.progress = 0;
    dprogressView.view.tag = 7;
    [self.viewRunlist addSubview:dprogressView.view];
    [dprogressView release];
}
-(void)setupArray{
    
    if ([[LAILib globalValue:@"isLoad" willSet:NO setString:nil] isEqualToString:@"1"]) {
        return;
    }
    arrayBid = [[NSMutableArray alloc]initWithObjects:@"Connected to AIM",@"No sale for this Run",@"Run # 187 - BIDDING CLOSED: Run #188",@"BIDDING OPEN", nil];
    [[NSUserDefaults standardUserDefaults] setObject:arrayBid forKey:@"BidArray"];
    [LAILib globalValue:@"isLoad" willSet:YES setString:@"1"];
}
//Implement Values in Progress View
-(void)animateProgress:(float)initValue getValue:(float)dValue{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[@"Value"] = [NSNumber numberWithFloat:dValue];
    dict[@"MaxValue"] = [NSNumber numberWithFloat:initValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MoveProgress" object:nil userInfo:dict];//Call by Notification
    [dict release];
}
-(void)viewDidDisappear:(BOOL)animated{
    [[NSUserDefaults standardUserDefaults] setObject:arrayBid forKey:@"BidArray"];
    NSLog(@"Array:%@",[[NSUserDefaults standardUserDefaults]
                       objectForKey:@"BidArray"]);
}
#pragma mark VIEWDIDAPPEAR
-(void)viewDidAppear:(BOOL)animated{
    searchVehicle.text = @"";
    self.title = @"Live Sales";
    [tableView reloadData];
    arrayBid= [[NSMutableArray alloc]
               initWithArray:[[NSUserDefaults standardUserDefaults]
                              objectForKey:@"BidArray"]];
    arrayFilter = [[NSMutableArray alloc]init];
    //arrayBid = [[NSArray alloc]initWithObjects:@"Connected to AIM",@"No sale for this Run",@"Run # 187 - BIDDING CLOSED: Run #188",@"BIDDING OPEN", nil];
    [tableBid reloadData];
    
    CGPoint offset = CGPointMake(0, tableBid.contentSize.height -  tableBid.frame.size.height);
    [self.tableBid setContentOffset:offset animated:YES]; //scroll tableview to the bottom
    // [LAILib adjustHeightOfTableview:tableBid];
    // [self showProgressView];
    //[self animateProgress:100 getValue:70];
    
    /*
     if (alreadyShow) {
     return;
     }
     alreadyShow = YES;
     [self.view addSubview: viewTutorial];
     viewTutorial.frame = CGRectMake(0, 524, viewTutorial.frame.size.width, viewTutorial.frame.size.height);
     [LAILib animateView:viewTutorial getFrame:CGRectMake(0, 0, viewTutorial.frame.size.width, viewTutorial.frame.size.height)];
     inTutorial = YES;
     [self slidingTutorial];
     [[buttonTutorial layer]setCornerRadius:8.0f];
     */
    
}
-(IBAction)remoteClick:(id)sender{
    
    if (!isRunlist) {
        return;
    }
    [tableVeh removeFromSuperview];
    [self.viewMsg removeFromSuperview];
    [self.viewPrices removeFromSuperview];
    [self.viewMain addSubview:viewInit];
    [self.viewMain addSubview:viewSlide];
    viewSlide.alpha = 1.0f;
    slider.value = 0.0f;
    labelSlide.alpha = 1.0f;
    isRunlist = NO;
}
-(IBAction)runlistClick:(id)sender{
    isRunlist = YES;
    tableVeh.frame = CGRectMake(0, 266, tableVeh.frame.size.width, tableVeh.frame.size.height);
    [self.view addSubview:tableVeh];
    
    [self syncDownload:@"https://mob1-av5q-inf.liveblockauctions.com:443/bamappserver/rest/vehlist?md5String=1047&vehlistid=1049179" getParam:@"" getConnName:@"RunList"];
}
-(void)viewWillAppear:(BOOL)animated{
    [[buttonSend layer]setCornerRadius:8.0f];
}
- (void)viewDidLoad
{
    
    labelLane.text = @"Golden Gate Lane 1";
    self.title = @"Live Sales";
    [self setupArray];
    //dTextView.text = @"Connected to AIM.\nNo sale for this Run.\nRun # 187 - BIDDING CLOSED : Run # 188\n-BIDDING OPEN.";
    //
    [self.view addSubview:viewRunlist];
    UIImage *stetchLeftTrack= [[UIImage imageNamed:@"Nothing.png"]
                               stretchableImageWithLeftCapWidth:30.0 topCapHeight:0.0];
	UIImage *stetchRightTrack= [[UIImage imageNamed:@"Nothing.png"]
                                stretchableImageWithLeftCapWidth:30.0 topCapHeight:0.0];
	[slider setThumbImage: [UIImage imageNamed:@"SlidePic.png"] forState:UIControlStateNormal];
	[slider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
	[slider setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyHide:) name:
     UIKeyboardDidHideNotification object:nil];
    
    
    //**pickerview Data
    arrayMessage = [[NSMutableArray alloc]init];
    arrayData = [[NSMutableArray alloc]initWithObjects:@"Message Auctioneer",@"New tires all around",@"Get live money",@"One owner car",@"D/R over 2000",@"PSI completed",@"Unit has mfg warranty",@"Must sell",@"CLOSE (within $500)",@"FIRM PRICE (within $100)",@"Please get any offer", nil];
    [arrayData addObjectsFromArray:arrayMessage];
    
    [tableView reloadData];
    [[viewSlideContainer layer]setCornerRadius:8.0f];
    
    [self.viewMain addSubview:viewInit];
    [self.viewMain addSubview:viewSlide];
    
    
    tableBid.layer.borderWidth = 1.0f;
    tableBid.layer.borderColor = [[UIColor grayColor]CGColor];
    
    tableView.layer.borderWidth = 1.0f;
    tableView.layer.borderColor = [[UIColor grayColor]CGColor];
    
    tableVehInfo.layer.borderWidth = 1.0f;
    tableVehInfo.layer.borderColor = [[UIColor grayColor]CGColor];
    
    viewSlideContainer.layer.borderWidth = 1.0f;
    viewSlideContainer.layer.borderColor = [[UIColor whiteColor]CGColor];
    
    
    dTextView.layer.borderWidth = 1.0f;
    dTextView.layer.borderColor = [[UIColor grayColor]CGColor];
    [[dTextView layer] setCornerRadius:8.0f];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
//** More Prices to Show
-(IBAction)toMore:(id)sender{
    [viewMsg removeFromSuperview];
    [viewInit removeFromSuperview];
    [self.viewMain addSubview:viewPrices];
}
//** Message View will Appear
-(IBAction)toMsg:(id)sender{
    [viewPrices removeFromSuperview];
    [viewInit removeFromSuperview];
    [self.viewMain addSubview:viewMsg];
}
//** Back to Initial View

#pragma mark SEARCH BAR
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBars{
    if (arrayCarName == nil) {
        arrayYear = [[NSMutableArray alloc]init];
        arrayModel = [[NSMutableArray alloc]init];
        arrayRunID = [[NSMutableArray alloc]init];
        arrayCarName = [[NSMutableArray alloc]init];
    }else{
        [arrayCarName removeAllObjects];
        [arrayYear removeAllObjects];
        [arrayModel removeAllObjects];
        [arrayRunID removeAllObjects];
        
    }
    for (int x = 0; x<[arrayRunlist count]; x++) {
        [arrayCarName addObject:[LAILib getArrayValue:arrayRunlist row:x column:3]];
        [arrayYear addObject:[LAILib getArrayValue:arrayRunlist row:x column:5]];
        [arrayModel addObject:[LAILib getArrayValue:arrayRunlist row:x column:7]];
        [arrayRunID addObject:[LAILib getArrayValue:arrayRunlist row:x column:2]];
        
    }
    NSLog(@"ArrayName:%@",arrayCarName);
    
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBars {
    
    for (int x = 0; x<[arrayRunlist count]; x++) {
        
    }
}
-(void)searchBar:(UISearchBar *)searchBars textDidChange:(NSString *)searchText{
    /*
     [[dictVeh valueForKey:@"vehId"] objectAtIndex:x],
     [[dictVeh valueForKey:@"photoLink"] objectAtIndex:x],
     [[dictVeh valueForKey:@"runId"] objectAtIndex:x],
     [[dictVeh valueForKey:@"make"] objectAtIndex:x],
     [[dictVeh valueForKey:@"vin"] objectAtIndex:x],
     [[dictVeh valueForKey:@"year"] objectAtIndex:x],
     [[dictVeh valueForKey:@"odometer"] objectAtIndex:x],
     [[dictVeh valueForKey:@"model"] objectAtIndex:x],nil] atIndex:x];
     */
    if ([searchText length] == 0) {
        return;
    }
    
    [searchBars setShowsCancelButton:YES animated:YES];
    NSMutableArray *arrayID = [[NSMutableArray alloc]init];
    if (arrayFilter == nil) {
        arrayFilter = [[NSMutableArray alloc]init];
    }else{
        [arrayFilter removeAllObjects];
    }
    for (NSString* string in arrayCarName) {
        
        NSRange nameRange = [string rangeOfString:searchText options:(NSCaseInsensitiveSearch)];
        if(nameRange.location != NSNotFound){
            [arrayID addObject:[NSString stringWithFormat:@"%i",[arrayCarName indexOfObject:string]]];
        }
    }
    for (NSString* string in arrayYear) {
        
        NSRange yearRange = [string rangeOfString:searchText options:(NSCaseInsensitiveSearch)];
        if(yearRange.location != NSNotFound){
            if (![self alreadyInArray:[NSString stringWithFormat:@"%i",[arrayCarName indexOfObject:string]]getArray:arrayID]) {
                [arrayID addObject:[NSString stringWithFormat:@"%i",[arrayYear indexOfObject:string]]];
            }
            
        }
    }
    for (NSString* string in arrayID) {
        
        NSRange runIDRange = [string rangeOfString:searchText options:(NSCaseInsensitiveSearch)];
        if(runIDRange.location != NSNotFound){
            if (![self alreadyInArray:[NSString stringWithFormat:@"%i",[arrayID indexOfObject:string]]getArray:arrayID]) {
                [arrayID addObject:[NSString stringWithFormat:@"%i",[arrayID indexOfObject:string]]];
            }
            
        }
    }
    for (NSString* string in arrayModel) {
        
        NSRange modelRange = [string rangeOfString:searchText options:(NSCaseInsensitiveSearch)];
        if(modelRange.location != NSNotFound){
            if (![self alreadyInArray:[NSString stringWithFormat:@"%i",[arrayModel indexOfObject:string]]getArray:arrayID]) {
                [arrayID addObject:[NSString stringWithFormat:@"%i",[arrayModel indexOfObject:string]]];
            }
            
        }
    }
    
    for (int x = 0; x<[arrayID count]; x++) {
        [arrayFilter insertObject:[NSMutableArray arrayWithObjects:[LAILib getArrayValue:arrayRunlist row:[[arrayID objectAtIndex:x]integerValue] column:0],
                                                                    [LAILib getArrayValue:arrayRunlist row:[[arrayID objectAtIndex:x]integerValue] column:1],
                                                                    [LAILib getArrayValue:arrayRunlist row:[[arrayID objectAtIndex:x]integerValue] column:2],
                                                                    [LAILib getArrayValue:arrayRunlist row:[[arrayID objectAtIndex:x]integerValue] column:3],
                                                                    [LAILib getArrayValue:arrayRunlist row:[[arrayID objectAtIndex:x]integerValue] column:4],
                                                                    [LAILib getArrayValue:arrayRunlist row:[[arrayID objectAtIndex:x]integerValue] column:5],
                                                                    [LAILib getArrayValue:arrayRunlist row:[[arrayID objectAtIndex:x]integerValue] column:6],
                                                                    [LAILib getArrayValue:arrayRunlist row:[[arrayID objectAtIndex:x]integerValue] column:7],nil] atIndex:x];
    }
         [tableVeh reloadData];
    
}

-(BOOL)alreadyInArray:(NSString*)dString getArray:(NSMutableArray*)dArray{
    BOOL isAlready = NO;
    
    for (int x = 0; x<[dArray count]; x++) {
        if ([[dArray objectAtIndex:x] isEqualToString:dString]) {
            isAlready = YES;
            return isAlready;
        }
    }
    
    return isAlready;
}
 
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBars{
    searchVehicle.text = @"";
    [searchBars resignFirstResponder];
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBarButton{
    [searchVehicle resignFirstResponder];
    
}
-(IBAction)toMain:(id)sender{
    
    [viewMsg removeFromSuperview];
    [viewPrices removeFromSuperview];
    [self.viewMain addSubview:viewInit];
}
-(CGFloat)tableView:(UITableView*)tableViews heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableViews == tableView) {
        if (indexPath.row>=11) {
            return [LAILib getCellHeight:[arrayData objectAtIndex:indexPath.row] getFont:[UIFont fontWithName:@"Superclarendon" size:11]getWidth:320 getAdd:+5];
        }else
        {
            return [LAILib getCellHeight:[arrayData objectAtIndex:indexPath.row] getFont:[UIFont fontWithName:@"Courier New" size:11] getWidth:320 getAdd:+5];
            
        }
        
        
    }else if (tableViews == tableBid){
        return [LAILib getCellHeight:[arrayBid objectAtIndex:indexPath.row] getFont:[UIFont fontWithName:@"Arial" size:12] getWidth:320 getAdd:+5];
    }else if (tableViews == tableVehInfo){
        if (indexPath.row == 6) {
            return 50;
        }
        return 15;
    }else if (tableViews == tableVeh){
        return  96;
    }
    
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableViews numberOfRowsInSection:(NSInteger)section {
    if (tableViews == tableView) {
        
        return [arrayData count];
    }else if (tableViews == tableBid){
        return  [arrayBid count];
    }else if (tableViews == tableVehInfo){
        return 8;
    }else if (tableViews == tableVeh){
        if ([searchVehicle.text length] > 0) {
            return [arrayFilter count];
        }
        return  [arrayRunlist count];
    }
    
    return 0;
    
}
/* Optional (for two sections only in table
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 return 2;
 }
 */
-(void)refreshTable{
    //call lai adjusttablehieght
}
- (UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableViews == tableView) {
        return [self msgTable:tableViews getCell:indexPath];
    }else if (tableViews == tableBid){
        return [self bidTable:tableViews getCell:indexPath];
    }else if (tableViews == tableVehInfo){
        return  [self vehInfoTable:tableViews getCell:indexPath];
    }else if (tableViews == tableVeh){
        return  [self vehTable:tableViews getCell:indexPath];
    }
    
    return 0;
}
-(UITableViewCell*)msgTable:(UITableView*)dTableView getCell:(NSIndexPath*)dIndexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [dTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    for(UIView *view in [cell.contentView subviews]){
        
        [view removeFromSuperview];
    }
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (dIndexPath.row == 10) {
        UIView *dView = [[UIView alloc]initWithFrame:CGRectMake(0, cell.contentView.frame.size.height, cell.contentView.frame.size.width, 2)];
        dView.backgroundColor = [LAILib getRGBRed:0 Green:128 Blue:128 Alpha:1.0f];
        [cell.contentView addSubview:dView];
        [dView release];
    }
    if (dIndexPath.row == 11) {
        UIView *dView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, 2)];
        dView.backgroundColor = [LAILib getRGBRed:0 Green:128 Blue:128 Alpha:1.0f];
        [cell.contentView addSubview:dView];
        [dView release];
    }
    cell.textLabel.numberOfLines = 0;
    if (dIndexPath.row>=11) {
        cell.textLabel.font = [UIFont fontWithName:@"Superclarendon" size:12.0];
    }else
    {
        cell.textLabel.font = [UIFont fontWithName:@"Courier New" size:12.0];
        
    }
    cell.textLabel.text = [arrayData objectAtIndex:dIndexPath.row];
    //[cell.contentView addSubview:cell.textLabel];
    
    return cell;
    
    
}
-(UITableViewCell*)bidTable:(UITableView*)dTableView getCell:(NSIndexPath*)dIndexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [dTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    for(UIView *view in [cell.contentView subviews]){
        
        [view removeFromSuperview];
    }
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:12.0];
    cell.textLabel.text = [arrayBid objectAtIndex:dIndexPath.row];
    
    
    return cell;
    
}

-(UITableViewCell*)vehInfoTable:(UITableView*)dTableView getCell:(NSIndexPath*)dIndexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [dTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    for(UIView *view in [cell.contentView subviews]){
        
        [view removeFromSuperview];
    }
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    /*
     Bid
     Floor Price
     VIN
     Odo
     Announcements:
     Grade
     arrayVehicle = [[NSMutableArray alloc]initWithObjects:@"$21,000,00",@"$19,000,00",@"5TFUY5F19CX238965",@"49533",@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur faucibus enim tellus, quis aliquam dui pulvinar sed. Sed vestibulum efficitur tortor, eget efficitur turpis fermentum ut. Vestibulum diam massa, auctor ac augue eget, lacinia tincidunt ex. In lacinia ultricies diam, in tempus est. In sed augue elementum, rhoncus nisl tempor",@"2", nil];
     */
    
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:11.0];
    cell.textLabel.lineBreakMode  = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.frame = CGRectMake(5, cell.textLabel.frame.origin.y, cell.textLabel.frame.size.width, cell.textLabel.frame.size.height);
    switch (dIndexPath.row) {
        case 0:
            cell.textLabel.textColor = [UIColor redColor];
            cell.textLabel.text = @"Bid: $21,000";
            break;
        case 1:
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.text = @"Floor Price: $19,000";
            break;
        case 2:
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.text = @"VIN: 5TFUY5F19CX238965";
            break;
        case 3:
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.text = @"Odo: 49533";
            break;
        case 4:
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.text = @"Body Style: 4DR Double Cab";
            break;
        case 5:
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.text = @"Int/Ext: Black.black";
            break;
        case 6:
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.text = @"Announcements: orem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur faucibus enim tellus, quis aliquam dui pulvinar sed. Sed vestibulum efficitur tortor, eget efficitur turpis fermentum ut. Vestibulum diam massa, auctor ac augue eget, lacinia tincidunt ex. In lacinia ultricies diam, in tempus est. In sed augue elementum, rhoncus nisl tempor";
            break;
        case 7:
            cell.textLabel.textColor = [UIColor blackColor];
            cell.textLabel.text = @"Grade: 2";
            break;
            
        default:
            break;
    }
    
    return cell;
}
-(UITableViewCell*)vehTable:(UITableView*)dTableView getCell:(NSIndexPath*)dIndexPath{
    static NSString *simpleTableIdentifier = @"VehicleTableCellReuse";
    
    VehicleTableCell *cell = (VehicleTableCell *)[dTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"VehicleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSMutableArray *dArray;
    if ([searchVehicle.text length]> 0) {
        dArray = arrayFilter;
    }else{
        dArray = arrayRunlist;
    }
    
    cell.labelName.textColor = [LAILib getRGBRed:0 Green:128 Blue:128 Alpha:1.0f];
    
    [cell.imageVeh setImageWithURL:[NSURL URLWithString:[LAILib getArrayValue:dArray row:dIndexPath.row column:1]]  placeholderImage:[LAILib getImageFile:@"noimage"]];
    
    cell.labelName.text = [NSString stringWithFormat:@"#%@ %@ %@ %@",[LAILib getArrayValue:dArray row:dIndexPath.row column:2],
                           [LAILib getArrayValue:dArray row:dIndexPath.row column:5],
                           [LAILib getArrayValue:dArray row:dIndexPath.row column:3],
                           [LAILib getArrayValue:dArray row:dIndexPath.row column:7]];
    cell.labelVin.text =[NSString stringWithFormat:@"VIN: %@",[LAILib getArrayValue:dArray row:dIndexPath.row column:4]] ;
    cell.labelOdo.text =[NSString stringWithFormat:@"Odo: %@",[LAILib getArrayValue:dArray row:dIndexPath.row column:6]] ;
    cell.labelNY.text = @"ADESA Golden Gate";
    cell.labelTimeDate.text = [NSString stringWithFormat:@"%@ %@ EST Open",[LAILib getDateTime:YES],[LAILib getAmPmTime]];
    cell.labelLaneGrade.text = @"Lane 1 Grade:Unknown";
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableViews didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableViews == tableView) {
        dTextView.text = [NSString stringWithFormat:@"%@%@",dTextView.text,[arrayData objectAtIndex:indexPath.row]];
        [self addButtonTextView];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        NSInteger dHeight = dTextView.frame.size.height;
        
        CGFloat fixedWidth = dTextView.frame.size.width;
        CGSize newSize = [dTextView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
        CGRect newFrame = dTextView.frame;
        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
        NSLog(@"NewFrame:%f",newFrame.size.height);
        dTextView.frame = newFrame;
        
        if (dTextView.frame.size.height != 30.50) {
            if (dHeight != newFrame.size.height) {
            [viewMain setFrame:CGRectMake(8, viewMain.frame.origin.y - newFrame.size.height + 30, viewMain.frame.size.width, viewMain.frame.size.height + newFrame.size.height)];
                viewMsg.frame = CGRectMake(0, 0, viewMsg.frame.size.width, viewMsg.frame.size.height + newFrame.size.height);
                tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, tableView.frame.size.height - newFrame.size.height);
                buttonBack.frame = CGRectMake(buttonBack.frame.origin.x, buttonBack.frame.origin.y + newFrame.size.height - buttonBack.frame.size.height - 5, buttonBack.frame.size.width, buttonBack.frame.size.height);
            //viewMsg.frame = CGRectMake(0, 0 + newFrame.size.height, viewMsg.frame.size.width, viewMain.frame.size.height);
            //[buttonBack setFrame:CGRectMake(buttonBack.frame.origin.x, buttonBack.frame.origin.y + newFrame.size.height, buttonBack.frame.size.width, buttonBack.frame.size.height)];
              //  tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y + newFrame.size.height, tableView.frame.size.width, tableView.frame.size.height);
            }
            //buttonSend.frame = CGRectMake(buttonSend.frame.origin.x, buttonSend.frame.origin.y - newFrame.size.height, buttonSend.frame.size.width, buttonSend.frame.size.height);
        }
        
        
        //buttonSend.frame = CGRectMake(buttonSend.frame.origin.x, 9, buttonSend.frame.size.width, buttonSend.frame.size.height);
        
        
        [UIView commitAnimations];
    }
}
-(IBAction)fadeLabel{
    [UIView beginAnimations: @"GoneNow" context: nil];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDuration: 0.35];
    // use CurveEaseOut to create "spring" effect
    [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];
    
    labelSlide.alpha = 0.0f;
    [UIView commitAnimations];
    //[LAILib animateFade:labelSlide setAlpha:0.0f willMove:NO getFrame:CGRectZero completion:nil];
	
}
-(IBAction)unlockTicker:(id)sender{
    
    if (slider.value == 1.0f) {
        if (inTutorial) {
            NSLog(@"Tick");
            buttonTutorial.alpha = 1.0f;
            return;
        }
        [LAILib animateFade:viewSlide setAlpha:0.0f willMove:NO getFrame:CGRectZero completion:^{[self removeSlideView];}];
    }else{
        
        [LAILib animateFade:labelSlide setAlpha:1.0f willMove:NO getFrame:CGRectZero completion:nil];
        
        [UIView beginAnimations: @"SlideCanceled" context: nil];
        [UIView setAnimationDelegate: self];
        [UIView setAnimationDuration: 0.35];
        // use CurveEaseOut to create "spring" effect
        [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];
        slider.value = 0.0;
        [UIView commitAnimations];
    }
}
-(void)removeSlideView{
    [self.viewSlide removeFromSuperview];
    self.viewSlide.alpha = 1.0f;
}
-(IBAction)sendMessage:(id)sender{
    BOOL isEnteredMessage = NO;
    BOOL isEqual = NO;
    for (int x = 0; x<[arrayData count]; x++) {
        if ([[arrayData objectAtIndex:x] isEqualToString:dTextView.text]){
            isEqual = YES;
        }
    }
    if (!isEqual) {
        for (int x = 0; x<[arrayData count]; x++) {
            
            if (![[arrayData objectAtIndex:x] isEqualToString:dTextView.text]) {
                NSLog(@"In First ArrayData");
                if ([arrayMessage count] == 10) {
                    NSLog(@"In If%i",[arrayMessage count]);
                    NSLog(@"Array Data:%@",arrayMessage);
                    [arrayMessage removeObjectAtIndex:0];
                    [arrayData removeAllObjects];
                    arrayData = [[NSMutableArray alloc]initWithObjects:@"Message Auctioneer",@"New tires all around",@"Get live money",@"One owner car",@"D/R over 2000",@"PSI completed",@"Unit has mfg warranty",@"Must sell",@"CLOSE (within $500)",@"FIRM PRICE (within $100)",@"Please get any offer", nil];
                    [arrayData addObjectsFromArray:arrayMessage];
                    //NSMutableArray *dArray = [[NSMutableArray alloc]init];
                    // for (int y = 0; y<[arrayMessage count]; y++) {
                    //    [dArray addObject:[arrayMessage objectAtIndex:y+1]];
                    //}
                    //arrayMessage = [[NSMutableArray alloc]initWithArray:dArray];
                    // [dArray release];
                    // [arrayData addObjectsFromArray:arrayMessage];
                }else{
                    NSLog(@"In Else");
                    
                    if ([arrayMessage count] == 0) {
                        NSLog(@"In Array Zero");
                        [arrayMessage addObject:dTextView.text];
                        NSLog(@"Array Inside MEssage:%@",arrayMessage);
                        [arrayData addObject:dTextView.text];
                    }else{
                        for (int y = 0; y<[arrayMessage count]; y++) {
                            if (!isEnteredMessage) {
                                if (![[arrayMessage objectAtIndex:y] isEqualToString:dTextView.text]) {
                                    isEnteredMessage = YES;
                                    NSLog(@"In Array Message");
                                    [arrayMessage addObject:dTextView.text];
                                    [arrayData addObject:dTextView.text];
                                }
                            }
                            
                        }
                        
                    }
                    
                    
                }
            }
        }
    }
    
    
    [tableView reloadData];
    NSLog(@"arrayData:%@",arrayData);
    NSLog(@"arrayMessage:%@",arrayMessage);
    [self addDataToArray:dTextView.text];
    dTextView.text = @"";
    [dTextView resignFirstResponder];
    [self msgInitView];
    
}
-(void)addDataToArray:(NSString*)dDataAdd{
    
    
    if ([arrayBid count] == 15) {
        [arrayBid removeObjectAtIndex:0];
        NSMutableArray *dArray  = [[NSMutableArray alloc]initWithArray:arrayBid];
        [arrayBid removeAllObjects];
        arrayBid = [[NSMutableArray alloc]initWithArray:dArray];
        [dArray release];
    }
    [arrayBid addObject:dDataAdd];
    
    [tableBid reloadData];
    
    CGPoint offset = CGPointMake(0, tableBid.contentSize.height -  tableBid.frame.size.height);
    [self.tableBid setContentOffset:offset animated:YES]; //scroll tableview to the bottom
    
}
-(void)addButtonTextView{
    if (clearButton) {
        return;
    }
    int kClearButtonWidth = 15;
    int kClearButtonHeight = kClearButtonWidth;
    //add the clear button
    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.clearButton setImage:[UIImage imageNamed:@"UITextFieldClearButton.png"] forState:UIControlStateNormal];
    [self.clearButton setImage:[UIImage imageNamed:@"UITextFieldClearButtonPressed.png"] forState:UIControlStateHighlighted];
    
    self.clearButton.frame = CGRectMake(0, 0, kClearButtonWidth, kClearButtonHeight);
    self.clearButton.center = CGPointMake(self.dTextView.frame.size.width - kClearButtonWidth , kClearButtonHeight);
    
    [self.clearButton addTarget:self action:@selector(clearTextView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.dTextView addSubview:self.clearButton];

}
-(void)keyShow:(NSNotification *)notif{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    tableView.alpha = 0.0f;
    buttonSend.frame = CGRectMake(buttonSend.frame.origin.x, 9, buttonSend.frame.size.width, buttonSend.frame.size.height);
    viewMain.frame = CGRectMake(8, 310, viewMsg.frame.size.width, 40);
    dTextView.frame = CGRectMake(dTextView.frame.origin.x, 8, dTextView.frame.size.width, dTextView.frame.size.height);
    [self addButtonTextView];
    [UIView commitAnimations];
    
    
}
- (void)clearTextView:(id)sender{
    [self msgInitView];
    self.dTextView.text = @"";
    [dTextView resignFirstResponder];
}
-(void)msgInitView{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [viewMain setFrame:CGRectMake(8, 347, viewMsg.frame.size.width, viewMsg.frame.size.height)];
    viewMsg.frame = CGRectMake(0, 0, viewMsg.frame.size.width, 172);
    buttonBack.frame = CGRectMake(buttonBack.frame.origin.x, 142, buttonBack.frame.size.width, buttonBack.frame.size.height);
    //viewMsg.frame = CGRectMake(0, 0, viewMsg.frame.size.width, viewMsg.frame.size.height + 5);
    tableBid.alpha = 1.0f;
    tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, 93);
    buttonSend.frame = CGRectMake(buttonSend.frame.origin.x, 109, buttonSend.frame.size.width, buttonSend.frame.size.height);
    dTextView.frame = CGRectMake(dTextView.frame.origin.x, 109, dTextView.frame.size.width, 25);
    tableView.alpha = 1.0f;
    [clearButton removeFromSuperview];
    clearButton = nil;
    [UIView commitAnimations];
}
-(void)keyHide:(NSNotification *)notif{
    [self msgInitView];
    
}
#pragma mark CONNECTIONS

-(void)checkOpenConnection{
    if (conn) {
        [conn setCancelResult:YES];
        [conn cancelResult];
        [conn setDelegate:nil];
        conn = nil;
        [conn release];
    }
}
-(void)syncDownload:(NSString*)urlLink getParam:(NSString*)dParam getConnName:(NSString*)dConnName{
    if (conn) {
        [conn setCancelResult:YES];
        [conn cancelResult];
        [conn setDelegate:nil];
        conn = nil;
        [conn release];
    }
    
    conn = [[Internet alloc]init];
    [conn setDelegate:self];
    [conn httpRequest:urlLink params:dParam getMethod:@"GET" connectionName:dConnName];
}
-(void) internetDidFailWithError:(NSString *)error connectionName:(NSString *)connectionName{
    
    
    NSLog(@"ERROR HTTP: %@---%@",error,connectionName);
    
    
    if(conn){
        
        
        [conn setDelegate:nil];
        conn=nil;
        [conn release];
        
    }
    
}
-(void) internetDidFinishDownloading:(NSMutableData *)data connectionName:(NSString *)connName{
    NSString *result = [[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSError *error;
    NSDictionary *connDict = [XMLReader dictionaryForXMLString:result error:&error];
    /* NSMutableDictionary *connDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
     if( error )
     {
     NSLog(@"Error Finish Data:%@ - %@",connName,[error localizedDescription]);
     return;
     }*/
    NSLog(@"DICT:%@",connDict);
    if([connName isEqualToString:@"RunList"]){
        NSDictionary *dictVeh = [[NSDictionary alloc]init];
        // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),
        //     ^{
        dictVeh = [[[connDict objectForKey:@"laiVehicleList"] objectForKey:@"vehs"] objectForKey:@"LaiVehicle"];
        NSMutableArray *dArrayHolder = [[NSMutableArray alloc]init];
        
        for (int x = 0; x< [dictVeh count]; x++) {
            [dArrayHolder insertObject:[NSMutableArray arrayWithObjects:[[dictVeh valueForKey:@"vehId"] objectAtIndex:x],
                                        [[dictVeh valueForKey:@"photoLink"] objectAtIndex:x],
                                        [[dictVeh valueForKey:@"runId"] objectAtIndex:x],
                                        [[dictVeh valueForKey:@"make"] objectAtIndex:x],
                                        [[dictVeh valueForKey:@"vin"] objectAtIndex:x],
                                        [[dictVeh valueForKey:@"year"] objectAtIndex:x],
                                        [[dictVeh valueForKey:@"odometer"] objectAtIndex:x],
                                        [[dictVeh valueForKey:@"model"] objectAtIndex:x],nil] atIndex:x];
        }
        arrayFilter = [[NSMutableArray alloc]init];
        arrayRunlist = [[NSMutableArray alloc]initWithArray:dArrayHolder];
        //   dispatch_async(dispatch_get_main_queue(),
        //                ^{
        NSLog(@"TableArray:%i",[arrayRunlist count]);
        [tableVeh reloadData];
        [dArrayHolder release];
        
        
        //  });
        //
        //  });
    }
}

-(void)textViewDidChange:(UITextView *)textView{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    
    
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;
    
    
    [viewMain setFrame:CGRectMake(8, 340  - newFrame.size.height, viewMsg.frame.size.width, viewMsg.frame.size.height + newFrame.size.height)];
    buttonSend.frame = CGRectMake(buttonSend.frame.origin.x, 9, buttonSend.frame.size.width, buttonSend.frame.size.height);
    
    
    [UIView commitAnimations];
    //[LAILib animateView:textView getFrame:textView.frame];
}
#pragma mark Tutorials
-(void)animateTutorial:(CGRect)pointerLocation getButton:(CGRect)buttonLocation getTextBox:(CGRect)textLocation dMessage:(NSString*)dMessage getTimeAnimate:(float)animationTime{
    labelTutorial.frame = textLocation;
    buttonTutorial.frame = buttonLocation;
    labelTutorial.text = dMessage;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationTime];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    imagePointer.frame = pointerLocation;
    
    [UIView commitAnimations];
    
}
-(void)touchUpEffect:(UIView*)dView{
    dView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    dView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    [UIView commitAnimations];
}
-(void)touchDownEffect:(UIView*)dView{
    dView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    dView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    [UIView commitAnimations];
}
-(void)clickAnimation:(float)touchDown getTouchUp:(float)touchUp{
    [self performSelector:@selector(touchDownEffect:) withObject:imagePointer afterDelay:touchDown];
    [self performSelector:@selector(touchUpEffect:) withObject:imagePointer afterDelay:touchUp];
}
-(void)msgTutorial{
    [self animateTutorial:CGRectMake(208, 495, imagePointer.frame.size.width, imagePointer.frame.size.height) getButton:CGRectMake(buttonTutorial.frame.origin.x, 210,buttonTutorial.frame.size.width, buttonTutorial.frame.size.height) getTextBox:CGRectMake(labelTutorial.frame.origin.x, 190,labelTutorial.frame.size.width, labelTutorial.frame.size.height + 80) dMessage:@"In message section..............." getTimeAnimate:2.0f];
    [self clickAnimation:2.0f getTouchUp:2.1f];
    [self performSelector:@selector(goToTAbleTutorial) withObject:nil afterDelay:2.2];
    
}
-(void)goToTAbleTutorial{
    [self toMsg:nil];
    viewMsg.userInteractionEnabled = NO;
    [self animateTutorial:CGRectMake(132, 369, imagePointer.frame.size.width, imagePointer.frame.size.height) getButton:CGRectMake(buttonTutorial.frame.origin.x, 210,buttonTutorial.frame.size.width, buttonTutorial.frame.size.height) getTextBox:CGRectMake(labelTutorial.frame.origin.x, 190,labelTutorial.frame.size.width, labelTutorial.frame.size.height + 80) dMessage:@"In message section..............." getTimeAnimate:1.0f];
    [self performSelector:@selector(touchDownEffect:) withObject:imagePointer afterDelay:1.1f];
    [self performSelector:@selector(scrollTableDown) withObject:imagePointer afterDelay:1.2f];
    
}
-(void)scrollTableDown{
    [self animateTutorial:CGRectMake(132, 436, imagePointer.frame.size.width, imagePointer.frame.size.height) getButton:CGRectMake(buttonTutorial.frame.origin.x, 210,buttonTutorial.frame.size.width, buttonTutorial.frame.size.height) getTextBox:CGRectMake(labelTutorial.frame.origin.x, 190,labelTutorial.frame.size.width, labelTutorial.frame.size.height + 80) dMessage:@"In message section..............." getTimeAnimate:1.0f];
    [self performSelector:@selector(scrollTableView:) withObject:@"NO" afterDelay:0.3];
    [self performSelector:@selector(scrollTableUp) withObject:nil afterDelay:1.2];
}
-(void)scrollTableUp{
    [self animateTutorial:CGRectMake(132, 364, imagePointer.frame.size.width, imagePointer.frame.size.height) getButton:CGRectMake(buttonTutorial.frame.origin.x, 210,buttonTutorial.frame.size.width, buttonTutorial.frame.size.height) getTextBox:CGRectMake(labelTutorial.frame.origin.x, 190,labelTutorial.frame.size.width, labelTutorial.frame.size.height + 80) dMessage:@"In message section..............." getTimeAnimate:1.0f];
    [self performSelector:@selector(scrollTableView:) withObject:@"YES" afterDelay:0.3];
    [self performSelector:@selector(showButtonTutorial) withObject:nil afterDelay:0.8];
    dTutorialValue = 6;
    
}
-(void)goToSendTutorial{
    [self animateTutorial:CGRectMake(252, 462, imagePointer.frame.size.width, imagePointer.frame.size.height) getButton:CGRectMake(buttonTutorial.frame.origin.x, 210,buttonTutorial.frame.size.width, buttonTutorial.frame.size.height) getTextBox:CGRectMake(labelTutorial.frame.origin.x, 190,labelTutorial.frame.size.width, labelTutorial.frame.size.height + 80) dMessage:@"Don't forget to click SEND" getTimeAnimate:1.0f];
    [self performSelector:@selector(backTutorial:) withObject:@"YES" afterDelay:1.5f];
}
-(void)scrollTableView:(NSString*)isUp{
    float dLoc = 0;
    if ([isUp isEqualToString:@"YES"]) {
        dLoc = tableView.frame.size.height;
    }else{
        dLoc = tableView.contentSize.height -  tableView.frame.size.height;
    }
    CGPoint offset = CGPointMake(0, dLoc);
    [self.tableView setContentOffset:offset animated:YES]; //scroll tableview to the bottom
}
-(void)showButtonTutorial{
    buttonTutorial.alpha = 1.0f;
}
-(void)backTutorial:(NSString*)isDone{
    [self animateTutorial:CGRectMake(134, 502, imagePointer.frame.size.width, imagePointer.frame.size.height) getButton:CGRectMake(buttonTutorial.frame.origin.x, 210,buttonTutorial.frame.size.width, buttonTutorial.frame.size.height) getTextBox:CGRectMake(labelTutorial.frame.origin.x, 190,labelTutorial.frame.size.width, labelTutorial.frame.size.height + 80) dMessage:@"Just presse BACK to return in Remote Rep main functions" getTimeAnimate:1.0f];
    [self clickAnimation:1.0f getTouchUp:1.1f];
    [self performSelector:@selector(toMain:) withObject:nil afterDelay:1.0f];
    if ([isDone isEqualToString:@"YES"]) {
        dTutorialValue = 0;
    }else{
        [self performSelector:@selector(showButtonTutorial) withObject:nil afterDelay:1.1f];
        dTutorialValue = 5;
    }
    //buttonTutorial.alpha = 1.0f;
}
-(void)moreTutorial{
    [self animateTutorial:CGRectMake(60, 496, imagePointer.frame.size.width, imagePointer.frame.size.height) getButton:CGRectMake(buttonTutorial.frame.origin.x, 210,buttonTutorial.frame.size.width, buttonTutorial.frame.size.height) getTextBox:CGRectMake(labelTutorial.frame.origin.x, 190,labelTutorial.frame.size.width, labelTutorial.frame.size.height + 80) dMessage:@"The MORE button contains more bid prices that you can set" getTimeAnimate:2.0f];
    [self clickAnimation:2.0f getTouchUp:2.1f];
    [self performSelector:@selector(removeMainViewTutorial) withObject:nil afterDelay:2.0f];
    [self performSelector:@selector(toMore:) withObject:nil afterDelay:2.0f];
    viewPrices.userInteractionEnabled = NO;
    dTutorialValue = 4;
    
}
-(void)removeMainViewTutorial{
    [self.viewInit removeFromSuperview];
    buttonTutorial.alpha = 1.0f;
}
-(void)sellPassTutorial{
    [self.viewTutorial setUserInteractionEnabled:NO];
    [self.viewMain addSubview:viewInit];
    //[UIView beginAnimations:nil context:nil];
    //[UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    [self animateTutorial:CGRectMake(59, 369, imagePointer.frame.size.width, imagePointer.frame.size.height) getButton:CGRectMake(buttonTutorial.frame.origin.x, 210,buttonTutorial.frame.size.width, buttonTutorial.frame.size.height) getTextBox:CGRectMake(labelTutorial.frame.origin.x, 190,labelTutorial.frame.size.width, labelTutorial.frame.size.height + 80) dMessage:@"Sell and Pass buttons contain 5 seconds approval time for the Consignor to sell or pass." getTimeAnimate:2.0f];
    [self clickAnimation:2.0f getTouchUp:2.1f];
    [self performSelector:@selector(sellPressed:) withObject:nil afterDelay:2.2f];
    [self performSelector:@selector(passButtonTutorial) withObject:nil afterDelay:2.2f];
}
-(void)passButtonTutorial{
    [self animateTutorial:CGRectMake(207, 369, imagePointer.frame.size.width, imagePointer.frame.size.height) getButton:CGRectMake(buttonTutorial.frame.origin.x, buttonTutorial.frame.origin.y,buttonTutorial.frame.size.width, buttonTutorial.frame.size.height) getTextBox:CGRectMake(labelTutorial.frame.origin.x, labelTutorial.frame.origin.y,labelTutorial.frame.size.width, labelTutorial.frame.size.height) dMessage:labelTutorial.text getTimeAnimate:2.0f];
    [self clickAnimation:2.0f getTouchUp:2.1f];
    [self performSelector:@selector(passSellDone) withObject:nil afterDelay:2.2f];
    
}
-(void)passSellDone{
    [self passPressed:nil];
    buttonTutorial.alpha = 1.0f;
    dTutorialValue = 2;
    [self.viewMain setUserInteractionEnabled:NO];
    [self.viewTutorial setUserInteractionEnabled:YES];
}
-(void)doubleSell{
    
    intSellCount = 0;
    [self animateTutorial:CGRectMake(60, 369, imagePointer.frame.size.width, imagePointer.frame.size.height)
                getButton:CGRectMake(buttonTutorial.frame.origin.x, buttonTutorial.frame.origin.y,buttonTutorial.frame.size.width, buttonTutorial.frame.size.height)
               getTextBox:CGRectMake(labelTutorial.frame.origin.x, labelTutorial.frame.origin.y,labelTutorial.frame.size.width, labelTutorial.frame.size.height)
                 dMessage:@"And if you confirm the Sell or Pass function, it will be logged into Live Chat and will show Green for Sell and Red for Pass"
           getTimeAnimate:2.0f];
    [self clickAnimation:2.0f getTouchUp:2.1f];
    [self performSelector:@selector(sellPressed:) withObject:nil afterDelay:2.1f];
    [self clickAnimation:2.2f getTouchUp:2.3f];
    [self performSelector:@selector(sellPressed:) withObject:nil afterDelay:2.3f];
    [self performSelector:@selector(doublePass) withObject:nil afterDelay:2.6f];
    
}
-(void)doublePass{
    intPassCount = 0;
    [self animateTutorial:CGRectMake(207, 369, imagePointer.frame.size.width, imagePointer.frame.size.height) getButton:CGRectMake(buttonTutorial.frame.origin.x, 250,buttonTutorial.frame.size.width, buttonTutorial.frame.size.height) getTextBox:CGRectMake(labelTutorial.frame.origin.x, labelTutorial.frame.origin.y,labelTutorial.frame.size.width, labelTutorial.frame.size.height) dMessage:labelTutorial.text getTimeAnimate:2.0f];
    [self clickAnimation:2.0f getTouchUp:2.1f];
    [self performSelector:@selector(passPressed:) withObject:nil afterDelay:2.1f];
    [self performSelector:@selector(doublePassDone) withObject:nil afterDelay:2.1f];
    
}
-(void)doublePassDone{
    [self clickAnimation:0.1f getTouchUp:0.2f];
    [self performSelector:@selector(passPressed:) withObject:nil afterDelay:0.3f];
    [self.viewTutorial setUserInteractionEnabled:YES];
    buttonTutorial.alpha = 1.0f;
    dTutorialValue = 3;
    
}
-(void)slidingTutorial{
    
    [self.viewTutorial addSubview:viewMain];
    [self.viewTutorial addSubview:imagePointer];
    [self.viewTutorial addSubview:labelTutorial];
    [self.viewTutorial addSubview:buttonTutorial];
    viewMain.frame = CGRectMake(viewMain.frame.origin.x, viewMain.frame.origin.y, viewMain.frame.size.width, viewMain.frame.size.height);
    buttonTutorial.alpha = 0.0f;
    imagePointer.frame = CGRectMake(14, 440, imagePointer.frame.size.width, imagePointer.frame.size.height);
    [self performSelector:@selector(touchDownEffect:) withObject:imagePointer afterDelay:0.5f];
    [self performSelector:@selector(moveSlideTutorial) withObject:nil afterDelay:0.9f];
}
-(void)moveSlideTutorial{
    //imagePointer.frame = CGRectMake(14, 440, imagePointer.frame.size.width, imagePointer.frame.size.height);
    [self animateTutorial:CGRectMake(261, 440, imagePointer.frame.size.width, imagePointer.frame.size.height) getButton:CGRectMake(buttonTutorial.frame.origin.x, 375,buttonTutorial.frame.size.width, buttonTutorial.frame.size.height) getTextBox:CGRectMake(labelTutorial.frame.origin.x, 360,labelTutorial.frame.size.width, labelTutorial.frame.size.height) dMessage: @"Slide the bar to enable live bidding" getTimeAnimate:2.0f];
    [self performSelector:@selector(touchUpEffect:) withObject:imagePointer afterDelay:2.0f];
    [self performSelector:@selector(slidingTutorialDone) withObject:nil afterDelay:2.0f];
    
}
-(void)slidingTutorialDone{
    self.viewTutorial.userInteractionEnabled = YES;
    dTutorialValue = 1;
    
}
-(IBAction)nextTutorial:(id)sender{
    switch (dTutorialValue) {
        case 1:
            [viewSlide removeFromSuperview];
            [self sellPassTutorial];
            break;
        case 2:
            if (intPassCounter>=4) {
                intPassCounter = 3;
                [self timePassStartCount];
            }
            if (intSellCounter>=4) {
                intSellCounter = 3;
                [self timeSellStartCount];
            }
            [self doubleSell];
            break;
        case 3:
            [self moreTutorial];
            //[self.self.viewMain setUserInteractionEnabled:YES];
            break;
        case 4:
            [self backTutorial:@"NO"];
            break;
        case 5:
            [self msgTutorial];
            break;
        case 6:
            [self goToSendTutorial];
            break;
        default:
            break;
    }
    buttonTutorial.alpha = 0.0f;
}
-(IBAction)removeTutorial:(id)sender{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    inTutorial = NO;
    [LAILib animateView:viewTutorial getFrame:CGRectMake(0, 568, self.viewTutorial.frame.size.width, self.viewTutorial.frame.size.height)];
    slider.value = 0.0f;
    [imagePointer removeFromSuperview];
    [viewSlide removeFromSuperview];
    viewPrices.userInteractionEnabled = YES;
    viewMsg.userInteractionEnabled = YES;
    viewInit.userInteractionEnabled = YES;
    viewSlide.userInteractionEnabled = YES;
    viewMain.userInteractionEnabled = YES;
    [self.view addSubview:viewMain];
    [self.viewMain addSubview:viewSlide];
    if (intPassCounter>=4) {
        intPassCounter = 3;
        [self timePassStartCount];
    }
    if (intSellCounter>=4) {
        intSellCounter = 3;
        [self timeSellStartCount];
    }
    intSellCount = 0;
    intPassCount = 0;
    alreadyShow = YES;
}
@end
