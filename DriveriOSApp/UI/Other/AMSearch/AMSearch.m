//
//  AMSearch.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/1.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "AMSearch.h"
#import "SearchFootView.h"

@interface AMSearch ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,AMapSearchDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/** 搜索栏*/
@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * arrayData;
@property (nonatomic,strong) NSMutableArray * historyDataArray;

//搜索
@property (nonatomic, strong) AMapSearchAPI *search;

/** 全屏透明层：点击取消第一响应 */
@property (nonatomic, strong) UIButton *screenView;



@end

@implementation AMSearch


-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(MATCHSIZE(110), MATCHSIZE(12), SCREEN_W - MATCHSIZE(130), MATCHSIZE(60))];
        _searchBar.placeholder = @"搜索";
        _searchBar.delegate = self;
        _searchBar.hidden = NO;
    }
    return _searchBar;
}

-(AMapSearchAPI *)search{
    if (!_search) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - StatusBar_H - self.navigationController.navigationBar.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
}

-(NSMutableArray *)historyDataArray{
    if (!_historyDataArray) {
        _historyDataArray = [NSMutableArray array];
    }
    return _historyDataArray;
}

-(UIView *)screenView{
    if (!_screenView) {
        _screenView = [UIButton buttonWithType:UIButtonTypeCustom];
        _screenView.frame = self.view.frame;
        _screenView.hidden = YES;
        _screenView.backgroundColor = [UIColor clearColor];
    }
    return _screenView;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

#pragma mark - tableView代理方法

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
    
    if(self.arrayData.count == 0){
        return cell;
    }
    
    id value = self.arrayData[indexPath.row];
    if ([value isKindOfClass:[AMLocationModel class]]) {
        AMLocationModel *model = value;
        cell.textLabel.text = model.name;
        cell.detailTextLabel.text = model.address;
        cell.imageView.image = [UIImage imageNamed:@"item"];
    }else{
        cell.textLabel.text = self.arrayData[indexPath.row];
        cell.detailTextLabel.text = @"";
        cell.imageView.image = [UIImage imageNamed:@"history"];
    }
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (self.arrayData.count > 0) {
        id value = self.arrayData[section];
        if ([value isKindOfClass:[NSString class]]) {
            return MATCHSIZE(60);
        }else{
            return 0;
        }
    }
    
    return 0;
}

#pragma mark - 尾部试图点击清除数据
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (self.arrayData.count > 0) {
        SearchFootView *cell = nil;
        
        id value = self.arrayData[section];
        if ([value isKindOfClass:[AMLocationModel class]]) {
            return cell;
        }
        
        cell = [[SearchFootView alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
        
        __weak typeof(self) weakSelf = self;
        [cell clearAllHistoryDataWithBlock:^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            
            //清除历史搜索数据
            [strongSelf.arrayData removeAllObjects];
            [CacheClass saveUserSearchHistoryWithArray:self.arrayData];
            [strongSelf.tableView reloadData];
            
        }];
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取消第一响应
    [self.searchBar resignFirstResponder];
    
    if(self.arrayData.count != 0){
        
        if ([self.arrayData[0] isKindOfClass:[NSString class]]) {
            //搜索
            self.searchBar.text = self.arrayData[indexPath.row];
            [self searchText:self.searchBar.text];
        }else{
            
            //保存／更新 相应数据
            AMLocationModel *model = self.arrayData[indexPath.row];
            
            if(_block){
                _block(model);
            }
            
            if (self.searchBar != nil) {
                _searchBar.hidden = YES;
                [_searchBar removeFromSuperview];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    //返选
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
}

-(void)getSearchResultWithAMSearchBlock:(AMSearchBlock)block{
    _block = block;
}


-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(leftOnclick:)];;
}
-(void)leftOnclick:(UIBarButtonItem *)itemBtn{
    if (self.searchBar != nil) {
        _searchBar.hidden = YES;
        [_searchBar removeFromSuperview];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatSearch];
    
    [self creatTableView];
    
    [self creatScreenView];
    
    [self loadHistory];
    
}
#pragma mark - 获取历史数据
-(void)loadHistory{
    
    [self.arrayData removeAllObjects];
    
    self.arrayData = [NSMutableArray arrayWithArray:[CacheClass getUserSearchHistory]];
    
    [self.tableView reloadData];
}
#pragma mark - 保存搜索历史纪录
-(void)saveSearchHistory{
    if (self.searchBar.text.length == 0 || self.searchBar.text == nil) {
        return;
    }
    NSArray *historyArray = [CacheClass getUserSearchHistory];
    NSMutableArray *arrHistory = [NSMutableArray arrayWithArray:historyArray];
    [arrHistory insertObject:self.searchBar.text atIndex:0];
    //保存历史纪录
    [CacheClass saveUserSearchHistoryWithArray:arrHistory];
}

#pragma mark - 创建透明层
-(void)creatScreenView{
    
    [self.screenView addTarget:self action:@selector(tapOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.screenView];
}
-(void)tapOnclick:(UIButton *)tap{
    
    self.screenView.hidden = YES;
    [self.searchBar resignFirstResponder];
    
}
#pragma mark - 搜索栏searchBar
-(void)creatSearch{
    
    [self.navigationController.navigationBar addSubview:self.searchBar];
    
}
#pragma mark 搜索栏searchBar代理方法
// 即将开始编辑
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    self.screenView.hidden = NO;
    //显示清除文字按钮
    self.searchBar.clearsContextBeforeDrawing = YES;
    
    return YES;
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchBar.text.length == 0 || searchBar.text == nil) {
        //加载搜索历史纪录
        [self loadHistory];
    }
    
    [self searchText:searchBar.text];
    
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    //保存搜索历史纪录
    [self saveSearchHistory];
    
}


// 点击键盘搜索按钮事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self searchText:searchBar.text];
    //保存搜索历史纪录
    [self saveSearchHistory];
    
    
}

#pragma mark - 表格视图tableView
-(void)creatTableView{
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}
#pragma mark - tableView空白时显示提示内容
//返回图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"userIMG"];
}
//返回一段文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"很抱歉，您还没有留下一丝痕迹";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f], NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


/** 搜索 */
-(void)searchText:(NSString *)keyWords{
    
    
    if (keyWords.length == 0) {
        return;
    }
    //关闭加载状态
    [self hideHud];
    //显示加载状态
    [self showHudInView:self.view hint:@"正在加载..."];
    
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [self.arrayData removeAllObjects];
    
    NSMutableString *cityCode = [CacheClass getAllDataFromYYCacheWithKey:CACHE_DATA][@"citycode"];
    if (cityCode == nil || cityCode.length == 0) {
        cityCode = [NSMutableString stringWithFormat:@"%@",Place_Default];//默认广州＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
    }
    
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords            = keyWords ;
    request.city                = cityCode;
    request.requireExtension    = YES;
    
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    
    [self.search AMapPOIKeywordsSearch:request];
    
}

-(void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    AMapPOISearchResponse *aResponse = (AMapPOISearchResponse *)response;
    
    if ( aResponse.pois == nil && aResponse.pois.count == 0) {
        return ;
    }
    
    //有数据，关闭加载状态
    [self hideHud];
    
    [self.arrayData removeAllObjects];
    [aResponse.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop)
     {
         AMLocationModel *model = [[AMLocationModel alloc] init];
         model.latitude = [NSString stringWithFormat:@"%f",obj.location.latitude];
         model.longitude = [NSString stringWithFormat:@"%f",obj.location.longitude];
         model.address = obj.address;
         model.name = obj.name;
         
         [self.arrayData addObject:model];
         
     }];
    
    [self.tableView reloadData];

}


@end
