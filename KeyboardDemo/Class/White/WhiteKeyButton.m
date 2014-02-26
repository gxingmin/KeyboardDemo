//
//  WhiteKeyButton.m
//  白色键盘的键按钮（继承KeyButtonBase）
//
//  Created by Baidu BP&IT 内网与预算组 高兴民 on 13-8-12.
//
//

#import "WhiteKeyButton.h"


@interface WhiteKeyButton()

@property (nonatomic, assign) KeyboardType keyboardType; //键盘类型
@end

@implementation WhiteKeyButton
@synthesize keyboardType;



//功能描述：初始化键盘按钮接口
//参数说明：
//        frame -- 按钮frame
//        index -- 按钮在键盘上的位置索引
//        arryText -- 按钮上显示的文本（字符型或数组型，数组型适用于abc键盘)
//        keyboardtype -- 键盘类型（T9、ABC）
//返 回 值：键盘按钮对象(self)
-(id)initWithFrame:(CGRect)frame withIndex:(int)index withTextArray:(id)arryText withKeyboardType:(KeyboardType)keyboardtype;
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.Index=index;
   
        //设置键上的文本和键的背景图片
        [self SetTextAndBackgroundImage:index arryText:arryText keyboardtype:keyboardtype];
        
        //设置字体、颜色以及触发事件
        if(![self.Digtal isEqualToString:@""])
        {
            
            int topOffset = 0;
            
            if(keyboardtype==KeyboardType_T9 && [self.Letters isEqualToString:@""])
                topOffset = 5;  //T9键盘最下方的ABC和0两个键文字要往下偏移点
            
            self.lblDigtal=[[UILabel alloc] initWithFrame:CGRectMake(0, 7+topOffset, self.frame.size.width, 20)];
            self.lblDigtal.textAlignment=NSTextAlignmentCenter;
            self.lblDigtal.font= [UIFont fontWithName:@"HelveticaNeue" size:20];
            self.lblDigtal.backgroundColor=[UIColor clearColor];
            
            if([self.Digtal isEqualToString:@" "])
                self.lblDigtal.text=@"Space";
            else
                self.lblDigtal.text=self.Digtal;
            
            self.lblDigtal.textColor=[UIColor blackColor];
            [self addSubview:self.lblDigtal];
            
            if(![self.Letters isEqualToString:@""])
            {
                self.lblLetters=[[UILabel alloc] initWithFrame:CGRectMake(0, 22, self.frame.size.width, 20)];
                self.lblLetters.textAlignment=NSTextAlignmentCenter;
                self.lblLetters.backgroundColor=[UIColor clearColor];
                self.lblLetters.font=[UIFont fontWithName:@"HelveticaNeue" size:14];
                self.lblLetters.text=self.Letters;
                self.lblLetters.textColor=[UIColor colorWithRed:133.0/255.0 green:144.0/255.0 blue:146.0/255.0 alpha:1.0];
                [self addSubview:self.lblLetters];
            }
            
            //按下字的颜色为白色，恢复字体为灰色
            [self addTarget:self action:@selector(ClickDown) forControlEvents:UIControlEventTouchDown];
            [self addTarget:self action:@selector(ClickUp) forControlEvents:UIControlEventTouchUpInside];
            [self addTarget:self action:@selector(ClickUp) forControlEvents:UIControlEventTouchUpOutside];
            [self addTarget:self action:@selector(ClickUp) forControlEvents:UIControlEventTouchDragOutside];
            
        }
        else   //设置两个回退按钮的前景图片
        {
            NSString *strImagePressed;  //按下图片
            NSString *strImageNormal;   //恢复图片
            
            switch (index)
            {
                case 11: //T9  回退
                case 42: //ABC 回退
                    strImageNormal = @"white_back.png";
                    strImagePressed = @"white_back_press.png";
                    break;
                default:
                    return self;
            }
            
            [self setImage:[UIImage imageNamed:strImageNormal] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:strImagePressed] forState:UIControlStateHighlighted];
            
        }

    }
    
    return self;
}

//功能描述：设置键上的文本和键的背景图片
//参数说明：
//        index -- 键按钮在键盘上的位置索引
//        arryText -- 按钮上显示的文本（字符型或数组型，数组型适用于abc键盘)
//        keyboardtype -- 键盘类型（T9、ABC）
- (void)SetTextAndBackgroundImage:(int)index arryText:(id)arryText keyboardtype:(KeyboardType)keyboardtype
{
    NSString *strImagePressed;  //按下图片
    NSString *strImageNormal;   //恢复图片
    
    if(keyboardtype == KeyboardType_T9)         //T9键盘
    {
        self.Digtal=[arryText objectAtIndex:0];
        self.Letters=[arryText objectAtIndex:1];
        
        //背景图片
        if(index==9 || index==11)   //ABC和回退键背景为深色，其他按钮背景为白色
            strImageNormal=@"white_keyboard_T9_gray_normal.png";
        else
            strImageNormal=@"white_keyboard_T9_normal.png";
        
        strImagePressed=@"white_keyboard_T9_pressed.png";
        
        [self setBackgroundImage:[UIImage imageNamed:strImageNormal] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:strImagePressed] forState:UIControlStateHighlighted];
    }
    else                                      //ABC键盘
    {
        self.Digtal=arryText;
        
        //背景图片
        if(index<=37 || index==39 || index==41)   //前四行键和最后一行的_、- 两个键背景为白色
        {
            strImageNormal=@"white_keyboard_abc_normal.png";
            strImagePressed=@"white_keyboard_abc_pressed.png";
        }
        else if(index==38) //T9键 背景
        {
            strImageNormal=@"white_keyboard_abc_T9_normal.png";
            strImagePressed=@"white_keyboard_abc_T9_pressed.png";
        }
        else if(index==40) //space键 背景
        {
            strImageNormal=@"white_keyboard_abc_space_normal.png";
            strImagePressed=@"white_keyboard_abc_space_pressed.png";
        }
        else //回退键背景
        {
            strImageNormal=@"white_keyboard_abc_back_normal.png";
            strImagePressed=@"white_keyboard_abc_back_pressed.png";
        }
        
        
        [self setBackgroundImage:[UIImage imageNamed:strImageNormal] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:strImagePressed] forState:UIControlStateHighlighted];
    }
}

//按下事件
-(void)ClickDown
{
    if(self.lblDigtal)
        self.lblDigtal.textColor=[UIColor whiteColor];
    if(self.lblLetters)
        self.lblLetters.textColor=[UIColor whiteColor];
}

//恢复事件
-(void)ClickUp
{
    if(self.lblDigtal)
        self.lblDigtal.textColor=[UIColor blackColor];
    if(self.lblLetters)
        self.lblLetters.textColor=[UIColor colorWithRed:133.0/255.0 green:144.0/255.0 blue:146.0/255.0 alpha:1.0];
}


//初始化键盘按钮，只初始化按钮大小
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

@end
