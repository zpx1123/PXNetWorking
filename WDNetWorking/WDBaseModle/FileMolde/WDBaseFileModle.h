//
//  BaseFileModle.h
//  WDNetWorking
//
//  Created by 周鹏翔 on 15/12/28.
//  Copyright © 2015年 周鹏翔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDBaseModle.h"
@interface WDBaseFileModle : WDBaseModle
@property(nonatomic,strong)NSString * mFileDirectory;//文件目录地址
@property(nonatomic,strong)NSString * mFileType;//文件类型 枚举
@property(nonatomic,strong)NSString * mFilePath;//文件所在本地地址
@property(nonatomic,strong)NSString * mFileSize;//文件大小
@property(nonatomic,strong)NSString * mFileCreatTime;
@end
