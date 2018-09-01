//
//  Macro.h
//  TestProject
//
//  Created by Wang,Ling(wallet-plus) on 2018/7/30.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define DuScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define DuScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

#define DuNativeResourceWidth(w) ((w/750.0) * DuScreenWidth)
#define DuNativeResourceHeight(h) DuNativeResourceWidth(h)
#define DuNativeResourceFontSize(size) (size/2)

#endif /* Macro_h */
