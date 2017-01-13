//
//  LYKLeftMenuMain.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/26.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "LeftMenuMain.h"
#import "LeftMainHeadView.h"


@interface LeftMenuMain ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayData;

@end

@implementation LeftMenuMain

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(MATCHSIZE(0), MATCHSIZE(0), MATCHSIZE(550), VIEW_H) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = MATCHSIZE(80);
    }
    return _tableView;
}

-(NSMutableArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
}
-(void)viewWillAppear:(BOOL)animated{
    
    
}
-(void)loadData{
    
    [self.arrayData addObjectsFromArray:@[@"我的信息",@"我的订单",@"消息通知",@"司机指南",@"离线地图",@"客服热线"]];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
    
    [self creatTableView];
    
    [self versionInfo];
    
    
}
-(void)creatTableView{
        
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.scrollEnabled = NO; //设置tableview 不能滚动
    
    self.tableView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.tableView];
    
}

-(void)versionInfo{
    UILabel *versionInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_H - MATCHSIZE(40), MATCHSIZE(550), MATCHSIZE(30))];
    versionInfo.textAlignment = NSTextAlignmentCenter;
    versionInfo.font = [UIFont systemFontOfSize:MATCHSIZE(25)];
    versionInfo.textColor = [UIColor whiteColor];
    versionInfo.text = @"丽新专车App版本2.0";
    [self.view addSubview:versionInfo];
}

#pragma mark tableView代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayData.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    cell.backgroundColor = [UIColor blackColor];
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = self.arrayData[indexPath.row];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.imageView.image = [UIImage imageNamed:@"item"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return MATCHSIZE(200.0);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *cell = @"headCell";
    
    LeftMainHeadView *headCell = [tableView dequeueReusableCellWithIdentifier:cell];
    
    if (headCell == nil) {
        headCell = [[LeftMainHeadView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
    }
    
    return headCell;

}
//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UINavigationController *messageNac = [[UINavigationController alloc] initWithRootViewController:[[MyMessage alloc] init]];
    
    UINavigationController *offlineNac = [[UINavigationController alloc] initWithRootViewController:[[OfflineDetailViewController alloc] init]];

    UINavigationController *myIndentNac = [[UINavigationController alloc] initWithRootViewController:[[MyIndent alloc] init]];
    
    UINavigationController *notifyNac = [[UINavigationController alloc] initWithRootViewController:[[Notify alloc] init]];

    UINavigationController *driverGuideNac = [[UINavigationController alloc] initWithRootViewController:[[DriverGuide alloc] init]];

    
    switch (indexPath.row) {
        case 0:
            [self presentFromViewController:self andToViewController:messageNac andAnimated:YES];
            break;
            
        case 1:
            [self presentFromViewController:self andToViewController:myIndentNac andAnimated:YES];
            break;
        case 2:
            [self presentFromViewController:self andToViewController:notifyNac andAnimated:YES];
            break;
            
        case 3:
            [self presentFromViewController:self andToViewController:driverGuideNac andAnimated:YES];
            break;
        case 4:
            [self presentFromViewController:self andToViewController:offlineNac andAnimated:YES];
            break;
        case 5:
            NSLog(@"-------------5");
            
            break;
            
        default:
            break;
    }
    
   //测试**********
    if (indexPath.row == 5) {
        
        AlertView *alert = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeIndentAlert];
        [alert alertViewShow];
        
    }
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];

}



@end
