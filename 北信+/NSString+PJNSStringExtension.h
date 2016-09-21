//
//  NSString+PJNSStringExtension.h
//  PJ - 仿QQ聊天界面
//
//  Created by #incloud on 16/7/30.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (PJNSStringExtension)

- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font;
+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font;

@end
