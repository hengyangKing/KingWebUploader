//
//  ViewController.m
//  KingWebUploaderDemo
//
//  Created by J on 2017/8/24.
//  Copyright © 2017年 J. All rights reserved.
//

#import "ViewController.h"
#import "KingWebUploaderConnection.h"
#import "GCDWebUploader.h"
#import "UploaderModel.h"

@interface ViewController ()<GCDWebUploaderDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)GCDWebUploader *uploader;

@property(nonatomic,copy)NSString *filePath;

@property (weak, nonatomic) IBOutlet UILabel *addrLabel;


@property (weak, nonatomic) IBOutlet UITableView *tableview;


@property(nonatomic,strong)NSMutableArray *datas;

@end

@implementation ViewController
#pragma mark lazy
-(GCDWebUploader *)uploader
{
    if (!_uploader) {
        _uploader=[[GCDWebUploader alloc]initWithUploadDirectory:self.filePath];
        _uploader.delegate = self;
    }
    return _uploader;
}
-(NSMutableArray *)datas
{
    if (!_datas) {
        _datas=[NSMutableArray arrayWithCapacity:0];
       
         NSArray *files =[[NSFileManager defaultManager]contentsOfDirectoryAtPath:self.filePath error:nil];
        for (NSString *fileName in files) {
            NSLog(@"%@",fileName);
            NSString *path=[NSString stringWithFormat:@"%@/%@",self.filePath,fileName];
            UploaderModel *model=[UploaderModel createModelWithFilePath:path];
            [_datas addObject:model];
        }
    }
    return _datas;
}
-(NSString *)filePath
{
    if (!_filePath.length) {
        
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        
        _filePath = [[[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"] stringByAppendingFormat:@"/uploadCaches"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:_filePath])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:_filePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
    }
    return _filePath;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.uploader startWithOptions:@{
                                      GCDWebServerOption_ConnectionClass:KingWebUploaderConnection.class,
                                      GCDWebServerOption_Port:@50001,
                                      GCDWebServerOption_BonjourName:@"foo"
                                      } error:nil];
    
    
    [self.addrLabel setText:self.uploader.serverURL.absoluteString];
    
}
#pragma mark 

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"democell"];
    UploaderModel *model=self.datas[indexPath.row];
    [cell.textLabel setText:(NSString *)[[model.filePath componentsSeparatedByString:[NSString stringWithFormat:@"%@/",self.filePath]]lastObject]];
    [cell.detailTextLabel setText:model.fileSize];
    return cell;
}
#pragma mark Delegate
-(void)webUploader:(GCDWebUploader *)uploader didUploadFileAtPath:(NSString *)path
{
    UploaderModel *model=[UploaderModel createModelWithFilePath:path];
    [self.datas addObject:model];
    [self.tableview reloadData];
}


@end
