//
//  KeyboardBase.h
//  键盘基类（ABC和T9键盘继承它）
//
//  Created by Baidu BP&IT 内网与预算组 高兴民 on 13-8-12.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


#import "define.h"

//键盘协议
@protocol KeyboardBaseDelegate<NSObject>

//功能描述：键盘按键事件协议
//参数说明：
//        sender        -- 按键按钮
//        keyboardType  -- 键盘类型(T9、ABC)
-(void)KeyButtonClicked:(id)sender withKeyboardType:(KeyboardType)keyboardType;   //键盘按键

@end

@interface KeyboardBase : UIView
@property (nonatomic, strong) id<KeyboardBaseDelegate> delegate;    //协议代理
@property (nonatomic, assign) PressKeySoundType pressKeySoundType;  //按键响应类型
@property (nonatomic, assign) KeyboardStyle keyboardStyle;          //键盘风格

+(NSArray *)stringListABC;    //ABC键盘按钮初始字符数组缓存
+(NSArray *)stringListT9;     //T9键盘按钮初始字符数组缓存

//功能描述：键盘按键事件
//参数说明：
//        sender        -- 按键按钮
//        keyboardType  -- 键盘类型(T9、ABC)
-(void)KeyButtonClicked:(id)sender withKeyboardType:(KeyboardType)keyboardType;

@end
