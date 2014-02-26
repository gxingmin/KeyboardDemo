//
//  BlackKeyButton.m
//  黑色键盘的键按钮（继承KeyButtonBase）
//
//  Created by Baidu BP&IT 内网与预算组 高兴民 on 13-8-12.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import "BlackKeyButton.h"

@interface BlackKeyButton()

@property (nonatomic, assign) KeyboardType keyboardType; //键盘类型
@end

@implementation BlackKeyButton
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
        [self SetTextAndBackgroundImage:arryText keyboardtype:keyboardtype];
        
        //设置字体、颜色以及触发事件
        if(![self.Digtal isEqualToString:@""])
        {
            if([self.Digtal isEqualToString:@"ABC"] || [self.Digtal isEqualToString:@"T9"]) //ABC和T9，加下划线
            {
                int lineWidth= 32 + ([self.Digtal isEqualToString:@"ABC"] ? 12 : 0);
                UIImageView *viewLine=[[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-lineWidth)/2, frame.size.height-([self.Digtal isEqualToString:@"ABC"] ? 10 : 7), lineWidth, 3)];
                [viewLine setImage:[UIImage imageNamed:@"underline.png"]];
                [self addSubview:viewLine];
            }

            
            int topOffset = 0;
            if(keyboardtype == KeyboardType_T9 && [self.Letters isEqualToString:@""])
                topOffset = 5; //T9键盘最下方的ABC和0两个键文字要往下偏移点
            
            self.lblDigtal=[[UILabel alloc] initWithFrame:CGRectMake(0, 7+topOffset, self.frame.size.width, 20)];
            self.lblDigtal.textAlignment=NSTextAlignmentCenter;
            self.lblDigtal.font= [UIFont fontWithName:@"HelveticaNeue" size:20];
            self.lblDigtal.backgroundColor=[UIColor clearColor];
            
            if([self.Digtal isEqualToString:@" "])
                self.lblDigtal.text=@"Space";
            else
                self.lblDigtal.text=self.Digtal;
            
            self.lblDigtal.textColor=[UIColor whiteColor];
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
            
       
        }
        else   //设置两个回退按钮的前景图片
        {
            NSString *strImagePressed;  //按下图片
            NSString *strImageNormal;   //恢复图片
            
            switch (index)
            {
                case 11: //T9  回退
                case 42: //ABC 回退
                    strImageNormal = @"black_back.png";
                    strImagePressed = @"black_back_press.png";
                    break;
                default:
                    break;
            }
            
            [self setImage:[UIImage imageNamed:strImageNormal] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:strImagePressed] forState:UIControlStateHighlighted];
            
            
        }
        
    }
    
    return self;
}

//功能描述：设置键上的文本和键的背景图片
//参数说明：
//        arryText -- 按钮上显示的文本（字符型或数组型，数组型适用于abc键盘)
//        keyboardtype -- 键盘类型（T9、ABC）
- (void)SetTextAndBackgroundImage:(id)arryText keyboardtype:(KeyboardType)keyboardtype
{
    NSString *strImagePressed;  //按下图片
    NSString *strImageNormal;   //恢复图片
    
    if(keyboardtype == KeyboardType_T9)  //T9键盘
    {
        self.Digtal=[arryText objectAtIndex:0];
        self.Letters=[arryText objectAtIndex:1];
        
        strImageNormal=@"black_keyboard_T9_normal.png";
        strImagePressed=@"black_keyboard_T9_pressed.png";
        
        [self setBackgroundImage:[UIImage imageNamed:strImageNormal] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:strImagePressed] forState:UIControlStateHighlighted];
    }
    else
    {
        self.Digtal=arryText;
        
        
        strImageNormal=@"black_keyboard_abc_normal.png";
        strImagePressed=@"black_keyboard_abc_pressed.png";
        
        [self setBackgroundImage:[UIImage imageNamed:strImageNormal] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:strImagePressed] forState:UIControlStateHighlighted];
    }
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

