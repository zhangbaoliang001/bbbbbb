//
//  ViewController.m
//  瀑布流
//
//  Created by mac on 16/9/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewLayout.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionViewLayout *layout;

@property (nonatomic,strong)NSMutableArray *heightArr;

@property (nonatomic,strong)UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
 
}

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
    
}

-(NSMutableArray *)heightArr{
    if (!_heightArr) {
        //随机生成高度
        NSMutableArray *arr = [NSMutableArray array];
        for (int i=0; i<100; i++) {
            [arr addObject:@(arc4random()%50+80)];
        }
        _heightArr = [arr copy];
    }
    return _heightArr;
}

-(UICollectionViewLayout *)layout{
    if (!_layout) {
        _layout = [[CollectionViewLayout alloc] initWithItemsHeightBlock:^CGFloat(NSIndexPath *indexPath) {
            return [self.heightArr[indexPath.item]floatValue];
        }];
    }
    return _layout;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.heightArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    return cell;
}




@end
