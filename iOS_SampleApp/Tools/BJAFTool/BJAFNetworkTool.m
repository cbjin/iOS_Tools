//
//  BJAFNetworkTool.m
//  Test
//
//  Created by dllo on 15/11/6.
//  Copyright © 2015年 Sie. All rights reserved.
//

#import "BJAFNetworkTool.h"
#import "AFNetworking.h"

@implementation BJAFNetworkTool
+ (void)getUrl:(NSString *)url body:(id)body response:(BJResposeStyle)style requsetHeadFile:(NSDictionary *)headFile success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    /**
     *  1.获取单例的网络管理对象
     */

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    /**
     *  2.根据style的类型,去选择返回值类型
     */
    
    switch (style) {
        case BJJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer]; //修改返回值(responseObject)类型
            break;
        case BJData:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case BJXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        default:
            break;
    }
    /**
     *  3.设置响应数据支持类型
     */
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript", nil]];
    
    /**
     * 4.给网络请求添加请求头
     * headFile [key] 字面量取值
     */
    if (headFile) {
        for (NSString *key in [headFile allKeys]) {
            [manager.requestSerializer setValue:headFile [key] forHTTPHeaderField:key];
        }
    }
    
    /**
     *  5.UTF8转码
     */
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    /**
     *  6.发送get请求
     */
    [manager GET:url parameters:body progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
//    [manager GET:url parameters:body success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        if (success) {
//            success(task, responseObject);
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure) {
//            failure(task, error);
//        }
//        
//    }];
    
}



+ (void)postUrlString:(NSString *)url
                 body:(id)body
             response:(BJResposeStyle)style
            bodyStyle:(BJRequestStyle)bodyStyle
      requestHeadFile:(NSDictionary *)headFile
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    // 1.获取Session管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript", nil]];
    // 2.设置网络请求返回时, responseObject的数据类型
    switch (style) {
        case BJJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case BJXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case BJData:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
    // 3.判断body体的类型
    switch (bodyStyle) {
        case BJRequestJSON:
            // 以JSON格式发送
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case BJRequestString:
            // 保持字符串样式
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, id parameters, NSError *__autoreleasing *error) {
                return parameters;
            }];
        case BJRequestDefault:
            // 默认情况会把JSON拼接成字符串, 但是没有顺序
            break;
            
        default:
            break;
    }
    // 4.给网络请求加请求头
    if (headFile) {
        for (NSString *key in headFile.allKeys) {
            [manager.requestSerializer setValue:headFile[key] forHTTPHeaderField:key];
        }
    }
    
    //无条件的信任服务器上的证书
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//    // 客户端是否信任非法证书

    securityPolicy.allowInvalidCertificates = YES;

    // 是否在证书域字段中验证域名

    securityPolicy.validatesDomainName = NO;
    
    manager.securityPolicy = securityPolicy;
    
    
    // 5.设置支持的响应头格式
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript", nil]];
    // 6.发送网络请求
    [manager POST:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
//    [manager GET:url parameters:body success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        if (success) {
//            success(task, responseObject);
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure) {
//            failure(task, error);
//        }
//        
//    }];

}
@end

