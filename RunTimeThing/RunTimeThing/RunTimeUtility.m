//
//  RunTimeModel.m
//  RunTimeThing
//
//  Created by Linzhixiao on 16/4/15.
//  Copyright © 2016年 Linzhixiao. All rights reserved.
//

#import "RunTimeUtility.h"
#import <objc/runtime.h>

@implementation RunTimeUtility

+ (NSMutableArray *)getClassAllMemberProperty {
    unsigned int count;
    
    NSMutableArray *array = [NSMutableArray array];
    // 获取成员变量的数组的指针
    Ivar *ivars = class_copyIvarList([Person class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        // 更加ivar获得其成员变量的名称
        const char *name = ivar_getName(ivar);
        // C的字符串转OC的字符串
        NSString *key = [NSString stringWithUTF8String:name];
        [array addObject:key];
    }
    free(ivars);
    return array;
}

+ (NSMutableArray *)getClassAllPropertyName {
    unsigned int count;
    
    NSMutableArray *array = [NSMutableArray array];
    // 获得指向该类所有属性的指针
    objc_property_t *properties = class_copyPropertyList([Person class], &count);
    
    for (int i = 0; i < count; i ++) {
        // 获取该类的一个属性的指针
        objc_property_t property = properties[i];
        // 获取属性的名称
        const char *name = property_getName(property);
        // 转换
        NSString *key = [NSString stringWithUTF8String:name];
        [array addObject:key];
    }
    free(properties);
    return array;
}

+ (NSMutableArray *)getClassAllMethod {
    unsigned int count;
    
    NSMutableArray *array = [NSMutableArray array];
    // 获取指向该类的所有方法的指针
    Method *methods = class_copyMethodList([Person class], &count);
    
    for (int i = 0; i < count; i ++) {
        // 获取该类的一个方法的指针
        Method method = methods[i];
        // 获取方法
        SEL methodSEL = method_getName(method);
        // 将方法转为C字符串
        const char *name = sel_getName(methodSEL);
        // 将C字符串转为OC字符串
        NSString *methodName = [NSString stringWithUTF8String:name];
        
        // 获取方法参数
//        int arguments = method_getNumberOfArguments(method);
        
        [array addObject:methodName];
    }
    free(methods);
    return array;
}

+ (NSMutableArray *)getClassAllProtocolWithClass: (Class )className {
    unsigned int count;
    
    NSMutableArray *array = [NSMutableArray array];
    // 获取指向该类遵循的所有协议的数组指针
    __unsafe_unretained Protocol **protocols = class_copyProtocolList([className class], &count);
    
    for (int i = 0; i < count; i ++) {
        // 获取该类遵循的一个协议指针
        Protocol *protocol = protocols[i];
        // 获取C字符串协议名
        const char *name = protocol_getName(protocol);
        // C字符串转OC字符串
        NSString *protocolName = [NSString stringWithUTF8String:name];
        [array addObject:protocolName];
    }
    free(protocols);
    return array;
}

- (void)changeClassPropertyValueWithPersonObject: (Person *)person {
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([Person class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithUTF8String:varName];
        if ([name isEqualToString:@"_name"]) {
            object_setIvar(person, var, @"张三");
            break;
        }
    }
    free(ivar);
}

+ (void)exchangeClassMethod {
    Method m1= class_getInstanceMethod([Person class], @selector(sing));
    Method m2 = class_getInstanceMethod([Person class], @selector(drink));
    
    method_exchangeImplementations(m1, m2);
    
    
}

+ (NSString *)addAndDoFromCityMethodWithPersonObject: (Person *)person {
    class_addMethod([Person class], @selector(fromCity:), (IMP)fromCityAnswer, "v@:@");
    if ([person respondsToSelector:@selector(fromCity:)]) {
        //Method method = class_getInstanceMethod([self.xiaoMing class], @selector(guess));
        [person performSelector:@selector(fromCity:) withObject:@"广州"];
        
    } else{
        NSLog(@"无法告诉你我从哪儿来");
    }
    return @"我来自广州";
}

void fromCityAnswer(id self,SEL _cmd,NSString *str){
    
    NSLog(@"我来自:%@",str);
}



@end
