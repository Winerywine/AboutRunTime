//
//  Person+addProperty.m
//  RunTimeThing
//
//  Created by Linzhixiao on 16/4/15.
//  Copyright © 2016年 Linzhixiao. All rights reserved.
//

#import "Person+addProperty.h"
#import <objc/runtime.h>

@implementation Person (addProperty)

char eName;

- (void)setEnglishName: (NSString *)englishName {
    objc_setAssociatedObject(self, &eName, englishName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)englishName {
    return objc_getAssociatedObject(self, &eName);
}

@end
