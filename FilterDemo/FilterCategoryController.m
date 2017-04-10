//
//  FilterCategoryController.m
//  FilterDemo
//
//  Created by Jion on 2017/4/5.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

#import "FilterCategoryController.h"

@interface FilterCategoryController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray  *filterNames;
@property(nonatomic,strong)UITableView  *tableView;
@end

@implementation FilterCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *switchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    switchBtn.bounds = CGRectMake(0, 0, 60, 40);
    [switchBtn setTitle:@"全部" forState:UIControlStateNormal];
    [switchBtn addTarget:self action:@selector(transformBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:switchBtn];
    
    self.title = self.filterCategoryName;
    self.filterNames = [CIFilter filterNamesInCategory:self.filterCategoryName];
    [self showTableView];
}

-(void)transformBtnAction:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setTitle:@"分类" forState:UIControlStateSelected];
        self.title = @"全部滤镜";
        self.filterNames = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    }else{
       [sender setTitle:@"全部" forState:UIControlStateNormal];
       self.title = self.filterCategoryName;
       self.filterNames = [CIFilter filterNamesInCategory:self.filterCategoryName];
    }
    
    [self.tableView reloadData];
}

-(void)showTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    
}

#pragma mark--UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filterNames.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%@",indexPath.row,self.filterNames[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id vc = [[NSClassFromString(@"SysFilterController") alloc] init];
    [vc setValue:self.filterNames[indexPath.row] forKey:@"filterName"];
    [vc setValue:@YES forKey:@"isEAGL"];
    [self.navigationController pushViewController:vc animated:YES];
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
