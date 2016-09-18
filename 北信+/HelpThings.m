//
//  HelpThings.m
//  北信+
//
//  Created by #incloud on 16/9/18.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "HelpThings.h"

@implementation HelpThings

+ (id)candyOfCategory:(NSString *)category name:(NSString *)name
{
    HelpThings *newCandy = [[self alloc] init];
    newCandy.category = category;
    newCandy.name = name;
    return newCandy;
}

@end
