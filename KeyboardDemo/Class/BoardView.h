//
//  BoardView.h
//  键盘面板，即键盘容器
//
//  Created by Baidu BP&IT 内网与预算组 高兴民 on 13-8-12.
//
//


#import "KeyboardBase.h"

//键盘面板协议
@protocol BoardViewDelegate<NSObject>

//功能描述：键盘按键事件协议
//参数说明：
//        sender   -- 按键按钮
//        preText  -- 接收键盘按键的焦点控件（一般为UITextField）在按下此键前的文本
//        currText -- 接收键盘按键的焦点控件（一般为UITextField）在按下此键后的文本
-(void)BoardViewClicked:(id)sender withPreText:(NSString *)preText withCurrText:(NSString *)currText;

@optional  //（可选协议）
//功能描述：键盘切换(从ABC切换到T9，或从T9切换到ABC)
//参数说明：
//        keyboardtype -- 切换到某键盘类型（即切换后的键盘类型）
-(void)SwitchKeyboardType:(KeyboardType)keyboardtype;

@end

//键盘面板，即键盘容器
@interface BoardView : UIView<KeyboardBaseDelegate>

@property (nonatomic, assign) KeyboardType keyboardType;       //当前键盘类型
@property (nonatomic, strong) id UIText;                       //接收键盘输入的控件(UITextField，UILabel，UIButton等）
@property (nonatomic, strong) id<BoardViewDelegate> delegate;  //协议代理

@property (nonatomic, assign) KeyboardStyle keyboardStyle;          //键盘风格
@property (nonatomic, assign) PressKeySoundType pressKeySoundType;  //按键响应类型


//重置键盘
-(void)reset;

//从ABC切换到T9，或从T9切换到ABC
-(void)SwitchKeyboardType:(KeyboardType)keyboardtype;
@end
