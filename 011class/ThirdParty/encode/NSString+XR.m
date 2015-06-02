//
//  NSString+XRString.m
//  KnowerParty
//
//  Created by 董欣然 on 15/1/17.
//  Copyright (c) 2015年 cn.chuangxue. All rights reserved.
//

#import "NSString+XR.h"

@implementation NSString (XR)

-(BOOL)isChinese
{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

-(BOOL)isEmail
{
    //\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*
    //\b([a-zA-Z0-9%_.+\-]+)@([a-zA-Z0-9.\-]+?\.[a-zA-Z]{2,6})\b
    //A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}
    NSString *match=@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

-(NSString *)clearEnterAndSpace
{
    NSString *result;
    result = [self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return result;
}

-(NSString *)clearEnter
{
    return [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

-(NSString *)clearSpace
{
    return [self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
}

//- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
//{
//    NSDictionary *attrs = @{NSFontAttributeName : font};
//    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
//}
@end
