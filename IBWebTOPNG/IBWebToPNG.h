//
//  IBWebToPNG.h
//  MyDeen
//
//  Created by Ibrahim Qraiqe on 15.01.13.
//  Copyright (c) 2013 Ibrahim Qraiqe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IBWebToPNG : NSObject


+(void)creatPNGSFromWebView:(UIWebView *)myWeb width:(float)width resultFileName:(NSString *)resultFileName;
@end
