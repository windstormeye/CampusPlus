//
//  GModel.h
//  BeijingWifi
//
//  Created by xlx on 16/12/13.
//  Copyright © 2016年 xlx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GModel : NSObject

+(NSString *)getDeviceUUID;

+(void)setToken:(NSString *)token;

+(NSString *)getToken;

+(UIViewController *)currentViewController;

@end
