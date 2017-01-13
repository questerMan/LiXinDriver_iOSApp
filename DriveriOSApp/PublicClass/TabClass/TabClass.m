//
//  TabClass.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/29.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//
#define collection_H self.frame.size.height
#define collection_W SCREEN_W

#define cell_H self.frame.size.height
#define cell_W SCREEN_W/5
#import "TabClass.h"
#import "TabCell.h"


@interface TabClass ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *arrayData;

@end

@implementation TabClass

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setItemSize:CGSizeMake(cell_W, cell_H)];//设置cell的尺寸
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake( 5,0,5,0);//设置其边界
        //确定水平方向
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, collection_W, collection_H+10) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor blackColor];
        //注册collectionView cell
        [_collectionView registerClass:[TabCell class] forCellWithReuseIdentifier:@"cellID"];
    }
    return _collectionView;
    
}

-(NSMutableArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
}


#pragma mark - collectionView dataSource Or delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrayData.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TabCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.isSelectItem = YES;
    }
    cell.model = self.arrayData[indexPath.row];
    cell.tag = 99 + indexPath.row;
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self changeAllCellTextColor];
    
    TabCell *cell = (TabCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.lable.textColor = TAB_SELECT_TEXTCOLOR;
    cell.lable.backgroundColor = TAB_SELECT_BG;
    
    TabModel *model = self.arrayData[indexPath.row];
    
    if (_Block != nil) {
        _Block(model.type);
    }
    
    //    NSLog(@"%s",__FUNCTION__);
}


-(void)changeAllCellTextColor{
    
    for ( int i = 0; i < self.arrayData.count; i++) {
        TabCell *cell = (TabCell *)[self viewWithTag:99+i];
        
        cell.lable.textColor = TAB_NOTSELECT_TEXTCOLOR;
        cell.lable.backgroundColor = TAB_NOTSELECT_BG;
        
    }
    
}

-(void)didSelectTabWithBlock:(TabClassBlock)block{
    _Block = block;
}

#pragma mark - 获取tab数据
-(void)getTabTitleDataWithArray:(NSMutableArray *)arrayData{

    //获取数据
    self.arrayData = arrayData;
    //刷行
    [self.collectionView reloadData];

}

-(void)creatCollectionView{
    
    [self addSubview:self.collectionView];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatCollectionView];
        
    }
    return self;
}





@end
