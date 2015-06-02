//
//  XRHttpTool.h
//  KnowerParty
//
//  Created by 董欣然 on 15/1/9.
//  Copyright (c) 2015年 cn.chuangxue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XRAuthenticationTool.h"
#define kSuccess @"RIGHT"
#define kError @"ERROR"

/**
 *  HTTP请求,成功,返回字符串
 *
 *  @param result
 */
typedef void (^HttpStringSuccessBlock)(NSString *result);
typedef void (^HttpRequestSuccessBlock)(id json);
/**
 *  HTTP请求,失败,返回error
 *
 *  @param error
 */
typedef void (^HttpStringFailureBlock)(NSError *error);


@interface XRHttpTool : NSObject

/**
 *  无参数get请求,返回字符串
 *
 *  @param url
 *  @param success
 *  @param failure
 */
+ (void) getWithUrl:(NSString *)url success:(HttpStringSuccessBlock)success failure:(HttpStringFailureBlock)failure;

/**
 *  无参数post请求,返回字符串
 *
 *  @param url
 *  @param success
 *  @param failure
 */
+ (void) postWithUrl:(NSString *)url success:(HttpStringSuccessBlock)success failure:(HttpStringFailureBlock)failure;

/**
 *  有参数,不加密,post请求,返回字符串
 *
 *  @param url
 *  @param names
 *  @param values
 *  @param success
 *  @param failure
 */
+ (void) postWith:(NSString *)url withParamNames:(NSArray *)names withParamValues:(NSArray *)values success:(HttpStringSuccessBlock)success failure:(HttpStringFailureBlock)failure;

/**
 *  有参数,加密,post请求,返回字符串
 *
 *  @param url
 *  @param names
 *  @param values
 *  @param success
 *  @param failure
 */
+ (void) postDecodeWith:(NSString *)url withParamNames:(NSArray *)names withParamValues:(NSArray *)values success:(HttpStringSuccessBlock)success failure:(HttpStringFailureBlock)failure;

/**
 *  有参数,加密post请求,返回字符串
 *
 *  @param url
 *  @param param
 *  @param success
 *  @param failure
 */
+ (void) postEncodeWithUrl:(NSString*)url withParams:(NSDictionary *)param success:(HttpRequestSuccessBlock)success failure:(HttpStringFailureBlock)failure;
@end
