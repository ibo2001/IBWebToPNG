//
//  IBWebToPNG.m
//  MyDeen
//
//  Created by Ibrahim Qraiqe on 15.01.13.
//  Copyright (c) 2013 Ibrahim Qraiqe. All rights reserved.
//

#import "IBWebToPNG.h"
#import <QuartzCore/QuartzCore.h>

@implementation IBWebToPNG
int imageName = 0;

+ (void) creatOnePngFile:(UIWebView *)myWeb width:(float)width resultFileName:(NSString *)resultFileName{
    
    CGSize pageSize = CGSizeMake(width*[[UIScreen mainScreen] scale], myWeb.scrollView.contentSize.height*[[UIScreen mainScreen] scale]);
    
    NSString *fileName = resultFileName;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pngFileName = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    CGSize size = CGSizeMake(pageSize.width, pageSize.height);
    UIGraphicsBeginImageContext(size);
    
    double currentHeight = 0.0;
    UIImage *newImg = nil;
    
    for (int index = 1; index <= imageName ; index++){
        NSLog(@"index %d",index);
        
        NSString *pngPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.png", index]];
        UIImage *pngImage = [UIImage imageWithContentsOfFile:pngPath];
        
        [pngImage drawInRect:CGRectMake(0, currentHeight, pageSize.width, pngImage.size.height)];
        currentHeight += pngImage.size.height;
        
        newImg = UIGraphicsGetImageFromCurrentImageContext();        
    }
    
    [UIImagePNGRepresentation(newImg) writeToFile:pngFileName atomically:YES];
    
    
    UIGraphicsEndPDFContext();
    
    for (int i = 1; i <= imageName; i++) {
        NSString *pngPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.png", i]];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:pngPath error:nil];
        
    }
    imageName = 0;
    [myWeb.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
}

+(void)creatPNGSFromWebView:(UIWebView *)myWeb width:(float)width resultFileName:(NSString *)resultFileName{
    
    
    double currentWebViewHeight = myWeb.scrollView.contentSize.height;
    float scale = [[UIScreen mainScreen] scale];
    while (currentWebViewHeight > 0)
    {
        imageName ++;
        
        if ([UIScreen instancesRespondToSelector:@selector(scale)] && scale == 2.0f)
            UIGraphicsBeginImageContextWithOptions(myWeb.bounds.size, NO, 2.0f);
        else
            UIGraphicsBeginImageContext(myWeb.bounds.size);
        
        
        [myWeb.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *pngPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.png",imageName]];
        
        if(currentWebViewHeight < myWeb.scrollView.contentSize.height){
            CGRect lastImageRect = CGRectMake(0, (myWeb.scrollView.bounds.size.height - currentWebViewHeight)*scale, scale*myWeb.bounds.size.width, scale*currentWebViewHeight);
            
            CGImageRef lastImageRef = CGImageCreateWithImageInRect([newImage CGImage], lastImageRect);
            newImage = [UIImage imageWithCGImage:lastImageRef];
            CGImageRelease(lastImageRef);
        }
        
        [UIImagePNGRepresentation(newImage) writeToFile:pngPath atomically:YES];
        
        [myWeb stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.scrollBy(0,%f);",myWeb.bounds.size.height]];
        currentWebViewHeight -= myWeb.bounds.size.height;
    }
    [self creatOnePngFile:myWeb width:width resultFileName:resultFileName];
}


@end
