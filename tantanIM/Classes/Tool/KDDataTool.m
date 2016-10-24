//
//  KDDataTool.m
//  tantanIM
//
//  Created by kaidan on 16/10/21.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "KDDataTool.h"
#import "FMDB.h"
#import "KDDataModel.h"

@implementation KDDataTool


+(BOOL)isDB{
    
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbPath = [NSString stringWithFormat:@"%@/chat.sqlite",path];
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    return [manager fileExistsAtPath:dbPath];
}

+(FMDatabase*)getFMDataBase{
    
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbPath = [NSString stringWithFormat:@"%@/chat.sqlite",path];
    
    FMDatabase* db = [[FMDatabase alloc]initWithPath:dbPath];
    
    [db open];
    return db;
    
}

+(BOOL)createTable:(NSString*)user chat:(NSString*)chat{
    
    
    FMDatabase* db = [KDDataTool getFMDataBase];
    
    NSString* sqlStr = [NSString stringWithFormat:@" create table chat_%@_%@(id integer primary key autoincrement ,type int,message text)",user,chat];
    
    
    
    if([db executeUpdate:sqlStr]){
        NSLog(@"建表成功");
        [db close];
        return YES;
    }else{
        NSLog(@"建表失败");
    }
    
    [db close];
    return NO;
}

+(BOOL)insertData:(id)data{
    
    KDDataModel* model = (KDDataModel*)data;
    
    FMDatabase* db = [KDDataTool getFMDataBase];
    
    NSString* sql = @" insert into chat_%@_%@(type,message) values(?,?)";
    
    if ([db executeUpdate:sql,model.chattype,model.msg]) {
        NSLog(@"添加成功");
        [db close];
        return YES;
    }else{
        NSLog(@"添加失败");
        [db close];
        return NO;
    }
}

+(NSArray*)selectData:(NSString*)user chat:(NSString*)chat{
    
    NSMutableArray* arr = [NSMutableArray array];
    
    FMDatabase* db = [KDDataTool getFMDataBase];
    
    NSString* sql = [NSString stringWithFormat:@" select * from chat_ %@_%@",user,chat];
    
    FMResultSet* result = [db executeQuery:sql];
    
    while (result.next) {
        
        NSInteger chatType = [result intForColumn:@"type"];
        
        
        
        NSLog(@"-数据库保存的条数--%ld",arr.count);
    }
    
    return arr;
}


@end
