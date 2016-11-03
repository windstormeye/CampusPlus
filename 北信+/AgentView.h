//
//  AgentView.h
//  北信+
//
//  Created by #incloud on 16/11/1.
//  Copyright © 2016年 #incloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgentView : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *AgentAvatarImg;
@property (weak, nonatomic) IBOutlet UILabel *Agent_title;
@property (weak, nonatomic) IBOutlet UITextView *Agent_content;
@property (weak, nonatomic) IBOutlet UILabel *Agent_money;
@property (weak, nonatomic) IBOutlet UILabel *Agent_time;
@property (weak, nonatomic) IBOutlet UIButton *Agent_getBtn;
@property (weak, nonatomic) IBOutlet UIButton *AvatarBtn;

+(instancetype)agentView;

@end
