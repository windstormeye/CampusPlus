//
//  MyGetAgentView.m
//  北信+
//
//  Created by #incloud on 16/11/3.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "MyGetAgentView.h"

@implementation MyGetAgentView

+ (instancetype)getAgentView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MyGetAgentView" owner:nil options:nil] firstObject];

}

@end
