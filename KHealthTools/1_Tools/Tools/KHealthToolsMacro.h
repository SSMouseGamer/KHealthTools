//
//  KHealthToolsMacro.h
//  KHealthTools
//
//  Created by 李云新 on 2018/10/10.
//

#ifndef KHealthToolsMacro_h
#define KHealthToolsMacro_h
#ifdef __OBJC__

//避免引用循环
#define KHWeakObj(o) __weak typeof(o) weakSelf = o;

#pragma mark - -=-=-=-=-=-=-=-=-=-=-=-=- Log -=-=-=-=-=-=-=-=-=-=-=-=-
//打印日志
#ifdef DEBUG
//#define KHLog(...)
#define KHLog(...) NSLog(__VA_ARGS__)
#else
#define KHLog(...)
//#define KHLog(...) NSLog(__VA_ARGS__)
//KHLog(@"%s", __FUNCTION__);
#endif

#pragma mark - -=-=-=-=-=-=-=-=-=-=-=-=- Color -=-=-=-=-=-=-=-=-=-=-=-=-
#define KH_RGBOF(v)      KH_RGBOFA(v, 1.0)
#define KH_RGBOFA(v, a)  KH_RGBA((float)((v & 0xFF0000) >> 16), (float)((v & 0xFF00) >> 8), (float)(v & 0xFF), a)
#define KH_RGB(r,g,b)    KH_RGBA(r,g,b,1.0)
#define KH_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//一般使用的颜色
#define KHColor333333 KH_RGBA( 51,  51,  51, 1)
#define KHColor666666 KH_RGBA(102, 102, 102, 1)
#define KHColor999999 KH_RGBA(153, 153, 153, 1)
#define KHColorCDCDCD KH_RGBA(205, 205, 205, 1)
#define KHColorEAEAEA KH_RGBA(234, 234, 234, 1)//线的颜色
#define KHColorF5F5F5 KH_RGBA(245, 245, 245, 1)//常用于View的背景色

//更改字体大小倍率成功的通知的KEY
#define KH_FONTSCALE_CHANGE_NOTIFICATION_KEY @"KH_FONTSCALE_CHANGE_NOTIFICATION_KEY"

#endif /* __OBJC__ */
#endif /* KHealthToolsMacro_h */
