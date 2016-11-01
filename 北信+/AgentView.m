//
//  AgentView.m
//  北信+
//
//  Created by #incloud on 16/11/1.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import "AgentView.h"

@implementation AgentView


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.Agent_content.layer.cornerRadius = 10;
}

+(instancetype)agentView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"AgentView" owner:nil options:nil] firstObject];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




@end
