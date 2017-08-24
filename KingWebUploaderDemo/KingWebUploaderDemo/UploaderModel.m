//
//  UploaderModel.m
//  KingWebUploaderDemo
//
//  Created by J on 2017/8/25.
//  Copyright © 2017年 J. All rights reserved.
//

#import "UploaderModel.h"

@implementation UploaderModel
-(void)setFileSize:(NSString *)fileSize
{
    _fileSize=fileSize;
}
-(void)setFilePath:(NSString *)filePath
{
    _filePath=filePath;
}
+(UploaderModel *)createModelWithFilePath:(NSString *)path
{
    UploaderModel *model=[[UploaderModel alloc]init];
    [model setFilePath:path];
    [model setFileSize:[[self class]getFileSize:path]];
    return model;
}
+(NSString *)getFileSize:(NSString *)filePath
{
    unsigned long long f=[[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
    
    return [NSString stringWithFormat:@"%@M",[NSNumber numberWithFloat:(f/1024.0/1024.0)]];
}



@end
