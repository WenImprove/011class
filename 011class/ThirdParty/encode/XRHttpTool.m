//
//  XRHttpTool.m
//  KnowerParty
//
//  Created by 董欣然 on 15/1/9.
//  Copyright (c) 2015年 cn.chuangxue. All rights reserved.
//

#import "XRHttpTool.h"
#import "AFNetworking.h"
#import "XREncodeAndDecodeTool.h"

#define kBaseUrl @"http://120.24.70.149/piaoshu1/index.php/"

@implementation XRHttpTool


+(void)getWithUrl:(NSString *)url success:(HttpStringSuccessBlock)success failure:(HttpStringFailureBlock)failure
{

}

+(void)postWithUrl:(NSString *)url success:(HttpStringSuccessBlock)success failure:(HttpStringFailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置content-type
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:[NSArray arrayWithObjects:@"text/html",@"text/plain", nil]];
    //设置编码
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //发送请求
    [manager POST:[NSString stringWithFormat:@"%@%@",kBaseUrl,url] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //转换成字符串
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        success(result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+(void)postWith:(NSString *)url withParamNames:(NSArray *)names withParamValues:(NSArray *)values success:(HttpStringSuccessBlock)success failure:(HttpStringFailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置content-type
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:[NSArray arrayWithObjects:@"text/html", @"text/plain", nil]];
    //设置编码
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //参数编码,设置参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i = 0; i < names.count; i++) {
        [dict setObject:[[values objectAtIndex:i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:[[names objectAtIndex:i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    //NSDictionary *dict = [NSDictionary dictionaryWithObjects:values forKeys:names];
    //发起请求
    [manager POST:[NSString stringWithFormat:@"%@%@",kBaseUrl,url] parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        success(result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+(void)postDecodeWith:(NSString *)url withParamNames:(NSArray *)names withParamValues:(NSArray *)values success:(HttpStringSuccessBlock)success failure:(HttpStringFailureBlock)failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //设置content-type
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:[NSArray arrayWithObjects:@"text/html", @"text/plain", nil]];
    //设置编码
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //参数编码,设置参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i = 0; i < names.count; i++) {
        [dict setObject:[[values objectAtIndex:i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:[[names objectAtIndex:i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    //参数加密
//    NSDictionary *params = [NSDictionary dictionaryWithObject:[XREncodeAndDecodeTool ocEncryptToHexWithInputStr:[dict JSONString]] forKey:@"encrept"];
    NSDictionary *params;
    //发起请求
    //DDLog(@"HTTP url-->%@",[NSString stringWithFormat:@"%@%@",kBaseUrl,url]);
    [manager POST:[NSString stringWithFormat:@"%@%@",kBaseUrl,url] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"HTTP Suceess Result-->%@",result);
        success(result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"HTTP Failure Result-->%@",error);
        failure(error);
    }];
}

#pragma mark - 面向对象编程
+(void)postEncodeWithUrl:(NSString *)url withParams:(NSDictionary *)param success:(HttpRequestSuccessBlock)success failure:(HttpStringFailureBlock)failure
{
//    DDLog(@"param-->%@",param);
//    DDLog(@"encode param-->%@",[XREncodeAndDecodeTool encode2HttpWithDict:param]);
    //检查key
    [XRAuthenticationTool getKeySuccess:^(NSString *key) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //设置content-type
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:[NSArray arrayWithObjects:@"text/html", @"text/plain", nil]];
        //设置编码
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //发起请求
        [manager POST:[NSString stringWithFormat:@"%@%@",kBaseUrl,url] parameters:[XREncodeAndDecodeTool encode2HttpWithDict:param]
            success:^(AFHTTPRequestOperation *operation, id responseObject) {
             //NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             //NSLog(@"HTTP Suceess Result-->%@",responseObject);
                success(responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"HTTP Failure Result-->%@",error);
             failure(error);
         }];
    } failure:^(NSError *error) {
        failure(error);
    }];


}
@end
