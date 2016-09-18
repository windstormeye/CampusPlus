//
//  HelpThings.h
//  北信+
//
//  Created by #incloud on 16/9/18.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HelpThings : NSObject

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;

+ (id)candyOfCategory:(NSString*)category name:(NSString*)name;

@end
