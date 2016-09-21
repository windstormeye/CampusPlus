//
//  Paper.h
//  北信+
//
//  Created by #incloud on 16/9/20.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Paper : NSObject

@property (nonatomic, retain) NSURL *URL;


-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)paperWithDict:(NSDictionary *)dict;

@end
