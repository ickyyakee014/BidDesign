//
//  TableSections.m
//  BidDesign
//
//  Created by Nickyboy on 2014-08-26.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import "TableSections.h"
#import "LAILib.h"
#import "VehicleTableCell.h"
#import "SectionsPageHolder.h"
#import "Internet.h"
#import "XMLReader.h"
#import "UIImageView+WebCache.h"
@interface TableSections ()

@end

@implementation TableSections
@synthesize tableView,slider,labelAloc,conn,dictVeh,arrayDict;
-(void)dealloc{
    [dictVeh release];
    [slider release];
    if (conn) {
        [self checkOpenConnection];
    }
    [tableView release];
    NSLog(@"Deallocating");
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
-(IBAction)scrollTable:(id)sender{
    UISlider *sliders = (UISlider *)sender;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sliders.value inSection:0];
    [tableView scrollToRowAtIndexPath:indexPath
                     atScrollPosition:UITableViewScrollPositionTop
                             animated:YES];
    
    float y = [self xPositionFromSliderValue:self.slider];
    [self locateY:y];
    [self getArrayValue:sliders.value];
}
-(void)getArrayValue:(NSInteger)dValue{
    labelAloc.text = [NSString stringWithFormat:@"#%@",[LAILib getArrayValue:arrayDict row:dValue column:2]];
}
-(IBAction)isPressed:(id)sender{
    [LAILib animateFade:labelAloc setAlpha:1.0f willMove:NO getFrame:CGRectZero completion:nil];
    
}
-(IBAction)pressedRemove:(id)sender{
    [LAILib animateFade:labelAloc setAlpha:0.0f willMove:NO getFrame:CGRectZero completion:^{
        [self removeLabel];
    }];
}
-(void)removeLabel{
    labelAloc.alpha = 1.0f;
}
- (float)xPositionFromSliderValue:(UISlider *)aSlider;
{
    float sliderRange = aSlider.frame.size.height - aSlider.currentThumbImage.size.height - 15;
    float sliderOrigin = aSlider.frame.origin.y + (aSlider.currentThumbImage.size.height / 2.0);
    
    float sliderValueToPixels = (((aSlider.value-aSlider.minimumValue)/(aSlider.maximumValue-aSlider.minimumValue)) * sliderRange) + sliderOrigin;
    return sliderValueToPixels;
}
-(void)locateY:(float)dValue{
    //labelAloc.text = [NSString stringWithFormat:@"%.2f",dValue];
    labelAloc.frame = CGRectMake(250, dValue -16, 50, 40);
    
}
/*
 -(void)viewWillAppear:(BOOL)animated{
 arrayTable = [[NSMutableArray alloc]init];
 for (int x = 0; x< 500; x++) {
 [arrayTable addObject:[NSString stringWithFormat:@"Number: %i",x]];
 }
 slider.value = 0;
 slider.maximumValue = [arrayTable count] - 1;//Arrays start to ZERO so subtract 1
 [tableView reloadData];
 
 }
 */
- (void)viewDidLoad
{
    
    dictVeh = [[NSDictionary alloc]init];
    self.labelAloc.alpha = 0.0f;
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI_2);
    slider.transform = trans; // this makes the slider to vertical
    
    UIImage *stetchLeftTrack= [[UIImage imageNamed:@"Nothing.png"]
                               stretchableImageWithLeftCapWidth:30.0 topCapHeight:0.0];
	UIImage *stetchRightTrack= [[UIImage imageNamed:@"Nothing.png"]
                                stretchableImageWithLeftCapWidth:30.0 topCapHeight:0.0];
	[slider setThumbImage: [UIImage imageNamed:@"SlidePic.png"] forState:UIControlStateNormal];
	[slider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
	[slider setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    [slider removeFromSuperview];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView*)tableViews heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 96;
}
- (NSInteger)tableView:(UITableView *)tableViews numberOfRowsInSection:(NSInteger)section {
    
    return [dictVeh count];
    
}
/*
 FOR SECTION HEADER
 -(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 return [arraySection objectAtIndex:section];
 }
 Optional (for two sections only in table
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 return 2;
 }
 
 - (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
 return[NSArray arrayWithObjects:@"a", @"e", @"i", @"m", @"p", nil];
 }
 - (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index {
 //return <yourSectionIndexForTheSectionForSectionIndexTitle >;
 return 0;
 }
 */
