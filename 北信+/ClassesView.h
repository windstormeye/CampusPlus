//
//  ClassesView.h
//  北信+
//
//  Created by #incloud on 16/9/14.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyClasses.h"
@interface ClassesView : UIView
@property(nonatomic, strong) MyClasses *model;
+ (instancetype)ClassView;

@end
