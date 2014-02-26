//
//  KeyboardBase.m
//  键盘基类（ABC和T9键盘继承它）
//
//  Created by Baidu BP&IT 内网与预算组 高兴民 on 13-8-12.
//
//

#import "KeyboardBase.h"
#import "SoundPlayer.h"

static NSArray *_stringListABC;
static NSMutableArray *_stringListT9;


@implementation KeyboardBase
@synthesize delegate;
@synthesize pressKeySoundType;

//ABC键盘上键按钮文本数组缓存
+(NSArray *)stringListABC
{
    if(_stringListABC==nil)
    {
        _stringListABC=[[NSArray alloc] initWithObjects:
                             @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",         //0-9
                             @"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",         //10-19
                             @"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",              //20-28
                             @".",@"z",@"x",@"c",@"v",@"b",@"n",@"m",@"@",              //29-37
                             @"T9",@"_",@" ",@"-",@"",nil];                             //38-42
    }
    
    return _stringListABC;
}

//T9键盘上键按钮文本数组缓存
+(NSMutableArray *)stringListT9
{
    if(_stringListT9==nil)
    {
        _stringListT9=[[NSMutableArray alloc] init];
        [_stringListT9 addObject:[NSArray arrayWithObjects:@"1",@"", nil]];
        [_stringListT9 addObject:[NSArray arrayWithObjects:@"2",@"ABC", nil]];
        [_stringListT9 addObject:[NSArray arrayWithObjects:@"3",@"DEF", nil]];
        [_stringListT9 addObject:[NSArray arrayWithObjects:@"4",@"GHI", nil]];
        [_stringListT9 addObject:[NSArray arrayWithObjects:@"5",@"JKL", nil]];
        [_stringListT9 addObject:[NSArray arrayWithObjects:@"6",@"MNO", nil]];
        [_stringListT9 addObject:[NSArray arrayWithObjects:@"7",@"PQRS", nil]];
        [_stringListT9 addObject:[NSArray arrayWithObjects:@"8",@"TUV", nil]];
        [_stringListT9 addObject:[NSArray arrayWithObjects:@"9",@"WXYZ", nil]];
        
        [_stringListT9 addObject:[NSArray arrayWithObjects:@"ABC",@"", nil]];  //拨号键盘最后一行
        [_stringListT9 addObject:[NSArray arrayWithObjects:@"0",@"", nil]];
        [_stringListT9 addObject:[NSArray arrayWithObjects:@"",@"", nil]];
        
    }
    
    return _stringListT9;
    
}

//初始化键盘
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//功能描述：键盘按键事件
//参数说明：
//        sender        -- 按键按钮
//        keyboardType  -- 键盘类型(T9、ABC)
-(void)KeyButtonClicked:(id)sender withKeyboardType:(KeyboardType)keyboardType
{
    switch (self.pressKeySoundType)
    {
        case PressKeySoundTypeSound:           //声音
            [SoundPlayer playSound];
            break;
        case PressKeySoundTypeVibrate:         //振动
            [SoundPlayer playVibrate];
            break;
        case PressKeySoundTypeSoundAndVibrate: //声音+振动
            [SoundPlayer playSoundAndVibrate];
            break;
        default:
            break;
    }

    //代理响应
    if(self.delegate!=nil)
        [self.delegate KeyButtonClicked:sender withKeyboardType:KeyboardType_T9];
}


@end