-(void)refreshTable{
    //call lai adjusttablehieght
}
-(void)viewWillAppear:(BOOL)animated{
    [self checkOpenConnection];
}
-(void)viewDidAppear:(BOOL)animated{
    slider.userInteractionEnabled = NO;
    //https://mob1-av5q-inf.liveblockauctions.com:443/bamappserver/rest/vehlist?md5String=1030&vehlistid=1048426
    [self performSelector:@selector(delayCall) withObject:nil afterDelay:1.0f];
    
}
-(void)delayCall{
    [self syncDownload:@"https://mob1-av5q-inf.liveblockauctions.com:443/bamappserver/rest/vehlist?md5String=1030&vehlistid=1048426" getParam:@"" getConnName:@"VehList"];
}
- (UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self vehTable:tableViews getCell:indexPath];
}
-(UITableViewCell*)vehTable:(UITableView*)dTableView getCell:(NSIndexPath*)dIndexPath{
    static NSString *simpleTableIdentifier = @"VehicleTableCellReuse";
    
    VehicleTableCell *cell = (VehicleTableCell *)[dTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"VehicleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        //AsyncImageView *asyncImage =[[AsyncImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
        //asyncImage.tag = 99;
        //[cell addSubview:asyncImage];
    }
    
    // NSDictionary *book = [[self.dictVeh valueForKey: @"photoLink"] objectAtIndex:dIndexPath.row];
    // NSLog(@"logNga:%@",[[self.dictVeh valueForKey:@"photoLink"]objectAtIndex:0]);
    /*
    
    NSString *fileChecker = [NSString stringWithFormat:@"%@/vehID%@.jpg",[LAILib getDocumentDirectory],[LAILib getArrayValue:arrayDict row:dIndexPath.row column:0]];
    BOOL isCache = [LAILib isFileExistInDocumentDirectory:fileChecker];
    
    if (isCache) {
        cell.imageVeh.image = [UIImage imageWithContentsOfFile:fileChecker];
        //[cell.contentView addSubview:images];
    }else{
        AsyncImageView *asyncImage = [[AsyncImageView alloc]init];
        NSURL *imgUrl = [NSURL URLWithString:[LAILib getArrayValue:arrayDict row:dIndexPath.row column:1]];
        NSLog(@"dURL:%@",imgUrl);
        [asyncImage loadImageFromURL:imgUrl file:[NSString stringWithFormat:@"vehID%@",[LAILib getArrayValue:arrayDict row:dIndexPath.row column:0]] needToSave:YES];
        cell.imageVeh.image = [LAILib getImageFile:@"noimage"];
        [cell.imageVeh addSubview:asyncImage];
        //asyncImage.image = asyncImage.image;
        //[cell.contentView addSubview:asyncImage];
    }
    */
    
     [cell.imageVeh setImageWithURL:[NSURL URLWithString:[LAILib getArrayValue:arrayDict row:dIndexPath.row column:1]]  placeholderImage:[LAILib getImageFile:@"noimage"]];
    
    cell.labelName.text = [NSString stringWithFormat:@"#%@ %@ %@",[LAILib getArrayValue:arrayDict row:dIndexPath.row column:2],
                           [LAILib getArrayValue:arrayDict row:dIndexPath.row column:5],
                           [LAILib getArrayValue:arrayDict row:dIndexPath.row column:3]];
    cell.labelVin.text = [LAILib getArrayValue:arrayDict row:dIndexPath.row column:4];
    cell.labelOdo.text = [LAILib getArrayValue:arrayDict row:dIndexPath.row column:6];
    cell.labelNY.text = @"ADESA Syracuse";
    cell.labelTimeDate.text = @"08/28/2014 10:00 PM EST Open";
    cell.labelLaneGrade.text = @"Lane 1 Grade:Unknown";
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableViews didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionsPageHolder *dNextView = [[SectionsPageHolder alloc]init];
    dNextView.dVehID = [LAILib getArrayValue:arrayDict row:indexPath.row column:0];
    [self.navigationController pushViewController:dNextView animated:YES];
    [dNextView release];
    
}
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
    if([connName isEqualToString:@"VehList"]){
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
                                                           [[dictVeh valueForKey:@"odometer"] objectAtIndex:x],nil] atIndex:x];
                           }
                           arrayDict = [[NSMutableArray alloc]initWithArray:dArrayHolder];
                        //   dispatch_async(dispatch_get_main_queue(),
                          //                ^{
                                              [tableView reloadData];
                                              [dArrayHolder release];
                                              slider.value = 0;
                                              slider.maximumValue = [dictVeh count] - 1;//Arrays start to ZERO so subtract 1
                                              
                                              slider.userInteractionEnabled = YES;
        [self.view addSubview:slider];
        
                                              
                                        //  });
                           //
                     //  });
        
        
    }
}

@end
