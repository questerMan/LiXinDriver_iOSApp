//
//  NativeBaseDataManage.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/2.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "NativeData.h"

@implementation NativeData

/** 单例 */
+ (NativeData *)shareInstance{
    
    static dispatch_once_t onceToken;
    static NativeData * dataBase = nil;
    dispatch_once(&onceToken, ^{
        dataBase = [[NativeData alloc]init];
        
    });
    return dataBase;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //获取目录沙盒地址路径
        NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        //目录地址／数据库名称
        NSString * dbPath = [NSString stringWithFormat:@"%@/DriveriOSApp.db",docPath];
        
        NSLog(@"本地持久化数据库地址: %@",dbPath);
        
        _dataBase = [FMDatabase databaseWithPath:dbPath];
        BOOL b = [_dataBase open];
        if (!b) {
            NSLog(@"数据打开失败");
        }else{
            //创建数据库表格
            [self creatTable];
            
        }
    }
    return self;
}

#pragma mark - 创建数据库表格
-(void)creatTable{
    
    //用户信息
    NSString * sql_NativeDataList =  @"create table if not exists NativeDataList (id integer primary key autoincrement,phoneNum text,userID text,indentID text,advertID text,firstRun text)";
    
    BOOL flag1 = [_dataBase executeUpdate:sql_NativeDataList];
    if (!flag1) {
        NSLog(@"nativeDataList表格创建失败");
    }
    
    //用户关联表格：订单
    NSString * sql_IndentInfoList =  @"create table if not exists IndentInfoList (id integer primary key autoincrement,indentID text)";
    
    BOOL flag2 = [_dataBase executeUpdate:sql_IndentInfoList];
    if (!flag2) {
        NSLog(@"IndentInfoList表格创建失败");
    }
    
    //用户关联表格：广告
    NSString * sql_AdverList =  @"create table if not exists AdverList (id integer primary key autoincrement,advertID text,userType text,advertURL text,time text)";
    
    BOOL flag3 = [_dataBase executeUpdate:sql_AdverList];
    if (!flag3) {
        NSLog(@"AdverList表格创建失败");
    }
    
}








/**
 查询语句：select * from 表名 where 条件子句 group by 分组字句 having ... order by 排序子句
 如：   select * from person
 select * from person order by id desc
 select name from person group by name having count(*)>1
 分页SQL与mysql类似，下面SQL语句获取5条记录，跳过前面3条记录
 select * from Account limit 5 offset 3 或者 select * from Account limit 3,5
 插入语句：insert into 表名(字段列表) values(值列表)。如： insert into person(name, age) values(‘传智’,3)
 更新语句：update 表名 set 字段名=值 where 条件子句。如：update person set name=‘传智‘ where id=10
 删除语句：delete from 表名 where 条件子句。如：delete from person  where id=10
 */
@end

