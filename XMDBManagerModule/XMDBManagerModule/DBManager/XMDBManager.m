//
//  XMDBManager.m
//  XMDBManagerModule
//
//  Created by 薛坤龙 on 2017/5/11.
//  Copyright © 2017年 xm. All rights reserved.
//

#import "XMDBManager.h"

@interface XMDBManager ()
{
    NSString *_dbPath;
}

@end

@implementation XMDBManager

static XMDBManager *_sharedDBManager;

+ (XMDBManager *)shardDBManager
{
    if (!_sharedDBManager)
    {
        _sharedDBManager = [[XMDBManager alloc] init];
    }
    return _sharedDBManager;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        int state = [self initializeDBWithName:kDataBaseName];
        if (state == -1)
        {
            NSLog(@"数据库初始化失败");
        } else
        {
            NSLog(@"数据库初始化成功");
        }
    }
    return self;
}

- (int)initializeDBWithName:(NSString *)name
{
    if (!name)
    {
        return -1;  // 返回 数据库创建失败
    }
    // 沙盒Document目录
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
    _dbPath = [documentPath stringByAppendingPathComponent:name];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL exist = [fileManager fileExistsAtPath:_dbPath];
    [self connect];
    NSLog(@"%@", [self connect]);
    if (!exist)
    {
        return 0;
    } else
    {
        return 1;   // 返回 数据库已经存在
    }
}

// 连接数据库
- (NSString *)connect
{
    if (!_db)
    {
        _db = [[FMDatabase alloc] initWithPath:_dbPath];
        return _dbPath;
    }
    if (![_db open])
    {
        NSLog(@"不能打开数据库");
        return nil;
    }
    return _dbPath;
}
// 关闭连接
- (void)close
{
    [_db close];
    _sharedDBManager = nil;
}

@end
