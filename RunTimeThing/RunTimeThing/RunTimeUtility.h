//
//  RunTimeModel.h
//  RunTimeThing
//
//  Created by Linzhixiao on 16/4/15.
//  Copyright © 2016年 Linzhixiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface RunTimeUtility : NSObject

// 获取类的所有成员变量

+ (NSMutableArray *)getClassAllMemberProperty;

// 获取类的所有属性名

+ (NSMutableArray *)getClassAllPropertyName;

// 获取类的所有方法

+ (NSMutableArray *)getClassAllMethod;

// 获取类遵循的全部协议

+ (NSMutableArray *)getClassAllProtocolWithClass: (Class )className;

// 动态改变成员变量

- (void)changeClassPropertyValueWithPersonObject: (Person *)person;

// 动态交换类的方法

+ (void)exchangeClassMethod;

// 动态添加新方法

+ (NSString *)addAndDoFromCityMethodWithPersonObject: (Person *)person;

@end
