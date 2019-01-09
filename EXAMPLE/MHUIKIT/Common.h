//
//  Common.h
//  MHUIKIT
//
//  Created by minghe on 2019/1/9.
//  Copyright © 2019年 minghe. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define COLOR_DEFAULT_WHITE        HEX(0xffffff)
#define COLOR_GRAY                  HEX(0xaaaaaa)
#define COLOR_ORANGE            HEX(0xfa5e3f)


//#define DO_MAIN @"https://test.95590.cn/nloan_test/"    // 二期测试服务器
//#define DO_MAIN @"https://test.95590.cn/OLI/"        // 信保测试
//#define    DO_MAIN @"https://test.95590.cn/OLI_ver/"  //信保UAT
//#define DO_MAIN @"https://app.ddsd-ccic.com/loan/"  //生产
#define DO_MAIN @"http://mock-api.com/89n6rrnV.mock/"  //生产




#ifdef DEBUG

#define NSLog(...) NSLog(__VA_ARGS__)
#define LOG(...) NSLog(__VA_ARGS__)
#define LOG_MARK  NSLog(@"MARK: %s, %d", __FUNCTION__, __LINE__)

#else

#define NSLog(...)
#define LOG_MARK
#define LOG(...)

#endif



#endif /* Common_h */
