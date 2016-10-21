//
//  demandView.m
//  北信+
//
//  Created by #incloud on 16/10/20.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "demandView.h"

@implementation demandView


+(instancetype)demandView
{
    
     return [[[NSBundle mainBundle] loadNibNamed:@"demandView" owner:nil options:nil] firstObject];
}

@end
