//
//  ZZYScrollPCHHeader.h
//  ZZYScrollDemo
//
//  Created by zzy on 2018/5/24.
//  Copyright © 2018年 zzy. All rights reserved.
//

#ifndef ZZYScrollPCHHeader_h
#define ZZYScrollPCHHeader_h
#import "UIResponder+Router.h"
#import "BaseViewController.h"

#define  ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#ifdef DEBUG
#define DebugLog( s, ... ) printf( "<%s:(%d)> %s %s\n\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] cStringUsingEncoding:NSUTF8StringEncoding], __LINE__,__func__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] cStringUsingEncoding:NSUTF8StringEncoding])
#else
#define DebugLog( s, ... )
#endif

#endif /* ZZYScrollPCHHeader_h */
