//
//  SoundPlayer.m
//  KeyboardDemo
//
//  Created by Baidu on 14-2-11.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "SoundPlayer.h"

@implementation SoundPlayer

//播放振动
+(void)playVibrate
{
    SystemSoundID sound=kSystemSoundID_Vibrate;//震动
    AudioServicesPlaySystemSound(sound);
}

//播放声音
+(void)playSound
{
    SystemSoundID sound=kSystemSoundID_Vibrate;//震动
    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",@"dtmf-0",@"caf"];
    //[[NSBundle bundleWithIdentifier:@"com.apple.UIKit" ]pathForResource:soundName ofType:soundType];//得到苹果框架资源UIKit.framework ，从中取出所要播放的系统声音的路径
    //[[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];  获取自定义的声音
    if (path)
    {
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
        
        if (error != kAudioServicesNoError)
        {//获取的声音的时候，出现错误
            return;
        }
        AudioServicesPlaySystemSound(sound);
    }
}

//同时播放声音和振动
+(void)playSoundAndVibrate
{
    SystemSoundID sound=kSystemSoundID_Vibrate;//震动
    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",@"dtmf-0",@"caf"];
    if (path)
    {
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
        
        if (error != kAudioServicesNoError)
        {//获取的声音的时候，出现错误
            return;
        }
        AudioServicesPlayAlertSound(sound);
    }
}

@end
