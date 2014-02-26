//
//  ViewController.m
//  KeyboardDemo
//
//  Created by Baidu BP&IT 内网与预算组 高兴民 on 13-8-12.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - ViewController Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.viewBoard.delegate = self;
    self.viewBoard.UIText = self.txtKeyboardInput;
    
  
    
}
-(void)viewWillAppear:(BOOL)animated
{
    //注册键盘显示消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

}

-(void)viewDidDisappear:(BOOL)animated
{
    //移除键盘显示消息
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - BoardViewDelegate 键盘面板协议
-(void)BoardViewClicked:(id)sender withPreText:(NSString *)preText withCurrText:(NSString *)currText
{
    
}

//切换键盘协议
-(void)SwitchKeyboardType:(KeyboardType)keyboardtype
{
    self.segKeyboardType.selectedSegmentIndex = keyboardtype;
}


#pragma mark - 选项控件事件
//风格选项选择事件
-(IBAction)segStyleAction:(id)sender
{
    if(self.segStyle.selectedSegmentIndex == self.viewBoard.keyboardStyle)
        return;

    self.viewBoard.keyboardStyle = self.segStyle.selectedSegmentIndex;

}

//键盘类型选项选择事件
-(IBAction)segKeyboardTypeAction:(id)sender
{
    if(self.segKeyboardType.selectedSegmentIndex == self.viewBoard.keyboardType)
        return;
    
    self.viewBoard.keyboardType = self.segKeyboardType.selectedSegmentIndex;
    if(self.viewBoard.keyboardType != KeyboardType_System)  //显示自定义键盘
    {
        [self.txtKeyboardInput resignFirstResponder];       //隐藏系统键盘
        [self.viewBoard SwitchKeyboardType:self.viewBoard.keyboardType];
    }
    else
    {
         [self.txtKeyboardInput becomeFirstResponder];      //显示系统键盘
    }
}

//声音、振动选项
-(IBAction)switchSoundTypeAction:(id)sender
{
    if(self.switchSound.on && self.switchVibrate.on)
        self.viewBoard.pressKeySoundType = PressKeySoundTypeSoundAndVibrate;
    else if(self.switchSound.on)
        self.viewBoard.pressKeySoundType = PressKeySoundTypeSound;
    else if(self.switchVibrate.on)
        self.viewBoard.pressKeySoundType = PressKeySoundTypeVibrate;
    else
        self.viewBoard.pressKeySoundType = PressKeySoundTypeNone;
}


#pragma mark - 键盘显示消息
//系统键盘出现
- (void)keyboardWillShow:(NSNotification *)notification
{
    if(self.viewBoard.keyboardType != KeyboardType_System) //T9或ABC
    {
        if([[[UIApplication sharedApplication] windows] count]>1)
        {
            UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
            [tempWindow setAlpha:0];
        }
        
        [self.viewBoard reset];  //显示自定义键盘
    }
    else  //系统键盘时，隐藏自定义键盘
    {
        self.viewBoard.hidden=YES;
    }
}

//显示自定义键盘
- (void)keyboardWasShown:(NSNotification *) Notification
{
//    if(self.viewBoard.keyboardType != KeyboardType_System) //T9或ABC
//        [self.viewBoard show];
//    else  //系统键盘
//         self.viewBoard.hidden=YES;
}
@end
