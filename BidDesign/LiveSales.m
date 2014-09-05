//
//  LiveSales.m
//  BidDesign
//
//  Created by Nickyboy on 2014-09-02.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import "LiveSales.h"
#import "LiveSalesCell.h"
#import "XMLReader.h"
#import "LAILib.h"
@interface LiveSales ()

@end

@implementation LiveSales
@synthesize tableLiveSales,arrayLiveSales,conn;
-(void)dealloc{
    [tableLiveSales release];
    [arrayLiveSales release];
    if (conn) {
        [self checkOpenConnection];
    }
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
-(void)viewWillAppear:(BOOL)animated{
    [self checkOpenConnection];
}
-(void)viewDidAppear:(BOOL)animated{
    [self syncDownload:@"https://mob1-av5q-inf.liveblockauctions.com:443/bamappserver/rest/liveauctionlist?md5String=1047&refresh=0" getParam:@"" getMethod:@"GET" getConnName:@"LiveSales"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView*)tableViews heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 71;
}
- (NSInteger)tableView:(UITableView *)tableViews numberOfRowsInSection:(NSInteger)section {
    
    return [arrayLiveSales count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self vehTable:tableViews getCell:indexPath];
}
-(UITableViewCell*)vehTable:(UITableView*)dTableView getCell:(NSIndexPath*)dIndexPath{
    static NSString *tableIdentifier = @"LiveSalesCellIdentifier";
    
    LiveSalesCell *cell = (LiveSalesCell *)[dTableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LiveSalesCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.labelName.text = [LAILib getArrayValue:arrayLiveSales row:dIndexPath.row column:2];
    cell.labelDesc.text = [LAILib getArrayValue:arrayLiveSales row:dIndexPath.row column:3];
    
    if ([[LAILib getArrayValue:arrayLiveSales row:dIndexPath.row column:6] integerValue] > 0) {
        cell.imageCell.animationImages = [NSArray arrayWithObjects:
                                          [UIImage imageNamed:@"icon_livesale_1.png"],
                                          [UIImage imageNamed:@"icon_livesale_2.png"],
                                          [UIImage imageNamed:@"icon_livesale_3.png"],nil];
        cell.imageCell.animationDuration = 2.0;
        cell.imageCell.animationRepeatCount = 0;
        [cell.imageCell startAnimating];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableViews didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
-(void)syncDownload:(NSString*)urlLink getParam:(NSString*)dParam getMethod:(NSString*)dMethod getConnName:(NSString*)dConnName{
    [self checkOpenConnection];
    
    conn = [[Internet alloc]init];
    [conn setDelegate:self];
    [conn httpRequest:urlLink params:dParam getMethod:dMethod connectionName:dConnName];
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
    NSLog(@"DICT:%@",connDict);
    
    connDict = [[connDict objectForKey:@"salelist"] objectForKey:@"sale"];
    
    NSMutableArray *dArrayHolder = [[NSMutableArray alloc]init];
    
    for (int x = 0; x< [connDict count]; x++) {
        [dArrayHolder insertObject:[NSMutableArray arrayWithObjects:[[connDict valueForKey:@"PSI"] objectAtIndex:x],
                                    [[connDict valueForKey:@"autobidWindow"] objectAtIndex:x],
                                    [[connDict valueForKey:@"caption"] objectAtIndex:x],
                                    [[connDict valueForKey:@"desc"] objectAtIndex:x],
                                    [[connDict valueForKey:@"id"] objectAtIndex:x],
                                    [[connDict valueForKey:@"isClosed"] objectAtIndex:x],
                                    [[connDict valueForKey:@"isRunning"] objectAtIndex:x],
                                    [[connDict valueForKey:@"vehicleCount"] objectAtIndex:x],nil] atIndex:x];
    }
    arrayLiveSales = [[NSMutableArray alloc]initWithArray:dArrayHolder];
    [dArrayHolder release];
 
    [tableLiveSales reloadData];
}

@end
