//
//  ViewController.m
//  JSON数据解析
//
//  Created by zh dk on 2017/8/29.
//  Copyright © 2017年 zh dk. All rights reserved.
//

#import "ViewController.h"
#import "BookModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [self parseData];
}

//获取组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//获取每组行数
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}
//创建单元格
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strID = @"ID";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strID];
    }
    
    //获取对应的图书数据
    BookModel *book = [_arrayData objectAtIndex:indexPath.row];
    cell.textLabel.text = book._bookName;
    cell.detailTextLabel.text = book._price;
    return cell;
    
}
//解析数据
-(void) parseData
{
    //获取json文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"" ofType:@"json"];
    //加载json文件为二进制文件
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    //字典对象解析
    NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //判断解析数据是不是字典
    if ([dicRoot isKindOfClass:[NSDictionary class]]) {
        //开始解析数据
        _arrayData = [[NSMutableArray alloc] init];
        //解析跟数据
        NSArray *arrayEnter = [dicRoot objectForKey:@"entry"];
        for (int i =0; i<arrayEnter.count; i++) {
            NSDictionary *dicBook = [arrayEnter objectAtIndex:i];
            //获取书籍名字对象
            NSDictionary *bookNameDic = [dicBook objectForKey:@"title"];
            NSString *bookName = [bookNameDic objectForKey:@"$t"];
            
            BookModel *book = [[BookModel alloc] init];
            book._bookName = bookName;
            
            NSArray *arrayAttr = [dicBook objectForKey:@"db.attribute"];
            for (int i=0; i<arrayAttr.count; i++) {
                NSDictionary *dic = [arrayAttr objectAtIndex:i];
                
                NSString *strName = [dic objectForKey:@"@name"];
                if ([strName isEqualToString:@"price"]==YES) {
                   NSString *strPrice =  [dic objectForKey:@"$t"];
                    book._price = strPrice;
                }
                else if ([strName isEqualToString:@"publisher"] == YES){
                    NSString *pub = [dic objectForKey:@"publisher"];
                    book._booklisher = pub;
                }
            }
            
            [_arrayData addObject:book];
        }
        
    }
    //跟新数据视图数据  相当于notify
    [_tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
