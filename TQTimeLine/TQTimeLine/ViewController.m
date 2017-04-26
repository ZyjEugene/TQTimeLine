//
//  ViewController.m
//  TQTimeLine
//  swift版本的美团的订单详情页面时间线效果
//  地址：http://www.jianshu.com/p/2504f2989556#
//  比较喜欢这样简洁的效果，所以用OC仿写了下，逻辑没动，完全照抄
//  Created by Eugene on 2017/4/25.
//  Copyright © 2017年 Eugene. All rights reserved.
//

#import "ViewController.h"
#import "TQTimeLineCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;
    
@property (nonatomic, assign) NSInteger leadingSpaceOfLines;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _items = @[@"Eugene",@"Eugene_iOS",@"Eugene's demo",@"Eugene write demo every night"];
    
    [self initPageView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initPageView {
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TQTimeLineCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TQTimeLineCell class])];
    [self.view addSubview:self.tableView];
  
    [self.view addSubview:self.topLine];
    [self.view addSubview:self.bottomLine];
}
    
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TQTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TQTimeLineCell class])];
    
    cell.titleLabel.text = _items[indexPath.row];
    
    cell.bottomLine.backgroundColor = indexPath.row == (_items.count-1) ? [UIColor grayColor] : cell.topLine.backgroundColor;
    
    return cell;
}
    
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TQTimeLineCell *_cell = (TQTimeLineCell *)cell;
    self.topLine.backgroundColor = _cell.topLine.backgroundColor;
    
    self.leadingSpaceOfLines = [_cell convertPoint:_cell.topLine.frame.origin toView:self.view].x;
    [self observerScrollView:tableView];
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
   
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self observerScrollView:scrollView];
}

#pragma mark - private method
- (void)observerScrollView:(UIScrollView *)scrollView {
    
    self.topLine.frame = CGRectMake(self.leadingSpaceOfLines+0.5, 0, 1, -scrollView.contentOffset.y);
    
    NSInteger yOffset = scrollView.frame.size.height-scrollView.contentSize.height+scrollView.contentOffset.y;
    
    self.bottomLine.frame = CGRectMake(self.leadingSpaceOfLines+0.5, self.view.frame.size.height-yOffset, 1, self.view.frame.size.height);
}
    
#pragma mark - getter
- (UITableView *)tableView {

    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = self.view.frame;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
   
- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [UIView new];
    }
    return _topLine;
}
    
- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = [UIColor grayColor];
    }
    return _bottomLine;
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
