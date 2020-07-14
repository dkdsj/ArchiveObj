//
//  NSObject+Archiver.h
//  归档
//
//  Created by ZZ on 2020/7/6.
//  Copyright © 2020 zz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Archiver)

/**
 自定义对象、自定义对象数组/字典、基本数据类型/数组/字典
 classTypes: 自定义对象1个 自定义对象数组/字典2个
 custom：是否自定义对象
 */
- (id)extArchivierObjectClassType:(Class)classType customType:(BOOL)custom;

@end

NS_ASSUME_NONNULL_END
