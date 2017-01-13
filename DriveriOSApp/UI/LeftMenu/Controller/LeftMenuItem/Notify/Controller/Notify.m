//
//  Notify.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/12.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "Notify.h"
#import "NotifyCell.h"
#import "NotifyModel.h"

@interface Notify ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arrayData;

@end

@implementation Notify

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - MATCHSIZE(128)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //去掉分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        // 设置 tableView 的额外滚动区域，防止被导航条盖住
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, MATCHSIZE(25), 0);

    }
    return _tableView;
}

-(NSMutableArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
}

#pragma mark - tableView代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NotifyModel *model = self.arrayData[indexPath.row];
    
    return model.height+MATCHSIZE(160);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    
    NotifyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NotifyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NotifyModel *model = self.arrayData[indexPath.row];
    
    cell.model = model;
    
    return cell;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"消息通知";
    
    [self loadData];
    
    [self creatTableView];

}

#pragma mark - 加载数据
-(void)loadData{
    //测试
    NSArray *array = @
    [
     @{@"title":@"重大消息",@"data":@"2016/12/12",@"content":@"广汽TOYOTA广州4S店车展主要车型:凯美瑞，汉兰达，致炫，雷凌，逸致。报名即获邮寄门票，购车即送950交强险，12月17-18广州国际采购中心举行。",},
     @{@"title":@"优惠出行",@"data":@"2016/12/20",@"content":@"广汽传祺GA5 PHEV，GAC五星安全车身结构，创新电力驱动技术的中高级舒适新能源车。油电双充能，里程无担忧!搭载世界先进电机技术和智控技术，带来全程超静音驾乘享受!",},
     @{@"title":@"私人定制",@"data":@"2016/12/22",@"content":@"广汽传祺GA5 PHEV",},
     @{@"title":@"无敌优惠卷",@"data":@"2016/12/23",@"content":@"创新电力驱动技术的中高级舒适新能源车。",},
     @{@"title":@"丽新特惠",@"data":@"2016/12/24",@"content":@"广汽传祺GA5油电双充能，里程无担忧!搭载世界先进电机技术和智控技术，带来全程超静音驾乘享受!",},
     @{@"title":@"免费坐车",@"data":@"2016/12/25",@"content":@"广汽传祺GA5 PHEV，GAC五星安全车身结构，创新电力驱动技术的中高级舒适新能源车。油电双充能，里程无担忧!搭载世界先进电机技术和智控技术，带来全程超静音驾乘享受!",},
     ];
    
    for (NSDictionary *dict in array) {
        NotifyModel *model = [[NotifyModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [self.arrayData addObject:model];
    }
}

#pragma mark - 创建表格视图
-(void)creatTableView{
    
    self.tableView.estimatedRowHeight = MATCHSIZE(200);
    
    [self.view addSubview:self.tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
