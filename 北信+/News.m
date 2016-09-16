//
//  News.m
//  北信+
//
//  Created by #incloud on 16/9/14.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "News.h"

@implementation News

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < 5; i++)
        {
            News *news = [[News alloc] init];
//            NSString *s = dict[@"results"][i][@"image_url"];
//            NSString *str = [s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            NSURL *URL = [NSURL URLWithString:str];
//            NSLog(@"%@",URL);
//            NSData* data = [NSData dataWithContentsOfURL:URL];
//            news.imgView.image = [UIImage imageWithData:data];
            
//            news.title = dict[@"results"][i][@"title"];
            news.newsURL = dict[@"results"][i][@"url"];
            [arr addObject:news];
        }
        self.array = arr;
    }
    return self;
}

+(instancetype)newsWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
