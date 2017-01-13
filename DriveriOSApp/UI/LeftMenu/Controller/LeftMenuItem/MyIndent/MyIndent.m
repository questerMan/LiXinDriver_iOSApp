//
//  MyIndent.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/11.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "MyIndent.h"
#import "MyIndentModel.h"
#import "MyIndentCell.h"

@interface MyIndent ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arrayData;

@property (nonatomic, strong) UIView *footView;

@property (nonatomic, strong) UILabel *totalLabel;

@property (nonatomic, strong) UILabel *reservationLabel;

@property (nonatomic, strong) UILabel *instantLabel;

@end

@implementation MyIndent

-(UILabel *)totalLabel{
    if (!_totalLabel) {
        _totalLabel = [FactoryClass labelWithFrame:CGRectMake((SCREEN_W/6)+MATCHSIZE(20), 0, SCREEN_W/6, MATCHSIZE(80)) TextColor:[UIColor orangeColor] fontBoldSize:MATCHSIZE(28)];
    }
    return _totalLabel;
}
-(UILabel *)instantLabel{
    if (!_instantLabel) {
        _instantLabel = [FactoryClass labelWithFrame:CGRectMake((SCREEN_W/6)*3+MATCHSIZE(20), 0, SCREEN_W/6, MATCHSIZE(80)) TextColor:[UIColor orangeColor] fontBoldSize:MATCHSIZE(28)];
    }
    return _instantLabel;
}

-(UILabel *)reservationLabel{
    if (!_reservationLabel) {
        _reservationLabel = [FactoryClass labelWithFrame:CGRectMake((SCREEN_W/6)*5+MATCHSIZE(20), 0, SCREEN_W/6, MATCHSIZE(80)) TextColor:[UIColor orangeColor] fontBoldSize:MATCHSIZE(28)];
    }
    return _reservationLabel;
}



-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(MATCHSIZE(0), MATCHSIZE(0), SCREEN_W, SCREEN_H - MATCHSIZE(200)) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = MATCHSIZE(300);
        UIEdgeInsets contentInset = self.tableView.contentInset;
        contentInset.top = 0;
        [_tableView setContentInset:contentInset];
        
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
        // 设置 tableView 的额外滚动区域，防止被导航条盖住
        _tableView.contentInset = UIEdgeInsetsMake(-MATCHSIZE(30), 0, -MATCHSIZE(30), 0);
        //去掉分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSMutableArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
}

-(UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(MATCHSIZE(0), SCREEN_H - MATCHSIZE(200) , SCREEN_W, MATCHSIZE(80))];
    }
    return _footView;
}

#pragma mark - tableView代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.arrayData.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (self.arrayData.count > 0) {
        return MATCHSIZE(30);
    }
    
    return MATCHSIZE(0);
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.arrayData.count > 0) {
        MyIndentModel *model = self.arrayData[section];
        return model.state;
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    
    MyIndentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MyIndentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [self totalCountWithArray:self.arrayData];
    }
    MyIndentModel *model = self.arrayData[indexPath.section];

    cell.model = model;
    return cell;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    
    [self creatTableView];
    
    [self creatFootView];
    
}
#pragma mark - 获取数据
-(void)loadData{
    
    //测试
    for(int i = 0; i < 5; i ++){
        MyIndentModel *model = [[MyIndentModel alloc] init];
        if (i%2 == 0) {
            model.state = @"未完成订单";
            model.type = @"预约单";
        }else{
            model.state = @"已完成订单";
            model.type = @"即时单";
        }
        model.timeData = @"2016/12/15  10:00";
        model.startPlace = @"广州天环广场";
        model.endPlace = @"广州天河区石牌桥";
        [self.arrayData addObject:model];
    }

}

#pragma mark - 创建表格视图
-(void)creatTableView{
    
    [self.view addSubview:self.tableView];
    
}
#pragma mark - 计算总数
-(void)totalCountWithArray:(NSMutableArray *)array{
   
    int totalCount = 0;
    int instantCount = 0;
    int reservationCount = 0;

    for (MyIndentModel *model in array) {
        if ([model.type isEqualToString:@"即时单"]) {
            instantCount ++;
        }else if ([model.type isEqualToString:@"预约单"]){
            reservationCount ++;
        }
        totalCount ++;
    }
    
    self.totalLabel.text = [NSString stringWithFormat:@"%d",totalCount];
    self.instantLabel.text = [NSString stringWithFormat:@"%d",instantCount];
    self.reservationLabel.text = [NSString stringWithFormat:@"%d",reservationCount];
}

#pragma mark - 创建底部视图
-(void)creatFootView{
    self.footView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.footView];
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.offset(MATCHSIZE(80));
    }];
    
    UILabel *total = [FactoryClass labelWithFrame:CGRectMake(MATCHSIZE(20), 0, SCREEN_W/6, MATCHSIZE(80)) TextColor:[UIColor whiteColor] fontBoldSize:MATCHSIZE(28)];
    total.text = @"合计订单:";
    [self.footView addSubview:total];
    
    
    
    [self.footView addSubview:self.totalLabel];
    
    UILabel *instant = [FactoryClass labelWithFrame:CGRectMake((SCREEN_W/6)*2+MATCHSIZE(20), 0, SCREEN_W/6, MATCHSIZE(80)) TextColor:[UIColor whiteColor] fontBoldSize:MATCHSIZE(28)];
    instant.text = @"即时单:";
    [self.footView addSubview:instant];
    
    [self.footView addSubview:self.instantLabel];
    
    UILabel *reservation = [FactoryClass labelWithFrame:CGRectMake((SCREEN_W/6)*4+MATCHSIZE(20), 0, SCREEN_W/6, MATCHSIZE(80)) TextColor:[UIColor whiteColor] fontBoldSize:MATCHSIZE(28)];
    reservation.text = @"预约单:";
    [self.footView addSubview:reservation];
    
    [self.footView addSubview:self.reservationLabel];
    
}

@end
