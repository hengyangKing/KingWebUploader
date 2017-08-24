//
//  KingWebUploaderConnection.m
//  KingWebUploaderDemo
//
//  Created by J on 2017/8/24.
//  Copyright © 2017年 J. All rights reserved.
//

#import "KingWebUploaderConnection.h"
#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"


@interface KingWebUploaderConnection ()
{
    NSUInteger _contentLength;
    NSUInteger _receivedDataLength;
}
@end

@implementation KingWebUploaderConnection


-(NSURL *)rewriteRequestURL:(NSURL *)url withMethod:(NSString *)method headers:(NSDictionary *)headers
{
    if ([method isEqualToString:@"POST"]) {
        
        _contentLength = [[NSString stringWithFormat:@"%@", headers[@"Content-Length"]]integerValue];
        _receivedDataLength = 0;
        
        
    }
    return [super rewriteRequestURL:url withMethod:method headers:headers];
}
-(void)didReadBytes:(const void *)bytes length:(NSUInteger)length
{
    [super didReadBytes:bytes length:length];
    if (_contentLength == 0 ) {
        return;
    }
    _receivedDataLength +=length;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showProgress:((CGFloat)_receivedDataLength /(CGFloat)_contentLength) status:@"正在上传..."];
    });
}
-(void)processRequest:(GCDWebServerRequest *)request completion:(GCDWebServerCompletionBlock)completion
{
    [super processRequest:request completion:completion];
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });

}
@end
