//
//  WhiteKeyButton.h
//  白色键盘的键按钮（继承KeyButtonBase）
//
//  Created by Baidu BP&IT 内网与预算组 高兴民 on 13-8-12.
//
//

#import "define.h"
#import "KeyButtonBase.h"

@interface WhiteKeyButton : KeyButtonBase

//功能描述：初始化键盘按钮接口
//参数说明：
//        frame -- 按钮frame
//        index -- 按钮在键盘上的位置索引
//        arryText -- 按钮上显示的文本（字符型或数组型，数组型适用于abc键盘)
//        keyboardtype -- 键盘类型（T9、ABC）
//返 回 值：键盘按钮对象(self)
-(id)initWithFrame:(CGRect)frame withIndex:(int)index withTextArray:(id)arryText withKeyboardType:(KeyboardType)keyboardtype;


@end
