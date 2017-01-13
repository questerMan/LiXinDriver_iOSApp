//
//  Setup.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/28.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "Setup.h"
#import "SetupCell.h"
#import "Safety.h"

@interface Setup ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arrayData;

@property (nonatomic, strong) UIButton *cancleLoginBtn;
@end

@implementation Setup

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = MATCHSIZE(80);
        _tableView.sectionHeaderHeight = MATCHSIZE(30);
        _tableView.sectionFooterHeight = MATCHSIZE(0);
        // 设置 tableView 的额外滚动区域，防止被导航条盖住
        _tableView.contentInset = UIEdgeInsetsMake(-MATCHSIZE(35), 0, 0, 0);

    }
    return _tableView;
}

-(NSMutableArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
}

-(UIButton *)cancleLoginBtn{
    if (!_cancleLoginBtn) {
        _cancleLoginBtn = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(0), SCREEN_H - MATCHSIZE(100), SCREEN_W, MATCHSIZE(80)) Title:@"退出登录" backGround:[UIColor grayColor] tintColor:[UIColor whiteColor] cornerRadius:0];
    }
    return _cancleLoginBtn;
}

#pragma mark - tableView代理方法
//组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
//行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 3;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return MATCHSIZE(90);
    }
    return MATCHSIZE(80);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        static NSString *cell_ID = @"cell_ID";
        
        SetupCell *setupCell = [tableView dequeueReusableCellWithIdentifier:cell_ID];
        
        if (!setupCell) {
            setupCell = [[SetupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_ID];
        }
        NSArray *array = @[@{@"title":@"实时路况",@"subTitle":@"打开后地图将显示实时路况"},@{@"title":@"声音提示",@"subTitle":@"打开后将以声音为你播报订单情况"},@{@"title":@"美颜相机",@"subTitle":@"打开后拍照时讲直接使用"}];
        [setupCell changeTitle:array[indexPath.row]];
        return setupCell;
    }
    
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    NSArray *arr = @[@[@{@"title":@"账号安全"},@{@"title":@"紧急求助"}],@[],@[@{@"title":@"意见与反馈"},@{@"title":@"关于丽新"}]];
    cell.textLabel.text = arr[indexPath.section][indexPath.row][@"title"];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}
//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            Safety *safety = [[Safety alloc] init];
            [self.navigationController pushViewController:safety animated:YES];
        }
    }
  
    //反选
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [self creatNavigationBackItemBtn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatTableView];
    
    [self creatCancleLoginBtn];
    
    
}

-(void)creatCancleLoginBtn{
    [self.view addSubview:self.cancleLoginBtn];
    
    [self.cancleLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(-MATCHSIZE(20));
        make.height.offset(MATCHSIZE(80));
    }];
    
    [[self.cancleLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //退出登录
        [self showHint:@"退出登录"];
    }];
}

-(void)creatTableView{
    [self.view addSubview:self.tableView];
}

@end
