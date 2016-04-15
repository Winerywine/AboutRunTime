//
//  Person.m
//  RunTimeThing
//
//  Created by Linzhixiao on 16/4/15.
//  Copyright © 2016年 Linzhixiao. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@interface Person ()

@property (nonatomic, copy) NSString *education;

@end

@implementation Person

- (void)eat {
    
}

- (void)sleep {
    NSLog(@"抓紧时间睡觉");
}

- (NSString *)sing; {
    return @"我要去唱歌";
}

- (NSString *)drink {
    return @"我要去喝水";
}

@end
