//
//  KHServices+UploadCategory.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/10/22.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHServices+UploadCategory.h"
#import "KHServicesConfig.h"
#import "KHealthToolsMacro.h"

@implementation KHServices (UploadCategory)

#pragma mark - ------------------------------ 单个图片上传 ------------------------------
#define kBoundary @"----khealth-d1e2m3ax4iy6a"

///单个图片上传 - 如使用默认域名，则doMain传nil
- (void)uploadWithDoMain:(NSString *)doMain
                    Path:(NSString *)path
                   Param:(NSDictionary *)param
               ImageData:(NSData *)imgData
                Complete:(KHServicesAnyOption)cBlock {
    //1.创建请求对象
    KHServicesTask *task = [KHServicesTask postPath:path Param:param];
    task.doMain = doMain;
    NSMutableURLRequest *request = [task getReuqest];
    request.timeoutInterval = 10.0f;
    
    //2.设置请求头
    NSString *header = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",kBoundary];
    [request setValue:header forHTTPHeaderField:@"Content-Type"];
    
    //3.创建上传task
    __block NSData *taskData = [KHServices getBodyData:imgData];
    NSURLSessionUploadTask *uploadTask = [self.session uploadTaskWithRequest:request fromData:taskData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        taskData = nil;
        
        [KHServicesResolve resolveWithDataType:[NSString class]
                                          Data:data
                                      Response:response
                                         Error:error
                                 CompleteBlock:cBlock];
    }];
    [uploadTask resume];
}

///批量多图片上传
- (void)multiFileUploadWithDoMain:(NSString *)doMain
                             Path:(NSString *)path
                            Param:(NSDictionary *)param
                     ImageDataArr:(NSArray <NSData *>*)imageDataArray
                         Progress:(void(^)(CGFloat currentProgress))pBlock
                         Complete:(KHServicesArrayOption)cBlock {
    __block NSData *taskData = [self appendBodyData:imageDataArray];
    //1.创建请求对象
    KHServicesTask *task = [KHServicesTask postPath:path Param:param];
    task.doMain = doMain;
    NSMutableURLRequest *request = [task getReuqest];
    request.timeoutInterval = 20.0f * imageDataArray.count;
    
    //2.设置请求头
    NSString *header = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",kBoundary];
    [request setValue:header forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionUploadTask *uploadTask = [self.session uploadTaskWithRequest:request fromData:taskData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        taskData = nil;
        
        [KHServicesResolve resolveWithDataType:[NSArray class]
                                          Data:data
                                      Response:response
                                         Error:error
                                 CompleteBlock:cBlock];
    }];
    [uploadTask resume];
}
///多图拼接data数据
- (NSData *)appendBodyData:(NSArray <NSData *>*)imageDataArr {
    NSMutableData *fileData = [NSMutableData data];
    int i = 1;
    for (NSData *data in imageDataArr) {
        NSString *field = [NSString stringWithFormat:@"file%d",i];
        NSString *fileName = [NSString stringWithFormat:@"image%d.png",i];
        NSString *fs0 = [NSString stringWithFormat:@"--%@",kBoundary];
        NSString *fs1 = @"\r\n";
        NSString *fs2 = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\";",field];
        NSString *fs3 = [NSString stringWithFormat:@"filename=\"%@\"",fileName];
        NSString *fs4 = @"\r\n";
        NSString *fs5 = @"Content-Type: image/png";
        NSString *fs6 = @"\r\n\r\n";
        NSString *fs  = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", fs0, fs1, fs2, fs3, fs4, fs5, fs6];
        [fileData appendData:[fs dataUsingEncoding:NSUTF8StringEncoding]];
        [fileData appendData:data];
        [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        i++;
    }
    NSString *endStr = [NSString stringWithFormat:@"--%@--",kBoundary];
    [fileData appendData:[endStr dataUsingEncoding:NSUTF8StringEncoding]];
    return fileData;
}

///生成图片的数据
+ (NSData *)getBodyData:(NSData *)imageData {
    NSMutableData *fileData = [NSMutableData data];
    
    //5.1 拼接文件参数
    /*
     --分隔符
     Content-Disposition: form-data; name="file"; filename="Snip20151228_572.png"
     Content-Type: image/png
     空行
     文件二进制数据
     --分隔符
     Content-Disposition: form-data; name="username"
     空行
     非二进制参数
     空行
     --分隔符
     */
    NSString *fs0 = [NSString stringWithFormat:@"--%@",kBoundary];
    NSString *fs1 = @"\r\n";
    NSString *fs2 = @"Content-Disposition: form-data; name=\"file\";";
    NSString *fs3 = @"filename=\"123456123.png\"";
    NSString *fs4 = @"\r\n";
    NSString *fs5 = @"Content-Type: image/png";
    NSString *fs6 = @"\r\n\r\n";
    NSString *fs  = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", fs0, fs1, fs2, fs3, fs4, fs5, fs6];
    [fileData appendData:[fs dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:imageData];
    
    NSString *hs0 = [NSString stringWithFormat:@"--%@",kBoundary];
    NSString *hs1 = @"\r\n";
    NSString *hs2 = @"Content-Disposition: form-data; name=\"username\"";
    NSString *hs3 = @"\r\n\r\n";
    NSString *hs4 = @"khealth";
    NSString *hs5 = @"\r\n";
    NSString *hs6 = [NSString stringWithFormat:@"--%@--",kBoundary];
    NSString *hs  = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", hs0, hs1, hs2, hs3, hs4, hs5, hs6];
    [fileData appendData:[hs dataUsingEncoding:NSUTF8StringEncoding]];
    
    return fileData;
}

@end

