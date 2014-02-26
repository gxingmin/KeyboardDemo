//
//  ViewController.h
//  KeyboardDemo
//
//  Created by Baidu BP&IT 内网与预算组 高兴民 on 13-8-12.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardView.h"

@interface ViewController : UIViewController<BoardViewDelegate>

@property (nonatomic, strong) IBOutlet UISegmentedControl *segStyle;         //风格

@property (nonatomic, strong) IBOutlet UISegmentedControl *segKeyboardType;  //键盘类型

@property (nonatomic, strong) IBOutlet UISwitch *switchSound;                //按键声音

@property (nonatomic, strong) IBOutlet UISwitch *switchVibrate;              //按键振动

@property (nonatomic, strong) IBOutlet UITextField *txtKeyboardInput;        //接收键盘输入的文本框

@property (nonatomic, strong) IBOutlet BoardView *viewBoard;                 //键盘面板



-(IBAction)segStyleAction:(id)sender;
-(IBAction)segKeyboardTypeAction:(id)sender;
-(IBAction)switchSoundTypeAction:(id)sender;
@end
