//
//  BJAFNetworkTool.h
//  Test
//
//  Created by dllo on 15/11/6.
//  Copyright © 2015年 Sie. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, BJResposeStyle) {
    BJJSON,
    BJXML,
    BJData,
};

typedef NS_ENUM(NSUInteger, BJRequestStyle) {
    BJRequestJSON,
    BJRequestString,
    BJRequestDefault
};

@interface BJAFNetworkTool : NSObject


+ (void)getUrl:(NSString *)url
          body:(id)body
      response:(BJResposeStyle)style
requsetHeadFile:(NSDictionary *)headFile
       success:(void (^)(NSURLSessionDataTask *task, id resposeObject))success
       failure:(void (^)(NSURLSessionDataTask *task, NSError *error)) failure;

+ (void)postUrlString:(NSString *)url
                 body:(id)body
             response:(BJResposeStyle)style
            bodyStyle:(BJRequestStyle)bodyStyle
      requestHeadFile:(NSDictionary *)headFile
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
