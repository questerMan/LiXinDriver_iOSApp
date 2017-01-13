//
//  IndentPublicViewTools.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/29.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "IndentPublicViewTools.h"



@interface IndentPublicViewTools()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation IndentPublicViewTools

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(MATCHSIZE(0), MATCHSIZE(90),SCREEN_W, SCREEN_H - MATCHSIZE(90+44)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.hidden = YES;
        _tableView.y = -(SCREEN_H - MATCHSIZE(90+44));
    }
    return _tableView;
}

-(NSMutableArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
}

-(UITextField *)seachTextF{
    if (!_seachTextF) {
        _seachTextF = [[UITextField alloc] init];
        _seachTextF.delegate = self;
        _seachTextF.text = nil;
        _seachTextF.frame = CGRectMake(MATCHSIZE(60), MATCHSIZE(100), SCREEN_W - MATCHSIZE(120), MATCHSIZE(60));
        _seachTextF.placeholder = @"查询地点、公交、地铁";
        [_seachTextF setValue:[UIColor orangeColor] forKeyPath:@"_placeholderLabel.textColor"];//修改颜色
        _seachTextF.textAlignment = NSTextAlignmentCenter;
        _seachTextF.textColor = [UIColor orangeColor];
        _seachTextF.backgroundColor = [UIColor whiteColor];
        _seachTextF.layer.cornerRadius = MATCHSIZE(5);
        _seachTextF.layer.masksToBounds = YES;
        _seachTextF.hidden = YES;

    }
    return _seachTextF;
}

-(UIButton *)startNavigation{
    if (!_startNavigation) {
        _startNavigation = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(40),SCREEN_H - MATCHSIZE(60) - MATCHSIZE(20) - StatusBar_H -MATCHSIZE(100), (SCREEN_W - MATCHSIZE(40)*3)/2, MATCHSIZE(60)) Title:@"开始导航" backGround:[UIColor grayColor] tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(8)];
        _startNavigation.hidden = YES;
    }
    return _startNavigation;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(40)*2 + (SCREEN_W - MATCHSIZE(40)*3)/2,SCREEN_H - MATCHSIZE(60) - MATCHSIZE(20) - StatusBar_H -MATCHSIZE(100), (SCREEN_W - MATCHSIZE(40)*3)/2, MATCHSIZE(60)) Title:@"取消" backGround:[UIColor grayColor] tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(8)];
        _cancelBtn.hidden = YES;
    }
    return _cancelBtn;
}
-(UIButton *)acceptIndentBtn{
    if (!_acceptIndentBtn) {
        _acceptIndentBtn = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(40),SCREEN_H - MATCHSIZE(60) - MATCHSIZE(20) - StatusBar_H -MATCHSIZE(100), (SCREEN_W - MATCHSIZE(40)*2), MATCHSIZE(60)) Title:@"接单" backGround:[UIColor grayColor] tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(8)];
        _acceptIndentBtn.hidden = YES;
    }
    return _acceptIndentBtn;

}

-(InstantHeadView *)instantHeadView{
    if (!_instantHeadView) {
        _instantHeadView = [[InstantHeadView alloc] initWithFrame:CGRectMake(MATCHSIZE(20), MATCHSIZE(90), SCREEN_W - MATCHSIZE(40), MATCHSIZE(140))];
        _instantHeadView.layer.cornerRadius = MATCHSIZE(8);
        _instantHeadView.layer.masksToBounds = YES;
        _instantHeadView.hidden = YES;
    }
    return _instantHeadView;
}

/** 单例 */
+ (IndentPublicViewTools *)shareInstance{
    
    static dispatch_once_t onceToken;
    static IndentPublicViewTools * shareTools = nil;
    dispatch_once(&onceToken, ^{
        shareTools = [[IndentPublicViewTools alloc]init];
    });
    return shareTools;
}


#pragma mark - 等单
-(void)addWaitIndentWithIndent:(UIViewController *)indent{
    
    [indent.view addSubview:self.seachTextF];
    
    [self.startNavigation addTarget:self action:@selector(pushNavigation:) forControlEvents:UIControlEventTouchUpInside];
    //创建导航按钮
    [indent.view addSubview:self.startNavigation];
    
    //创建取消按钮
    [indent.view addSubview:self.cancelBtn];
    
    [self buttonOfIndent];

}
//开始导航 点击事件
-(void)pushNavigation:(UIButton *)btn{
    
    if (_navigationMapBlock) {
        _navigationMapBlock();
    }
    
}
-(void)buttonOfIndent{
    //开始导航 点击事件
//    [[self.startNavigation rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//
//    }];
    
    //取消按钮 点击事件
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        self.startNavigation.hidden = YES;
        self.seachTextF.text = @"";
        if(_clearRouteBlock){
            _clearRouteBlock();
        }
        
    }];
    
    //如果seachTextF有值时显示导航按钮
    [[[self.seachTextF rac_textSignal] filter:^BOOL(id value) {
        NSString *text = value;
        return text.length > 0 ;
    }] subscribeNext:^(id x) {
        self.startNavigation.hidden = NO;
        self.cancelBtn.hidden = NO;
    }];
    
    //如果seachTextF没有值时显示导航按钮
    [[[self.seachTextF rac_textSignal] filter:^BOOL(id value) {
        NSString *text = value;
        return text.length == 0 ;
    }] subscribeNext:^(id x) {
        self.startNavigation.hidden = YES;
        self.cancelBtn.hidden = YES;
    }];
}



