//
//  KeyboardT9.m
//  ABC键盘
//
//  Created by Baidu BP&IT 内网与预算组 高兴民 on 13-8-12.
//
//
#import "KeyboardABC.h"
#import "WhiteKeyButton.h"
#import "BlackKeyButton.h"

@interface KeyboardABC()
@property (nonatomic, strong) UIButton *viewTipButton; //按键提示
@end

@implementation KeyboardABC
@synthesize viewTipButton;

//初始化ABC键盘
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
    
    
    
    float width=26;
    float height=36.5;
    float intervalX = 6;
    float intervalY = 7;
    float left,top;
    
    //初始化ABC键盘上的键
    for(int i=0;i<[[KeyboardBase stringListABC] count];i++)
    {
        
        if(i<=19)   //第一、二行
        {
            left= (width+intervalX)*(i%10)+3;
            top=(i/10)*(height+intervalY)+intervalY;
        }
        else if(i<=28)   //第三行
        {
            left=18+(width+intervalX)*(i%10);
            top=(i/10)*(height+intervalY)+intervalY;
        }
        else if(i<=37)  //第四行
        {
            left=18+(width+intervalX)*((i+1)%10);
            top=((i+1)/10)*(height+intervalY)+intervalY;
        }
        else  //第五行
        {
            top=((i+2)/10)*(height+intervalY)+intervalY;
            switch (i)
            {
                case 38: //T9
                    left=6;
                    width=39;
                    break;
                case 39:  //_
                    left+=width+intervalX;
                    width=26;
                    break;
                case 40:  //space
                    left+=width+intervalX;
                    width=133;
                    break;
                case 41:  //-
                    left+=width+intervalX;
                    width=26;
                    break;
                default:  //42, X
                    left+=width+intervalX;
                    width=60;
                    break;
            }
        }
        
        
        id arryText=[[KeyboardBase stringListABC] objectAtIndex: i];
        KeyButtonBase *btnKeyButton=nil;
        if(keyboardStyle == KeyboardStyleWhite)
            btnKeyButton = [[WhiteKeyButton alloc] initWithFrame:CGRectMake(left, top, width, height) withIndex:i withTextArray:arryText withKeyboardType:KeyboardType_ABC];
        else
            btnKeyButton = [[BlackKeyButton alloc] initWithFrame:CGRectMake(left, top, width, height) withIndex:i withTextArray:arryText withKeyboardType:KeyboardType_ABC];
        
        if(i>=10 && i<=36 && i!=29) //键盘上字母显示大写
        {
            btnKeyButton.lblDigtal.text = [arryText uppercaseString];
        }
        
        [btnKeyButton addTarget:self action:@selector(btnKeyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnKeyButton];
        
        
    }

}

//ABC键盘按钮Click事件
-(void)btnKeyButtonClick:(id)sender
{
    KeyButtonBase *btnKeyButton=(KeyButtonBase *)sender;
    if(btnKeyButton.Digtal.length==1 && ![btnKeyButton.Digtal isEqualToString:@" "]) //只有1个字符的出悬浮
    {
        if(viewTipButton==nil)
            [self showMidTips];
        
        int left=btnKeyButton.frame.origin.x-btnKeyButton.frame.size.width/2;
        int top=btnKeyButton.frame.origin.y-52;
        
        if(left<20)
            left+=20;
        if(left>self.frame.size.width-btnKeyButton.frame.size.width-20)
            left-=20;
        
        
        viewTipButton.hidden = NO;
        [viewTipButton setTitle:btnKeyButton.lblDigtal.text forState:UIControlStateNormal];
        [viewTipButton setFrame:CGRectMake(left , top, 50, 50)];
        if(btnKeyButton.Digtal.length>1)
            viewTipButton.titleLabel.font = [UIFont systemFontOfSize:24.0];
        else
            viewTipButton.titleLabel.font = [UIFont systemFontOfSize:36.0];
        
        //显示浮动
        [NSTimer scheduledTimerWithTimeInterval:0.4
                                         target:self
                                       selector:@selector(HiddenTipTimer:)
                                       userInfo:nil
                                        repeats:NO];
    }
    
    //传递到父类
    [super KeyButtonClicked:sender withKeyboardType:KeyboardType_ABC];
}

//隐藏按键提示
-(void)HiddenTipTimer:(NSTimer *)timer
{
    viewTipButton.hidden = YES;
}

//显示按键提示
- (void)showMidTips
{
    viewTipButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    [viewTipButton setBackgroundImage:[UIImage imageNamed:@"tip_avatar.png"] forState:UIControlStateNormal];
    [viewTipButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    viewTipButton.titleLabel.font = [UIFont systemFontOfSize:36.0];
    
    viewTipButton.userInteractionEnabled = NO;
    viewTipButton.hidden = YES;
    
    [self.superview addSubview:viewTipButton];
}


@end
