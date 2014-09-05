//
//  LAILib.h
//  BidDesign
//
//  Created by Nickyboy on 2014-08-14.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LAILib : NSObject
+(UIView*)animateView:(UIView*)dView getFrame:(CGRect)dFrame;
+(UIView*)animateFade:(UIView*)dView setAlpha:(NSInteger)dAlpha willMove:(BOOL)isMoving getFrame:(CGRect)dFrame completion:(void (^)(void))completion NS_AVAILABLE_IOS(5_0);
+(BOOL)isIphone5;
+(void)removeSubviews:(UIView*)dView getTag:(NSInteger)dTag;
+ (void)adjustHeightOfTableview:(UITableView*)dTableView;
+(NSString*)globalValue:(NSString*)dString willSet:(BOOL)isSet setString:(NSString*)keyString;
+(UIColor*)getRGBRed:(float)red Green:(float)green Blue:(float)blue Alpha:(float)alpha;
+(BOOL)isInternetConnected;
+(NSString *) getDocumentDirectory;
+(BOOL)isFileExistInDocumentDirectory:(NSString *)fileName;
+(NSString *) getArrayValue:(NSMutableArray *)data row:(int)row column:(int)column;
+(UIImage*)getImageFile:(NSString*)imageName;
+(NSInteger)getCellHeight:(NSString*)dText getFont:(UIFont*)dFont getWidth:(NSInteger)dWidth getAdd:(NSInteger)dAddedHeight;
+(NSString*)trimWhiteSpace:(NSString*)dString;
+ (NSString*) getDateTime:(BOOL)isDate;
+(NSString*)getAmPmTime;
@end
