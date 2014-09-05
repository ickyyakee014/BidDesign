//
//  SectionsPageHolder.m
//  BidDesign
//
//  Created by Nickyboy on 2014-08-27.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import "SectionsPageHolder.h"
#import "TableMainView.h"
#import "XMLReader.h"
@interface SectionsPageHolder ()

@end
static NSInteger MaxPage = 2;
@implementation SectionsPageHolder
@synthesize pageController,viewTable,tableShow,arrayTable,isShow,dPageControl,dVehID,conn;
-(void)dealloc{
    if (conn) {
        [conn release];
    }
    [dVehID release];
    [dPageControl release];
    [tableShow release];
    [arrayTable release];
    [viewTable release];
    [pageController release];
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
-(void)viewWillDisappear:(BOOL)animated{
    [self checkOpenConnection];
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
-(void)viewWillAppear:(BOOL)animated{
    [self syncDownload:[NSString stringWithFormat:@"https://mob1-av5q-inf.liveblockauctions.com:443/bamappserver/rest/vehlist/html/%@?md5String=1047&purpose=detail",dVehID] getParam:@"" getConnName:@"VehDetail" getMethod:@"GET"];
}
-(void)syncDownload:(NSString*)urlLink getParam:(NSString*)dParam getConnName:(NSString*)dConnName getMethod:(NSString*)dMethod{
    if (conn) {
        [conn setCancelResult:YES];
        [conn cancelResult];
        [conn setDelegate:nil];
        conn = nil;
        [conn release];
    }
    
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
   // NSError *error;
    //NSDictionary *connDict = [XMLReader dictionaryForXMLString:result error:&error];
    NSLog(@"connDict:%@",result);
}
- (UIBarButtonItem *)leftMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(showTable:)];
}
-(IBAction)showTable:(id)sender{
    
    if (isShow) {
        isShow = NO;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        //[self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        viewTable.frame = CGRectMake(self.view.frame.size.width, 0, self.viewTable.frame.size.width, self.viewTable.frame.size.width);
        [UIView commitAnimations];
        
        double delayInSeconds = 0.2;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [viewTable removeFromSuperview];
        });
        
    }else{
        isShow = YES;
        [self.view addSubview:viewTable];
        viewTable.frame = CGRectMake(320, 0, self.viewTable.frame.size.width, self.viewTable.frame.size.width);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        //[self.view setFrame:CGRectMake(-207, 0, self.view .frame.size.width, self.view .frame.size.height)];
        viewTable.frame = CGRectMake(113, 0, self.viewTable.frame.size.width, self.viewTable.frame.size.width);
        [UIView commitAnimations];
    }
    
    //[dView release];
}
-(CGFloat)tableView:(UITableView*)tableViews heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableViews numberOfRowsInSection:(NSInteger)section {
    
    return [arrayTable count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableViews cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self msgTable:tableViews getCell:indexPath];
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
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:15.0];
    cell.textLabel.text = [arrayTable objectAtIndex:dIndexPath.row];
    //[cell.contentView addSubview:cell.textLabel];
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableViews didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TableMainView *initialViewController = [self viewControllerAtIndex:indexPath.row];
     NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    //[self pageViewController:pageController viewControllerBeforeViewController:dViewControlelr];
}
- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movePageControl:)
                                                 name:@"MovePage" object:nil];
    
    arrayTable = [[NSMutableArray alloc]initWithObjects:@"First",@"Second", nil];
    
    [tableShow reloadData];

    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor lightGrayColor];
    
    
    self.navigationItem.rightBarButtonItem = [self leftMenuBarButtonItem];
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    //[[self.pageController view] setFrame:[[self view] bounds]];
    self.pageController.view.frame = CGRectMake(0.0, 0.0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    TableMainView *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    dPageControl.numberOfPages = MaxPage;
    dPageControl.frame = CGRectMake(141, 500, 39, 20);
    dPageControl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:dPageControl];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (TableMainView *)viewControllerAtIndex:(NSUInteger)index {
    //*****manipulate what will happen
    TableMainView *childViewController = [[TableMainView alloc] initWithNibName:@"TableMainView" bundle:nil];
    childViewController.index = index;
    return childViewController;
    
}
-(void)movePageControl:(NSNotification *)note{
    
    self.dPageControl.currentPage = [[[note userInfo]valueForKey:@"Value"] integerValue];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(TableMainView *)viewController index];
    
    
    if (index == 0) {
        return nil;
    }
    // Decrease the index by 1 to return
    index--;
    return [self viewControllerAtIndex:index];
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(TableMainView *)viewController index];
    
    index++;
    
    
    if (index == 2) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return MaxPage;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
