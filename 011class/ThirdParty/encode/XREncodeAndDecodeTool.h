//
//  XREncodeAndDecode.h
//  SuperMarket103001
//
//  Created by 董欣然 on 14/11/13.
//  Copyright (c) 2014年 chaungxue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+XR.h"

@interface XREncodeAndDecodeTool : NSObject

/**
 *  加密参数用作网络请求
 */
+ (NSDictionary *)encode2HttpWithDict:(NSDictionary*)dict;

/**
 *  随机增加长度加密
 */
+ (NSString*) encodeAndChangeLengthWithKey:(NSString*)keys inputStr:(NSString*)inputStr;

/**
 *  对随机增加长度加密后的字符串解密
 */
+ (NSString*) decodeAndChangeLengthWithKey:(NSString*)keys inputStr:(NSString*)inputStr;



@end
