//
//  UploaderModel.h
//  KingWebUploaderDemo
//
//  Created by J on 2017/8/25.
//  Copyright © 2017年 J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploaderModel : NSObject
+(UploaderModel *)createModelWithFilePath:(NSString *)path;

@property(nonatomic,copy,readonly)NSString *filePath;
@property(nonatomic,copy,readonly)NSString *fileSize;

@end
