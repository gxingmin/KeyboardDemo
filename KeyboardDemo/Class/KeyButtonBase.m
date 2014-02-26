//
//  KeyButtonBase.m
//  键盘每个键按钮的基类
//
//  Created by Baidu BP&IT 内网与预算组 高兴民 on 13-8-12.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import "KeyButtonBase.h"

@implementation KeyButtonBase
@synthesize Index;
@synthesize Digtal;
@synthesize Letters;
@synthesize lblDigtal;
@synthesize lblLetters;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
