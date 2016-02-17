//
//  ViewController.m
//  WDNetWorking
//
//  Created by 周鹏翔 on 15/12/28.
//  Copyright © 2015年 周鹏翔. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "WDHttpRequest.h"
#import "userRequest.h"
#import "WDNetRequest.h"
#import "personInfoRequset.h"
@interface ViewController (){
    

//    NSURLSessionDownloadTask *downloadTask;
    NSInteger index;
    NSMutableArray * taskArr;
    NSTimeInterval begin, end, time;
    NSData * redata;
}
@property long long totalContentLength;             //文件总大小
@property long long totalReceivedContentLength;     //已下载大小
@property (nonatomic, strong) NSString *targetPath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self aaaaaa];
    index=1;
    taskArr =[NSMutableArray array];
//    redata =[NSData data];
    
    UIButton * button=[[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor=[UIColor redColor];
    [button addTarget:self action:@selector(aaaaaa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
//    [button addTarget:self action:@selector(dddddd) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
    UIButton * button1=[[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
    button1.backgroundColor=[UIColor redColor];
    [button1 addTarget:self action:@selector(bbbbbb) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton * button2=[[UIButton alloc]initWithFrame:CGRectMake(100, 500, 100, 100)];
    button2.backgroundColor=[UIColor redColor];
    [button2 addTarget:self action:@selector(cccccc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 *  获取文件大小
 *  @param path 文件路径
 *  @return 文件大小
 *
 */
- (long long)fileSizeForPath:(NSString *)path {
    
    long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}
-(void)dddddd{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];//Documents目录
    self.targetPath = [documentsDirectory stringByAppendingPathComponent:@"myPic"];

    
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    
    
    
     NSURL *url = [NSURL URLWithString:@"http://p1.pichost.me/i/40/1639665.png"];
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    long long downloadedBytes  = [self fileSizeForPath:self.targetPath];
    if (downloadedBytes > 0) {
        
        NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
        [request setValue:requestRange forHTTPHeaderField:@"Range"];
    }else{
        
        int fileDescriptor = open([self.targetPath UTF8String], O_CREAT | O_EXCL | O_RDWR, 0666);
        if (fileDescriptor > 0) {
            close(fileDescriptor);
        }
    }
    
    
      NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    
    
    

//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *  downloadProgress) {
//
//        NSLog(@"downloadProgress %ld is  %@",index,downloadProgress);
//        
//    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        
//       
//        return [NSURL fileURLWithPath:self.targetPath];
//       
//        
//        
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        
//        NSLog(@"File downloaded to: %@", filePath);
//      
//        
//    }];
    
    NSURLSessionDataTask * downloadTask=[manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
          NSLog(@"uploadProgress %ld is  %@",index,uploadProgress);
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
          NSLog(@"downloadProgress %ld is  %@",index,downloadProgress);
//        mutableData
//        manager.
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        NSLog(@"%@",responseObject);
    }];
    
    
    
    [downloadTask resume];
    


    
    
    
    
    
    
}
-(void)cccccc{
//    [downloadTask resume];
    [[taskArr lastObject] resume];

    
    
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
  
    
    NSString * name=[NSString stringWithFormat:@"wudao %ld",index];

    NSURL * pathUrl=documentsDirectoryURL;
    
    NSString * fileName=[name stringByAppendingString:@".mp4"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.networkServiceType=NSURLNetworkServiceTypeVideo;
    configuration.timeoutIntervalForResource=-1;
//    configuration.allowsCellularAccess=YES;
    begin=0;
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    
    
    
    //    progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
    NSURLSessionDownloadTask *downloadTask=[manager downloadTaskWithResumeData:redata progress:^(NSProgress *  downloadProgress) {
        
          NSLog(@"Progress %ld is  %@",index,downloadProgress);
        
    } destination:^NSURL * (NSURL *  targetPath, NSURLResponse *  response) {
        
        return [pathUrl URLByAppendingPathComponent:fileName];
        
    } completionHandler:^(NSURLResponse *  response, NSURL *  filePath, NSError *  error) {
        
           NSLog(@"File downloaded to: %@", filePath);
    }];

    [downloadTask resume];
}
-(void)bbbbbb{
    
//    [downloadTask suspend];
//     [[taskArr firstObject] suspend];
//    [[taskArr lastObject] cancel];
    [[taskArr lastObject] cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        
        NSLog(@"%@",resumeData);
        redata=[resumeData copy];
       
    }];
    
//    [taskArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        
//        NSURLSessionDownloadTask *downloadTask=(NSURLSessionDownloadTask *)obj;
//        NSURLSessionTaskState sta = downloadTask.state;
////        [downloadTask.response d ]
////        downloadTask.taskIdentifier
//        [downloadTask suspend];
//        
//
//
//        
//        
//    }];
    
    NSLog(@"");
}
-(void)aaaaaa{
    
//     userRequest * ur=[[userRequest alloc]init];
//   
//    personInfoRequset * per=(personInfoRequset *)[[WDHttpRequest sharedInstance]getDefault:@"personInfoRequset"];
//   BOOL ishaveCache=[per cache];
//    [per startWithRequest:ur downloadProgress:^(NSProgress *progress) {
//        
//    } success:^(WDBaseRequest *request) {
//        
//    } failure:^(WDBaseRequest *request) {
//        
//    }];
    
    index++;

    
    userRequest * ur=[[userRequest alloc]init];
//    [ur star];
//    return;
    
    
    WDBaseRequest * baserequest=[[WDBaseRequest alloc]init];
//   baserequest.requestMethod=WDRequestMethodPost;
//   baserequest.requestUrl=@"http://api3.dance365.com/global/ntptime";
     baserequest.requestUrl=@"/global/ntptime";
     baserequest.requestArgument=@{@"id":@"chinadance"};

//    baserequest.requestSerializerType=WDRequestSerializerTypeJSON;
    
  [[WDHttpRequest creatNetRequest]startWithRequest:ur downloadProgress:nil success:^(WDBaseRequest *request) {
      
       NSLog(@"--------->>>>-------------");
   
      
  } failure:^(WDBaseRequest *request) {
      
      NSLog( @"22222%@",request.ERRORString);
  }];

    WDBaseRequest * baserequest1=[[WDBaseRequest alloc]init];
    //   baserequest.requestMethod=WDRequestMethodPost;
    //   baserequest.requestUrl=@"http://api3.dance365.com/global/ntptime";
    baserequest1.requestUrl=@"/global/ntptime1";
    baserequest1.requestArgument=@{@"id":@"chinadance"};
    
    //    baserequest.requestSerializerType=WDRequestSerializerTypeJSON;
    
    [[WDHttpRequest creatNetRequest]startWithRequest:baserequest downloadProgress:nil success:^(WDBaseRequest *request) {
        
        NSLog(@"--------->>>>-------------");
        
        
    } failure:^(WDBaseRequest *request) {
        
        NSLog( @"11111  %@",request.ERRORString);
    }];
    
    
//    return;
    
//      NSURL *URL = [NSURL URLWithString:@"http://218.92.226.116/7xjxau.media1.z0.glb.clouddn.com/AtscFGDQ0QlJTV4SUTcSZzCY6o0=/lv1TYU86t22rbxvzYw5YiTFFbpWP?wsiphost=local"];
//    
//    
////    NSURL *URL = [NSURL URLWithString:@"http://upload.wudaotv.com/api/video.php?mp4=1&vkey=6NFZQJ"];
//   
//    
//    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
////
////
//    NSString * name=[NSString stringWithFormat:@"wudao %ld",index];
//    [[WDHttpRequest creatNetRequest]downloadWithRequestUrl:URL downPathUrl:documentsDirectoryURL downloadName:name downloadProgress:^(NSProgress *progress) {
//        
//        NSLog(@"downloadProgress  is  %@",progress);
//        
//    } success:^(NSURL *filePath) {
//        
//          NSLog(@"File downloaded to: %@", filePath);
//        
//    } failure:^(NSError *error) {
//        
//        NSLog(@"%@",error);
//        NSData * data=[error.userInfo objectForKey:NSURLSessionDownloadTaskResumeData];
//        NSLog(@"%@",data);
//        
//    }];
//
//    WDNetRequest * rea=(WDNetRequest *)[[WDHttpRequest sharedInstance]getDefault];
//    NSMutableArray * aa=   rea.downLoadTaskArrs;
//
//    NSLog(@"%@",aa);
//    
//        WDBaseRequest * baserequest=[[WDBaseRequest alloc]init];
//    //   baserequest.requestMethod=WDRequestMethodPost;
//    //   baserequest.requestUrl=@"http://api3.dance365.com/global/ntptime";
//         baserequest.requestUrl=@"/global/ntptime";
//         baserequest.requestArgument=@{@"id":@"chinadance"};
//    
//    //    baserequest.requestSerializerType=WDRequestSerializerTypeJSON;
//    
//      [[WDHttpRequest creatNetRequest]startWithRequest:baserequest downloadProgress:nil success:^(WDBaseRequest *request) {
//    
//           NSLog(@"--------->>>>-------------");
//    
//    
//      } failure:^(WDBaseRequest *request) {
//    
//          NSLog( @"22222%@",request.ERRORString);
//      }];
//    
//    WDNetRequest * rea1=(WDNetRequest *)[[WDHttpRequest sharedInstance]getDefault];
//    NSMutableArray * aa1=   rea.downLoadTaskArrs;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
