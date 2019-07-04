//
//  SwizzleClass.h
//  TestIMPChangeDemo
//
//  Created by ios_LH on 2019/7/2.
//  Copyright © 2019 PAAT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject(Swizzle)

+ (void)oneSwizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector;
+ (void)twoSwizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector;

@end

NS_ASSUME_NONNULL_END