#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.seachTextF resignFirstResponder];
    //跳转到搜索页面
    if (_searchBlock != nil) {
        _searchBlock();
    }
    
}
-(void)pusToSearchWithSearchBlock:(IndentPublicViewToolsPusToSearchBlock)searchBlock{
    _searchBlock = searchBlock;
}
-(void)clearRouteWithBlock:(IndentPublicViewToolsPusOfClearRouteBlock)clearRouteBlock{
    _clearRouteBlock = clearRouteBlock;
}

-(void)pusToNavigationMapWithNavigationMapBlock:(IndentPublicViewToolsPusToNavigationMapBlock) navigationMapBlock{
    _navigationMapBlock = navigationMapBlock;
}
#pragma mark - 隐藏等单页面的view
-(void)hideWaitIndentAllView{
    
    self.seachTextF.hidden = YES;
    self.startNavigation.hidden = YES;
    self.cancelBtn.hidden = YES;
    
}
#pragma mark - 显示等单页面的view
-(void)showWaitIndentAllView{
    
    self.seachTextF.hidden = NO;
    
}


#pragma mark - 即时单
-(void)addInstantIndentWithIndent:(UIViewController *)indent{
    
    [indent.view addSubview:self.instantHeadView];
    
    [indent.view addSubview:self.acceptIndentBtn];
    
    [[self.acceptIndentBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self showHint:@"接单"];
        
    }];
    
}
#pragma mark - 隐藏即时单页面的view
-(void)hideInstantIndentAllView{

    self.instantHeadView.hidden = YES;
    
    self.acceptIndentBtn.hidden = YES;

}
#pragma mark - 显示即时单页面的view
-(void)showInstantIndentAllView{
    
    [UIView animateWithDuration:0.8 animations:^{
        
    } completion:^(BOOL finished) {
        
        self.instantHeadView.hidden = NO;
        
        self.acceptIndentBtn.hidden = NO;

        
    }];
    
}

#pragma mark - 预约单
-(void)addReservationIndentWithIndent:(UIViewController *)indent{
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = MATCHSIZE(310);
    self.tableView.backgroundColor = [UIColor clearColor];
    [indent.view addSubview:self.tableView];
    
    
    
}
#pragma mark - 预约单tableView代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count+2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    
    ReservationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ReservationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self showHint:@"页面未搭建完成"];

}
#pragma mark - 隐藏预约单页面的view
-(void)hideReservationIndentAllView{
    
    [UIView animateWithDuration:0.8 animations:^{
        self.tableView.y = -(SCREEN_H - MATCHSIZE(90+44));
        
    } completion:^(BOOL finished) {
        self.tableView.hidden = YES;

    }];
}
#pragma mark - 显示预约单页面的view
-(void)showReservationIndentAllView{

    self.tableView.hidden = NO;
    
    [UIView animateWithDuration:0.8 animations:^{
        self.tableView.y = MATCHSIZE(90);

    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - tab点击显示相应的View
-(void)implementAllMethodWithIndent:(int)type andIndent:(UIViewController *)indent{
    // 点击取消第一响应
    [self.seachTextF resignFirstResponder];
    
    switch (type) {
        case 0:
            //显示
            [self addWaitIndentWithIndent:indent];//已经加载
            [self showWaitIndentAllView];
            //隐藏
            [self hideReservationIndentAllView];
            [self hideInstantIndentAllView];
            break;
        case 1:
            //显示
            [self addInstantIndentWithIndent:indent];
            [self showInstantIndentAllView];
            //隐藏
            [self hideReservationIndentAllView];
            [self hideWaitIndentAllView];
            break;
        case 2:
            //显示
            [self addReservationIndentWithIndent:indent];
            [self showReservationIndentAllView];
            //隐藏
            [self hideWaitIndentAllView];
            [self hideInstantIndentAllView];
            break;
            
        default:
            [self hideWaitIndentAllView];
            [self hideInstantIndentAllView];
            [self hideReservationIndentAllView];
            break;
    }
}


@end
