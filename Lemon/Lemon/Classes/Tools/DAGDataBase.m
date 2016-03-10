//
//  DAGDataBase.m
//  Lemon
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGDataBase.h"
#import "DAGImageDownLoad.h"
static DAGDataBase *manager = nil;
@implementation DAGDataBase

+(instancetype)shareInstance {
       static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
              manager = [self new];
       });
       return manager;
}

static sqlite3 *db = nil;

#pragma  mark - 打开数据库
- (void)openDB {
       
       if (db != nil) {
              NSLog(@"数据库已经打开，无需重复打开");
       }
       // 获取document路径
       NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
       // 拼接数据库文件路径
       NSString *filePath = [docPath stringByAppendingString:@"/dataBase.sqlite"];
       NSLog(@"%@", filePath);
       // 打开数据库
       int result = sqlite3_open(filePath.UTF8String, &db);
       if (result == SQLITE_OK) {
              NSLog(@"数据库打开成功");
       } else {
              NSLog(@"数据库打开失败");
       }
}

#pragma mark - 关闭数据库
- (void)closeDB {
       int result = sqlite3_close(db);
       if (result == SQLITE_OK) {
              NSLog(@"数据库关闭成功");
       } else {
              NSLog(@"数据库关闭失败");
       }
}

#pragma mark - 创建表
- (void)createTable {
       [self openDB];
       // 生成SQL语句
       NSString *sql = @"CREATE  TABLE IF NOT EXISTS ImageDownLoad (pid INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , name TEXT NOT NULL , imageUrl TEXT NOT NULL )";
       // 执行SQL语句
       int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
       if (result == SQLITE_OK) {
              NSLog(@"创建表成功");
       } else {
              NSLog(@"创建表失败：%d", result);
       }
       
}

// 添加数据
- (void)addImage:(NSString *)image user:(NSString *)name {
       [self createTable];
       
       
       NSString *sql = [NSString stringWithFormat:@"INSERT INTO ImageDownLoad (name,imageUrl) VALUES ('%@','%@')",name, image];
       
       int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, NULL);
       if (result == SQLITE_OK) {
              NSLog(@"数据添加成功");
              
       } else {
              NSLog(@"数据添加失败%d",result);
       }
       
}

// 查询所有数据
- (NSArray<DAGImageDownLoad *> *)selectAll {
       [self openDB];
       NSMutableArray *arr = [NSMutableArray array];
       NSString *sql = @"SELECT *FROM ImageDownLoad";
       sqlite3_stmt *stmt = NULL;
       int result = sqlite3_prepare(db, sql.UTF8String, -1, &stmt, NULL);
       if (result == SQLITE_OK) {
              while (sqlite3_step(stmt) == SQLITE_ROW) {
                     DAGImageDownLoad *image = [DAGImageDownLoad new];
                     int pid = sqlite3_column_int(stmt, 0);
                     NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
                     NSString *imageUrl = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
                     image.pid = pid;
                     image.name = name;
                     image.imageUrl = imageUrl;
                     [arr addObject:image];
                     
              }
       }
       sqlite3_finalize(stmt);
       return arr;
       
       
}

// 查询指定的用户的数据
- (DAGImageDownLoad *)selectByName:(NSString *)name {
       DAGImageDownLoad *image = [DAGImageDownLoad new];
       for (DAGImageDownLoad *iamge in [self selectAll]) {
              if ([iamge.name isEqualToString:name]) {
                     image = iamge;
              }
       }
       return image;
}


@end
