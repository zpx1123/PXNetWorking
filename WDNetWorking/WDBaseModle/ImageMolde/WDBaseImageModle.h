//
//  BaseImageModle.h
//  WDNetWorking
//
//  Created by 周鹏翔 on 15/12/28.
//  Copyright © 2015年 周鹏翔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDBaseModle.h"

@interface WDimageSize

@property(nonatomic,assign)NSInteger mImageWidth;
@property(nonatomic,assign)NSInteger mImageHeigth;
@end

@interface WDBaseImageModle : WDBaseModle


@property(nonatomic,strong)NSString * mImageSubTitle;
@property(nonatomic,strong)NSString * mImagePath;
@property(nonatomic,strong)NSString * mImageFileSize;
@property(nonatomic,strong)WDimageSize* mImageSize;//600*800

@end
