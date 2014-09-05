//
//  Internet.h
//  Perxclub
//
//  Created by Nicky Malayba on 1/10/13.
//  FRAMEWORK VERSION: 1.1

#import <UIKit/UIKit.h>

@protocol InternetDelegate;
@interface Internet : NSObject{
    
    NSURLConnection *connection;
    NSMutableData *receivedData;
    
    id <InternetDelegate> delegate;
    
    NSString *dconnectionName;
    NSString *errorMsg;
    float timeOut;
    
    BOOL cancelResult;
    
}

@property(nonatomic) float timeOut;
@property(nonatomic) BOOL cancelResult;
@property(assign) id<InternetDelegate> delegate;
@property(nonatomic,retain) NSString *dconnectionName;
@property(nonatomic,retain) NSString *errorMsg;

-(void) httpRequest:(NSString *)url params:(NSString *)params getMethod:(NSString*)dMethod connectionName:(NSString *)connectionName;
-(void) cancelRequest;

@end


@protocol InternetDelegate <NSObject>
@optional
-(void) internetDidFinishDownloading:(NSMutableData *) data connectionName:(NSString *)connectionName;
-(void) internetDidFailWithError:(NSString *) error connectionName:(NSString *)connectionName;
@end