//
//  NSString+PJNSStringExtension.m
//  PJ - 仿QQ聊天界面
//
//  Created by #incloud on 16/7/30.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "NSString+PJNSStringExtension.h"

@implementation NSString (PJNSStringExtension)

-(CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+(CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font
{
    return [text sizeOfTextWithMaxSize:maxSize font:font];
}

@end
