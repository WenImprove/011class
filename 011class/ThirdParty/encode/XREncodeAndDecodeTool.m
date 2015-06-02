//
//  XREncodeAndDecode.m
//  SuperMarket103001
//
//  Created by 董欣然 on 14/11/13.
//  Copyright (c) 2014年 chaungxue. All rights reserved.
//


#import "XREncodeAndDecodeTool.h"
#import "MJExtension.h"
#import "JSONKit.h"

@implementation XREncodeAndDecodeTool
+ (NSDictionary *)encode2HttpWithDict:(NSDictionary *)dict
{
    __block NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //取出参数对value进行utf-8编码
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        [params setObject:[[NSString stringWithFormat:@"%@",value] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:[[NSString stringWithFormat:@"%@",key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    return @{@"encrept" : [self ocEncryptToHexWithInputStr:[params JSONString]]};
}

+(NSString *)encodeAndChangeLengthWithKey:(NSString *)keys inputStr:(NSString *)inputStr
{
    NSMutableString *result = [NSMutableString stringWithString:inputStr];
    //1.先随机增加字符串的长度
    NSInteger length = inputStr.length;
    if (length < 24) {
        //对少于24位长度的,长度随机增加
        int ranInt = arc4random() % (24 - length) + 1;
        for (int i = 0; i < ranInt; i++) {
            int temp = arc4random() % 26 + 97;
            [result appendString:[NSString stringWithFormat:@"%c",temp]];
        }
        //2.末尾增加长度标志位
        [result appendString:[NSString stringWithFormat:@"%c",ranInt + 97]];
    } else {
        [result appendString:[NSString stringWithFormat:@"%c",97]];
    }
    //3.对增加长度后的字符串流加密
    return [self encryptToArrayWithKeys:keys inputStr:result];
}

+(NSString *)decodeAndChangeLengthWithKey:(NSString *)keys inputStr:(NSString *)inputStr
{
    NSString *result = [NSString string];
    //判断是否为空字符串
    if (inputStr.length == 0) {
        return inputStr;
    }
    //1.
    NSRange ran;
    NSArray *arr = [inputStr componentsSeparatedByString:@","];
    NSString *temp;
    NSUInteger len = arr.count;
    //这里使用c类型的数组,是因为若acsII码为0时,依旧保留作为占位符
    unichar data[len];
    for (int i = 0; i < arr.count; i++) {
        temp = [arr objectAtIndex:i];
        //        temp = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        temp = [temp clearEnterAndSpace];
//        temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//        temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        if (i == 0) {
            ran = NSMakeRange(1, temp.length - 1);
            data[i] = [[temp substringWithRange:ran] intValue];
        } else if (i == arr.count - 1){
            ran = NSMakeRange(0, temp.length - 1);
            data[i] = [[temp substringWithRange:ran] intValue];
        } else {
            data[i] = [temp intValue];
        }
    }
    //把上面的c类型的字符数组转变为oc数组
    result = [NSString stringWithCharacters:data length:arr.count];
    //2.解密
    result = [self encryptToStreamWithKeys:keys inputStr:result];
    //3.截取出原来的字符串
    ;
    //
    //
    result = [result substringWithRange:NSMakeRange(0, result.length - ([result characterAtIndex:(result.length - 1)] - 96))];
    return result;
}


#pragma mark - private
+ (NSMutableString *)ocEncryptToHexWithInputStr:(NSString *)strInput
{
    //获取密钥接口
    //http://120.24.70.149/zhitu1/index.php/firstlogin_c
    NSString *keys = @"sfaf1520144201550164rf122013111820";
    NSMutableArray *keyBytes = [[NSMutableArray alloc] initWithCapacity:256];
    NSMutableArray *cypherBytes = [[NSMutableArray alloc] initWithCapacity:256];
    for (int i = 0; i < 256; i++) {
        //UniChar ch = [keys characterAtIndex:i % keys.length];
        int ch = [keys characterAtIndex:i % keys.length];
        [keyBytes addObject:[NSNumber numberWithChar:ch]];
        [cypherBytes addObject:[NSNumber numberWithInt:i]];
    }
    int jump = 0;
    for (int i = 0; i < 256; i++) {
        jump = jump + [[cypherBytes objectAtIndex:i] intValue] + [[keyBytes objectAtIndex:i] intValue] & 0xFF;
        NSNumber *tmp = [cypherBytes objectAtIndex:i];
        [cypherBytes replaceObjectAtIndex:i withObject:[cypherBytes objectAtIndex:jump]];
        [cypherBytes replaceObjectAtIndex:jump withObject:tmp];
    }
    int i = 0;
    jump = 0;
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:0];
    for (int x = 0; x < strInput.length; x++) {
        i = i + 1 & 0xFF;
        int tmp = [[cypherBytes objectAtIndex:i] intValue];
        jump = jump + tmp & 0xFF;
        int t = tmp + [[cypherBytes objectAtIndex:jump] intValue] & 0xFF;
        [cypherBytes replaceObjectAtIndex:i withObject:[cypherBytes objectAtIndex:jump]];
        [cypherBytes replaceObjectAtIndex:jump withObject:[NSNumber numberWithInt:tmp]];
        unichar ch = (unichar)[strInput characterAtIndex:x];
        char temp = ch ^ [[cypherBytes objectAtIndex:t] intValue];
        [result appendString:[self ocBytesArrToHexWithInputArr:temp]];
    }
    return result;
}


+ (NSMutableString *)ocBytesArrToHexWithInputArr:(int)data
{
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:0];
    if (data < 16 && data > 0) {
        [result appendString:[NSString stringWithFormat:@"0%1x",data & 0xFF]];
    } else {
        [result appendString:[NSString stringWithFormat:@"%2x",data & 0xFF]];
    }
    return result;
}

+(NSString*)encryptToArrayWithKeys:(NSString*)keys inputStr:(NSString*)inputStr
{
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:inputStr.length];
    NSMutableArray *keyBytes = [[NSMutableArray alloc] initWithCapacity:256];
    NSMutableArray *cypherBytes = [[NSMutableArray alloc] initWithCapacity:256];
    for (int i = 0; i < 256; i++) {
        int ch = [keys characterAtIndex:i % keys.length];
        [keyBytes addObject:[NSNumber numberWithChar:ch]];
        [cypherBytes addObject:[NSNumber numberWithInt:i]];
    }
    int jump = 0;
    for (int i = 0; i < 256; i++) {
        jump = jump + [[cypherBytes objectAtIndex:i] intValue] + [[keyBytes objectAtIndex:i] intValue] & 0xFF;
        NSNumber *tmp = [cypherBytes objectAtIndex:i];
        [cypherBytes replaceObjectAtIndex:i withObject:[cypherBytes objectAtIndex:jump]];
        [cypherBytes replaceObjectAtIndex:jump withObject:tmp];
    }
    int i = 0;
    jump = 0;
    for (int x = 0; x < inputStr.length; x++) {
        i = (i + 1) & 0xFF;
        int tmp = [[cypherBytes objectAtIndex:i] intValue];
        jump = (jump + tmp) & 0xFF;
        int t = tmp + [[cypherBytes objectAtIndex:jump] intValue] & 0xFF;
        [cypherBytes replaceObjectAtIndex:i withObject:[cypherBytes objectAtIndex:jump]];
        [cypherBytes replaceObjectAtIndex:jump withObject:[NSNumber numberWithInt:tmp]];
        //typedef unsigned short unichar;
        unichar ch = (unichar)[inputStr characterAtIndex:x];
        unichar temp = ch ^ [[cypherBytes objectAtIndex:t] intValue];
        [resultArr addObject:@(temp)];
    }
    return [NSString stringWithFormat:@"%@",resultArr];
}

