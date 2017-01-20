//
//  ViewController.m
//  下拉刷新动画
//
//  Created by Rainy on 2017/1/20.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "ViewController.h"
#import "LYLProgressView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)LYLProgressView *hud;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DomeCell"];
    [self.view addSubview:tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DomeCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.hud.type != 1) {
        
        CGFloat progress = -((scrollView.contentOffset.y)/100);
        
        [self.hud updateProgress:progress];
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.hud.currentProgress >= 1 && self.hud.type == 2) {
        
        [self.hud setType:1];
        [self reloadDatas];
    }
}
-(void)reloadDatas
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.hud hide];
        self.hud.type = 2;
    });
}
-(LYLProgressView *)hud
{
    if (!_hud) {
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"你财富.jpg"]];
        img.backgroundColor = [UIColor lightGrayColor];
        _hud = [[LYLProgressView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-15, 25, 30, 30) withType:2 OnView:img];
        [self.view addSubview:_hud];
        [_hud show];
    }
    return _hud;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
