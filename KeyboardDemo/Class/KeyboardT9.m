//
//  WhiteKeyboardT9.m
//  T9键盘
//
//  Created by Baidu BP&IT 内网与预算组 高兴民 on 13-8-12.
//
//
#import "KeyboardT9.h"
#import "WhiteKeyButton.h"
#import "BlackKeyButton.h"

@implementation KeyboardT9

//初始化T9键盘
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

//设置键盘类型属性
-(void)setKeyboardStyle:(KeyboardStyle)keyboardStyle
{
    //清除内容，防止文本重叠
    while ([self.subviews lastObject]) {
        [(UIView *)[self.subviews lastObject] removeFromSuperview];
    }
    
    float initLeft = keyboardStyle == KeyboardStyleWhite ? 4 : 2;
    float intervalX = keyboardStyle == KeyboardStyleWhite ? 6 : 1;
    float intervalY = keyboardStyle == KeyboardStyleWhite ? 6 : 1;
    float width = keyboardStyle == KeyboardStyleWhite ? 100 : 105;
    float height=  46;
    
    //初始化T9键盘上的12个键
    for(int i = 0;i<12;i++)
    {
        float left=(width+intervalX)*(i%3) + initLeft;
        float top=(i/3)*(height+intervalY) + intervalY;
        
        NSArray *arryText=[[KeyboardBase stringListT9] objectAtIndex: i];
        KeyButtonBase *btnKeyButton=nil;
        if(keyboardStyle == KeyboardStyleWhite)
            btnKeyButton = [[WhiteKeyButton alloc] initWithFrame:CGRectMake(left, top, width, height) withIndex:i withTextArray:arryText  withKeyboardType:KeyboardType_T9];
        else
            btnKeyButton = [[BlackKeyButton alloc] initWithFrame:CGRectMake(left, top, width, height) withIndex:i withTextArray:arryText  withKeyboardType:KeyboardType_T9];
        
        [btnKeyButton addTarget:self action:@selector(btnKeyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btnKeyButton];
        
    }

}

//T9键盘按钮Click事件
-(void)btnKeyButtonClick:(id)sender
{
     //传递到父类
    [super KeyButtonClicked:sender withKeyboardType:KeyboardType_T9];
}

@end
