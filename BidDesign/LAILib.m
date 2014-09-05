//
//  LAILib.m
//  BidDesign
//
//  Created by Nickyboy on 2014-08-14.
//  Copyright (c) 2014 NickyLAI. All rights reserved.
//

#import "LAILib.h"

@implementation LAILib
+(UIView*)animateView:(UIView*)dView getFrame:(CGRect)dFrame{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [dView setFrame:dFrame];
    [UIView commitAnimations];
    return dView;
    
}
+(void)removeSubviews:(UIView*)dView getTag:(NSInteger)dTag{
    for (UIView *subview in [dView subviews]) {
        if (subview.tag == dTag) {
            [subview removeFromSuperview];
        }
    }

}
+(UIColor*)getRGBRed:(float)red Green:(float)green Blue:(float)blue Alpha:(float)alpha{
    UIColor *tempColor = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
    return tempColor;
}

+(NSString*)globalValue:(NSString*)dString willSet:(BOOL)isSet setString:(NSString*)keyString{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (isSet) {
        [defaults setObject:dString forKey:keyString];
        return nil;
    }else{
        
        return [defaults objectForKey:dString];
    }
}
+ (void)adjustHeightOfTableview:(UITableView*)dTableView;
{
    CGFloat height = dTableView.contentSize.height;
    CGFloat maxHeight = dTableView.superview.frame.size.height - dTableView.frame.origin.y;
    
    // if the height of the content is greater than the maxHeight of
    // total space on the screen, limit the height to the size of the
    // superview.
    
    if (height > maxHeight)
        height = maxHeight;
    
    // now set the frame accordingly
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = dTableView.frame;
        frame.size.height = height;
        dTableView.frame = frame;
        
        // if you have other controls that should be resized/moved to accommodate
        // the resized tableview, do that here, too
    }];
}
+(UIView*)animateFade:(UIView*)dView setAlpha:(NSInteger)dAlpha willMove:(BOOL)isMoving getFrame:(CGRect)dFrame completion:(void (^)(void))completion NS_AVAILABLE_IOS(5_0){
    dView.alpha = 1.0f;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    dView.alpha = dAlpha;
    
    if (isMoving) {
        [dView setFrame:dFrame];
    }
    
    [UIView commitAnimations];
    return dView;
    
}
+(BOOL)isInternetConnected{
    BOOL dVal=NO;
    if([[self globalValue:@"InternetConn" willSet:NO setString:nil] isEqualToString:@"YES"]){
        
        dVal=YES;
        
    }else {
        dVal=NO;
    }
    return dVal;
    
}
+(NSString*)getAmPmTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"hh:mm a"];
    NSString *dString  = [formatter stringFromDate:[NSDate date]];
    [formatter release];
    return dString;
}
+ (NSString*) getDateTime:(BOOL)isDate{
    
    // Get current date time
    
    NSDate *currentDateTime = [NSDate date];
    
    // Instantiate a NSDateFormatter
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // Set the dateFormatter format
    
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // or this format to show day of the week Sat,11-12-2011 23:27:09
    
    //[dateFormatter setDateFormat:@"EEE,MM-dd-yyyy HH:mm:ss"];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    // Get the date time in NSString
    
    NSString *dateInStringFormated = [dateFormatter stringFromDate:currentDateTime];
    
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    NSString *timeInStringFormated = [dateFormatter stringFromDate:currentDateTime];
    
    //NSLog(@"Result: %@", dateInStringFormated);
    
    // Release the dateFormatter
    
    [dateFormatter release];
    
    if(isDate==YES){
        
        return dateInStringFormated;
        
    }else {
        return timeInStringFormated;
    }
    
}
+(NSInteger)getCellHeight:(NSString*)dText getFont:(UIFont*)dFont getWidth:(NSInteger)dWidth getAdd:(NSInteger)dAddedHeight{
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:dText
     attributes:@
     {
     NSFontAttributeName: dFont
     }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){dWidth, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    return size.height + dAddedHeight;
    
}
+(NSString *) getArrayValue:(NSMutableArray *)data row:(int)row column:(int)column{
    
    NSString *result=@"";
    
    result=[[data objectAtIndex:row] objectAtIndex:column];
    
    return result;
    
}

+(NSString*)trimWhiteSpace:(NSString*)dString{
    dString = [dString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return dString;
}
+(NSString *) getDocumentDirectory{
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    return docDir;
    
}
+(BOOL)isFileExistInDocumentDirectory:(NSString *)fileName{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *tempImg= fileName;
    
    //NSString *pngFilePath = [NSString stringWithFormat:@"%@/%@",docDir,tempImg];
    
    BOOL success =[fileManager fileExistsAtPath:tempImg];
    
    return success;
    
}
+(UIImage*)getImageFile:(NSString*)imageName{
    UIImage *tempImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]
                                                           pathForResource:imageName ofType:@"png"]];
    return tempImage;
}
+(BOOL)isIphone5{
    BOOL is5 = NO;
    if ([[UIScreen mainScreen]bounds].size.height > 480) {
        is5 = YES;
    }
    //NSLog(@"Size:%f",[[UIScreen mainScreen]bounds].size.height);
    return is5;
}
+(BOOL)isIpad{
    NSLog(@"isIpad");
    BOOL isOk = NO;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        isOk = YES; /* Device is iPad */
    }
    
    NSLog(@"isIpad2");
    return isOk;
}
@end
