//
//  userRequest.m
//  WDNetWorking
//
//  Created by 周鹏翔 on 15/12/30.
//  Copyright © 2015年 周鹏翔. All rights reserved.
//

#import "userRequest.h"
#import "WDHttpRequest.h"

@implementation userRequest

-(NSString *)requestUrl{
    
    return @"/global/ntptime";
}
-(id)requestArgument{
    
    return @{@"id":@"chinadance"};
}
-(WDRequestMethod)requestMethod{
    
    return WDRequestMethodGet;
}

-(void)star{
    
    
    [[WDHttpRequest creatNetRequest]startWithRequest:self downloadProgress:nil success:^(WDBaseRequest *request) {
        NSLog(@"--------->>>>-------------");
        
    } failure:^(WDBaseRequest *request) {
        
        NSLog( @"%@",request.ERRORString);
    }];
    
}
@end
