//
//  ViewController.m
//  TableViewTopUnlimitScroll
//
//  Created by 雷祥 on 2017/6/8.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) CustomTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
//@property (nonatomic, assign) CGSize collectionViewSize;
@property (nonatomic, assign) NSInteger max;
@property (nonatomic, assign) NSInteger min;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:(UITableViewStylePlain)];
    //    tableView.delegate = self;
    //    tableView.dataSource = self;
    //    self.collectionViewSize = self.view.frame.size;

    [self.view addSubview:self.tableView];
    _min = 10;
    _max = 10;

    for (NSInteger i = 10; i < 70; i++) {
        if (i > _max) {
            _max = i;
        }

        if (i < _min) {
            _min = i;
        }
        [self.dataSource addObject:[NSNumber numberWithInteger:i]];
    }


    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加数据" style:(UIBarButtonItemStylePlain) target:self action:@selector()];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

}

- (void)addHeaderData {
    NSLog(@"添加数据");
    //    for (NSInteger i = _max + 1; i < _max + 10; i++) {
    //
    //        [self.dataSource addObject:[NSNumber numberWithInteger:i]];
    //    }

    //    NSLog(@"contentOffset:%@",NSStringFromCGPoint(self.tableView.contentOffset));
    for (NSInteger i = _min - 1; i > _min - 11; i--) {
        [self.dataSource insertObject:[NSNumber numberWithInteger:i] atIndex:0];
    }

    //    if (self.dataSource.count > 200) {
    //        [self.dataSource removeObjectsInRange:NSMakeRange(200, self.dataSource.count - 200)];
    //    }
    //    _max += 10;
    _min -= 10;
    self.tableView.contentOffset = CGPointMake(0, 150);
    [self.tableView reloadData];
}

- (CustomTableView *)tableView {
    if (!_tableView) {
        _tableView = [[CustomTableView alloc] initWithFrame:CGRectMake(0, 0, 375, 668) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        __weak typeof(self)weakSelf = self;
        _tableView.layoutSubViewsBlock = ^(BOOL isUp, CGFloat contentOffsetY){
            if (contentOffsetY < 20) { //自动加载
                [weakSelf addHeaderData];
            }
        };
    }

    return _tableView;
}


//- (UICollectionView *)collectionView {
//    if (!_collectionView) {
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        CGFloat width = (self.collectionViewSize.width - 10 * 2) / 7 - 10 * 2;
//        flowLayout.itemSize = CGSizeMake(width, width * 1.5);
//        flowLayout.minimumLineSpacing = 30;
//        flowLayout.minimumInteritemSpacing = 10;
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.collectionViewSize.width , self.collectionViewSize.height - 64) collectionViewLayout:flowLayout];
//    }
//
//    return _collectionView;
//}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }

    return _dataSource;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd向下滑动,无限滚动",[self.dataSource[indexPath.row] integerValue]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


@end
