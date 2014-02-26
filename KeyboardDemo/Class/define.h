//
//  define.h
//  KeyboardDemo
//  此文件用于定义枚举、常量等
//  Created by Baidu BP&IT 内网与预算组 高兴民 on 13-8-12.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#ifndef KeyboardDemo_define_h
#define KeyboardDemo_define_h

//键盘类型
typedef enum
{
    KeyboardTypeUnknown = -1,  //未知
    KeyboardType_T9 = 0,       //T9键
    KeyboardType_ABC = 1,      //ABC键盘
    KeyboardType_System = 2    //系统键盘
    
} KeyboardType;

//键盘风格
typedef enum
{
    KeyboardStyleWhite,  //白色风格
    KeyboardStyleBlack   //黑色风格
    
}KeyboardStyle;

//按键响应声音类型
typedef enum
{
    PressKeySoundTypeNone = -1,             //不播放声音
    PressKeySoundTypeSound = 0,             //播放声音
    PressKeySoundTypeVibrate = 2,           //振动
    PressKeySoundTypeSoundAndVibrate = 3    //声音+振动
    
} PressKeySoundType;


#endif
