//
//  Internet.m
//  Perxclub
//
//  Created by Nicky Malayba on 1/10/13.
//  FRAMEWORK VERSION: 1.1


#import "Internet.h"
@implementation Internet
@synthesize delegate,dconnectionName,errorMsg,cancelResult,timeOut;

-(void) httpRequest:(NSString *)url params:(NSString *)params getMethod:(NSString*)dMethod connectionName:(NSString *)connectionName{
    
    if (connection!=nil) { [connection release]; } //in case we are downloading a 2nd image
	if (receivedData!=nil) { [receivedData release]; }
    
    dconnectionName=connectionName;
    
    if(timeOut<=0){
        timeOut=60.0;
    }
    
    NSLog(@"INTERNET TIME OUT: %f",timeOut);
    
    NSURL *URLs = [NSURL URLWithString:url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URLs cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeOut];
    
    request.HTTPMethod=dMethod;
    
    NSData *datas = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [request addValue:@"8bit" forHTTPHeaderField:@"Content-Transfer-Encoding"];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request addValue:[NSString stringWithFormat:@"%lu",(unsigned long)[datas length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:datas];
    
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSLog(@"INTERNET OPEN:%@ URL:%@ PARAMETERS:%@ ",connectionName,url,params);
}

#pragma mark NSURLConnection methods

- (void)connection:(NSURLConnection *)dconnection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
    
}

- (void)connection:(NSURLConnection *)dconnection didReceiveData:(NSData *)data
{
    if (receivedData==nil) { receivedData = [[NSMutableData alloc] initWithCapacity:2048]; } 
	[receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)dconnection didFailWithError:(NSError *)error
{
    [connection release];
    [receivedData release];
    
    
    NSLog(@"INTERNET CLASS CLOSE WITH NAME: %@ -- IN ERROR MODE",dconnectionName);
    
    NSString *err=[NSString stringWithFormat:@"Connection failed! Error - %@ %@",
                   [error localizedDescription],
                   
                   [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]];
    
    errorMsg=err;
    
    if(!cancelResult){
        @try {
            if([self.delegate respondsToSelector:@selector(internetDidFailWithError:connectionName:)]){
                [self.delegate internetDidFailWithError:errorMsg connectionName:dconnectionName];
            }
        }
        @catch (NSException *exception) {
            NSLog(@"Error: %@",exception.reason);
        }
        @finally {
            
        }
        
    }
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)dconnection
{
    [connection release];
	connection=nil;
    
    if(!cancelResult){
        if([self.delegate respondsToSelector:@selector(internetDidFinishDownloading:connectionName:)]){
            
            NSString *result = [[[NSString alloc] init] autorelease];
            
            result=[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
            
            //NSLog(@"IN RES: %@",result);
            
            [self.delegate internetDidFinishDownloading:receivedData connectionName:dconnectionName];
        }
        
        
    }
    [receivedData release];
    receivedData=nil;
    
    
}

- (void)dealloc {

    //[connection cancel]; //in case the URL is still downloading
    
    //if(connection){
    
    @try {
        [connection release];
        NSLog(@"INTERNET CLASS CLOSE WITH NAME: %@",dconnectionName);
    }
    @catch (NSException *exception) {
        //
    }
    @finally {
        //
    }
    
        
    //}
    
    
    [receivedData release]; 
    [errorMsg release];
    [dconnectionName release];
   
    NSLog(@"INTERNET DEALLOC: ");

    [super dealloc];
}

-(void) cancelRequest{
    
    [connection cancel];
    
}

@end
