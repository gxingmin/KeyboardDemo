//
//  BoardView.m
//  键盘面板
//
//  Created by Baidu BP&IT 内网与预算组 高兴民 on 13-8-12.
//
//
#import "BoardView.h"
#import "KeyButtonBase.h"
#import "KeyboardT9.h"
#import "KeyboardABC.h"


//默认键盘高度
#define BoardViewHEIGHT 216

//黑色风格T9键盘背景色
#define BLACK_T9_BACKCOLOR  [UIColor colorWithRed:20.0/255.0 green:24.0/255.0 blue:28.0/255.0 alpha:1.0]

//黑色风格ABC键盘背景色
#define BLACK_ABC_BACKCOLOR [UIColor colorWithRed:40.0/255.0 green:44.0/255.0 blue:48.0/255.0 alpha:1.0]

//白色风格键盘背景色
#define WHITE_BACKCOLOR     [UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:241.0/255.0 alpha:1.0]

@interface BoardView()
@property (nonatomic, strong)  KeyboardBase *viewKeyboardT9;     //T9键盘
@property (nonatomic, strong)  KeyboardBase *viewKeyboardABC;    //ABC键盘

@property (nonatomic,assign) CGRect initFrame; //键盘初始frame
@end

@implementation BoardView
@synthesize keyboardType;
@synthesize UIText;
@synthesize viewKeyboardT9,viewKeyboardABC;
@synthesize delegate;
@synthesize initFrame;
@synthesize keyboardStyle = _keyboardStyle;
@synthesize pressKeySoundType = _pressKeySoundType;

//初始化键盘面板，默认父容器大小为整个屏幕大小
-(id)init
{
    self = [super init];
    if(self)
    {
        [self interalInit:[[UIScreen mainScreen] bounds]];
    }
    return self;

}

//初始化键盘面板，默认父容器大小为整个屏幕大小
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        [self interalInit:[[UIScreen mainScreen] bounds]];
    }
    return self;
}

//初始化键盘面板，指定父容器大小
-(void)interalInit:(CGRect)superViewFrame
{
    if (self)
    {
        //键盘面板初始frame
        self.initFrame = CGRectMake(superViewFrame.origin.x, superViewFrame.size.height-BoardViewHEIGHT, superViewFrame.size.width, BoardViewHEIGHT);
        
        [self setFrame:self.initFrame];
        
        //T9号码按键面板
        self.viewKeyboardT9=[[KeyboardT9 alloc] initWithFrame:CGRectMake(0, 0, initFrame.size.width, initFrame.size.height)];
        [self addSubview:self.viewKeyboardT9];
        self.viewKeyboardT9.delegate=self;
        
        
        //ABC号码按键面板
        self.viewKeyboardABC=[[KeyboardABC alloc] initWithFrame:CGRectMake(0, 0, initFrame.size.width, initFrame.size.height)];
        [self addSubview:self.viewKeyboardABC];
        self.viewKeyboardABC.delegate=self;
        self.viewKeyboardABC.hidden=YES;
        
        self.keyboardType = KeyboardType_T9;     //默认为T9键盘
        self.keyboardStyle = KeyboardStyleWhite; //默认为白色风格
    }

}


//重置键盘
-(void)reset
{
    CGRect frame;
    if(self.keyboardType == KeyboardType_T9) //T9键盘，重置面板到初始位置
    {
        frame = initFrame;
    }
    else                        //ABC键盘，重置面板到初始位置，由于ABC键盘比T9键盘高12像素，所以初始位置需往上伸12像素
    {
        frame = CGRectMake(initFrame.origin.x, initFrame.origin.y-12, initFrame.size.width, initFrame.size.height+12);
    }
    

    if(_keyboardStyle == KeyboardStyleBlack)  //黑色风格
    {
        if(self.keyboardType == KeyboardType_T9)
        {
            self.backgroundColor = BLACK_T9_BACKCOLOR;
            self.viewKeyboardT9.backgroundColor = BLACK_T9_BACKCOLOR;
        }
        else
        {
            self.backgroundColor = BLACK_ABC_BACKCOLOR;
            self.viewKeyboardABC.backgroundColor=BLACK_ABC_BACKCOLOR;
        }
        
        CGRect frame = self.viewKeyboardT9.frame;
        
        if(frame.origin.y == 0)
        {
            frame.origin.y = 26;
            frame.size.height -= 26;
            self.viewKeyboardT9.frame = frame;
        }
    }
    else                                     //白色风格
    {
        self.backgroundColor = WHITE_BACKCOLOR;
        self.viewKeyboardT9.backgroundColor = WHITE_BACKCOLOR;
        self.viewKeyboardABC.backgroundColor = WHITE_BACKCOLOR;
        
        CGRect frame = self.viewKeyboardT9.frame;
        
        if(frame.origin.y > 0)   //恢复位置
        {
            frame.origin.y = 0;
            frame.size.height += 26;
            self.viewKeyboardT9.frame = frame;
        }
    }

    //设置键盘容器位置
    self.frame = frame;

    self.hidden = NO;
}

