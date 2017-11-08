//
//  BookModel.h
//  JSON数据解析
//
//  Created by zh dk on 2017/8/29.
//  Copyright © 2017年 zh dk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookModel : NSObject

{
    //书籍名称
    NSString *_bookName;
    //出版社名称
    NSString *_booklisher;
    //书籍价格
    NSString *_price;
    //作者数组
    NSMutableArray *_authorArray;
}

@property (retain,nonatomic) NSString *_bookName;
@property (retain,nonatomic) NSString *_booklisher;
@property (retain,nonatomic) NSString *_price;
@property (retain,nonatomic) NSMutableArray *_authorArray;

@end
