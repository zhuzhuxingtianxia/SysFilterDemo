//
//  StackFilterController.m
//  FilterDemo
//
//  Created by Jion on 2017/4/6.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

#import "StackFilterNameController.h"

@interface StackFilterNameController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray  *filterNames;

@end

@implementation StackFilterNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"复合滤镜";
    // Do any additional setup after loading the view.
    [self showTableView];
}
-(void)showTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
    
}
#pragma mark--UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filterNames.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.filterNames[indexPath.row][@"title"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        id vc = [[NSClassFromString(@"StackFilterController") alloc] init];
        [vc setValue:@YES forKey:@"isEAGL"];
        [self.navigationController pushViewController:vc animated:YES];

    }else if (indexPath.row == 1){
        id vc = [[NSClassFromString(@"DigOutController") alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(NSArray*)filterNames{
    if (!_filterNames) {
        _filterNames = @[@{@"title":@"像素点,CoreGraphics,CoreImage比较"},@{@"title":@"简单抠图"},@{@"title":@"美白"},@{@"title":@"美颜"},@{@"title":@"图片合并"},@{@"title":@"图片添加文字"},@{@"title":@"终极PS"},];
    }
    return _filterNames;
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