//设置键盘风格
-(void)setKeyboardStyle:(KeyboardStyle)keyboardStyle
{
    _keyboardStyle = keyboardStyle;

    if(self.keyboardType == KeyboardType_System) //如果显示系统键盘，则自定义键盘隐藏
    {
        self.hidden = YES;
    }
    else
    {
        [self reset];                            //显示自定义键盘
    }

    

    self.viewKeyboardT9.keyboardStyle = keyboardStyle;
    self.viewKeyboardABC.keyboardStyle = keyboardStyle;
    
}

//设置按键声音或按键振动
-(void)setPressKeySoundType:(PressKeySoundType)pressKeySoundType
{
    _pressKeySoundType = pressKeySoundType;
    [self reset];
    
    self.viewKeyboardABC.pressKeySoundType = pressKeySoundType;
    self.viewKeyboardT9.pressKeySoundType = pressKeySoundType;
}

//从ABC切换到T9，或从T9切换到ABC
-(void)SwitchKeyboardType:(KeyboardType)keyboardtype
{
    self.keyboardType=keyboardtype;
    [self.UIText setText:@""];
    if(self.keyboardType==KeyboardType_T9)
    {
        //切换到T9
        self.viewKeyboardT9.hidden=NO;
        self.viewKeyboardABC.hidden=YES;
    }
    else
    {
        //切换到ABC
        self.viewKeyboardT9.hidden=YES;
        self.viewKeyboardABC.hidden=NO;
    }
    [self reset];
    
    //代理响应
    if(self.delegate!=nil && [self.delegate respondsToSelector:@selector(SwitchKeyboardType:)])
        [self.delegate SwitchKeyboardType:keyboardtype];
    
}

#pragma mark - KeyboardBaseDelegate

//功能描述：键盘按键事件协议
//参数说明：
//        sender        -- 按键按钮
//        keyboardType  -- 键盘类型(T9、ABC)
-(void)KeyButtonClicked:(id)sender withKeyboardType:(KeyboardType)keyboardType
{
    KeyButtonBase *btn = (KeyButtonBase *)sender;
    NSString *digtal = btn.Digtal;
    
    
    //>>T9和ABC键互相切换
    if ([digtal isEqualToString:@"T9"])
    {
        //切换到T9
        [self SwitchKeyboardType:KeyboardType_T9];
        return;
    }
    else if ([digtal isEqualToString:@"ABC"])
    {
        //切换到ABC
        [self SwitchKeyboardType:KeyboardType_ABC];
        return;
    }
    //<<T9和ABC键互相切换
    
    
    NSString *preText=[UIText text];;
    NSString *currText=@"";
    if(preText==nil)
        preText=@"";
    
    if([digtal length]==1)
    {
        preText=[UIText text];
        
        currText=[NSString stringWithFormat:@"%@%@",preText,digtal];
        [UIText setText:currText];
    }
    else
    {
        if(btn.Index==11 || btn.Index==42) //回退
        {
            if(preText.length==0)
                return;
            
            currText=[preText substringToIndex:preText.length-1];
            [UIText setText:currText];
        }
        
    }
    
    //代理响应
    if(delegate!=nil)
        [delegate BoardViewClicked:sender withPreText:preText withCurrText:currText];
    
}


@end
