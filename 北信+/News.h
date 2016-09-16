//
//  News.h
//  北信+
//
//  Created by #incloud on 16/9/14.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface News : NSObject

@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *newsURL;
@property (nonatomic, retain) NSArray *array;



- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)newsWithDict:(NSDictionary *)dict;

@end
