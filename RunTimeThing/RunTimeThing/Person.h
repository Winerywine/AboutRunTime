//
//  Person.h
//  RunTimeThing
//
//  Created by Linzhixiao on 16/4/15.
//  Copyright © 2016年 Linzhixiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol personDelegate <NSObject>

- (void)personPayForFun: (NSInteger )money;

@end

@interface Person : NSObject

@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSString *sex;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) float     height;
@property (nonatomic, copy)   NSString *job;
@property (nonatomic, copy)   NSString *native; // 籍贯
@property (nonatomic, assign) id <personDelegate> delegate;

- (void)eat;

- (void)sleep;

- (NSString *)sing;

- (NSString *)drink;

@end

