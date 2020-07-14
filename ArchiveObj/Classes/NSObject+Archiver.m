//
//  NSObject+Archiver.m
//  归档
//
//  Created by ZZ on 2020/7/6.
//  Copyright © 2020 zz. All rights reserved.
//

#import "NSObject+Archiver.h"

@implementation NSObject (Archiver)

- (id)extArchivierObjectClassType:(Class)classType customType:(BOOL)custom {
    
    //1. 判断objcect的类型 数组/字典/非集合
    
    //1.1 数组
    if ([self isKindOfClass:[NSArray class]]) {
        
        NSArray *items = (NSArray *)self;
        
        //2. 判断是否是自定义对象
        if (custom) {
            
            //归档对象未遵守 NSSecureCoding 协议
            if (![items.firstObject conformsToProtocol:@protocol(NSSecureCoding)]) {
                NSLog(@"-----自定义类 未遵守 NSSecureCoding 协议-----");
                return nil;
            }
            
            if (@available(iOS 11.0, *)) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:items requiringSecureCoding:NO error:nil];
                return [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithArray:@[classType, NSArray.class]] fromData:data error:nil];
            } else {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:items];
                return [NSKeyedUnarchiver unarchiveObjectWithData:data];
            }
        } else {
            if (@available(iOS 11.0, *)) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:items requiringSecureCoding:NO error:nil];
                return [NSKeyedUnarchiver unarchivedObjectOfClass:[NSArray class] fromData:data error:nil];
            } else {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:items];
                return [NSKeyedUnarchiver unarchiveObjectWithData:data];
            }
        }
    }
    //1.2 字典
    else if ([self isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *dic = (NSDictionary *)self;
        
        //2. 判断是否是自定义对象
        if (custom) {
            
            //归档对象未遵守 NSSecureCoding 协议
            if (![dic.allValues.firstObject conformsToProtocol:@protocol(NSSecureCoding)]) {
                NSLog(@"-----自定义类 未遵守 NSSecureCoding 协议-----");
                return nil;
            }
            
            if (@available(iOS 11.0, *)) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic requiringSecureCoding:NO error:nil];
                return [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithArray:@[classType, NSDictionary.class]] fromData:data error:nil];
            } else {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
                return [NSKeyedUnarchiver unarchiveObjectWithData:data];
            }
        } else {
            if (@available(iOS 11.0, *)) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic requiringSecureCoding:NO error:nil];
                return [NSKeyedUnarchiver unarchivedObjectOfClass:[NSDictionary class] fromData:data error:nil];
            } else {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dic];
                return [NSKeyedUnarchiver unarchiveObjectWithData:data];
            }
        }
    }
    
    //1.3 非集合的
    if (custom) {
        //归档对象未遵守 NSSecureCoding 协议
        if (![self conformsToProtocol:@protocol(NSSecureCoding)]) {
            NSLog(@"-----自定义类 未遵守 NSSecureCoding 协议-----");
            return nil;
        }
    }
        
    if (@available(iOS 11.0, *)) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self requiringSecureCoding:NO error:nil];
        return [NSKeyedUnarchiver unarchivedObjectOfClass:classType fromData:data error:nil];
    } else {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
}

@end
