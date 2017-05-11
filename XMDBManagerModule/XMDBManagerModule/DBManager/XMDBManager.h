//
//  XMDBManager.h
//  XMDBManagerModule
//
//  Created by 薛坤龙 on 2017/5/11.
//  Copyright © 2017年 xm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

#define kDataBaseName @"xm_app.sqlite"

@interface XMDBManager : NSObject

@property (nonatomic, strong) FMDatabase *db;

+ (XMDBManager *)shardDBManager;

- (void)close;

@end