+ (NSString*) encryptToStreamWithKeys:(NSString *)keys inputStr:(NSString*)inputStr
{
    NSMutableArray *keyBytes = [[NSMutableArray alloc] initWithCapacity:256];
    NSMutableArray *cypherBytes = [[NSMutableArray alloc] initWithCapacity:256];
    for (int i = 0; i < 256; i++) {
        int ch = [keys characterAtIndex:i % keys.length];
        [keyBytes addObject:[NSNumber numberWithChar:ch]];
        [cypherBytes addObject:[NSNumber numberWithInt:i]];
    }
    int jump = 0;
    for (int i = 0; i < 256; i++) {
        jump = jump + [[cypherBytes objectAtIndex:i] intValue] + [[keyBytes objectAtIndex:i] intValue] & 0xFF;
        NSNumber *tmp = [cypherBytes objectAtIndex:i];
        [cypherBytes replaceObjectAtIndex:i withObject:[cypherBytes objectAtIndex:jump]];
        [cypherBytes replaceObjectAtIndex:jump withObject:tmp];
    }
    int i = 0;
    jump = 0;
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:0];
    for (int x = 0; x < inputStr.length; x++) {
        i = i + 1 & 0xFF;
        int tmp = [[cypherBytes objectAtIndex:i] intValue];
        jump = jump + tmp & 0xFF;
        int t = tmp + [[cypherBytes objectAtIndex:jump] intValue] & 0xFF;
        [cypherBytes replaceObjectAtIndex:i withObject:[cypherBytes objectAtIndex:jump]];
        [cypherBytes replaceObjectAtIndex:jump withObject:[NSNumber numberWithInt:tmp]];
        unichar ch = (unichar)[inputStr characterAtIndex:x];
        unichar temp = ch ^ [[cypherBytes objectAtIndex:t] intValue];

        [result appendString:[NSString stringWithFormat:@"%c",temp]];
    }
    return result;
}

@end
