//
//  TableViewController.m
//  Table
//
//  Created by 金贝恩资本 on 2018/3/24.
//  Copyright © 2018年 金贝恩资本. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@property(nonatomic,strong)DataArray *openTemp;
@end

@implementation TableViewController
-(NSMutableArray*)resultArray{
    if (!_resultArray) {
        _resultArray=[NSMutableArray array];
    }
    return _resultArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   _openTemp=[[DataArray alloc]init];
    [_openTemp initData];
    _resultArray=_openTemp.resultArray;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView=[UIView new];
    [self.view addSubview:self.tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString*identifier=@"xx";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSInteger row = indexPath.row;
    Open *model=_resultArray[row];
    if (model.level==2) {
        cell.textLabel.text=[NSString stringWithFormat:@"        %@",model.title];
    }else if (model.level==3) {
        cell.textLabel.text=[NSString stringWithFormat:@"            %@",model.title];
    }else if(model.level==1){
        cell.textLabel.text=[NSString stringWithFormat:@"    %@",model.title];
    }else{
         cell.textLabel.text=[NSString stringWithFormat:@"%@",model.title];
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    Open *model = _resultArray[row];
    
    if (model.isOpen) {
        //原来是展开的，现在要收起,则删除model.detailArray存储的数据
        [_openTemp deleteObjectWithDataArray:model.detailArray count:0];
    }
    else {
        if (model.detailArray.count > 0) {
            //原来是收起的，现在要展开，则需要将同层次展开的收起，然后再展开
            [_openTemp compareSameLevelWithModel:model row:row];
        }
        else {
            //点击的是最后一层数据，跳转到别的界面
            NSLog(@"最后一层");
        }
    }
    
    model.isOpen = !model.isOpen;
    
    //滑动到屏幕顶部
    for (int i = 0; i < _resultArray.count; i++) {
        Open *openModel = _resultArray[i];
        
        if (openModel.isOpen && openModel.level == 0) {
            //将点击的cell滑动到屏幕顶部
            NSIndexPath *selectedPath = [NSIndexPath indexPathForRow:i inSection:0];
            [tableView scrollToRowAtIndexPath:selectedPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
    
    [tableView reloadData];
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
