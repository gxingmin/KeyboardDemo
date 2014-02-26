//
//  KeyButtonBase.h
//  键盘每个键按钮的基类
//
//  Created by Baidu BP&IT 内网与预算组 高兴民 on 13-8-12.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyButtonBase : UIButton

@property (nonatomic, assign) int Index;         //键按钮在键盘上的位置索引
@property (nonatomic, strong) NSString *Digtal;  //键按钮上方的数字
@property (nonatomic, strong) NSString *Letters; //键按钮下方的字母
@property (nonatomic,retain) UILabel *lblDigtal; //显示键按钮上方数字
@property (nonatomic,retain) UILabel *lblLetters;//显示键按钮下方字母

@end
